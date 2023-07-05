Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C93748E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGEUFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGEUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A120188
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E4D4616E4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845A9C433C7;
        Wed,  5 Jul 2023 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688587514;
        bh=/9Wf08zwHCPkfI9j/bmmemPjMIDBcY9mCKRm+cSjE4g=;
        h=Date:From:To:Cc:Subject:From;
        b=a1KlZIaqwNONvvnILN/Az7/QC9ERfNH/sOggKDNGPWG4nF9GbQP4lIrmINXwzRUhX
         NqpJ1IIilxnx+rWVOsziXXwEdqz0yu+iOt6ypP94LfW3K5RcdZf1HVdw/6sWxfpvpq
         lH0ekN7BkLAU6m2ClOBaf7CuDakuKPVbdpJy2IoRN/2NCK17K0b8/+zWA3LxtBnFyu
         k6KfUataZA+FF6UqbTZWlZxtOzm0H9QjOu0ARel2wi/r9XU14kr+ml5LmdHvP4/Ktg
         M3VfRKA0X20vLE935GPLxlA2dqVDXOvoKMrXxX98MSRNMZlMv/3nMe9RO5ZKjFFYaO
         Oqsb0pUS7iepw==
Date:   Thu, 6 Jul 2023 01:35:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.5-rc1, v2
Message-ID: <ZKXM9Ww8gNkH5yfZ@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1HJOG35jfV+NnA+r"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1HJOG35jfV+NnA+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Here is the v2 of the earlier messed up PR. I have regenerated this and
hopefully this would turn to be okay.

So, please excuse my mistake and consider pull to receive updates
containing, core debugfs support, a new driver for Hisilicon Hi3798MV100,
bunch of Qualcomm device support incliuding drm_bridge support for DP
compo phy. Low Power optimzation for Sparx5 serdes driver, cadence salvo
USB and torrent updates for DP with PCIE/USB and couple of YAML binding
conversions

And this request is based on phy fixes already upstream.

The following changes since commit 2a881183dc5ab2474ef602e48fe7af34db460d95:

  phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc (2023-05-16 19:4=
8:55 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.5_v2

for you to fetch changes up to a454850a815e62fa5d7c1eded0e8d56742613b94:

  dt-bindings: phy: brcm,brcmstb-usb-phy: Fix error in "compatible" conditi=
onal schema (2023-06-22 13:29:38 +0530)

----------------------------------------------------------------
phy-for-6.5-v2

- New Support
  - Debugfs support for phy core and mediatek driver
  - Hisilicon inno-usb2-phy driver supporting Hi3798MV100
  - Qualcomm SGMII SerDes PHY driver, SM6115 & QCM2290 QMP-USB support,
    SA8775P USB PHY & USB3 UNI support, QUSB2 support for IPQ9574, IPQ9574 =
USB3 PHY

- Updates
  - Sparx5 serdes phy power optimzation
  - cadence salvo usb properties and updates and torrent DP with PCIe &
    USB support
  - Yaml conversion for Broadcom kona USB bindings and MXS USB binding

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

--1HJOG35jfV+NnA+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmSlzPUACgkQfBQHDyUj
g0dyRBAAvy6inPD0yo62QBQgz4YsZTH27Eat4HSHKyWrctWzvEkPbEhP2UzV+sFT
Vch+P9EZWzFEVy2cxUTDWziZZiSy674ymmdooCM9mP76lFFv327kQCvz0z+yp2KL
VnETB7jlg2B/QfBIp3Kb8eHS4527ibpfRtGBG+V07XFBColDMjBJrOhV21izf82e
fOLAMwY2btkLlque5mk8cajq+tk7TKjPfYIaul7KOuhrzT2KnF3iv3fj/gv+Nee7
W0AaapFH6IcX5EjUSYudbEn2L5EYEdy39nyg1at9bjEvcKu6ArqrdIh5nIBPp8xF
SoJIGzGLAh97uyWCTfflSlrmHyswPOsvlIHrpcXa1HcDeKogKxLT7Xg9n0n9ZbVL
UPXyzDPbCwkg+LG2kD/95gHzYLH/fbtQTrTYrLQU0DHXhwy1I3GYCOrxI9GMQWC7
Wof7+GKIzROZW0SW27cQymCqVAR2Lhsvdul4JrIsxWs2KKWYjILtvRb2LewaDVTK
sTs0f260FuJMfocX2YTomBmKp7HMLi0iewyUC+gccZ3DgQOw7mz1Cftp4+O3QYfk
aMLHuXo4lhGq5/1nThwlL0XaM1jcMm5nSOOJ6g5oba3Dzwy8wmbvQcoKZm8m9jbq
nty8M6wBDnCXUFjdcfAXVOa+I2jbnlfmVF4ooj3UbClLmNEqyhM=
=uV8v
-----END PGP SIGNATURE-----

--1HJOG35jfV+NnA+r--
