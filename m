Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2524A73927D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFUWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFUWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:25:08 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC11735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:25:07 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D89F2009E4;
        Thu, 22 Jun 2023 00:25:05 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0194F200359;
        Thu, 22 Jun 2023 00:25:05 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D4B304058C;
        Wed, 21 Jun 2023 15:25:03 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v6.5)
Date:   Wed, 21 Jun 2023 17:25:03 -0500
Message-Id: <20230621222503.12402-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v6.5

for you to fetch changes up to fb9c384625dd604e8a5be1f42b35e83104b90670:

  bus: fsl-mc: fsl-mc-allocator: Drop a write-only variable (2023-06-08 17:56:26 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v6.5

- fsl-mc: Make remove function return void
- QE USB: fix build issue caused by missing dependency

----------------------------------------------------------------
Randy Dunlap (1):
      soc/fsl/qe: fix usb.c build errors

Uwe Kleine-König (8):
      bus: fsl-mc: Only warn once about errors on device unbind
      bus: fsl-mc: dprc: Push down error message from fsl_mc_driver_remove()
      bus: fsl-mc: fsl-mc-allocator: Drop if block with always wrong condition
      bus: fsl-mc: fsl-mc-allocator: Improve error reporting
      soc: fsl: dpio: Suppress duplicated error reporting on device remove
      bus: fsl-mc: Make remove function return void
      bus: fsl-mc: fsl-mc-allocator: Initialize mc_bus_dev before use
      bus: fsl-mc: fsl-mc-allocator: Drop a write-only variable

 drivers/bus/fsl-mc/dprc-driver.c                   | 12 ++++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c              | 35 +++++++++++-----------
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  7 +----
 drivers/crypto/caam/caamalg_qi2.c                  |  4 +--
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  4 +--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  4 +--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   |  4 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  4 +--
 drivers/soc/fsl/dpio/dpio-driver.c                 |  8 +----
 drivers/soc/fsl/qe/Kconfig                         |  1 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                  |  3 +-
 include/linux/fsl/mc.h                             |  2 +-
 12 files changed, 32 insertions(+), 56 deletions(-)
