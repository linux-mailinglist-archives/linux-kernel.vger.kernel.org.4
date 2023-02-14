Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48669618F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjBNK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBNK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:58:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8645E22789
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:58:28 -0800 (PST)
X-UUID: 798a1e64ac5611ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VDM/X9Rv4Dnk0OZyDBmi3fSTCK369lUNj0HJzi93FoY=;
        b=R8jNUMUirQEa5FpHn+sxhkUMBEHkni8O+0vPtmBbo7oateGQW05d4oU3r4WhaTOxFYg1OHil2j3eF8zD7ipLXY619I2kIWQ0B1Op8pS1KFzqZ49pLk9AWB2lmSvLLBo22flHkl82CzGDPj/xA5ECvCnNLIIBWRtuzvFMSFsu5eg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:05c2e37e-409b-406a-9784-cb33fc571f03,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.19,REQID:05c2e37e-409b-406a-9784-cb33fc571f03,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:885ddb2,CLOUDID:cd218925-564d-42d9-9875-7c868ee415ec,B
        ulkID:230214185814PHV5GKMY,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 798a1e64ac5611ed945fc101203acc17-20230214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2048553882; Tue, 14 Feb 2023 18:58:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Feb 2023 18:58:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 18:58:11 +0800
From:   <walter.chang@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <Chun-hung.Wu@mediatek.com>, <Freddy.Hsin@mediatek.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/4] clocksource/drivers/timer-of: Remove __init markings
Date:   Tue, 14 Feb 2023 18:53:13 +0800
Message-ID: <20230214105412.5856-4-walter.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230214105412.5856-1-walter.chang@mediatek.com>
References: <20230214105412.5856-1-walter.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chun-Hung Wu <chun-hung.wu@mediatek.com>

Remove __init markings to allow timer drivers 
can be compiled as modules.

Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
---
 drivers/clocksource/timer-of.c | 23 ++++++++++++-----------
 drivers/clocksource/timer-of.h |  6 +++---
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9912be..59bc5921acad 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -19,7 +19,7 @@
  *
  * Free the irq resource
  */
-static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
+static void timer_of_irq_exit(struct of_timer_irq *of_irq)
 {
 	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
 
@@ -47,8 +47,8 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  *
  * Returns 0 on success, < 0 otherwise
  */
-static __init int timer_of_irq_init(struct device_node *np,
-				    struct of_timer_irq *of_irq)
+static int timer_of_irq_init(struct device_node *np,
+			     struct of_timer_irq *of_irq)
 {
 	int ret;
 	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
@@ -91,7 +91,7 @@ static __init int timer_of_irq_init(struct device_node *np,
  *
  * Disables and releases the refcount on the clk
  */
-static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
+static void timer_of_clk_exit(struct of_timer_clk *of_clk)
 {
 	of_clk->rate = 0;
 	clk_disable_unprepare(of_clk->clk);
@@ -107,8 +107,8 @@ static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
  *
  * Returns 0 on success, < 0 otherwise
  */
-static __init int timer_of_clk_init(struct device_node *np,
-				    struct of_timer_clk *of_clk)
+static int timer_of_clk_init(struct device_node *np,
+			     struct of_timer_clk *of_clk)
 {
 	int ret;
 
@@ -146,13 +146,13 @@ static __init int timer_of_clk_init(struct device_node *np,
 	goto out;
 }
 
-static __init void timer_of_base_exit(struct of_timer_base *of_base)
+static void timer_of_base_exit(struct of_timer_base *of_base)
 {
 	iounmap(of_base->base);
 }
 
-static __init int timer_of_base_init(struct device_node *np,
-				     struct of_timer_base *of_base)
+static int timer_of_base_init(struct device_node *np,
+			      struct of_timer_base *of_base)
 {
 	of_base->base = of_base->name ?
 		of_io_request_and_map(np, of_base->index, of_base->name) :
@@ -165,7 +165,7 @@ static __init int timer_of_base_init(struct device_node *np,
 	return 0;
 }
 
-int __init timer_of_init(struct device_node *np, struct timer_of *to)
+int timer_of_init(struct device_node *np, struct timer_of *to)
 {
 	int ret = -EINVAL;
 	int flags = 0;
@@ -209,6 +209,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 		timer_of_base_exit(&to->of_base);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(timer_of_init);
 
 /**
  * timer_of_cleanup - release timer_of resources
@@ -217,7 +218,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
  * Release the resources that has been used in timer_of_init().
  * This function should be called in init error cases
  */
-void __init timer_of_cleanup(struct timer_of *to)
+void timer_of_cleanup(struct timer_of *to)
 {
 	if (to->flags & TIMER_OF_IRQ)
 		timer_of_irq_exit(&to->of_irq);
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3e8589..5d1472846346 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -66,9 +66,9 @@ static inline unsigned long timer_of_period(struct timer_of *to)
 	return to->of_clk.period;
 }
 
-extern int __init timer_of_init(struct device_node *np,
-				struct timer_of *to);
+extern int timer_of_init(struct device_node *np,
+			 struct timer_of *to);
 
-extern void __init timer_of_cleanup(struct timer_of *to);
+extern void timer_of_cleanup(struct timer_of *to);
 
 #endif
-- 
2.18.0

