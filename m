Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B562E3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiKQSKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiKQSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:10:22 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 669C96BDDC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:10:17 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vjL5ohRGp6OFPvjL6oOWC6; Thu, 17 Nov 2022 19:10:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668708617; bh=aJUpV+2iNzlEctA/nZn6vs5b9ZOoFURlgD5u4XCogPU=;
        h=From:To:Subject:Date:MIME-Version;
        b=HbjJKav/azVOWxkNrvrFbjDKCExLXjunMxCSUPf6xES6etDcTiMl0mhjDI1vf/gs6
         dFkk9cr5sxooZ+SrJErUuYbJR5nAevvB2EhXzFfzdNdGzhNJ+Prgf1KVZTik07zjqw
         h8oQUB1CQzhr1ELxYdydfEtSMrwo5IGQRbGLdcXRjWIMcLa9gCh6Ak4lKdcq9Ja9nT
         R+mTLRqyKd6O5G90aafZ69hBQAhHA2FRMdWzbEMKoK7p+B69dORXq17tECcvWWNxbx
         QWxtxCb0YTPmoEHRI22asig1LazszsXmv2Zmxl3iz/geMlXDzZF2HWaFfWLI7tOaoa
         3D2w7WWjJPdOA==
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
Subject: [PATCH 2/4] clk: imx: imxrt1050: add IMXRT1050_CLK_LCDIF_PIX clock gate
Date:   Thu, 17 Nov 2022 19:10:12 +0100
Message-Id: <20221117181014.851505-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
References: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEE49uSxiBV+RGJO+gQCg6h7mt/LyknWLfUC6aIGaUyVvKOBQHPfG+wBs7BhUwq0fZdbLBURrhtwH5Qee+u3UASwgMH7q2Bg2uJFXthwNn56WoQSB48l
 ph49s3hRTGxhGlP1n20qrzaFGbHWNlD397RNfHjN4Snf8cbdON7Ak84kntWX2//tKgoh3AyLVW25DbTDE3zAXPcMBttvbNcg6ganmTHaXiPw0GIHpL6pemuo
 TMMxMw2ZQGoAJliEMGo+Y3R4spKXnoNyNRsDqq6hgKthU4Hus8o2exwoQfAWEgOmm7th9yzywciWYudvJZLH0iudW+3tvTJH2/pqgZGNwW8RlSrFCu0WS2g2
 hoOwHgRtdRxLZs16RqY0vwC4Daxe4JnRy/6XwkLUzwqlJiyPx99t9UlRjybb7D7kna2Ji4TLdJRBqk7zqXCenvWERvXOd7GkrLkU8oz0wP/FoUt8mo1u5lyW
 1VAM4Vb7O9U8IJhgiTWKWPHO6/W2C5Y+nE5GAMrhm08j6V9/58rGfQxJYKWhOau4r9yjXPYX1YBEj8NFuhxvnlVK1hpbv+6TJyZAkR4uHrF9+GY5OhQz1oS0
 mD7qDGJ85e9O95kEtot3dFkr8rv0ykmxxOzVrBrE64oBMKI+dymFBHNvKxh0lyikSn/xA7+CLCkwJiTsxLQ9Q8FJn9GOEc1xOZwacf/xbpP0QI0WWObZ39nU
 6RcNBuWoE1QyHp2oAsUwMS1DQd2QkbJnxTq2p9z5QWa+uq4Mtqv9NBxR1so2iXyKhQO0l/Rkd5wnL5i0+s8zzxYEZqoi2GbWX0Ns+7514yaLn+rwZP/7BA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IMXRT1050_CLK_LCDIF_PIX clock gate.

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Jesse Taube <mr.bossman075@gmail.com>
---
V1->V2:
* nothing done
V2->V3:
* added commit log and not only subject as suggested by Jesse Taube
* added Jesse Taube's Acked-by:
V3->V4:
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

