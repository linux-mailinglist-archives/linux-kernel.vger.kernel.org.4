Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6276F682C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjEDJTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEDJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:18:59 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354434686;
        Thu,  4 May 2023 02:18:55 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1683191906tesa
Received: from localhost ( [255.251.132.4])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 May 2023 17:18:24 +0800 (CST)
X-QQ-SSF: 0140000000000090C000000A0000000
X-QQ-FEAT: vqhsT3OOnzQrJGtKCXS1pBcMKUMmDAjRfxQG/B6ZO/lWYFwgO+2Y2O7Nj4C5U
        hOuwigMdoftTB6SuFpHto05XEDV5S23KOJ3BOGlsuK+f1kR4V2ecsKb2uC7U92bw45zmVDs
        5/4vnrT05DyXcfzc8h8KP+Oizt6Nfp9/KCxPAxem/ukx7eycB6kUEgSc3ioOx/ruKj+l7dM
        taLLl6jbSB0CsxH1Q/S3pgszqZah34fwyxi5koDec+b4YTNl/TdOGCQNouZpGRKvwrQs38j
        MM2bi2ZkgdpdeqHhKyyFKp2DJncghKq1SJVIclSjX/ELo5g9/df6I7JMy9DiUMxWZI0WCuc
        O+zAaoKzTnjQ8ABSvdctz04dzAzSNvCLtQIeZ9a
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7082002643039706499
Date:   Thu, 4 May 2023 17:18:24 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] strcut: Correct spelling mistakes in comments
Message-ID: <A393097506CB918E+ZFN4YOkubdwQvONz@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-2
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>

strcut: Correct spelling mistakes in comments.

---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..b27affb7503f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -398,7 +398,7 @@ struct mem_zone_bm_rtree {
 	unsigned int blocks;		/* Number of Bitmap Blocks     */
 };
 
-/* strcut bm_position is used for browsing memory bitmaps */
+/* struct bm_position is used for browsing memory bitmaps */
 
 struct bm_position {
 	struct mem_zone_bm_rtree *zone;
-- 
2.34.1

