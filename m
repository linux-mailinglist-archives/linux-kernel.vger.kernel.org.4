Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27F86ADE00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCGLvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCGLvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:51:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45B037B102;
        Tue,  7 Mar 2023 03:50:29 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxedkDJQdknlgJAA--.11831S3;
        Tue, 07 Mar 2023 19:50:27 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHuT+JAdk6f9NAA--.33988S2;
        Tue, 07 Mar 2023 19:50:27 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v13 1/2] dt-bindings: clock: add loongson-2 boot clock index
Date:   Tue,  7 Mar 2023 19:50:21 +0800
Message-Id: <20230307115022.12846-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHuT+JAdk6f9NAA--.33988S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFW8Wr4UAFykuw47Wry8Krg_yoW8XFW5pr
        4kuFW7Kry2yF4xKw4vqr13Kr43u3yxGw1UAF47uF4UXF17A3WkJwsruF4fAryUXFykGFyx
        Za1DCw40va9rW37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bVxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
        Av8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7J3v
        UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson-2 boot clock was used to spi and lio peripheral and
this patch was to add boot clock index number.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 include/dt-bindings/clock/loongson,ls2k-clk.h | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
index db1e27e792ff1..e86804365e506 100644
--- a/include/dt-bindings/clock/loongson,ls2k-clk.h
+++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
@@ -13,17 +13,18 @@
 #define LOONGSON2_DC_PLL				3
 #define LOONGSON2_PIX0_PLL				4
 #define LOONGSON2_PIX1_PLL				5
-#define LOONGSON2_NODE_CLK				6
-#define LOONGSON2_HDA_CLK				7
-#define LOONGSON2_GPU_CLK				8
-#define LOONGSON2_DDR_CLK				9
-#define LOONGSON2_GMAC_CLK				10
-#define LOONGSON2_DC_CLK				11
-#define LOONGSON2_APB_CLK				12
-#define LOONGSON2_USB_CLK				13
-#define LOONGSON2_SATA_CLK				14
-#define LOONGSON2_PIX0_CLK				15
-#define LOONGSON2_PIX1_CLK				16
-#define LOONGSON2_CLK_END				17
+#define LOONGSON2_BOOT_CLK				6
+#define LOONGSON2_NODE_CLK				7
+#define LOONGSON2_HDA_CLK				8
+#define LOONGSON2_GPU_CLK				9
+#define LOONGSON2_DDR_CLK				10
+#define LOONGSON2_GMAC_CLK				11
+#define LOONGSON2_DC_CLK				12
+#define LOONGSON2_APB_CLK				13
+#define LOONGSON2_USB_CLK				14
+#define LOONGSON2_SATA_CLK				15
+#define LOONGSON2_PIX0_CLK				16
+#define LOONGSON2_PIX1_CLK				17
+#define LOONGSON2_CLK_END				18
 
 #endif
-- 
2.31.1

