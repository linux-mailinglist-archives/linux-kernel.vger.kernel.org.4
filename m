Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF662A1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiKOTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiKOTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:32:52 -0500
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C689E2F649
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:32:49 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id v1fpoedd9ae4mv1fqoaGVJ; Tue, 15 Nov 2022 20:32:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668540767; bh=bYxD4zkvpQWcK4XaGs1emJgCui8X6J85I/IA0uMXmdw=;
        h=From:To:Subject:Date:MIME-Version;
        b=fDmhcdJKUZsA9jCF7Gya6TWhNzo46mVT7LhNsDlelHhtVFQxHic+E4QiGGBkfHuzn
         jzQYoD7iIMx0CspNs3lWaxuAy41rHv6WrlTwm0p4KOm5kPhEooQ8jj8ZvudYUWz8Nb
         8+8051lZSF03QugC4OChFjcT2eU0EVE6LEDtRQmioRUApQn3UxrnUhRU9plBd/uuwu
         7AHwks9qgg4rEvoYZjyIAghg4DrdMSGSRRrhHTxMDG1pqQfcON1z/24Fn0mzke6z3M
         WX5iCUce7XxcU1rcMmkn8ei3Ty913bXsMwRchi8HKkdYSE0AamDAAloXDQhRUtuOXG
         oADscU9DmktmQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2 2/4] clk: imx: imxrt1050: add IMXRT1050_CLK_LCDIF_PIX clock gate
Date:   Tue, 15 Nov 2022 20:32:42 +0100
Message-Id: <20221115193244.10484-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHG0IczV7O1OTEH8JFjCezO1cBEeuOrntfvuuFG8PrRE7fAjtWiGlULy3ubD/SNhJP2iKOMP+oqBb4b3g7HT2k3Zl39NRg1zVev0rOZ0ZrRPqwlyqCac
 2tPfcNK22ELx1VDRMD2BbY+ufGqHgk/7TiphF9O9963UuAGcfPeBLxfMDq0b+tSGFfx1koHdwlN7HFKnmHeo2a7KRX9Gqt4f9rZFvI16DHltHTz79H9uxEJo
 pY+QR07ue2/8uVwBTVvtooatB/Fgr6uMfX5nAHdEm3xz9ILJrouqGhnijH7WuV+2o0EUCMEqGqokQbVZfHnrg/uI3Zf91khEE4K4m9OOAvn5SgkjDa0UWKsN
 7SF4VmZo3P8N/wHd1trd71WDrk7k/Vt8zztuc2b6gLqQ3lATtWLlHoh7fOaXvDeQPCKDx0IZAWK6881yChZ0ASD5bdS8bWFDsuToH3IpQCRF4JdTBQCQmAJE
 IItI8nT4To37VWZUTmrblO5T/tSw/uUURPinxqQUhJLo9c1aOHWRIozvHtcrZjV53nlhHxbzerNKNAz3c1sZbCd5CrPof1ockKn6UgIlX1cUTzUFJFvxeyCM
 NbxNBRw4Utc20xTUIiBlEPye3bazMXWVHrHRxQv7Y3F35S7L2Gyx9vLNt1sKZHp0Lda2Sx+w0sszOaWFAl8FhZ7UUY3OTGT0EIZRF/fSepbnMjHb/DX9l+I1
 DfLMRZA9H4y012QQ47ptJZpy/xwIM3GawOfJfWnPgrEK3xplQw9pJ4dzfP/MOpIC5tExYTig2Dn9YTyQWXRmthAWwd7zvKtIJub86zseqmGYvQBcPjYPGg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* nothing done
---
 drivers/clk/imx/clk-imxrt1050.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 26108e9f7e67..39f77c03b892 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -141,6 +141,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
 	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
 	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
+	hws[IMXRT1050_CLK_LCDIF_PIX] = imx_clk_hw_gate2("lcdif_pix", "lcdif", ccm_base + 0x74, 10);
 	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
 	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
 	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
-- 
2.34.1

