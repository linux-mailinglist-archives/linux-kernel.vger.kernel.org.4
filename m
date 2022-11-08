Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FD620C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiKHJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiKHJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:45:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A162672;
        Tue,  8 Nov 2022 01:45:00 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N639C3BYxzmVJZ;
        Tue,  8 Nov 2022 17:44:47 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:44:58 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
CC:     <linux-clk@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
Subject: [PATCH] clk: sunxi-ng: v3s: Correct the header guard of ccu-sun8i-v3s.h
Date:   Tue, 8 Nov 2022 17:43:35 +0800
Message-ID: <20221108094335.3597008-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the header guard of ccu-sun8i-v3s.h from _CCU_SUN8I_H3_H_ to
_CCU_SUN8I_V3S_H_ what corresponding with the file name.

Fixes: d0f11d14b0bc ("clk: sunxi-ng: add support for V3s CCU")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
index 108eeeedcbf7..345cdbbab362 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
@@ -6,8 +6,8 @@
  * Copyright (c) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
  */
 
-#ifndef _CCU_SUN8I_H3_H_
-#define _CCU_SUN8I_H3_H_
+#ifndef _CCU_SUN8I_V3S_H_
+#define _CCU_SUN8I_V3S_H_
 
 #include <dt-bindings/clock/sun8i-v3s-ccu.h>
 #include <dt-bindings/reset/sun8i-v3s-ccu.h>
@@ -51,4 +51,4 @@
 
 #define CLK_PLL_DDR1		74
 
-#endif /* _CCU_SUN8I_H3_H_ */
+#endif /* _CCU_SUN8I_V3S_H_ */
-- 
2.25.1

