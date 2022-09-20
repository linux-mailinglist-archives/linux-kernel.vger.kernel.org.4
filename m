Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151155BD9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiITCDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiITCDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:03:43 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60005724C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:03:39 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28K1gpFj087853;
        Tue, 20 Sep 2022 09:42:51 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Sep
 2022 10:03:36 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <minyard@acm.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH] ipmi: kcs: aspeed: Update port address comments
Date:   Tue, 20 Sep 2022 10:03:33 +0800
Message-ID: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28K1gpFj087853
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove AST_usrGuide_KCS.pdf as it is no longer maintained.

Add more descriptions as the driver now supports the I/O
address configurations for both the KCS Data and Cmd/Status
interface registers.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index cdc88cde1e9a..19c32bf50e0e 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -207,17 +207,24 @@ static void aspeed_kcs_updateb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 mask,
 }
 
 /*
- * AST_usrGuide_KCS.pdf
- * 2. Background:
- *   we note D for Data, and C for Cmd/Status, default rules are
- *     A. KCS1 / KCS2 ( D / C:X / X+4 )
- *        D / C : CA0h / CA4h
- *        D / C : CA8h / CACh
- *     B. KCS3 ( D / C:XX2h / XX3h )
- *        D / C : CA2h / CA3h
- *        D / C : CB2h / CB3h
- *     C. KCS4
- *        D / C : CA4h / CA5h
+ * We note D for Data, and C for Cmd/Status, default rules are
+ *
+ * 1. Only the D address is given:
+ *   A. KCS1/KCS2 (D/C: X/X+4)
+ *      D/C: CA0h/CA4h
+ *      D/C: CA8h/CACh
+ *   B. KCS3 (D/C: XX2/XX3h)
+ *      D/C: CA2h/CA3h
+ *   C. KCS4 (D/C: X/X+1)
+ *      D/C: CA4h/CA5h
+ *
+ * 2. Both the D/C addresses are given:
+ *   A. KCS1/KCS2/KCS4 (D/C: X/Y)
+ *      D/C: CA0h/CA1h
+ *      D/C: CA8h/CA9h
+ *      D/C: CA4h/CA5h
+ *   B. KCS3 (D/C: XX2/XX3h)
+ *      D/C: CA2h/CA3h
  */
 static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2], int nr_addrs)
 {
-- 
2.25.1

