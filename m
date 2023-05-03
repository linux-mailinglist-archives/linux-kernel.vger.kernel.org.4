Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0A6F5690
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjECKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjECKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505D5FCC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C19161EB7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791A6C433EF;
        Wed,  3 May 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110885;
        bh=E7dDNFzf05YwIQv1FzQ+P1S+4NYL/FcPlnOq8lTgrh8=;
        h=Date:From:To:Cc:Subject:From;
        b=TINLnwwp4vxOMT62XKgYMUG2uGtH6Oj6zrF2UebzGlTyy0tcC/dgtgcA1E8+ZAqHg
         TFW2LpqD3Fv7Ti7cnrtOOEBZVdSZoZW5kS8XABVRZfSHVhhUX44NATd/gT5ElLLkpR
         emY/0ADIs1tBBCzfcIxQsTTA4/MJA5uTaNHu4Qv3hiWH8myl0oTyeRoZlYBD80VrUO
         327U18tKkqyH5z3e+j5Qff8WgCw/Dvp7QKeMTjioyZT5RJUuQyH8PMBiuSEdZk/PIb
         yFLqfAg1FlTst2UcV4if31fDqZs1soHN3FXzsOjGv/Gchz8pfMm0IcAxxuYYOAEV4Z
         ttR80iRm8giaw==
Date:   Wed, 3 May 2023 16:18:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: [GIT PULL]: Generic phy updates for v6.4
Message-ID: <ZFI74eeUzVPKhi4f@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kaDgpFRSWYCTU2t3"
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaDgpFRSWYCTU2t3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please consider pull to receive generic phy updates for v6.4-rc1. We
have a bunch of new controller support in qcom, mediatek and rk socs.
Intel Thunder Bay eMMC PHY driver is dropped as no users and bunch of
driver updates for the subsystem

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.4

for you to fetch changes up to a0106132372120dd0abf5ad7636614e5aeb5da08:

  phy: cadence: cdns-dphy-rx: Add common module reset support (2023-04-12 2=
2:16:16 +0530)

----------------------------------------------------------------
phy-for-6.4

  - New support:
        - UFS PHY for Qualcomm SA8775p, SM7150
        - PCIe 2 lane phy support for sc8180x and PCIe PHY for SDX65
        - Mediatke hdmi phy support for mt8195
        - rockchip naneng combo phy support for RK358

  - Updates:
        - Drop Thunder Bay eMMC PHY driver
        - RC support for PCIe phy for Qualcomm SDX55
        - SGMII support in WIZ driver for J721E
        - PCIe and multilink SGMII PHY support in cadence driver
        - Big pile of platform remove callback returning void conversions

----------------------------------------------------------------
A, Rashmi (2):
      phy: intel: Remove Thunder Bay eMMC PHY support
      dt-bindings: phy: intel: Remove Thunder Bay eMMC PHY bindings

Alain Volmat (1):
      phy: st: miphy28lp: use _poll_timeout functions for waits

Bartosz Golaszewski (2):
      dt-bindings: phy: qmp-ufs: describe the UFS PHY for sa8775p
      phy: qualcomm: phy-qcom-qmp-ufs: add definitions for sa8775p

David Wronek (2):
      dt-bindings: phy: Add QMP UFS PHY comptible for SM7150
      phy: qcom-qmp-ufs: Add SM7150 support

Dmitry Baryshkov (4):
      phy: qcom-qmp-combo: fix v3 offsets table
      phy: qcom-qmp-combo: use qmp_combo_offsets_v3 instead of _v6
      phy: qcom-qmp-pcie: sc8180x PCIe PHY has 2 lanes
      phy: qcom-qmp-pcie: drop sdm845_qhp_pcie_rx_tbl

Gaosheng Cui (1):
      phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_por=
t and ulpi_port

Guillaume Ranquet (3):
      dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
      phy: phy-mtk-hdmi: Add generic phy configure callback
      phy: mediatek: add support for phy-mtk-hdmi-mt8195

Henry Lin (1):
      phy: tegra: xusb: Support sleepwalk for Tegra234

Krzysztof Kozlowski (7):
      phy: marvell: drop of_match_ptr for ID table
      phy: st: spear: drop of_match_ptr for ID table
      dt-bindings: phy: cadence-sierra: drop assigned-clocks
      dt-bindings: phy: cadence-torrent: drop assigned-clocks
      dt-bindings: phy: ti,phy-am654-serdes: drop assigned-clocks type
      dt-bindings: phy: ti,phy-j721e-wiz: drop assigned-clocks
      dt-bindings: phy: ti,phy-j721e-wiz: document clock-output-names

Lars-Peter Clausen (2):
      phy: cadence: Sierra: Replace `clk_register(`) with `clk_hw_register(=
)`
      phy: cadence: Sierra: Use clk_parent_data to provide parent informati=
on

Lucas Tanure (3):
      dt-bindings: PCI: dwc: Add rk3588 compatible
      dt-bindings: phy: rockchip: Add rk3588 compatible
      phy: rockchip: Add naneng combo phy support for RK3588

Manivannan Sadhasivam (2):
      phy: qcom-qmp-pcie: Split out EP related init sequence for SDX55
      phy: qcom-qmp-pcie: Add RC init sequence for SDX55

Mark Brown (1):
      phy: xgene: Depend on ARCH_XGENE rather than plain arm64

Michael Grzeschik (1):
      phy: stm32-usphyc: add 200 to 300 us delay to fix timeout on some mac=
hines

Radhey Shyam Pandey (1):
      phy: xilinx: phy-zynqmp: mention SGMII as supported protocol

Rob Herring (2):
      phy: Use of_property_present() for testing DT property presence
      dt-bindings: phy: Drop unneeded quotes

Rohit Agarwal (2):
      dt-bindings: phy: qcom,qmp: Add SDX65 QMP PHY
      phy: qcom-qmp: Add support for SDX65 QMP PCIe PHY

Siddharth Vadapalli (3):
      phy: ti: j721e-wiz: Fix unreachable code in wiz_mode_select()
      dt-bindings: phy: ti: phy-gmii-sel: Add support for J784S4 CPSW9G
      phy: ti: j721e-wiz: Add SGMII support in WIZ driver for J721E

Sinthu Raja (1):
      phy: cadence: cdns-dphy-rx: Add common module reset support

Swapnil Jakhade (1):
      phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration

Tom Rix (2):
      phy: rockchip-pcie: remove unused phy_rd_cfg function
      phy: rockchip: remove unused hw_to_inno function

Uwe Kleine-K=F6nig (31):
      phy: allwinner: phy-sun4i-usb: Convert to platform remove callback re=
turning void
      phy: broadcom: phy-brcm-usb: Convert to platform remove callback retu=
rning void
      phy: cadence: cdns-dphy: Convert to platform remove callback returnin=
g void
      phy: cadence: phy-cadence-sierra: Convert to platform remove callback=
 returning void
      phy: cadence: phy-cadence-torrent: Convert to platform remove callbac=
k returning void
      phy: freescale: phy-fsl-imx8qm-lvds-phy: Convert to platform remove c=
allback returning void
      phy: intel: phy-intel-lgm-combo: Convert to platform remove callback =
returning void
      phy: mediatek: phy-mtk-mipi-dsi: Convert to platform remove callback =
returning void
      phy: motorola: phy-cpcap-usb: Convert to platform remove callback ret=
urning void
      phy: motorola: phy-mapphone-mdm6600: Convert to platform remove callb=
ack returning void
      phy: phy-lgm-usb: Convert to platform remove callback returning void
      phy: qualcomm: phy-qcom-apq8064-sata: Convert to platform remove call=
back returning void
      phy: qualcomm: phy-qcom-eusb2-repeater: Convert to platform remove ca=
llback returning void
      phy: qualcomm: phy-qcom-ipq806x-sata: Convert to platform remove call=
back returning void
      phy: renesas: phy-rcar-gen3-pcie: Convert to platform remove callback=
 returning void
      phy: renesas: phy-rcar-gen3-usb2: Convert to platform remove callback=
 returning void
      phy: renesas: phy-rcar-gen3-usb3: Convert to platform remove callback=
 returning void
      phy: renesas: r8a779f0-ether-serdes: Convert to platform remove callb=
ack returning void
      phy: rockchip: phy-rockchip-inno-csidphy: Convert to platform remove =
callback returning void
      phy: rockchip: phy-rockchip-inno-dsidphy: Convert to platform remove =
callback returning void
      phy: rockchip: phy-rockchip-inno-hdmi: Convert to platform remove cal=
lback returning void
      phy: rockchip: phy-rockchip-typec: Convert to platform remove callbac=
k returning void
      phy: st: phy-stm32-usbphyc: Convert to platform remove callback retur=
ning void
      phy: tegra: xusb: Convert to platform remove callback returning void
      phy: ti: phy-am654-serdes: Convert to platform remove callback return=
ing void
      phy: ti: phy-da8xx-usb: Convert to platform remove callback returning=
 void
      phy: ti: phy-dm816x-usb: Convert to platform remove callback returnin=
g void
      phy: ti: phy-j721e-wiz: Convert to platform remove callback returning=
 void
      phy: ti: phy-omap-usb2: Convert to platform remove callback returning=
 void
      phy: ti: phy-ti-pipe3: Convert to platform remove callback returning =
void
      phy: ti: phy-twl4030-usb: Convert to platform remove callback returni=
ng void

Yang Li (1):
      phy: dphy: Use devm_platform_ioremap_resource()

Ye Xingchen (1):
      phy: omap-usb2-phy: Use dev_err_probe()

 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |   6 +-
 .../bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml |   4 +-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |   2 +-
 .../bindings/phy/amlogic,axg-mipi-dphy.yaml        |   4 +-
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml         |   4 +-
 .../bindings/phy/amlogic,g12a-usb2-phy.yaml        |   4 +-
 .../bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml   |   4 +-
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |   4 +-
 .../bindings/phy/amlogic,meson-axg-pcie.yaml       |   4 +-
 .../bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml   |   4 +-
 .../bindings/phy/amlogic,meson8b-usb2-phy.yaml     |   4 +-
 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml        |   4 +-
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     |   4 +-
 .../devicetree/bindings/phy/cdns,salvo-phy.yaml    |   4 +-
 .../bindings/phy/hisilicon,hi3660-usb3.yaml        |   4 +-
 .../bindings/phy/hisilicon,hi3670-usb3.yaml        |   6 +-
 .../bindings/phy/intel,phy-thunderbay-emmc.yaml    |  45 --
 .../bindings/phy/marvell,armada-3700-utmi-phy.yaml |   4 +-
 .../phy/marvell,armada-cp110-utmi-phy.yaml         |   4 +-
 .../bindings/phy/marvell,mmp3-hsic-phy.yaml        |   4 +-
 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |   1 +
 .../bindings/phy/mediatek,mt7621-pci-phy.yaml      |   4 +-
 .../bindings/phy/phy-cadence-sierra.yaml           |  12 +-
 .../bindings/phy/phy-cadence-torrent.yaml          |  10 +-
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  |   1 +
 .../devicetree/bindings/phy/phy-tegra194-p2u.yaml  |   4 +-
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   4 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   4 +-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   1 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |  27 +-
 .../devicetree/bindings/phy/qcom,usb-hs-28nm.yaml  |   4 +-
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |   4 +-
 .../devicetree/bindings/phy/qcom,usb-ss.yaml       |   4 +-
 .../bindings/phy/qcom-usb-ipq4019-phy.yaml         |   4 +-
 .../bindings/phy/samsung,exynos-pcie-phy.yaml      |   4 +-
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |   2 +-
 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |   4 +-
 .../bindings/phy/ti,phy-am654-serdes.yaml          |   5 -
 .../devicetree/bindings/phy/ti,phy-gmii-sel.yaml   |   8 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |  25 +-
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |   4 +-
 MAINTAINERS                                        |   7 -
 drivers/phy/Kconfig                                |   2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |   8 +-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      |   4 +-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |   2 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |   6 +-
 drivers/phy/cadence/cdns-dphy-rx.c                 |  32 ++
 drivers/phy/cadence/cdns-dphy.c                    |   6 +-
 drivers/phy/cadence/phy-cadence-sierra.c           | 250 +++++++---
 drivers/phy/cadence/phy-cadence-torrent.c          |   6 +-
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c    |   6 +-
 drivers/phy/intel/Kconfig                          |  10 -
 drivers/phy/intel/Makefile                         |   1 -
 drivers/phy/intel/phy-intel-lgm-combo.c            |   5 +-
 drivers/phy/intel/phy-intel-thunderbay-emmc.c      | 509 -----------------=
----
 drivers/phy/marvell/phy-pxa-28nm-hsic.c            |   2 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c            |   2 +-
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         | 495 +++++++++++++++++=
+++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         | 113 +++++
 drivers/phy/mediatek/phy-mtk-hdmi.c                |  15 +
 drivers/phy/mediatek/phy-mtk-hdmi.h                |   3 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |   5 +-
 drivers/phy/motorola/phy-cpcap-usb.c               |   6 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |   6 +-
 drivers/phy/phy-lgm-usb.c                          |   6 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |   6 +-
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |   8 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c       |   6 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  19 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 263 ++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |  24 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  98 ++++
 drivers/phy/renesas/phy-rcar-gen3-pcie.c           |   6 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   6 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c           |   6 +-
 drivers/phy/renesas/r8a779f0-ether-serdes.c        |   6 +-
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   |   6 +-
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   |  11 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |   6 +-
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 184 ++++++++
 drivers/phy/rockchip/phy-rockchip-pcie.c           |  15 -
 drivers/phy/rockchip/phy-rockchip-typec.c          |   6 +-
 drivers/phy/st/phy-miphy28lp.c                     |  42 +-
 drivers/phy/st/phy-spear1310-miphy.c               |   2 +-
 drivers/phy/st/phy-spear1340-miphy.c               |   2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   9 +-
 drivers/phy/tegra/xusb-tegra186.c                  |  20 +
 drivers/phy/tegra/xusb.c                           |   8 +-
 drivers/phy/tegra/xusb.h                           |   1 +
 drivers/phy/ti/phy-am654-serdes.c                  |   6 +-
 drivers/phy/ti/phy-da8xx-usb.c                     |   6 +-
 drivers/phy/ti/phy-dm816x-usb.c                    |   6 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |  19 +-
 drivers/phy/ti/phy-omap-usb2.c                     |  14 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |   6 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   6 +-
 drivers/phy/xilinx/phy-zynqmp.c                    |   5 +-
 102 files changed, 1628 insertions(+), 973 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunder=
bay-emmc.yaml
 delete mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h

--=20
~Vinod

--kaDgpFRSWYCTU2t3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmRSO+AACgkQfBQHDyUj
g0eVOg/+KMusx5J55yszyQr5O/mQ4y3Ri7fNJpsLxC1SbEBW6TSCkDV0haXchKpJ
zKJASiDOXYTP5ESnx4GZ3xnh9Zn357bkaCLgHdUbBfQBkJCFto6U5TntCTsHz7sw
3DbR0FVVW+jEazgVGAufy+RtqpPTj48qGRcbqb+ogeot4Bw7LP/naP9UiU/gf+uZ
Rxfyg2wbaiLhwvHp250WQpsOG1te0pYltD442asj/IWjDu/01fzMUly1IUIP5ID7
CDeF8re/MU1UxrwS22qF6N0nohNtUeAjJ6/cPgL0GTJ8Zq5Cn2qQv5pWf0fxGmJY
2NJBwgZAXvkjPKL2c0CRfFFo0lZLPXPdWcXi8fiT+fNMl7impn1Drtvca5KRQB4s
Vkmte1yIsJKOsUSDB/57jHvln2RZbfMh1zAV5a2j8OqkHZ1ka4KUbNmelUouPQjp
sWSETE8hfyhZnkS/K+4XtBBtjtjQg5mBGwSvExXSesdcB5NisM01fqcp366cfiXr
CVr2c/3fEFMdjNuXyLwj5haQ1+tr2VB3uT7PHygDZ0IOsWcKPzudIQEoilSNH8qJ
FbsARd0zgLg+gZ4A/3WlyxlhGB+Euwsi2lS0m8IS30ym2BlOrxkG8yHf3ymZDjte
Kz5hK+DBcJvo+exqmWVnpH6m70inwxxd3GBTFM439FmR3+bkJfs=
=3/jO
-----END PGP SIGNATURE-----

--kaDgpFRSWYCTU2t3--
