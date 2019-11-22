*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Resource                      ${RENODEKEYWORDS}

*** Variables ***
${SCRIPT}                     ${CURDIR}/tools/sel4Extra/renode_support/sel4test.resc
${UART}                       sysbus.uart0

*** Keywords ***
Prepare Machine
    Execute Command           using sysbus
    Execute Command           mach create "sel4test"
    Execute Command           \$bin?=@${CURDIR}/../../../riscv-build-hifive-64/images/sel4test-driver-image-riscv-hifive
    Execute Command           \$dtb?=@${CURDIR}/hifive-renode.dtb
    Execute Command           machine LoadPlatformDescription @${CURDIR}/sifive-fu540-dw.repl
    Execute Command           showAnalyzer uart0

    Execute Command           sysbus LoadELF $bin
    Execute Command           sysbus LoadFdt $dtb 0x81000000 "earlyconsole mem=256M@0x80000000"
    Execute Command           e51 SetRegisterUnsafe 11 0x81000000
    Execute Command           u54_1 SetRegisterUnsafe 11 0x81000000

*** Test Cases ***
Should Boot seL4
    [Documentation]           Boots seL4 on SiFive Freedom U540 platform.
    [Tags]                    sel4  uart
    Prepare Machine

    Create Terminal Tester    ${UART}
    Start Emulation

    Wait For Line On Uart   bbl loader                                    timeout=120
    Wait For Line On Uart   ELF-loader started on (HART 1) (NODES 1)      timeout=120

    Provides                  booted-sel4

Should Test There Are Tests
    [Documentation]           Check for the first test from sel4test
    [Tags]                    sel4 test uart

    Requires                  booted-sel4
    Wait For Line On Uart   <testcase classname="sel4test" name="Test that there are tests">    timeout=9999

   Provides                   there-are-tests