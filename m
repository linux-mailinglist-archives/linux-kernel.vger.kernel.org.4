Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359074957E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjGFGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjGFGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBB10F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20FF561877
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F81C433C8;
        Thu,  6 Jul 2023 06:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688624446;
        bh=kGTtffnGyt3hq4GoD2/gn1hxX2jZbaQwoHdDrXAlhHA=;
        h=Date:From:To:Cc:Subject:From;
        b=MNTE+r9WAJjwq4ehVEBx12YsEhGqpbwxuajhcAluDO2oqqHrMs1Up9AfR0vVtA8rX
         OrjVSzOTHCi24yD2e1ReuiFEONJRs/ykKgFRlQkb3ilGhEHZWobEeqOz+j67SmGHYL
         ZSsY/JR1dt2aVTyJFDulW+M+rgskzZ3VO7iPpLuhdkLi8jlj4j5M92t8fWG1mvyeH8
         hhIxxKsfd08yff824cFtuYpHx8iU8ncCWdYW7dNS733lRBSMQRySSixX5CVhXcu5TM
         F2tYzaEXXz1AbDLNk6wJ5F8lUCNRFdxAhbEmG9YqHhcAcwZ/wLFV+gV3gJeY87IaNS
         RQlLEKq1EUH/g==
Date:   Thu, 6 Jul 2023 11:50:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.5-rc1
Message-ID: <ZKZdOWi8I0vxpdzL@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NpmKRYY6Uu4M4bXD"
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


--NpmKRYY6Uu4M4bXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive updates for dmaengine. A new device support in TI
driver, native HDMI support for designware edma driver, ste dma40
updates for SRAM handling and bunch of drivers removal of dma device
chancnt setting along with odd updates to bunch of drivers

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.5-rc1

for you to fetch changes up to 907514a7dc4c574136e8fb576b014be05d25813a:

  dmaengine: sprd: Don't set chancnt (2023-05-24 12:24:32 +0530)

----------------------------------------------------------------
dmaengine updates for v6.5

 New support:
 - TI J721S2 CSI BCDMA support

 Updates:
 - Native HDMI support for dw edma driver
 - ste dma40 updates for supporting proper SRAM handle in DT
 - removal of dma device chancnt setting in drivers

----------------------------------------------------------------
Arnd Bergmann (1):
      dmaengine: ste_dma40: use proper format string for resource_size_t

Baoquan He (1):
      dmaengine: make QCOM_HIDMA depend on HAS_IOMEM

Cai Huoqing (4):
      dmaengine: dw-edma: Rename dw_edma_core_ops structure to dw_edma_plat=
_ops
      dmaengine: dw-edma: Create a new dw_edma_core_ops structure to abstra=
ct controller operation
      dmaengine: dw-edma: Add support for native HDMA
      dmaengine: dw-edma: Add HDMA DebugFS support

Jisheng Zhang (5):
      dmaengine: dw-axi-dmac: Don't set chancnt
      dmaengine: axi-dmac: Don't set chancnt
      dmaengine: plx_dma: Don't set chancnt
      dmaengine: hidma: Don't set chancnt
      dmaengine: sprd: Don't set chancnt

Kishon Vijay Abraham I (1):
      dmaengine: ti: k3-psil-j721s2: Add PSI-L thread map for main CPSW2G

Linus Walleij (7):
      dt-bindings: dma: dma40: Prefer to pass sram through phandle
      dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
      dmaengine: ste_dma40: Add dev helper variable
      dmaengine: ste_dma40: Remove platform data
      dmaengine: ste_dma40: Pass dev to OF function
      dmaengine: ste_dma40: Use managed resources
      dmaengine: ste_dma40: Return error codes properly

Michal Simek (1):
      dt-bindings: dma: xilinx: Add power-domains to xlnx,zynqmp-dpdma

Serge Semin (3):
      MAINTAINERS: Demote Gustavo Pimentel to DW EDMA driver reviewer
      MAINTAINERS: Add Manivannan to DW eDMA driver maintainers list
      MAINTAINERS: Add myself as the DW eDMA driver reviewer

Stephan Gerhold (1):
      dmaengine: qcom: bam_dma: allow omitting num-{channels,ees}

Vaishnav Achath (2):
      dt-bindings: dma: ti: Add J721S2 BCDMA
      dmaengine: ti: k3-udma: Add support for J721S2 CSI BCDMA instance

Vinod Koul (2):
      dmaengine: ste_dma40: use correct print specfier for resource_size_t
      dmaengine: ste_dma40: fix typo in enum documentation

 .../devicetree/bindings/dma/stericsson,dma40.yaml  |  36 ++-
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |  30 +-
 .../bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml     |   6 +
 MAINTAINERS                                        |   4 +-
 drivers/dma/Kconfig                                |   1 +
 drivers/dma/dma-axi-dmac.c                         |   1 -
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |   1 -
 drivers/dma/dw-edma/Makefile                       |   8 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  88 ++----
 drivers/dma/dw-edma/dw-edma-core.h                 |  58 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c                 |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c              |  85 +++++-
 drivers/dma/dw-edma/dw-edma-v0-core.h              |  14 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c              | 296 ++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h              |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c           | 170 +++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h           |  22 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h              | 129 ++++++++
 drivers/dma/plx_dma.c                              |   1 -
 drivers/dma/qcom/Kconfig                           |   1 +
 drivers/dma/qcom/bam_dma.c                         |  18 +-
 drivers/dma/qcom/hidma.c                           |   1 -
 drivers/dma/sprd-dma.c                             |   1 -
 drivers/dma/ste_dma40.c                            | 334 +++++++++--------=
----
 .../dma-ste-dma40.h =3D> drivers/dma/ste_dma40.h     | 101 +------
 drivers/dma/ste_dma40_ll.c                         |   3 +-
 drivers/dma/ti/k3-psil-j721s2.c                    |  11 +
 drivers/dma/ti/k3-udma.c                           |  25 ++
 drivers/pci/controller/dwc/pcie-designware.c       |   2 +-
 include/linux/dma/edma.h                           |   7 +-
 30 files changed, 1074 insertions(+), 401 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
 rename include/linux/platform_data/dma-ste-dma40.h =3D> drivers/dma/ste_dm=
a40.h (51%)
--=20
~Vinod

--NpmKRYY6Uu4M4bXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmSmXTkACgkQfBQHDyUj
g0fV1w//c8v4B9J89SCFeAKiBlLhUDLSXkjSyU5DmihX0e3dJD8v/bsyqR51Kbt9
N6EdofH8pzQ0wHzAh9RTRyQ5xME8F2PgOr3GUTF/VJGhol33K0gpLD0nzIo1J1nI
v+7s7LGkFBIbk/hKRO2At2A79pfzsBrNd0eHK7nXuEIEO0Y+jNd5SRHi+uwDk6b1
BmyLo3jX8UECGbPlYgsSpw4/L6Bu2kKBqLhDVFyyjJzByd/DD8xAmoqzvZ0HIxsB
5TYmRXmGpR3DnYhf1pxL3DlSbcwEHXBR6RNcY+t5t8ilgwpOEppYCOZfU+WfU6jP
Ohu1F6bj26MaLfGf8XfcAgu8Jm3/EeYTjq9VWueNmUmql/FO0aOoOs3II0rNFQ1Z
zBwaA3xYFXIQY8jehpgRUBUF3DpAxuqb1w8NYiBU36E8sN+hDhw6wA5dkOK3vcYu
QCBYEPEiEFfM9FvUKlgZQkZNxC8TgA108ooaiz/1ZrV1gshRi/suBQXra9bvFb1T
TK354vblaeskXT3yG5yn0Cn3A22Surj2Xcig6rb1/+Bln+0ufXh9u5jTRvnHjTpe
73Cn3z1nwG5uTaSG3M32jf9ITaKcGouaNzm/0hvMqXUlDURB7t/zA86SdGkI5lzp
fsCfeMc/qjoybvAQYhFHZUyF7fqU42yuKO54O5A8zpQMKOQW7v0=
=KaEF
-----END PGP SIGNATURE-----

--NpmKRYY6Uu4M4bXD--
