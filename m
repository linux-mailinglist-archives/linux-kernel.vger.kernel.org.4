Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970D7615B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiKBDu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiKBDuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:50:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D991275F2;
        Tue,  1 Nov 2022 20:50:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Dxvrfx6GFj2u0DAA--.8992S3;
        Wed, 02 Nov 2022 11:50:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxLeDr6GFjgqcJAA--.29311S2;
        Wed, 02 Nov 2022 11:50:08 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/3] dt-bindings: clock: add loongson-2 clock include file
Date:   Wed,  2 Nov 2022 11:49:55 +0800
Message-Id: <20221102034957.19626-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxLeDr6GFjgqcJAA--.29311S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Wry3AF4kWr47Kw1fXr4UXFb_yoW8tw15pr
        4kCFWfKry2yF4IkanYgF13Kr13uw4xA3W7AF47uF1jyF17Jw18JwnruF1fAa9xXF4kJFWx
        Zan7Cw409FZrX3DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU7uc_DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file defines all Loongson-2 SoC clock indexes, it should be
included in the device tree in which there's device using the
clocks.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS                                   |  6 ++++
 include/dt-bindings/clock/loongson,ls2k-clk.h | 29 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 include/dt-bindings/clock/loongson,ls2k-clk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3aff8b8723b1..d5d1f2b9fcfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12018,6 +12018,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
 F:	drivers/thermal/loongson2_thermal.c
 
+LOONGSON-2 SOC SERIES CLOCK DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-clk@vger.kernel.org
+S:	Maintained
+F:	include/dt-bindings/clock/loongson,ls2k-clk.h
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
new file mode 100644
index 000000000000..db1e27e792ff
--- /dev/null
+++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LOONGSON2_H
+#define __DT_BINDINGS_CLOCK_LOONGSON2_H
+
+#define LOONGSON2_REF_100M				0
+#define LOONGSON2_NODE_PLL				1
+#define LOONGSON2_DDR_PLL				2
+#define LOONGSON2_DC_PLL				3
+#define LOONGSON2_PIX0_PLL				4
+#define LOONGSON2_PIX1_PLL				5
+#define LOONGSON2_NODE_CLK				6
+#define LOONGSON2_HDA_CLK				7
+#define LOONGSON2_GPU_CLK				8
+#define LOONGSON2_DDR_CLK				9
+#define LOONGSON2_GMAC_CLK				10
+#define LOONGSON2_DC_CLK				11
+#define LOONGSON2_APB_CLK				12
+#define LOONGSON2_USB_CLK				13
+#define LOONGSON2_SATA_CLK				14
+#define LOONGSON2_PIX0_CLK				15
+#define LOONGSON2_PIX1_CLK				16
+#define LOONGSON2_CLK_END				17
+
+#endif
-- 
2.33.0

