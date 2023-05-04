Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B144C6F7385
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEDTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEDTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9B9EF3;
        Thu,  4 May 2023 12:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A921E63722;
        Thu,  4 May 2023 19:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223F2C433EF;
        Thu,  4 May 2023 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229376;
        bh=JIQfiJRR8Qc+Y36j36yjNp/OGMv0j8pwpjokVNFvSkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5UE0fSCpWdPcqLotM1K97ItbojJYKGB3rk5mnYOGTJ0bZOH0YxK8Dyz1u28tKFup
         esfyut+VhMF373QfG0jFRwM1qchEC7o88FU/j5MmqN1OEJVqkr/8SNKdAt3ZHVewMN
         jJm4KWyZVk7B7uOgF2NWgAdBW+RvfcM5KANRgA/UIiB3K72PGzsZAWFBAQ7uI06TCb
         8E4iA7hdTESRglxpeFBf8yH3j5bP82CKspxuoD56CPWwkkM7Mg0WP2z+PnTRcIKMzY
         3LMAQ4ol/jTolxeRdOp85Ure973UOyGTLcZzLa/5Y0N88ignQTiPjloMLuxq008oRn
         ittcQLMOo+XGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        dlunev@chromium.org, beanhuo@micron.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 23/59] scsi: ufs: ufs-pci: Add support for Intel Lunar Lake
Date:   Thu,  4 May 2023 15:41:06 -0400
Message-Id: <20230504194142.3805425-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 0a07d3c7a1d205b47d9f3608ff4e9d1065d63b6d ]

Add PCI ID to support Intel Lunar Lake, same as MTL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230328105832.3495-1-adrian.hunter@intel.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufshcd-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 1c91f43e15c8e..9c911787f84c6 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -607,6 +607,7 @@ static const struct pci_device_id ufshcd_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x51FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x54FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x7E47), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0xA847), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
 	{ }	/* terminate list */
 };
 
-- 
2.39.2

