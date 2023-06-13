Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA772D774
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbjFMCua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjFMCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:50:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88CE57;
        Mon, 12 Jun 2023 19:50:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgChs3cNnz4f3tqD;
        Tue, 13 Jun 2023 10:50:21 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP1 (Coremail) with SMTP id cCh0CgAnRjBl2Ydk2xLCKw--.57225S2;
        Tue, 13 Jun 2023 10:50:22 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com
Subject: [PATCH] clk: renesas: r8a7778: remove checker warnings: x | !y
Date:   Tue, 13 Jun 2023 10:54:03 +0800
Message-Id: <20230613025403.3338129-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAnRjBl2Ydk2xLCKw--.57225S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1xJrW7CF4UAr4UXFWrXwb_yoWkuwc_GF
        1xXr1UJr1qvw10kr4Uu3y3AFZIyw1DZFZ5Zan29rW3J343u3yUJFnxu39Fv34Dua15ZF98
        Krn7tr1jkrW7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbr8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following Sparse reports when building with C=1:

drivers/clk/renesas/clk-r8a7778.c:85:52: warning: dubious: x | !y
drivers/clk/renesas/clk-r8a7778.c:87:50: warning: dubious: x | !y

Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
---
 drivers/clk/renesas/clk-r8a7778.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/clk-r8a7778.c b/drivers/clk/renesas/clk-r8a7778.c
index 797556259370..ad1a50f3b0cd 100644
--- a/drivers/clk/renesas/clk-r8a7778.c
+++ b/drivers/clk/renesas/clk-r8a7778.c
@@ -81,11 +81,11 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
 
 	BUG_ON(!(mode & BIT(19)));
 
-	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
-			 (!!(mode & BIT(12)) << 1) |
-			 (!!(mode & BIT(11)));
-	cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
-			(!!(mode & BIT(1)));
+	cpg_mode_rates = (mode & BIT(18) ? BIT(2) : 0) |
+			 (mode & BIT(12) ? BIT(1) : 0) |
+			 (mode & BIT(11) ? BIT(0) : 0);
+	cpg_mode_divs = (mode & BIT(2) ? BIT(1) : 0) |
+			(mode & BIT(1) ? BIT(0) : 0);
 
 	num_clks = of_property_count_strings(np, "clock-output-names");
 	if (num_clks < 0) {
-- 
2.25.1

