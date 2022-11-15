Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E2562A1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKOTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiKOTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:32:53 -0500
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C69E92F64A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:32:49 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id v1fpoedd9ae4mv1fpoaGUi; Tue, 15 Nov 2022 20:32:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668540766; bh=F96fCobNFwzSc24hF2RWaCdYhORhSmQYoTDFi15Klt0=;
        h=From:To:Subject:Date:MIME-Version;
        b=kvUp5misxfG1fIkVV3ce+WF3BlXQiOBkk0RVOBxP0BStdxCKUpVpuZrL5i3zYD+8G
         8siRhFbkCpYPWjmzUYxwuX4WmFTyu900dd6MYa0o/Av+CuryBZTXu69ziR99XOc6Z7
         YUfPf6WiFJu2Kl/xd+6DXZ4Wk4dfcw/XCkOHR0lvzEj26Eb5FiYPBOriXicioYX/G4
         HCFpo+V7sd6ng9GtipktCrZaqkX/0OONHU4mTM864Eiovehk6tnO9LANO+h5TAaKoy
         fGnYwXV41AeHl0T4OO57WkKQ/bUUNRBxohGggrH62H8f/lS9/+mx9mNQdHkG/u15uW
         nSsDRiMgqQk9g==
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
Subject: [PATCH v2 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB offsets
Date:   Tue, 15 Nov 2022 20:32:41 +0100
Message-Id: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEbb0vIKeHKaMvW6NqJPmg/6dZgVPQbkiTpnoEbSXdxS7CzW1PFGTTfUpksX+Tmvdza3EKhH0dWlS2t3wQln0x+ItV1A1NRQDr87iY38ctGbBKnkhTAA
 ffOSU8fRq3EMB/PI0Vorv7Pmez22rA5ceKdM4ZYpNxeAgOJ8rLAEsDeuL5Zhk5quQqglP9PDB59r/FrozKAE4HtQ9FV9IVxa4JsIUPyX9h0AQxvYU0jRnO9c
 C7fXN5kjXmbQP8FGCFdjT3tRrza94kTj89mtp6Skrbxvp9kd13z0puwqhzSyvSbp4yuM6wOuO7xXKiHKr+QQVhc6nFx28ufi0JWDB7bgV271ZZeOZ93ISrc0
 v4+DxJOhPxJEBd0KLNxJB+Z80kT6ntkPQj/K+YKYVaDnFSL0O1JtoLsLttCDxhrst4iBlvzoakYN0jgSYgSVoBLOL7Qem7tFdXKV1TJw3tbc4mN9/FqGIEXy
 E0totXeRcNo1Dl3hyMSC5NKsj1EjI5s7g+3E6zMf0B0pFWuvJFGdMzy2AR2bbqh2icY3i9aZwqpidOZemeiWdpqHj+zwjZpFZ6Qnfj2AkFvg53/nRiJfNDqY
 Z5m2LanbBQw4K5r2TUJFtzuV1/mV70alFlCo98v09rfrTctaUEJTTE+sxp0JHKPqqP8LlN3sn0WYBoPQa3In1AiNIHk5IfQVBj9N5Bv/v5nGjsBObuV9hxJV
 1JysYkextfV+/la8PZxG9bYJSsV21bQR6+smnfuLEt3SAu5a2Xs8qX3bkk7R9lxeSN6dPw4qDrJ7NRAYOR7BrGM0sb+ZjaDKPFgELPV/nge9rTRdRZ7c8w==
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

