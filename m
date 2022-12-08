Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB31646B49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLHJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLHJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:02:45 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D718710A2;
        Thu,  8 Dec 2022 01:02:41 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1798432002E2;
        Thu,  8 Dec 2022 04:02:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Dec 2022 04:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1670490159; x=1670576559; bh=R4MrWN+CSz7QFshA2PjZ7T7ly
        6PvFA9S5vCqTmxqsXM=; b=W1MEgpDCNjWU0o7upZmi7IllenrLxaCsmAFUkzNh+
        rLin3ekP5WXeyVfnDI50nckR/jhpDV/S0uoVnVzdXBOa9m9KiBsb9ueRIBlvxlx2
        4H/CHYIMEZnInhzLX+kauwA7VUHyECpUBRWYU2/6tJj/J3kKYMXw0owyHg0VhzHg
        DQ9PlQ96qhzYpIGMlE9Rca6HrCUGA8LeVJlCJzlilhgmPMuQ7MkrkFTfcPex6LBy
        GxaT7k0C8C3DuU15NnaWSPVzCPm7TgqWWiT85vCNe2LeJbH771djkIoa5zEg+pPL
        IP2u17YWHQzLAhkhX5A9YjAH5noZCfM0k/06GVxyZpmnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1670490159; x=1670576559; bh=R4MrWN+CSz7QFshA2PjZ7T7ly6PvFA9S5vC
        qTmxqsXM=; b=wOVT6yiXwfvRTDSBYLqM/dr6II/bX1eOtpd1bCZkHvPQocZKpxJ
        JYbOHMwoT7Z/LG6mT7lTauRYcWnKGwzZbwEMFJ2/DgsZRCmWF62HT6XdeccrYYHN
        4mb4oayOMTIRjVrnvp6Lf9BKqUiuVhdUFuyXV35prMPkVgEAUsKjhjXATZpSLUUG
        Dniv0R9aEDpN/I06YMbeeJjTY6a5ZfCh9IiPF7GgREWXjsIg/HvGbfLmOr3mP/l2
        T211+e3V7y7TjFTXiGTH6SEr2DCoOZMyTOp2cCSfwjJMMRVIcPClTrtmoL7YG0qK
        rm1FBFlZGnTK2djv2szGLtyNat6lAsw0JOw==
X-ME-Sender: <xms:L6iRY6Rxp7ZPmsi4uSRYv2kyXl-ViJ7wa-Iia9QHkWKJYKsWRMoCvw>
    <xme:L6iRY_zWingWNteGWJRimi5zxP0tEfvRi5s-o8Liqbo6jAj-jITCKkH1H8Jyo_dZp
    XvQZA8zuPARWvX__w>
X-ME-Received: <xmr:L6iRY31J9L-DJ0afUbiVZmzwO8HkvcB3K9wTVZv49bwy9B9ejnEMj0hBwbXFkcKpBrt9qh5aH9BfxCl94bqDLSDcNWZC-THz5hFxXInXzxrwfVLtX-y6T4Dq5wxEupoCBnQ9HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfjohhl
    lhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvg
    hrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledvvdffhfev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:L6iRY2AEKZ-Lrl_Z_R-5p3r3qv2DEdaK12MV4Q68c2EZtpXmj6FAmw>
    <xmx:L6iRYzjhKCNafSg8eLD3zrdBiizgK1NFfGycim2vXctw-4EB2ymhGw>
    <xmx:L6iRYyrRRmOet_ZYXFD-PsL7uohVl29o6HmBUwg2iTwO-Rmm_7RJHQ>
    <xmx:L6iRY-SBUbEXbSkoGFWhO9ziEeOB6XCrKcUg7mW1EDpQkEqW83Ehqw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:02:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 00/12] riscv: Allwinner D1/D1s platform support
Date:   Thu,  8 Dec 2022 03:02:25 -0600
Message-Id: <20221208090237.20572-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the Kconfig/defconfig plumbing and devicetrees for a
range of Allwinner D1 and D1s-based boards. Many features are already
enabled, including USB, Ethernet, and WiFi.

The devicetrees use bindings from the following series which have not
yet been merged to linux-next:
 - In-package LDO regulators:
   https://lore.kernel.org/lkml/20221208084127.17443-1-samuel@sholland.org/
 - Ethernet MAC binding fix (not a new issue with D1):
   https://lore.kernel.org/lkml/20221208061616.7806-1-samuel@sholland.org/
 - TI ADC101C ADC (accepted, not yet in linux-next):
   https://lore.kernel.org/lkml/20221125220903.8632-1-samuel@sholland.org/

The only remaining DT validation issue is that gpio-fan is missing a
YAML conversion, although one is on the list here:
https://lore.kernel.org/lkml/20220126200350.3633576-1-clabbe@baylibre.com/

$ make ARCH=riscv CROSS_COMPILE=riscv64-linux-musl- dtbs_check
  SYNC    include/config/auto.conf.cmd
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb
  DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb
arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb:0:0: /fan: failed to match any schema with compatible: ['gpio-fan']

Note that validation requires dt-schema v2022.12 or newer.

I tested this series (DMIC, Ethernet, LEDs, MMC, PMIC, touch, and USB,
all where available) on the following boards:
 - sun20i-d1-devterm-v3.14
 - sun20i-d1-dongshan-nezha-stu
 - sun20i-d1-lichee-rv-86-panel-480p
 - sun20i-d1-mangopi-mq-pro
 - sun20i-d1-nezha
 - sun20i-d1s-mangopi-mq

Changes in v3:
 - Drop dummy DCXO clock-frequency property
 - Decrease the PLIC's riscv,ndev property to 175
 - Fix `make W=1 dtbs` warnings (unnecessary #address/#size-cells)
 - Drop mmc aliases
 - Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the backlight
   regulator is disconnected by default, so this is a standalone LED)
 - Fix `make W=1 dtbs` warnings (missing reg properties)
 - ARCH_SUNXI depends on MMU && !XIP_KERNEL

Changes in v2:
 - Add MangoPi MQ (non-Pro) board
 - Split into separate files for sharing with D1s/R528/T113
 - Use SOC_PERIPHERAL_IRQ macro for interrupts
 - Rename osc24M to dcxo and move the frequency to the board DTs
 - Drop analog LDOs due to the missing binding
 - Correct tcon_top DSI clock reference
 - Add DMIC, DSI controller, and DPHY (bindings are in linux-next)
 - Add CPU OPP table
 - Common regulators moved to MangoPi MQ patch, removed analog LDOs
 - Removed LRADC (depends on analog LDOs)
 - Added XR829 host-wake interrupt
 - Added DMIC sound card to Lichee RV dock and Lichee RV 86 Panel
 - Removed LRADC (depends on analog LDOs)
 - Added LED (GPIO shared between onboard LED and backlight regulator)
 - Added PMIC GPIO controller node (binding merged for 6.2)
 - Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofing

Samuel Holland (12):
  MAINTAINERS: Match the sun20i family of Allwinner SoCs
  dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
  dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
  riscv: dts: allwinner: Add the D1/D1s SoC devicetree
  riscv: dts: allwinner: Add MangoPi MQ devicetree
  riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
  riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
  riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
  riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
  riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
  riscv: Add the Allwinner SoC family Kconfig option
  riscv: defconfig: Enable the Allwinner D1 platform and drivers

 .../devicetree/bindings/riscv/sunxi.yaml      |  69 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 MAINTAINERS                                   |   2 +-
 arch/riscv/Kconfig.socs                       |  10 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |  11 +
 .../allwinner/sun20i-common-regulators.dtsi   |  35 +
 .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 252 ++++++
 .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +
 .../sun20i-d1-dongshan-nezha-stu.dts          | 117 +++
 .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
 .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
 .../sun20i-d1-lichee-rv-86-panel.dtsi         | 119 +++
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  97 ++
 .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  87 ++
 .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 142 +++
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 166 ++++
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  66 ++
 .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 134 +++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |  76 ++
 .../boot/dts/allwinner/sunxi-d1-t113.dtsi     |  15 +
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 837 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |  22 +-
 23 files changed, 2335 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi

-- 
2.37.4

