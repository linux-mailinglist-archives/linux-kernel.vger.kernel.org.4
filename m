Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689C76AFD90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCHDpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCHDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:45:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3C1164C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 19:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cAGQQH4wQyWDGC6FY8VeQxL7CF0wk1r7pps8zKct/lQ=; b=Js7x8WulqOLxQ+pRSWSdy/vrLn
        jgRM0AK53k9TYypy3IWJokVkTZoAtqSGkqlZiQ0jRb8SbyF4heuf2bEww6xrcPa+qhI5Hg2HdLiVv
        PlR7Ig00ZehMokI161qJdrMbETaTLpCc5L2ccLRMIB+9GyvQVX2+OfqUAuDKp9I+g39NRNLHACYDJ
        DwwJFfsCuQU31sE727eMfZZdQPwTjwjD22E/+U897cV9xliJKn21KVB3vCYqlDVaBPIjZXV+B4y1B
        AsbMP4EL8UM309QHKlm1GsEO578u3FcAvGLkmYPZeNK4/YG6sj2CibT4PknoOCzxAhlN3ic5XN8pP
        Pco2HA4g==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZkjh-003MaC-AI; Wed, 08 Mar 2023 03:45:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Timur Tabi <timur@tabi.org>,
        Varun Sethi <Varun.Sethi@freescale.com>,
        Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
Date:   Tue,  7 Mar 2023 19:45:04 -0800
Message-Id: <20230308034504.9985-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings as reported by the kernel test robot:

fsl_pamu.c:192: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
fsl_pamu.c:239: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
fsl_pamu.c:239: warning: Function parameter or member 'dev' not described in 'get_ome_index'
fsl_pamu.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Setup operation mapping and stash destinations for QMAN and QMAN portal.
fsl_pamu.c:361: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Setup the operation mapping table for various devices. This is a static

Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202302281151.B1WtZvSC-lkp@intel.com
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: Timur Tabi <timur@tabi.org>
Cc: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/iommu/fsl_pamu.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -- a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -178,7 +178,7 @@ int pamu_update_paace_stash(int liodn, u
 }
 
 /**
- * pamu_config_paace() - Sets up PPAACE entry for specified liodn
+ * pamu_config_ppaace() - Sets up PPAACE entry for specified liodn
  *
  * @liodn: Logical IO device number
  * @omi: Operation mapping index -- if ~omi == 0 then omi not defined
@@ -232,7 +232,8 @@ int pamu_config_ppaace(int liodn, u32 om
 /**
  * get_ome_index() - Returns the index in the operation mapping table
  *                   for device.
- * @*omi_index: pointer for storing the index value
+ * @omi_index: pointer for storing the index value
+ * @dev: target device
  *
  */
 void get_ome_index(u32 *omi_index, struct device *dev)
@@ -328,7 +329,7 @@ found_cpu_node:
 #define QMAN_PORTAL_PAACE 2
 #define BMAN_PAACE 3
 
-/**
+/*
  * Setup operation mapping and stash destinations for QMAN and QMAN portal.
  * Memory accesses to QMAN and BMAN private memory need not be coherent, so
  * clear the PAACE entry coherency attribute for them.
@@ -357,7 +358,7 @@ static void setup_qbman_paace(struct paa
 	}
 }
 
-/**
+/*
  * Setup the operation mapping table for various devices. This is a static
  * table where each table index corresponds to a particular device. PAMU uses
  * this table to translate device transaction to appropriate corenet
