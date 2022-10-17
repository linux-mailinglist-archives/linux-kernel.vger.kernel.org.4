Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE72C601DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJQX4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJQX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:56:11 -0400
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEC73DEE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:56:06 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kZxkoIDsHJpY4kZxloMdt3; Tue, 18 Oct 2022 01:56:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666050965; bh=9AqIDwasHv/H4KU9S0QioOQou+hO6NpojAdY9uHOcbA=;
        h=From:To:Subject:Date:MIME-Version;
        b=LH2MqRH3B9uHU6tD9Dxd44gak30mkP0K/k0V5kUUBnOHawF2Olhg2Xu8xW1ShplNr
         nwm3vIx37EAooAhU0t8Z07ZytmJDi0TeJ1812H3rBUsXqp2jysrqSNFzI/TWtccsKW
         q0JDIcYjpcI4ITusCSNt33Gy2eM1VJ5H9sAcLIPpSRz9VfnkZL/JroakrNZ79k8wBj
         lpszL44jGfsdP8hixzwOqCyaPwWSVQZyeD8lF68SWc3nt2mxEh5upDhPwOHEnmUChI
         uKTbltN7gXOvjyNfTWLd62hqb+TWq3S+wzaZ4zYWe12TEP0L1oC2qfqTqY4BPGgNHa
         tN3G5hlJVpYUg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 2/5] clk: imx: imxrt1050: add IMXRT1050_CLK_LCDIF_PIX clock gate
Date:   Tue, 18 Oct 2022 01:55:59 +0200
Message-Id: <20221017235602.86250-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPrn7ntQdoekybvwfhFyO67CFnqXTpbenwSu5crc4XKZ5ExrFtLgKub6vuPX7iwmOxEApIB8wqcmul4VKipnrJ27OwlZeUrE7KmNoEviAUNFWy5I+1jK
 Er10ZCTFieqmKEHNcDB6Ng7qMSpyAFxg7ipKt/VcvJolwBx6RX8S+M39hOOc/VOvYWnecqGjNzK/kVcPY7JZifJTtYIWPnYAARwEY58+xTp/XQvKvyTSFB1Z
 C6UfaD7j4D19FwrNcGCHX8XhVIyVugL4O+RAAdaMEbh0+fJZoac2gSx1NlaWbiZ0GahmGCYIP4Ef8QqEsEFQjxYu/YKQCY+GHHY5/pq4+U1hGkFOaVRTtlTO
 76N/gnGQVpL9VPF1n4+10sQCFizSAjUPk//MMKeog7rVul0qYBwEpbOcjfEdXAqD7GKRmoQlasBn9eNPFXU4SDIgx2ED23AbFRi7yN7afF1dJDEWDsehoKq6
 5hm0KOOkD4snEZOezBo0yu/wvojYXOX7oST69pEwuYUGzCrQgBGb2mMAqzvcrQzCVF/Va8oAv3VfNQWwQvrhCOBmx1SGBgA6grB4179aeZWCL8gwLON7c5MZ
 TY0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
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

