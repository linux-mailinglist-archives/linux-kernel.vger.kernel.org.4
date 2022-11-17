Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A062E3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiKQSKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbiKQSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:10:23 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E486C74CE5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:10:17 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vjL5ohRGp6OFPvjL5oOWAI; Thu, 17 Nov 2022 19:10:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668708616; bh=DkD0FT6uYp5PVEwHynX8RbPLNYVMQoXPIJI6hhGbE00=;
        h=From:To:Subject:Date:MIME-Version;
        b=bNO8Qyxjl1HcvXCgM+DH7YLuJQNnlJf+GDOGxsMS62ibounZzmUi24sw3G5YVBhcE
         Q635xLP5MTcuTGzYi+6s4UbeL5eBGnWW3s+hO9slPotM1fI8j3RJ3dBF1cgcuWhGJI
         ULbttpOLMrPUPqRqS8Rj7QmMxRqhv0ja9qM74XgesaC6ISy2XdpwO4bLsk9aE56Ncy
         BgpqFim6+V4HfUo5pK1hGD8qhmufcXOHED4Jcdnwj8z+g0YtYTxueOT3jBbBmauNte
         hfD+B8ZBpOc5VyXDjzDNtxIflKZ3Ytz0z6fPLYTi49zam0OzTdQxolGFCc8FHfOlVB
         mnQo8JCM0F7LQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Bough Chen <haibo.chen@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB offsets
Date:   Thu, 17 Nov 2022 19:10:11 +0100
Message-Id: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAT4tLLIX8LwkPEPsgf5zfUM23STm/KarxmCHJZ5jZe3wzxKcQF//zBr0dWDUhOCKovxe5gzDQX8EMNDgLi6HivYqerbbJdRTRHxN77PHACFaRFfxOUt
 NgagsNVF8AAhylhDkdyqOYeSxK6ayJn62YPHhw7G9Q2+aOPGVLeqifaHhL9kWNyjWzfeUY1Wu8J4WnigiQBQyliIJBzTfzzAGSRMDK+Kg2Klg8OGVr3pqMLL
 /xeUWkXhRcDoyQMoYnSfEBwBktbpd4WhVrQ58rXgtiIghAnFMxWzYs3SC4paajitxGEhwfsZLhhkZKZJRpbXwGx9HFAG7AAxUQVoiePWheYRfsXxRbD8soXG
 6ZCID992Z5Qiel8YvuFPtHOvU0T2AtXkPhD3xCjvOyHkxevvrxRwF7Kz/oQCf5ILZYOqg4gB+vvZ10MzjAinkqpEAvccrZ0qx6I8d45DQ04RvB9JtpITQDof
 3nJK9ZgaZDNAFP5TPEk0PJCfkuNoGRg3e1XJ+gD6FxPACC5aWRunLar5W1v9Qr1GnR4onhvJzLiPrh1gMreKlidSbwQ+WmO7IUr55yumjCn0EsenJNaofRFO
 PVzL/DIVShFor6Mx8XcuVwk2dntqt1SzNo5CU+/eILDdcUvnkHAPEhVimA874GdHOTB0QEw3WnikcTYvZ5c/xytTpDbq2uSeM/yvBTQXvl8dkQqlQ6oHfG3j
 FNiZQxJmwEQz1FHoDtzClvT59WZ065gcfECv7F5c23MeST4N9HIPiwq2nryqCosPDvsg6VTX/spB4tEGbcO7NBhrdnz8uJSIiDiY4B8kjqomVq+qT/9DYg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IMXRT1050_CLK_LCDIF_APB offsets.

Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* nothing done
V2->V3:
* added commit log and not only subject as suggested by Jesse Taube
V3->V4:
* added Fixes: as suggested by Fabio Estevam
---
 drivers/clk/imx/clk-imxrt1050.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 9539d35588ee..26108e9f7e67 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -140,7 +140,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
 	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
 	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
-	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
+	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
 	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
 	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
 	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
-- 
2.34.1

