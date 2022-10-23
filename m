Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D160920A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJWJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJWJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:42:07 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29FD67044
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666518123; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nidTa8LVHCdKn0fBaVlgdpsS23LKT9OOQ2ynsYfFhKQfkq9WLKCc2ljtNagZyOvZwu7pf+wuIOwtwOfMGsAf54eVIIj0pT3lg827DpQMOY+noziciyBSqsgrw5FQC4hB1hwZtfkPFbiJeNL3vC+SR5fajAJQAWqmjmgcVltjX2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666518123; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4eNxmxYpWlyDCv0HM9lKeWy6ZvZtE8JS7KlXlMTCmoA=; 
        b=bcg3mq2vuYDirwaw2tAcr4V9ZGv1qiTWXFos3eqrCUb/KCKHNP3CsYbT9RIZH91iJ3caZKXl0glI2dppkMdO9v0MADD1X365PYktejOEDit5yGfo9dh+1WT9/ACmQhELUyDOY7isFtUvGcDhTJR4RXv3YW1ORLrAAxlvURxVz0A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666518123;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=4eNxmxYpWlyDCv0HM9lKeWy6ZvZtE8JS7KlXlMTCmoA=;
        b=RO1gHCjkRrVx2EWWLqghBWLOmo9dzT93AGX9vnit0oxqpXNPE4wjm9nIEJW5H0KB
        lgiuDdegJxRO0OGH7Vp5xNt2WCEJeQ7M4K2mPcsihbQNRS2byFprn6EFj/jVM1wmAdd
        jfjzienFwrth6Xaw1cZFSbscivrYJaU3p6rJeX4w=
Received: from plymouth (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 1666518121542609.2986885232069; Sun, 23 Oct 2022 02:42:01 -0700 (PDT)
Date:   Sun, 23 Oct 2022 16:41:51 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing
 blank space
Message-ID: <e6635103e3cf2426220767955b99d2e2b62a7329.1666502177.git.t4rmin@zohomail.com>
References: <cover.1666502177.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666502177.git.t4rmin@zohomail.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a missing blank space as per the Linux kernel coding-style
regulations. The issue was flagged by the checkpatch script as a
warning.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ef3dca51cf99..b763cf0ba356 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -70,6 +70,7 @@ static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+
 	pHTInfo->bRegShortGI20MHz = 1;
 	pHTInfo->bRegShortGI40MHz = 1;
 
-- 
2.38.1

