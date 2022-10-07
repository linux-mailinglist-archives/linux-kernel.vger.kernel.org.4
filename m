Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC52F5F789C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJGNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJGNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:08:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B174C0993
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29145B822E1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF00C433D6;
        Fri,  7 Oct 2022 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148123;
        bh=U6qkCPg18vQj9cDInvi/Sb9S2Nssrb8Uve2H2xjC9u8=;
        h=Date:From:To:Cc:Subject:From;
        b=hybUx0ZwdYD+VZInPaKGPf/M5+uJiC0sfR37vDJSGFatZfho8WatHvxNiRcNOonBQ
         /9eKDBJuckslOR002929xqIGVh4UCx/XRlxZwq4MYHtOAigzSezMPim29qbOryjbWu
         Tbg8Id/VTV7g4p6bUtA6bPIa4xp7gofuDH8o8erKJD6Fz30jFBEgw7v1TYfxBImdws
         pFKq7Jp3EPHQHOCz0Lh57Hpme3PUzdzs1uUR2CWtKdOyVF5hknuize2SXFb5lK9kdZ
         HJCTBIYhcQ6BUGXMC9Lz7bLA8ZYmQpKfzxFQQ7hGBVwn94YRJIyzBeVs1mVx1GQ5gm
         dwgYPed6ecccg==
Date:   Fri, 7 Oct 2022 18:38:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.1-rc1
Message-ID: <Y0Ak14T6qDHEq8bi@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xdY9J5uc3Tpnz67P"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdY9J5uc3Tpnz67P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for Generic phy subsystem for v6.1.
Please note that typically this used to go thru Greg thru char-misc and
I requested Greg to send to you directly and he agreed, so I would be
sending this and soundwire tree updates from this cycle onwards.

This request contains bunch of new device support and one new Sunplus
driver along with updates which include another big round of qmp phy
conversion.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.1

for you to fetch changes up to 9aa0dade8f6b4cdcbb114e1a06037939ee3238bc:

  phy: phy-mtk-dp: make array driving_params static const (2022-09-29 21:01=
:27 +0530)

----------------------------------------------------------------
phy-for-6.1

  - New support:
	- Bjorn Andersson provided Qualcomm SC8280XP eDP & DP and USB3 UNI phy sup=
port
	- Chris Morgan added Rockchip rk3568 inno dsidphy support
	- Colin Foster converted ocelot-serdes phy binding to yaml
	- Geert Uytterhoeven converted Renesas gen2-usb phy binding to yaml
	- Horatiu Vultur added RGMII suport in lan966x driver
	- Konrad Dybcio provided Qualcomm SM6375 usb snps-femto-v2 bindings
	- Michael Riesch added support for rockchip rk356x csi-dphya
	- Richard Acayan provided Qualcomm sdm670 usb2 bindings
	- Vincent Shih provided new Sunplus USB2 PHY driver

  - Updates:
	- Chunfeng Yun provided Mediatek hdmi, ufs, tphy and xsphy updates
	  to use bitfield helpers.
	- Dmitry Baryshkov & Johan Hovold continued with Qualcomm qmp phy
	  driver split and cleanup. More patches are under review and
	  expected that next cycle might see completion of this activity.
	- Roger Quadros added support for TI wiz driver for j7200 10g
	- Sandeep Maheswaram added support in Qualcomm femto phy driver to
	  override params to help with tuning
	- Siddharth Vadapalli added SGMII support in TI wiz driver
	- Yuan Can did bunch of dev_err_probe simplification

----------------------------------------------------------------
Aurelien Jarno (1):
      phy: rockchip-snps-pcie3: only look for rockchip,pipe-grf on rk3588

Bjorn Andersson (10):
      dt-bindings: phy: qcom-edp: Add SC8280XP PHY compatibles
      phy: qcom: edp: Generate unique clock names
      phy: qcom: edp: Perform lane configuration
      phy: qcom: edp: Introduce support for DisplayPort
      phy: qcom: edp: Add SC8280XP eDP and DP PHYs
      dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys
      phy: qcom-qmp-combo: Parameterize swing and pre_emphasis tables
      phy: qcom-qmp: Add SC8280XP USB3 UNI phy
      phy: qcom-qmp-combo: Add sc8280xp USB/DP combo phys
      phy: qcom: edp: Postpone clk_set_rate until the PLL is up

Chanho Park (1):
      dt-bindings: phy: samsung,ufs-phy: match clock items

Chris Morgan (2):
      dt-bindings: phy-rockchip-inno-dsidphy: add compatible for rk3568
      phy: rockchip: inno-dsidphy: Add support for rk3568

Chunfeng Yun (26):
      dt-bindings: phy: mediatek,tphy: add support type of SGMII
      dt-bindings: phy: mediatek,tphy: add property to set pre-emphasis
      phy: phy-mtk-tphy: add property to set pre-emphasis
      phy: phy-mtk-tphy: disable hardware efuse when set INTR
      phy: phy-mtk-tphy: disable gpio mode for all usb2 phys
      phy: phy-mtk-tphy: set utmi 0 register in init() ops
      phy: phy-mtk-tphy: fix the phy type setting issue
      phy: mediatek: add a new helper to update bitfield
      phy: mediatek: tphy: remove macros to prepare bitfield value
      phy: mediatek: xsphy: remove macros used to prepare bitfield value
      phy: mediatek: ufs: use common register access helpers
      phy: mediatek: pcie: use new helper to update register bits
      phy: mediatek: hdmi: mt2701: use GENMASK and BIT to generate mask and=
 bits
      phy: mediatek: hdmi: mt2701: use FIELD_PREP to prepare bits field
      phy: mediatek: hdmi: mt2701: use common helper to access registers
      phy: mediatek: hdmi: mt8173: use GENMASK to generate bits mask
      phy: mediatek: hdmi: mt8173: use FIELD_PREP to prepare bits field
      phy: mediatek: hdmi: mt8173: use common helper to access registers
      phy: mediatek: hdmi: remove register access helpers
      phy: mediatek: mipi: mt8173: use GENMASK to generate bits mask
      phy: mediatek: mipi: mt8173: use FIELD_PREP to prepare bits field
      phy: mediatek: mipi: mt8173: use common helper to access registers
      phy: mediatek: mipi: mt8183: use GENMASK to generate bits mask
      phy: mediatek: mipi: mt8183: use common helper to access registers
      phy: mediatek: mipi: remove register access helpers
      phy: mediatek: fix build warning of FIELD_PREP()

Colin Foster (1):
      dt-bindings: phy: ocelot-serdes: convert to YAML

Colin Ian King (1):
      phy: phy-mtk-dp: make array driving_params static const

Dan Carpenter (1):
      phy: ti: phy-j721e-wiz: fix reference leaks in wiz_probe()

Dmitry Baryshkov (3):
      phy: qualcomm: phy-qcom-qmp: add support for combo USB3+DP phy on SDM=
845
      phy: qcom-qmp-pcie: drop if (table) conditions
      phy: qcom-qmp-pcie: fix resource mapping for SDM845 QHP PHY

Dongliang Mu (1):
      phy: qualcomm: call clk_disable_unprepare in the error handling

Frank Wunderlich (1):
      dt-bindings: phy: rockchip: add PCIe v3 phy

Geert Uytterhoeven (1):
      dt-bindings: phy: renesas,rcar-gen2-usb-phy: Convert to json-schema

Heiner Kallweit (1):
      phy: amlogic: use devm_clk_get_enabled() to simplify the code

Horatiu Vultur (1):
      phy: Add RGMII support on lan966x

Iskren Chernev (1):
      dt-bindings: phy: qcom,qmp-ufs: Fix SM6115 clocks, regs

Johan Hovold (79):
      dt-bindings: phy: qcom,qmp: fix bogus clock-cells property
      dt-bindings: phy: qcom,qmp: sort compatible strings
      dt-bindings: phy: qcom,qmp: drop redundant descriptions
      dt-bindings: phy: qcom,qmp: fix child node description
      dt-bindings: phy: qcom,qmp: clean up descriptions
      dt-bindings: phy: qcom,qmp: clean up example
      dt-bindings: phy: qcom,qmp: drop child-node comment
      dt-bindings: phy: add qcom,msm8996-qmp-pcie-phy schema
      dt-bindings: phy: qcom,msm8996-qmp-pcie: add missing child node schema
      dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate PIPE clock names
      dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate reset names
      dt-bindings: phy: add QMP PCIe PHY schema
      dt-bindings: phy: qcom,qmp-pcie: add missing child node schema
      dt-bindings: phy: qcom,qmp-pcie: deprecate PIPE clock name
      dt-bindings: phy: add QMP UFS PHY schema
      dt-bindings: phy: qcom,qmp-ufs: add missing SM8450 clock
      dt-bindings: phy: qcom,qmp-ufs: add missing SM8150 power domain
      dt-bindings: phy: qcom,qmp-ufs: add missing child node schema
      dt-bindings: phy: add QMP USB PHY schema
      dt-bindings: phy: qcom,qmp-usb: add missing child node schema
      dt-bindings: phy: qcom,qmp-usb: deprecate PIPE clock name
      dt-bindings: phy: qcom,qmp-usb: add missing qcom,sc7180-qmp-usb3-phy =
schema
      dt-bindings: phy: qcom,qmp-usb3-dp: fix bogus clock-cells property
      dt-bindings: phy: qcom,qmp-usb3-dp: deprecate USB PIPE clock name
      phy: qcom-qmp-pcie: drop pipe clock lane suffix
      phy: qcom-qmp-combo: drop unused lane reset
      phy: qcom-qmp-combo: drop pipe clock lane suffix
      phy: qcom-qmp-pcie-msm8996: drop pipe clock lane suffix
      phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
      phy: qcom-qmp-usb: drop pipe clock lane suffix
      dt-bindings: phy: qcom,qmp-usb: add missing power-domains property
      dt-bindings: phy: qcom,qmp-usb3-dp: add missing power-domains property
      phy: qcom-qmp-pcie: shorten function prefixes
      phy: qcom-qmp: drop dual-lane comments
      phy: qcom-qmp-combo: disable runtime PM on unbind
      phy: qcom-qmp-combo: drop unused defines
      phy: qcom-qmp-pcie: drop unused runtime PM implementation
      phy: qcom-qmp-pcie: drop unused defines
      phy: qcom-qmp-pcie-msm8996: drop unused runtime PM implementation
      phy: qcom-qmp-pcie-msm8996: drop unused defines
      phy: qcom-qmp-ufs: drop unused runtime PM implementation
      phy: qcom-qmp-ufs: drop unused defines
      phy: qcom-qmp-usb: disable runtime PM on unbind
      phy: qcom-qmp-usb: drop unused defines
      phy: qcom-qmp: silence noisy probe
      phy: qcom-qmp-combo: shorten function prefixes
      phy: qcom-qmp-pcie-msm8996: drop unused secondary init tables
      phy: qcom-qmp-pcie-msm8996: shorten function prefixes
      phy: qcom-qmp-ufs: shorten function prefixes
      phy: qcom-qmp-usb: shorten function prefixes
      phy: qcom-qmp-pcie: add pcs_misc sanity check
      phy: qcom-qmp-pcie: fix memleak on probe deferral
      phy: qcom-qmp-pcie-msm8996: fix memleak on probe deferral
      phy: qcom-qmp-combo: fix memleak on probe deferral
      phy: qcom-qmp-ufs: fix memleak on probe deferral
      phy: qcom-qmp-usb: fix memleak on probe deferral
      phy: qcom-qmp-pcie-msm8996: drop unused pcs_misc handling
      phy: qcom-qmp-pcie: drop unused legacy DT workaround
      phy: qcom-qmp-combo: drop unused legacy DT workaround
      phy: qcom-qmp-ufs: drop legacy DT workaround
      phy: qcom-qmp-usb: drop legacy DT workaround
      phy: qcom-qmp-combo: fix sc8280xp PCS_USB offset
      phy: qcom-qmp-pcie: drop unused type from config
      phy: qcom-qmp-pcie-msm8996: drop unused type from config
      phy: qcom-qmp-ufs: drop unused type from config
      phy: qcom-qmp-usb: drop unused type from config
      phy: qcom-qmp-pcie: drop init and exit wrappers
      phy: qcom-qmp-usb: drop init and exit wrappers
      phy: qcom-qmp: drop unused forward declarations
      phy: qcom-qmp-pcie-msm8996: drop unused kernel doc
      phy: qcom-qmp-pcie: drop unused mode field
      phy: qcom-qmp-pcie: drop unused config field
      phy: qcom-qmp: drop unused index field
      phy: qcom-qmp-pcie: consolidate lane config
      phy: qcom-qmp-pcie-msm8996: rename nlanes config
      phy: qcom-qmp-combo: consolidate lane config
      phy: qcom-qmp-ufs: consolidate lane config
      phy: qcom-qmp-usb: consolidate lane config
      phy: qcom-qmp-combo: drop redundant DP config flag

Johan Jonker (1):
      dt-bindings: phy: phy-rockchip-inno-usb2: add rockchip,rk3128-usb2phy

Konrad Dybcio (1):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add SM6375

Krishna Kurapati (1):
      phy: qcom-snps: Add support for overriding phy tuning parameters

Krzysztof Kozlowski (1):
      dt-bindings: phy: Update Pratyush Yadav's email

Liang He (1):
      phy: amlogic: phy-meson-axg-mipi-pcie-analog: Hold reference returned=
 by of_get_parent()

Matt Ranostay (1):
      phy: ti: phy-j721e-wiz: stop name conflict if multiple serdes are ini=
tialized

Michael Riesch (2):
      dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy
      phy: rockchip: add support for the rk356x variant to rockchip-inno-cs=
idphy

Peter Geis (1):
      phy: rockchip-inno-usb2: Return zero after otg sync

Richard Acayan (1):
      dt-bindings: phy: qcom,qusb2: document sdm670 compatible

Rob Herring (1):
      dt-bindings: phy: Add missing (unevaluated|additional)Properties on c=
hild nodes

Roger Quadros (4):
      dt-bindings: phy: ti,phy-j721e-wiz: deprecate clock MUX nodes
      dt-bindings: phy: ti,phy-j721e-wiz: Add support for ti,j7200-wiz-10g
      phy: ti: phy-j721e-wiz: add support for j7200-wiz-10g
      phy: ti: phy-j721e-wiz: set PMA_CMN_REFCLK_DIG_DIV based on reflk rate

Sandeep Maheswaram (1):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bin=
dings

Shawn Lin (1):
      phy: rockchip: Support PCIe v3

Siddharth Vadapalli (4):
      phy: ti: phy-j721e-wiz: Add SGMII support in wiz driver for J7200
      dt-bindings: phy: ti: phy-gmii-sel: Cleanup example
      dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
      phy: ti: gmii-sel: Add support for CPSW5G GMII SEL in J7200

Swapnil Jakhade (1):
      dt-bindings: phy: Add PHY_TYPE_USXGMII definition

Tanmay Patil (1):
      phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver

Uwe Kleine-K=F6nig (1):
      phy: tegra: xusb: Only warn once about reset problems in .remove()

Vincent Shih (2):
      phy: usb: Add USB2.0 phy driver for Sunplus SP7021
      dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver

Wayne Chang (1):
      phy: tegra: xusb: Enable usb role switch attribute

Wei Yongjun (1):
      phy: usb: sunplus: Fix return value check in update_disc_vol()

Wolfram Sang (1):
      phy: move from strlcpy with unused retval to strscpy

Yang Yingliang (1):
      phy: rockchip-snps-pcie3: Use devm_platform_get_and_ioremap_resource()

Yuan Can (9):
      phy: qcom-qmp-pcie: Use dev_err_probe() to simplify code
      phy: qcom-qusb2: Use dev_err_probe() to simplify code
      phy: qcom-snps: Use dev_err_probe() to simplify code
      phy: tegra: xusb: Use dev_err_probe() to simplify code
      phy: intel: Use dev_err_probe() to simplify code
      phy: qcom-qmp-combo: Use dev_err_probe() to simplify code
      phy: qcom-qmp-pcie-msm8996: Use dev_err_probe() to simplify code
      phy: qcom-qmp-ufs: Use dev_err_probe() to simplify code
      phy: qcom-qmp-usb: Use dev_err_probe() to simplify code

 .../bindings/mfd/ti,j721e-system-controller.yaml   |   6 +
 .../bindings/phy/brcm,cygnus-pcie-phy.yaml         |   1 +
 .../devicetree/bindings/phy/cdns,dphy-rx.yaml      |   2 +-
 .../devicetree/bindings/phy/cdns,dphy.yaml         |   2 +-
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |  11 +
 .../bindings/phy/mscc,vsc7514-serdes.yaml          |  56 ++
 .../devicetree/bindings/phy/phy-ocelot-serdes.txt  |  43 --
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       |   1 +
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   2 +
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 .../bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml    | 189 +++++
 .../devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml | 296 ++++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 502 -------------
 .../devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml  | 240 ++++++
 .../devicetree/bindings/phy/qcom,qmp-usb-phy.yaml  | 401 ++++++++++
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |  25 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  89 +++
 .../devicetree/bindings/phy/rcar-gen2-phy.txt      | 112 ---
 .../bindings/phy/renesas,rcar-gen2-usb-phy.yaml    | 123 ++++
 .../bindings/phy/rockchip,pcie3-phy.yaml           |  80 ++
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml       |   1 +
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       |   1 +
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |  47 +-
 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |  73 ++
 .../devicetree/bindings/phy/ti,phy-gmii-sel.yaml   |  27 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |  27 +-
 MAINTAINERS                                        |  10 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |   2 +-
 .../phy/amlogic/phy-meson-axg-mipi-pcie-analog.c   |   6 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |  32 +-
 drivers/phy/intel/phy-intel-lgm-combo.c            |  45 +-
 drivers/phy/mediatek/phy-mtk-dp.c                  |   2 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c         | 238 +++---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c         | 246 +++----
 drivers/phy/mediatek/phy-mtk-hdmi.c                |  33 -
 drivers/phy/mediatek/phy-mtk-hdmi.h                |   7 -
 drivers/phy/mediatek/phy-mtk-io.h                  |   8 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c     | 164 +++--
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c     |  74 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |  24 -
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h            |   5 -
 drivers/phy/mediatek/phy-mtk-pcie.c                |  17 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                | 223 +++---
 drivers/phy/mediatek/phy-mtk-ufs.c                 |  78 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c               |  46 +-
 drivers/phy/microchip/lan966x_serdes.c             |  99 ++-
 drivers/phy/microchip/lan966x_serdes_regs.h        |  42 ++
 drivers/phy/qualcomm/phy-qcom-edp.c                | 221 +++++-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 819 ++++++++++++++---=
----
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   | 251 ++-----
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 360 +++------
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h         |  13 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v5_5nm.h    | 333 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 270 ++-----
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 468 +++++++-----
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  27 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 273 ++++++-
 drivers/phy/qualcomm/phy-qcom-usb-hsic.c           |   6 +-
 drivers/phy/rockchip/Kconfig                       |   9 +
 drivers/phy/rockchip/Makefile                      |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   |  24 +
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   | 204 +++--
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  10 +-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 322 ++++++++
 drivers/phy/sunplus/Kconfig                        |  12 +
 drivers/phy/sunplus/Makefile                       |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c             | 296 ++++++++
 drivers/phy/tegra/xusb-tegra186.c                  |   9 +-
 drivers/phy/tegra/xusb.c                           |   3 +-
 drivers/phy/ti/phy-gmii-sel.c                      |  47 +-
 drivers/phy/ti/phy-j721e-wiz.c                     | 248 ++++++-
 include/dt-bindings/phy/phy.h                      |   1 +
 include/linux/phy/pcie.h                           |  12 +
 77 files changed, 5351 insertions(+), 2654 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mscc,vsc7514-serd=
es.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-=
pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy=
=2Eyaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rcar-gen2=
-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-ph=
y.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-us=
b2-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_5nm.h
 create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c
 create mode 100644 include/linux/phy/pcie.h

--=20
~Vinod

--xdY9J5uc3Tpnz67P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmNAJNcACgkQfBQHDyUj
g0f03g//bXJHdc0S2R1GXXZCNM1NtQwhtOiVlKjVHl0AO2PylbwSPgPTAoGgUYFh
uokRNjVhyRhzUE2PConkLbt4CV0wonWTDXAUjTXvTyyqM6l6xM9bX1dfpHIHBW91
IgfXOCR192XpQxPplt28lWKXE1UNNjforhk1qevFk4BxUlX8J8qKnJ1H73EVWquv
HM5ShklbX3+ltzGyeYWB1YSgdBJRdohQe1r+WqHyTru6bagsjwuRwfGvK6W2S3YW
tqqL38+naBJ42E3bfOkEhQj/uPs5BBgjGZb6XjlDu2JBPumU6RtNlZpa5j/fpqu9
z4ecmD4vq6GAG8Cd6rQeu5V6WfXXR5n6ys46Ipvz+ctNHEJt+S2+V2W/ORlXK07V
8QSnf3cQuvbFO4uawIDgEyYa9gSII2AXdZTJb68QnX6FvBw53l05rIROH6APXBwu
rZMsvz/ovh726XAJZnTiLi+Vw1Yu9vXxa4K8oj6W16TxCq1MloohdJCdwMlLrTVC
Ty6f0PvJscpKfvysg0sG/paHPEYwUG8jN+eRxlm28fMelbWIlpYaCCKXCnRgtzJ4
2RZ4OX/k5gDeNgBUOykOdaKZK1mX4GEBKZCl4C3nWV7aE3mprUwe1mg1LNQ2xQvD
atNIsTm3VdGHcCtP5BVax5FhKGrtSqR7qpgGkIE9S8vJ6qBZSUA=
=aYHD
-----END PGP SIGNATURE-----

--xdY9J5uc3Tpnz67P--
