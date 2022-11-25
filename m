Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7754639252
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiKYXrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKYXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:04 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E34159FFD;
        Fri, 25 Nov 2022 15:47:03 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 369185C00EA;
        Fri, 25 Nov 2022 18:47:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 25 Nov 2022 18:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669420020; x=1669506420; bh=xss0NdGfxEL3CqgP3XiRfb0uF
        osgnXP9+IiAsE1Thgg=; b=TiwTnu+ijK3ioN3rUPrG7GcwIsv9yPVS/QbvdReEH
        CzRgECthxp10Phj7cZoASkqtnpKt0dJ8FjWhMli1Oe2difUXnncGnZeGiuaQfw7T
        xtAZ8pINEiXNa/AyujD1iFymj4y5nGbuvPwDD1XnDx+6VoRacmLZeZiHxQI6Yeku
        rdTVuBk0aPn8ZKN52rpMAp6b8EfxBwAbahyBIgPqeOcufivKaHkSMTo0OC4lg2q3
        l8OPpg+ksX6KmfiJ51/gf07RmvQA52VbWABd7lH0Ro/gJ9ELQP3AO/w6tR1I6t3W
        FHJUQuy6eERc2w2ue/15KbjNdOgx2hoojc7uMmRcL3OVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669420020; x=1669506420; bh=xss0NdGfxEL3CqgP3XiRfb0uFosgnXP9+Ii
        AsE1Thgg=; b=dYyxs87sMlQhLwCMCLt8rwz5qBHZmppSTDfDw2XCpxiRnGfuo5S
        xUCdX7bmllx/rEpxbJ5k5FGkgVSgOHPmfAe98iLsknTyxeDv2NJ6d+rPOG+xO1Uq
        T6lxkLUb+svdnns5lr+crcqPOM11Ixv2TwnujVU3DAkJFOc57DVAzvfoUHd7SlDF
        wHvCUntHUr4Ar80f6/miEEys7o1oUMih2Gxe4qK1RwzkFZzNSAt1V+oaMIV7vZX6
        1Wg+c8FEbfyfR2rE+epe1epT0Genl4ECZBxb6W/5/jOTbVruCapemHWTo5ccNVHZ
        BI9ByPQX1Dyolh4k3LeciNo4XdNpExln25w==
X-ME-Sender: <xms:8lOBY_drji0q2NwwhoJYzDuc1UEZW_i25TTkhYcoe3JY66vZszSNUw>
    <xme:8lOBY1P-TVxaFeh3DmzMgfIKzFhEFjAttuTTaFVM28Gy2yCdUJKqulAcKwEXqH5iG
    JNodRkq7Ldw9aYz3w>
X-ME-Received: <xmr:8lOBY4gzmMWrhqoCzUnzzU29_QW9UBJqbbJDj2YtmvNMh0Amtpr5MmReZbERFvcrkndBb-qRZa34XxBTI4Ly4C_Mlo6zKZQS40DeJCxwUhxtG3UAnqiJ2amolwllncm5PUv1KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:8lOBYw-NXZac8qLVMn2TCTebiUt99PbvQeFvgU_B9ojyOsOzElaiyg>
    <xmx:8lOBY7tNqFqYF1xILMOXszW2opcPT0ZM6Fw9BonglBtqTJowhrZYKA>
    <xmx:8lOBY_G2ySJcFgQRrMEI9YnUkgGdfLrSJM37ZTxWuZMg5qm-KPlmiQ>
    <xmx:9FOBY8uTx5DXUGW8Y0BPd5uU7S64vl4qKtHw98pl6uAbpv9s_nxsZQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:46:57 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: [PATCH v2 00/12] riscv: Allwinner D1/D1s platform support
Date:   Fri, 25 Nov 2022 17:46:44 -0600
Message-Id: <20221125234656.47306-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the Kconfig/defconfig plumbing and devicetrees for a
range of Allwinner D1 and D1s-based boards. Many features are already
enabled, including USB, Ethernet, and WiFi.

The devicetrees use bindings from the following series which have not
yet been merged:
 - In-package LDO regulators:
   https://lore.kernel.org/lkml/20221125040112.18160-1-samuel@sholland.org/
 - Ethernet MAC binding fixes (not a new issue with D1):
   https://lore.kernel.org/lkml/20221125202008.64595-1-samuel@sholland.org/
 - RTL8723DS Bluetooth (has driver support, missing documentation):
   https://lore.kernel.org/lkml/20221125040956.18648-1-samuel@sholland.org/
 - TI ADC101C ADC (has driver support, missing documentation):
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

I tested this series (DMIC, Ethernet, LEDs, MMC, PMIC, touch, and USB,
all where available) on the following boards:
 - sun20i-d1-devterm-v3.14
 - sun20i-d1-dongshan-nezha-stu
 - sun20i-d1-lichee-rv-86-panel-480p
 - sun20i-d1-mangopi-mq-pro
 - sun20i-d1-nezha
 - sun20i-d1s-mangopi-mq

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
 arch/riscv/Kconfig.socs                       |   9 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |  11 +
 .../allwinner/sun20i-common-regulators.dtsi   |  35 +
 .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 253 ++++++
 .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +
 .../sun20i-d1-dongshan-nezha-stu.dts          | 118 +++
 .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
 .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
 .../sun20i-d1-lichee-rv-86-panel.dtsi         | 118 +++
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  96 ++
 .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  88 ++
 .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 143 +++
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 167 ++++
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  66 ++
 .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 135 +++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |  76 ++
 .../boot/dts/allwinner/sunxi-d1-t113.dtsi     |  15 +
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 844 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |  23 +-
 23 files changed, 2346 insertions(+), 2 deletions(-)
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

