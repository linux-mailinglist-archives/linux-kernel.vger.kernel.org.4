Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8073A111
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjFVMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjFVMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:37:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79C1AC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687437463; x=1718973463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m+Ev4wmCm18e2vsd+uR0dwc67qrspzWomHfGrrOjEiM=;
  b=ioLvKPHYfDuNKeneQAnHcKVL72uO6qFQVkdu01DLdwlrZ6KWk2cON8BY
   EygKd98jG5iPvnS0y+PMW0GKuiyC+bd2WtiaF7S5XW3FaiyWn3DxHqKqt
   Bz174Z3XGljeqvtRA62bxEU3E7OZCjX++ah9tXZBgyfEgfpnbBFxgZWs5
   qkiSb3g5wARQ25Q4BhwBS2eKe7AnXyqOF0phQJjYFUx/RB0B+s6rsyIrc
   O5Xsk7N1o6RUe8gef+Fb2gmUjuW34Kskzr4/d/PgncHQlpt0IvUkjb+35
   CRkFQgaiRV55Shd8dvQ8yQDZQJHXABv4rJMuOETAaFWLRNsbkjXwULe7q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360492533"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="360492533"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1045148777"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="1045148777"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 05:37:39 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v2 2/2] arm64: defconfig: Enable UBI and UBIFS
Date:   Thu, 22 Jun 2023 20:36:58 +0800
Message-Id: <20230622123657.593719-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622123254.593308-1-kah.jing.lee@intel.com>
References: <20230622123254.593308-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

This patch is to enable UBI and UBIFS in Linux defconfig for socfpga
Agilex and Stratix10 platform.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
v2: Update subject prefix and align defconfig config place
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..8c3c6fd20d77 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -267,6 +267,7 @@ CONFIG_MTD_NAND_BRCMNAND=m
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
@@ -1444,6 +1445,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_EFIVAR_FS=y
+CONFIG_UBIFS_FS=y
 CONFIG_SQUASHFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
-- 
2.25.1

