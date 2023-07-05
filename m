Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE449747EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjGEIF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGEIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445710DD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C3C6143D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514CAC433C8;
        Wed,  5 Jul 2023 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688544325;
        bh=k0lOI1pPpXEXR6H90EWFTDmam7F2+yLIgeIuZmlqWOA=;
        h=Date:From:To:Cc:Subject:From;
        b=b/lR2rWCh/iq+sHOzE1nZu9SfmNwAZO2uph8Y6/1Z16ZHaG0UbnnBT0JlG/lW/21I
         DbXLh/EyHGr1prkZmIaz8VNHkLbnRbQDcek0gRLxaL4f34HQOll8M3/lLmnEdX8Mm+
         OjM7zrd/0lop1la89PuWyiP9MKjXl826/HaKZAZBlWBZmNgO95XGCQ0gF2FR5b234c
         bKQVEv/MEcaaRb7raGIHB8P+4GsxAoKroAs2Emrpv783Zv8foKpt8sESsv090LAyZK
         8giKcjIHqVHIC/NTGetH4xJppAFNFttEIRlGrGYgcWegvfvXoz6aKEWZglFFb0+tad
         dxOYPCidivhxw==
Date:   Wed, 5 Jul 2023 13:35:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy subsystem updates for v6.5-rc1
Message-ID: <ZKUkQTLeDMNIyyK7@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LSFxs+oeAN1p21AR"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LSFxs+oeAN1p21AR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the generic phy subsystem updates. This includes
bunch of new controller support, dropping of a driver and updates to
various drivers.

This is also based on phy/fixes tag which is already upstream.

The following changes since commit 2a881183dc5ab2474ef602e48fe7af34db460d95:

  phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc (2023-05-16 19:4=
8:55 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.5

for you to fetch changes up to a454850a815e62fa5d7c1eded0e8d56742613b94:

  dt-bindings: phy: brcm,brcmstb-usb-phy: Fix error in "compatible" conditi=
onal schema (2023-06-22 13:29:38 +0530)

----------------------------------------------------------------
phy-for-6.5

 - New support:
   - TI J784S4  gmii phy and SGMII support
   - Rockchip RK3588 naneng combo phy
   - Mediatek mt8195 hdmi phy
   - Qualcomm UFS PHY for sa8775p, SM7150, PCI phy for SDX65
   - Drop Thunder Bay eMMC PHY support

 - Updates
   - Further cleanup for Qualcomm phys and support for PCIe RC
   - Xilinx zynqmp SGMII support
   - Cadence Sierra PCIe + SGMII PHY multilink configuration
   - Phy subsystem platform remove callback

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: phy: mixel,mipi-dsi-phy: Remove assigned-clock* properti=
es

Artur Weber (1):
      phy: Revert "phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB"

Bartosz Golaszewski (4):
      dt-bindings: phy: qmp-ufs: tweak clock and clock-names for sa8775p
      phy: qualcomm: fix indentation in Makefile
      dt-bindings: phy: describe the Qualcomm SGMII PHY
      phy: qcom: add the SGMII SerDes PHY driver

Bhupesh Sharma (2):
      dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newe=
r one (SM6115 & QCM2290)
      phy: qcom-qmp-usb: add support for updated qcm2290 / sm6115 binding

Bjorn Andersson (6):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and orientatio=
n-switch
      phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
      phy: qcom-qmp-combo: Extend phy_mutex to all phy_ops
      phy: qcom-qmp-combo: Introduce orientation variable
      phy: qcom-qmp-combo: Introduce orientation switching
      phy: qcom-qmp-combo: Introduce drm_bridge

Chunfeng Yun (2):
      phy: core: add debugfs files
      phy: mediatek: tphy: add debugfs files

Claudiu Beznea (1):
      phy: tegra: xusb: check return value of devm_kzalloc()

Daniel Machon (7):
      phy: sparx5-serdes: add registers required for SD/CMU power down
      phy: sparx5-serdes: configure optimal quiet mode for serdes lanes
      phy: sparx5-serdes: reorder CMU functions
      phy: sparx5-serdes: power down all CMUs by default
      phy: sparx5-serdes: power on CMUs individually
      phy: sparx5-serdes: remove power up of all CMUs
      phy: sparx5-serdes: add skip_cmu_cfg check when configuring lanes

David Yang (2):
      phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100
      phy: hisilicon: Allow building phy-hisi-inno-usb2 on ARM32

Dmitry Baryshkov (1):
      dt-bindings: phy: qcom,qmp-usb: fix bindings error

Dmitry Rokosov (1):
      phy: amlogic: enable/disable clkin during Amlogic USB PHY init/exit

EJ Hsu (1):
      phy: tegra: xusb: Clear the driver reference in usb-phy dev

Frank Li (2):
      phy: cadence: salvo: Add cdns,usb2-disconnect-threshold-microvolt pro=
perty
      dt-bindings: phy: cdns,salvo: add property cdns,usb2-disconnect-thres=
hold-microvolt

Johannes Zink (1):
      dt-bindings: phy: imx8mq-usb: add phy tuning properties

Justin Chen (2):
      phy: usb: Turn off phy when port is in suspend
      phy: usb: suppress OC condition for 7439b2

Krzysztof Kozlowski (2):
      dt-bindings: phy: qcom,edp-phy: allow power-domains
      dt-bindings: phy: intel,combo-phy: restrict node name suffixes

Li Jun (1):
      phy: fsl-imx8mp-usb: add support for phy tuning

Neil Armstrong (1):
      phy: qcom: qmp-combo: fix Display Port PHY configuration for SM8550

Peter Chen (4):
      phy: cadence: salvo: add access for USB2PHY
      phy: cadence: salvo: decrease delay value to zero for txvalid
      phy: cadence: salvo: add bist fix
      phy: cadence: salvo: add .set_mode API

Rob Herring (1):
      dt-bindings: phy: brcm,brcmstb-usb-phy: Fix error in "compatible" con=
ditional schema

Rudraksha Gupta (1):
      dt-bindings: phy: qcom,usb-hs-phy: Add compatible

Shazad Hussain (4):
      dt-bindings: usb: qcom,dwc3: Add bindings for SA8775P
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SA8775P
      dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add SA8775P USB PHY bin=
ding
      phy: qcom-qmp: Add SA8775P USB3 UNI phy

Siddharth Vadapalli (5):
      phy: ti: gmii-sel: Add support for SGMII mode
      phy: ti: gmii-sel: Enable SGMII mode for J7200
      phy: ti: gmii-sel: Enable SGMII mode for J721E
      phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J784S4
      phy: ti: gmii-sel: Enable USXGMII mode for J784S4

Stanislav Jakubek (1):
      dt-bindings: phy: brcm,kona-usb2-phy: convert to YAML

Swapnil Jakhade (4):
      phy: cadence-torrent: Add function to get PLL to be configured for DP
      phy: cadence-torrent: Prepare driver for multilink DP support
      phy: cadence-torrent: Add PCIe + DP multilink configuration for 100MH=
z refclk
      phy: cadence-torrent: Add USB + DP multilink configuration

Varadarajan Narayanan (4):
      dt-bindings: phy: qcom,qusb2: Document IPQ9574 compatible
      dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
      phy: qcom-qusb2: add QUSB2 support for IPQ9574
      phy: qcom: qmp: Update IPQ9574 USB Phy initialization Sequence

Vinod Koul (3):
      Merge branch 'fixes' into next
      dt-bindings: phy: qcom,qmp-pcie: fix the sc8180x regs
      dt-bindings: phy: qcom,qmp-ufs: fix the sc8180x regs

Xu Yang (2):
      dt-bindings: phy: mxs-usb-phy: convert to DT schema format
      dt-bindings: phy: mxs-usb-phy: add imx8ulp and imx8qm compatible

Yang Li (1):
      phy: freescale: imx8m-pcie: Use devm_platform_ioremap_resource()

 .../bindings/phy/brcm,brcmstb-usb-phy.yaml         |   4 +-
 .../devicetree/bindings/phy/brcm,kona-usb2-phy.txt |  15 -
 .../bindings/phy/brcm,kona-usb2-phy.yaml           |  36 ++
 .../devicetree/bindings/phy/cdns,salvo-phy.yaml    |   6 +
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  47 ++
 .../devicetree/bindings/phy/fsl,mxs-usbphy.yaml    | 128 ++++
 .../devicetree/bindings/phy/intel,combo-phy.yaml   |   2 +-
 .../bindings/phy/mixel,mipi-dsi-phy.yaml           |   9 -
 .../devicetree/bindings/phy/mxs-usb-phy.txt        |  33 -
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   3 +
 .../bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |   2 +-
 .../bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml     |  18 +-
 .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    |  27 -
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   3 +-
 .../bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml |  55 ++
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |   4 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |  65 +-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  51 ++
 .../devicetree/bindings/phy/qcom,usb-hs-phy.yaml   |   5 +-
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |   1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  21 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c          |  15 +-
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c  |  15 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           |  34 +
 drivers/phy/broadcom/phy-brcm-usb-init.h           |   8 +
 drivers/phy/cadence/phy-cadence-salvo.c            |  95 ++-
 drivers/phy/cadence/phy-cadence-torrent.c          | 720 +++++++++++++++--=
----
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |   4 +-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         | 218 +++++++
 drivers/phy/hisilicon/Kconfig                      |   2 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |  60 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                | 356 ++++++++++
 drivers/phy/microchip/sparx5_serdes.c              | 426 +++++++-----
 drivers/phy/microchip/sparx5_serdes.h              |   1 -
 drivers/phy/microchip/sparx5_serdes_regs.h         | 106 +++
 drivers/phy/phy-core.c                             |  14 +
 drivers/phy/qualcomm/Kconfig                       |  12 +
 drivers/phy/qualcomm/Makefile                      |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 263 ++++++--
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 182 ++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c          | 451 +++++++++++++
 drivers/phy/samsung/Kconfig                        |   2 +-
 drivers/phy/tegra/xusb.c                           |   4 +
 drivers/phy/ti/phy-gmii-sel.c                      |  34 +-
 include/linux/phy/phy.h                            |   2 +
 46 files changed, 3005 insertions(+), 560 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,kona-usb2-ph=
y.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,kona-usb2-ph=
y.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,mxs-usbphy.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/phy/mxs-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sa8775p-dwma=
c-sgmii-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c

--=20
~Vinod

--LSFxs+oeAN1p21AR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmSlJEEACgkQfBQHDyUj
g0eHlA/+KyMD1KiISO0Xv04LFb8FIEU+R43JGc5HvCHQx0zFYr4hFqgny13lerhy
ROvK7d0L/HCR9JQiHJ5PcHCmURTuO+qyw43WlcSzDnUAPXhUeNSv6ryC+NkQPZX8
ChT/TqvFmIpVdHAyfHTvP8gyVdMEzxonIJh1gNr50BhsLhtQBpmW92aKQg5xkqw6
i+Q9oRA3gI0XlRmF/FrYnFPvmeRxA50cAcFM+6Uwmr44F2oeWEflbBSjjDM/jpJm
TXyOb1s43xZlk9VMXcu8Y8vKFF0mc8C4cv0RrcciJGIIEfgE077tYXVV1a4ezpSO
x3MwnZo0kQKqri61xZXrxa1zA6SmutAe3cWj2NYEWZEn4rFn6We2yABJ2O0c/Xjh
5exC7EoH5kDXujrmJii2dGibX4av5XziDL7bjFYzwKGH33NXEmsNil6PIMOAEt0q
PYXM2tf/Y1SC2XGPPgOMK/R25QWRZlXxqTXfsHwdL1Fu8DviX6ARCfqLmMw19Pxj
S7J41xUY5+gRU3ilpxOyn8/sXdqnaOtSRiv9IvCOBUQPTTBo+6ZXvbavNj5sPWYa
wEPg+hR+wkToqAqNPUUQVXVFyOq9u4NVwXzBc5HH/gVALI7I3BlcLY4phxk7YW22
xNsIw0yEChbwZauH7pYMQ1qWFgR4TFcXJy7vyXgfwwsFXpkDZ0I=
=Lhup
-----END PGP SIGNATURE-----

--LSFxs+oeAN1p21AR--
