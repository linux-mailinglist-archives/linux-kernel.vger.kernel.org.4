Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D46731DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFOQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjFOQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:20:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E6296F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:20:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FGKOOG058026;
        Thu, 15 Jun 2023 11:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686846024;
        bh=OeazqEeX0Q9RZKkon1AxBxkF5a79/NGDy9Zg1j7CHp4=;
        h=Date:To:CC:From:Subject;
        b=I/8e1NvPDMfEc+Q2sGpYDhehXsNpAnGr9aSq34GTm/dcwxe/Ki08sjZhVh6D7oI2H
         /vkuAdmeAGg/HNfAO8dpPa11yMq1+7GIfh8ABGaBEPlMFyPo/InH3D5dr/+m9e5wmX
         1H+CFlGaGBMAi//Uj0gdistRbg+COIVjPscQ1eWU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FGKOA1021844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 11:20:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 11:20:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 11:20:23 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FGKKA3095827;
        Thu, 15 Jun 2023 11:20:21 -0500
Message-ID: <7fe0c6de-cb99-9c89-8583-b3855fde16f8@ti.com>
Date:   Thu, 15 Jun 2023 21:50:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL 2/2] arm64: dts: ti: K3 updates for v6.5
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="------------UIW47RBypgDGluXpm4Q3vm0b"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------UIW47RBypgDGluXpm4Q3vm0b
Content-Type: multipart/mixed; boundary="------------hFvrg8MG0utYahZO712leilt";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <7fe0c6de-cb99-9c89-8583-b3855fde16f8@ti.com>
Subject: [GIT PULL 2/2] arm64: dts: ti: K3 updates for v6.5

--------------hFvrg8MG0utYahZO712leilt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

The following changes since commit ac9a78681b921877518763ba0e89202254349d=
1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-dt-for-v6.5

for you to fetch changes up to a49568115143435390f20965902809471b6f830c:

  arm64: dts: ti: Unify pin group node names for make dtbs checks (2023-0=
6-15 20:58:38 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.5

New Boards:
phyBOARD-Lyra-AM625 Board support
Toradex Verdin AM62 COM, carrier and dev boards

New features:
Across K3 SoCs:
 - Error Signaling Module(ESM) and Secproxy IPC modules
 - On board I2C EEPROM
 - Voltage Temp Monitoring (VTM) module
 - DM timers (GP Timers)
J784s4:
 - R5 and C7x DSP remoteproc, ADC, QSPI
AM69:
 - Addition of more peripherals: CPSW, eMMC, UARTs, I2C et al
J721s2:
 - USB, Serdes, OSPI, PCIe
AM62a:
- Watchdog
J721e:
- HyperFlash/HyperBus
AM62:
- Type-C USB0 port

Cleanups and non-urgent fixes
Particularly large set of cleanups to get rid of dtbs_check errors and
dtc warnings:
 - Addition of missing pinmux and uart nodes for AM64, AM62x, AM62A,
   J721e, J7200 that are used by bootloader
 - Split Pinmux regions/range to avoid holes for J721s2, J7200, J784s4
 - Drop bootargs and unneeded aliases across all K3 SoCs
 - Move aliases to board dts files from SoC dtsi files
 - Move to generic node name for can, rtc nodes on am65
 - s/-pins-default/default-pins/ to match upcoming pinctrl.yaml update
 - Fix pinctrl phandle references to use <> as separator where multiple
   entries are present

----------------------------------------------------------------
Andrew Davis (7):
      arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox node status
      arm64: dts: ti: k3-j721e: Remove PCIe endpoint nodes
      arm64: dts: ti: k3-j721e: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-am64: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j721e: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am64: Only set UART baud for used ports
      arm64: dts: ti: k3-am64: Use phandle to stdout UART node

Apurva Nandan (2):
      arm64: dts: ti: k3-j784s4-mcu-wakeup: Add FSS OSPI0 and FSS OSPI1
      arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flashe=
s

Aswath Govindraju (7):
      arm64: dts: ti: k3-j721s2-main: Add support for USB
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
      arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
      arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes
      arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe

Bhavya Kapoor (4):
      arm64: dts: ti: k3-j721e-main: Update delay select values for MMC s=
ubsystems
      arm64: dts: ti: k3-j784s4-mcu-wakeup: Add support for ADC nodes
      arm64: dts: ti: k3-j784s4-evm: Add pinmux information for ADC
      arm64: dts: ti: k3-j784s4-main: Enable support for high speed modes=


Bryan Brattlof (3):
      arm64: dts: ti: k3-am64-main: add VTM node
      arm64: dts: ti: k3-am62-wakeup: add VTM node
      arm64: dts: ti: k3-am62a-wakeup: add VTM node

Dasnavis Sabiya (2):
      arm64: dts: ti: k3-am69-sk: Add eMMC mmc0 support
      arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header

Francesco Dolcini (4):
      dt-bindings: arm: ti: add toradex,verdin-am62 et al.
      arm64: dts: ti: add verdin am62
      arm64: dts: ti: add verdin am62 dahlia
      arm64: dts: ti: add verdin am62 yavia

Hari Nagalla (3):
      arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
      arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
      arm64: dts: ti: k3-j784s4-evm: Reserve memory for remote proc IPC

Jyri Sarha (1):
      arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay

Keerthy (5):
      arm64: dts: ti: k3-j7200: Fix physical address of pin
      arm64: dts: ti: j784s4: Add VTM node
      arm64: dts: ti: j721e: Add VTM node
      arm64: dts: ti: j7200: Add VTM node
      arm64: dts: ti: j721s2: Add VTM node

Krzysztof Kozlowski (1):
      arm64: dts: ti: add missing cache properties

Matt Ranostay (1):
      arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node=


Neha Malcom Francis (4):
      arm64: dts: ti: k3-j721s2: Change CPTS clock parent
      dt-bindings: misc: esm: Add ESM support for TI K3 devices
      arm64: dts: ti: k3-j721e: Add ESM support
      arm64: dts: ti: k3-j7200: Add ESM support

Nishanth Menon (84):
      arm64: dts: ti: k3-am64: Add general purpose timers
      arm64: dts: ti: k3-am642-sk: Fix mmc1 pinmux
      arm64: dts: ti: k3-am642-sk: Enable main_i2c0 and eeprom
      arm64: dts: ti: k3-am642-sk: Describe main_uart1 pins
      arm64: dts: ti: k3-am642-sk: Rename regulator node name
      arm64: dts: ti: k3-am642-evm: Enable main_i2c0 and eeprom
      arm64: dts: ti: k3-am642-evm: Describe main_uart1 pins
      arm64: dts: ti: k3-am642-evm: Rename regulator node name
      arm64: dts: ti: k3-am642-evm: Add VTT GPIO regulator for DDR
      arm64: dts: ti: k3-am642-sk|evm: Drop bootargs, add aliases
      arm64: dts: ti: k3-am62x-sk-common: Drop bootargs
      arm64: dts: ti: k3-am65*: Drop bootargs
      arm64: dts: ti: k3-j721e-*: Drop bootargs
      arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
      arm64: dts: ti: k3-j721s2-common-proc-board: Drop bootargs
      arm64: dts: ti: k3-am62a: Add general purpose timers
      arm64: dts: ti: k3-am62a: Add watchdog nodes
      arm64: dts: ti: k3-am654-base-board: Add missing pinmux wkup_uart, =
mcu_uart and mcu_i2c
      arm64: dts: ti: k3-am654-base-board: Rename regulator node name
      arm64: dts: ti: k3-am654-base-board: Add VTT GPIO regulator for DDR=

      arm64: dts: ti: k3-am654-base-board: Add missing PMIC
      arm64: dts: ti: k3-am654-base-board: Add board detect eeprom
      arm64: dts: ti: k3-am654-base-board: Add aliases
      arm64: dts: ti: k3-am65: Drop aliases
      arm64: dts: ti: k3-am65-main: Remove "syscon" nodes added for pcieX=
_ctrl
      arm64: dts: ti: k3-am62a7-sk: Describe main_uart1 and wkup_uart
      arm64: dts: ti: k3: j721s2/j784s4: Switch to https links
      arm64: dts: ti: k3-am62x-sk-common: Drop extra EoL
      arm64: dts: ti: k3-am62x-sk-common: Describe main_uart1 and wkup_ua=
rt
      arm64: dts: ti: k3-am62x-sk-common: Add eeprom
      arm64: dts: ti: k3-am62x-sk-common: Improve documentation of mcasp1=
_pins
      arm64: dts: ti: k3-am65-main: Fix mcan node name
      arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel prope=
rty
      arm64: dts: ti: k3-am65-iot2050-common: Rename rtc8564 nodename
      arm64: dts: ti: k3-am62a-main: Add sa3_secproxy
      arm64: dts: ti: k3-am65-mcu: Add mcu_secproxy
      arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
      arm64: dts: ti: k3-j721e-mcu: Add mcu_secproxy
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Add sa3_secproxy and mcu_sec_=
proxy
      arm64: dts: ti: k3-j784s4-mcu-wakeup: Add sa3_secproxy and mcu_sec_=
proxy
      arm64: dts: ti: k3-j721e: Add general purpose timers
      arm64: dts: ti: k3-j721e: Configure pinctrl for timer IO
      arm64: dts: ti: k3-j721s2: Add general purpose timers
      arm64: dts: ti: k3-j721s2: Configure pinctrl for timer IO
      arm64: dts: ti: k3-j784s4: Add general purpose timers
      arm64: dts: ti: k3-j784s4: Configure pinctrl for timer IO
      arm64: dts: ti: k3-j721e-sk: Fixup reference to phandles array
      arm64: dts: ti: k3-j721e-som-p0/common-proc-board: Fixup reference =
to phandles array
      arm64: dts: ti: k3-j721e-beagleboneai64: Move camera gpio pinctrl t=
o gpio node
      arm64: dts: ti: k3-j721e-beagleboneai64: Move eeprom WP gpio pinctr=
l to eeprom node
      arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandle=
s array
      arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fixup reference to p=
handles array
      arm64: dts: ti: k3-j7200-som/common-proc-board: Fixup reference to =
phandles array
      arm64: dts: ti: k3-j721s2-common-proc-board: Fixup reference to pha=
ndles array
      arm64: dts: ti: k3-am625-sk: Fixup reference to phandles array
      arm64: dts: ti: k3-am64-evm: Fixup reference to phandles array
      arm64: dts: ti: k3-am64-sk: Fixup reference to phandles array
      arm64: dts: ti: k3-am65-iot*: Fixup reference to phandles array
      arm64: dts: ti: k3-am654-base-board: Fixup reference to phandles ar=
ray
      arm64: dts: ti: k3-am68-sk-base-board: Fixup reference to phandles =
array
      arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias
      arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
      arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
      arm64: dts: ti: k3-am69-sk: Enable mcu network port
      arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts
      arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j721e-sk: Add missing uart pinmuxes
      arm64: dts: ti: k3-j721e-sk: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: j721e-som/common-proc-board: Add product links
      arm64: dts: ti: j721e-common-proc-board: Add uart pinmux
      arm64: dts: ti: k3-j721e-som-p0: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j721e-beagleboneai64: Add wakeup_uart pinmux
      arm64: dts: ti: k3-j721e-sk: Define aliases at board level
      arm64: dts: ti: k3-j721e-common-proc-board: Define aliases at board=
 level
      arm64: dts: ti: k3-j721e: Drop SoC level aliases
      arm64: dts: ti: k3-am68-sk-base-board: Add uart pinmux
      arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j721s2-common-proc-board: Add uart pinmux
      arm64: dts: ti: k3-j721s2-som-p0: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-am62: Add ESM support
      arm64: dts: ti: k3-am64: Add ESM support
      arm64: dts: ti: k3-j721e-som-p0: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix =
from nodename

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Add sa3_secproxy

Roger Quadros (1):
      arm64: dts: ti: k3-am625: Enable Type-C port for USB0

Sinthu Raja (2):
      arm64: dts: ti: k3-j721s2: Fix wkup pinmux range
      arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

Thejasvi Konduru (1):
      arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node=
 offsets

Tony Lindgren (1):
      arm64: dts: ti: Unify pin group node names for make dtbs checks

Udit Kumar (7):
      arm64: dts: ti: k3-j7200-som: Enable I2C
      arm64: dts: ti: k3-j7200: Add general purpose timers
      arm64: dts: ti: k3-j7200: Configure pinctrl for timer IO pads
      arm64: dts: ti: k3-j7200-common-proc-board: remove duplicate main_i=
2c0 pin mux
      arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux
      arm64: dts: ti: k3-j7200-common-proc-board: Define aliases at board=
 level
      arm64: dts: ti: k3-j7200: Drop SoC level aliases

Vaishnav Achath (9):
      arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
      arm64: dts: ti: k3-j721e-som-p0: Add HyperFlash node
      arm64: dts: ti: k3-j7200-common-proc-board: Add OSPI/Hyperflash sel=
ect pinmux
      arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash sel=
ect pinmux
      arm64: dts: ti: k3-j721e: Describe OSPI and QSPI flash partition in=
fo
      arm64: dts: ti: k3-j721e-sk: Describe OSPI flash partition info
      arm64: dts: ti: k3-j7200-som: Describe OSPI and Hyperflash partitio=
n info
      arm64: dts: ti: k3-am654-baseboard: Describe OSPI flash partition i=
nfo
      arm64: dts: ti: k3-am642-sk/evm: Describe OSPI flash partition info=


Wadim Egorov (3):
      arm64: dts: ti: Add LED controller to phyBOARD-Electra
      dt-bindings: arm: ti: Add bindings for PHYTEC AM62x based hardware
      arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM625

 Documentation/devicetree/bindings/arm/ti/k3.yaml             |   26 +
 Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml     |   53 +
 arch/arm64/boot/dts/ti/Makefile                              |    9 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                     |    6 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                     |   21 +
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                      |    6 +
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi              |  324 +++
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi                  |   33 +
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi            |  161 ++
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi               |  190 ++
 arch/arm64/boot/dts/ti/k3-am62-verdin-nonwifi.dtsi           |   20 +
 arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi              |   39 +
 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi             |  207 ++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                   | 1401 ++++=
++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi                   |    8 +
 arch/arm64/boot/dts/ti/k3-am62.dtsi                          |    8 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts               |   52 +-
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts        |  266 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                       |   13 +-
 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dahlia.dts    |   22 +
 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dts       |   22 +
 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.dts     |   22 +
 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dahlia.dts       |   22 +
 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dts          |   22 +
 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts        |   22 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                    |  156 ++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi                     |   56 +
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi                 |   47 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi                  |   19 +
 arch/arm64/boot/dts/ti/k3-am62a.dtsi                         |    2 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                      |   58 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi               |   97 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                     |  171 +-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                      |   53 +-
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi              |   36 +-
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi                  |   33 +
 arch/arm64/boot/dts/ti/k3-am64.dtsi                          |   19 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                      |  173 +-
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts     |   51 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                       |  166 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi           |   68 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                     |   28 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                      |   19 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                          |   17 -
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi   |    2 +-
 .../dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso     |   71 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts               |  172 +-
 arch/arm64/boot/dts/ti/k3-am654.dtsi                         |    1 +
 .../arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi |    2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts     |   24 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts             |  171 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi                   |   22 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                        |  182 +-
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts        |  121 +-
 arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso   |    2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                    |  264 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi              |  179 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi                  |  107 +-
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi                 |   47 +
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                         |   21 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts           |  157 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts        |  226 +-
 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso   |    2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                    |  362 ++-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi              |  206 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                       |  210 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi                  |  167 +-
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi                 |   75 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                         |   23 +-
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts       |  213 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                   |  405 +++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi             |  275 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi                 |   67 +-
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi                |  101 +
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi                        |    7 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                     |  616 +++-=

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                   |  427 ++-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi             |  350 ++-
 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi                |  101 +
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                        |    6 +-
 80 files changed, 8767 insertions(+), 861 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,j721e-esm.y=
aml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-nonwifi.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts=

 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dahlia=
=2Edts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dt=
s
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.=
dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dahlia.dt=
s
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts=

 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-r=
k101-panel.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi

--=20
Regards
Vignesh

--------------hFvrg8MG0utYahZO712leilt--

--------------UIW47RBypgDGluXpm4Q3vm0b
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmSLOkQFAwAAAAAACgkQxEYeRXyRFuPp
RQf/ZTeEfm5MN6ju9qSEPL02CucMZ+Ue4d6vaPdo5bceEczrSr77oj0BJT2PxM7+UOcs4AGUiRGd
OzNCYoaks8hMk7Cq14cacKPKLdGQiQlXt5y1LUjXLSD+EXCzlIpsAiu7NFuYrscwMl4BFJmvWzYg
8wJvNnnL/bvG+Y4bZmmak7ejJQ7DKWy3yikix/ZpNE9drkDA5mtCJFjhCB/pokqk4lLbbLCwVA0O
TaXCeYuGxVctqkyCDrjlsccZ/rcxYMilnK582IniRo6Ia3Aecu4W2Qm8xmooERVI8+bkhe5dIQOd
VsNIQcy3oSZLECnH0+15at1BI28uvw5FWUjKj9WXEA==
=iM14
-----END PGP SIGNATURE-----

--------------UIW47RBypgDGluXpm4Q3vm0b--
