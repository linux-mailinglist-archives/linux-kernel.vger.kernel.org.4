Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8321B602C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJRNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:05:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 062DBC5895;
        Tue, 18 Oct 2022 06:05:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxzNippE5jdG0AAA--.2548S3;
        Tue, 18 Oct 2022 21:05:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbuCipE5j_LMAAA--.2960S2;
        Tue, 18 Oct 2022 21:05:44 +0800 (CST)
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
Subject: [PATCH v1 1/3] clk: loongson2: add clock dt-bindings include file
Date:   Tue, 18 Oct 2022 21:05:29 +0800
Message-Id: <20221018130531.301-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbuCipE5j_LMAAA--.2960S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7AF4UWr4rXFWfKrWUJw13Arb_yoW8uw48pr
        s7CFWfKry7KF4I9wsYgFy3Kr13uw4xCw17AF47uF1UAFn7Jw18JrsF9F1fAFZrXF4kCFyx
        Z3Z7uw409a9rWw7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8Ta0PUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file defines all loongson2 soc clock indexes, it should be
included in the device tree in which there's device using the
clocks.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 MAINTAINERS                                 |  6 +++++
 include/dt-bindings/clock/loongson2-clock.h | 29 +++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 include/dt-bindings/clock/loongson2-clock.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a162b6fba6fe..3db469f51d74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11914,6 +11914,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
 F:	drivers/clocksource/loongson2_hpet.c
 
+LOONGSON2 SOC SERIES CLOCK DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-clk@vger.kernel.org
+S:	Maintained
+F:	include/dt-bindings/clock/loongson2-clock.h
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
diff --git a/include/dt-bindings/clock/loongson2-clock.h b/include/dt-bindings/clock/loongson2-clock.h
new file mode 100644
index 000000000000..23806408fe49
--- /dev/null
+++ b/include/dt-bindings/clock/loongson2-clock.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LOONGSON2_H
+#define __DT_BINDINGS_CLOCK_LOONGSON2_H
+
+#define	LOONGSON2_REFCLK_100M				0
+#define	LOONGSON2_NODE_PLL				1
+#define	LOONGSON2_DDR_PLL				2
+#define	LOONGSON2_DC_PLL				3
+#define	LOONGSON2_PIX0_PLL				4
+#define	LOONGSON2_PIX1_PLL				5
+#define	LOONGSON2_NODE_CLK				6
+#define	LOONGSON2_HDA_CLK				7
+#define	LOONGSON2_GPU_CLK				8
+#define	LOONGSON2_DDR_CLK				9
+#define	LOONGSON2_GMAC_CLK				10
+#define	LOONGSON2_DC_CLK				11
+#define	LOONGSON2_APB_CLK				12
+#define	LOONGSON2_USB_CLK				13
+#define	LOONGSON2_SATA_CLK				14
+#define	LOONGSON2_PIX0_CLK				15
+#define	LOONGSON2_PIX1_CLK				16
+#define	LOONGSON2_CLK_END				17
+
+#endif
-- 
2.20.1

