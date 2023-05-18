Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877F4708214
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjERNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjERNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:08:12 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 06:07:56 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F32F1726;
        Thu, 18 May 2023 06:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684415090; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jHp5siR+mpF442a5tGnVIsTWCOu67V55rUPcoVou53WJKCWN+qTAmII+Pu7TU8ex/D
    ySc9MtPECNPRnckq8ffAVuhWY3mWc/KQ02u7XxRUW17+KlUrEjaSL9ImXRvFPzRRWKol
    T71KZYiJsYr4gC96Z2zjELQQK+JhoCs81WVtBkXj/p34f4eRtWIrU2t580mxujVcEXJT
    G1ygOstO9LGws1Qvj3qMkD91qtCp2gBluqD0pMam7Bov9bdNLV95awDdWfV8in14ble1
    n1unqDIZPTjwKjQ5sA8XcuejNLKxgoPWfLwj0xa8ta5lOfB0E+wELt4DPjZicgOir1J5
    vQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684415090;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=1A4pWdRSyRquDJYOJ8/0StLwGPzYcPJ+8wTjCsISdD8=;
    b=mqzczOcU5K6zxym1zhKJ27g9oD2QhWKdq3EdsIrVgkimBlyZBrFfQXOljU/+/RCH25
    8fyIEDniNEt0KIkzKIHH2E+oULCE7lVxi86Xxji3q9xD1vzBZSLCA0ZnHQtAuPRy6RA5
    mp/YBNaxbQNQojX/Vuj101TvU2lWPkOjNqEzIRfoWMM8pMiMKCWtYNHOyA4SA+AHGQ4Q
    7aROCLu6uGh/wsTMaMQfrZEPLIwgMdMKzOvzgnahRlVn/TR6RG5HK5fcSfHIDd6EA4lG
    4qUQWq23DngjEYt1c/AyhBmYspLWrfwjO5X2lGtoL9MArqlgRUtl9JEufiIUI4O0eCJ9
    oEgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684415090;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=1A4pWdRSyRquDJYOJ8/0StLwGPzYcPJ+8wTjCsISdD8=;
    b=bMshw8duaax9aITLuq2vz4VCipAk+DcXI85nhKezpsY8LVVBtlG6dTZcX4xYDv2/77
    iEfY6hurG0RjWXSq97qNkyCEQa3wy8DVpAjuQIZ5+Q29Vauu12m5AUVJo5YUBubesoZQ
    F/UB6WkPa9O3IShE+ABpnRS/tBWGNXteaXAwcjzTnnpz/RlVKxKnn0/6LgfwgpM7t6qY
    +3YFpntevYSlXTlPUm/UBYS6X/kPC3Enjuzehl+8Xg5SVDfM4nKHl4DzPZQlGT5ra1uS
    yGSlF8zgAfGd08Q2KSHPcJH4UaqvDx4KPt2cgkHe7+TccuiAUPOw5Rfck4vjy/IJjqzW
    JkFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684415090;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=1A4pWdRSyRquDJYOJ8/0StLwGPzYcPJ+8wTjCsISdD8=;
    b=yR1zUV+6SNnB74h2L/cWgn5U5zo14cpDUHP5THYm7utMH3ChNq/dMEz/+zkdzZFBlv
    uAgFYXaxT8wdiC72HDDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p1/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4ID4oCWf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 May 2023 15:04:50 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 18 May 2023 15:04:25 +0200
Subject: [PATCH] spi: qup: Request DMA before enabling clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230518-spi-qup-clk-defer-v1-1-f49fc9ca4e02@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAFgiZmQC/x2N0QrCMAwAf2Xk2UC7MhF/RXzo2tQFS60JG8LYv
 xv2eAfH7aAkTAr3YQehjZU/zcBfBkhLbC9CzsYwujG4yd9QO+N37ZjqGzMVEswlhkRXHxwFsG6
 OSjhLbGmxsq21muxChX/n6PE8jj/UF+p5eAAAAA==
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is usually better to request all necessary resources (clocks,
regulators, ...) before starting to make use of them. That way they do
not change state in case one of the resources is not available yet and
probe deferral (-EPROBE_DEFER) is necessary. This is particularly
important for DMA channels and IOMMUs which are not enforced by
fw_devlink yet (unless you use fw_devlink.strict=1).

spi-qup does this in the wrong order, the clocks are enabled and
disabled again when the DMA channels are not available yet.

This causes issues in some cases: On most SoCs one of the SPI QUP
clocks is shared with the UART controller. When using earlycon UART is
actively used during boot but might not have probed yet, usually for
the same reason (waiting for the DMA controller). In this case, the
brief enable/disable cycle ends up gating the clock and further UART
console output will halt the system completely.

Avoid this by requesting the DMA channels before changing the clock
state.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/spi/spi-qup.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 944ef6b42bce..00e5e88e72c4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1028,23 +1028,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = clk_prepare_enable(cclk);
-	if (ret) {
-		dev_err(dev, "cannot enable core clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(iclk);
-	if (ret) {
-		clk_disable_unprepare(cclk);
-		dev_err(dev, "cannot enable iface clock\n");
-		return ret;
-	}
-
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
 		dev_err(dev, "cannot allocate master\n");
 		return -ENOMEM;
 	}
@@ -1092,6 +1077,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
+	ret = clk_prepare_enable(cclk);
+	if (ret) {
+		dev_err(dev, "cannot enable core clock\n");
+		goto error_dma;
+	}
+
+	ret = clk_prepare_enable(iclk);
+	if (ret) {
+		clk_disable_unprepare(cclk);
+		dev_err(dev, "cannot enable iface clock\n");
+		goto error_dma;
+	}
+
 	iomode = readl_relaxed(base + QUP_IO_M_MODES);
 
 	size = QUP_IO_M_OUTPUT_BLOCK_SIZE(iomode);
@@ -1121,7 +1119,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error_dma;
+		goto error_clk;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -1145,7 +1143,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error_dma;
+		goto error_clk;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -1160,11 +1158,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_clk:
+	clk_disable_unprepare(cclk);
+	clk_disable_unprepare(iclk);
 error_dma:
 	spi_qup_release_dma(master);
 error:
-	clk_disable_unprepare(cclk);
-	clk_disable_unprepare(iclk);
 	spi_master_put(master);
 	return ret;
 }

---
base-commit: 5e41763e97db00125dec847e54a1827436d34cd3
change-id: 20230518-spi-qup-clk-defer-dfa3ce6130e3

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

