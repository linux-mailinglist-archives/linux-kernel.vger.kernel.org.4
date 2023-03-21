Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBA6C3248
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCUNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCUNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:07:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E892D392B0;
        Tue, 21 Mar 2023 06:07:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxhdgCrBlkFWwPAA--.23194S3;
        Tue, 21 Mar 2023 21:07:14 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuX_qxlke6AIAA--.36902S2;
        Tue, 21 Mar 2023 21:07:14 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v15 1/2] dt-bindings: clock: add loongson-2 boot clock index
Date:   Tue, 21 Mar 2023 21:07:09 +0800
Message-Id: <20230321130710.20236-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuX_qxlke6AIAA--.36902S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7GFWkCF18GF17KryxGF4Uurg_yoW8Jrykpr
        sYkrykGFWjyFWSkF4qvr1xGrn5Za17JwnrAayjkF1UAr43Jw1kXrs7Ja4UAr90qrW3AFW7
        ZF17Cw4rZF4Uu3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bVxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8I
        j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcOJ5
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Change in v15:
		1. Add the acked-by for review information.
Change in v14:
		1. Add the history changelog for this patch.
		2. Move the boot clock index in ending.
Change in v13:
		1. Add this patch as new patch and the clock driver patch need
		   depend on this patch so add this patch as a series and set
		   version number was v13.
Change in v2 to v12:
		1. This patch doesn't exit, so no changelog. 

 include/dt-bindings/clock/loongson,ls2k-clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
index db1e27e792ff..3bc4dfc193c2 100644
--- a/include/dt-bindings/clock/loongson,ls2k-clk.h
+++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
@@ -24,6 +24,7 @@
 #define LOONGSON2_SATA_CLK				14
 #define LOONGSON2_PIX0_CLK				15
 #define LOONGSON2_PIX1_CLK				16
-#define LOONGSON2_CLK_END				17
+#define LOONGSON2_BOOT_CLK				17
+#define LOONGSON2_CLK_END				18
 
 #endif
-- 
2.20.1

