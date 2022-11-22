Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2483634925
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiKVVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiKVVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:23:52 -0500
Received: from mailout-pe-b.jellyfish.systems (mailout-pe-b.jellyfish.systems [198.54.127.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52C8221F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:23:49 -0800 (PST)
Received: from output-router-58994b6955-tvtjg (unknown [10.35.5.64])
        by mailout-pe-b.jellyfish.systems (Postfix) with ESMTPA id 4NGy1D3bhlzDqRJ;
        Tue, 22 Nov 2022 21:23:44 +0000 (UTC)
Received: from MTA-13.privateemail.com (unknown [10.50.14.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id 69A7F18000CF;
        Tue, 22 Nov 2022 16:23:44 -0500 (EST)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 42DAD18000B2;
        Tue, 22 Nov 2022 16:23:44 -0500 (EST)
Received: from bpappas-XPS-13-9310.wppl.org (unknown [131.226.25.151])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 13FFF18000AF;
        Tue, 22 Nov 2022 16:23:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1669152224;
        bh=p+WdSq8yxg9uUyI+r1wYQtUA9kjPikh1LL+rjuRzmRs=;
        h=From:To:Cc:Subject:Date:From;
        b=Y12Uka78C9YKBxcVP02/1A+LDIeSO889SgUBn2zf6Mb2OzqeWOqBV0BmrC38GVWq3
         bYCa44M4geuAe2/I9m5/3XBl6IulPjm0J6vZZlDtGemTVHM8tYdZZWqUS6tpqCX5zQ
         ODy0dFV0jZAVjY2cnHBoZwSfVV/eRq/VChxhaE8omcc+bRscK9xN/eikksngZtTHBH
         t/Zt98qAP2g7do7iOeWAJT9J447YTqSrH3FULVoRnK9cTRgMaE6/9/Sap6d2OEV+gM
         lkaDq3TbnBO+DLSvOZpacFMAwSmsajtbhnevq6f7XRSCynOBmOallgx1MCcbdqf7BV
         /tQluWC0IWoEQ==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] staging: media: atomisp: Remove unused macro PAGE_VALID
Date:   Tue, 22 Nov 2022 16:22:41 -0500
Message-Id: <20221122212240.12654-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused macro PAGE_VALID.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 drivers/staging/media/atomisp/include/mmu/isp_mmu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/include/mmu/isp_mmu.h b/drivers/staging/media/atomisp/include/mmu/isp_mmu.h
index 268560954792..77546c773754 100644
--- a/drivers/staging/media/atomisp/include/mmu/isp_mmu.h
+++ b/drivers/staging/media/atomisp/include/mmu/isp_mmu.h
@@ -124,7 +124,6 @@ struct isp_mmu {
 	((pte) & ISP_PTE_VALID_MASK(mmu))
 
 #define	NULL_PAGE	((phys_addr_t)(-1) & ISP_PAGE_MASK)
-#define	PAGE_VALID(page)	((page) != NULL_PAGE)
 
 /*
  * init mmu with specific mmu driver.
-- 
2.34.1

