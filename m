Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8967CDED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjAZOXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjAZOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DD1D932;
        Thu, 26 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7022AB81DF1;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1158CC43335;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=WgIpMYi4FWB9ExPnYPbTqydDNPPFYwbTWNzEsRMkHfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2P++exfhCPS0wl63NfNlZ9YTF6VV4ZmZvL2VWcAMqTbPOuagVa/Sr1rEJOCUDJB2
         8/sV9t+VcsLmLR3hDIuEwQjOC0Qy9SPfnffxUx8E+Iqd3hrRieU2nd1FUbbwgItkOf
         kltAkxHnKaDgV7ItPF0wptnJPqaJZaxusnLf45/yILWIBMnAoxlfLcCZYPfkDLQ3O5
         hnjhKC1jZqiVaaDkuNPHYafSNyXx+PsLJ0V74KfrtE9nRJyhUPuh8+MuRs66y66hiB
         ANKnLvvbCL6Q+OmLTkwEJBCoWtStshKXpxHtC/yWOlteSPHQeAjLbe42N/5yHbAggq
         QUU7aF07HNL2A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006ig-Ui; Thu, 26 Jan 2023 15:23:04 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 11/24] rtc: pm8xxx: clean up comments
Date:   Thu, 26 Jan 2023 15:20:44 +0100
Message-Id: <20230126142057.25715-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the driver comments somewhat and remove obsolete, incorrect or
redundant ones.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index ea867b20573a..8a94a19e0d14 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -23,13 +23,13 @@
 
 /**
  * struct pm8xxx_rtc_regs - describe RTC registers per PMIC versions
- * @ctrl: base address of control register
- * @write: base address of write register
- * @read: base address of read register
- * @alarm_ctrl: base address of alarm control register
- * @alarm_ctrl2: base address of alarm control2 register
- * @alarm_rw: base address of alarm read-write register
- * @alarm_en: alarm enable mask
+ * @ctrl:		address of control register
+ * @write:		base address of write registers
+ * @read:		base address of read registers
+ * @alarm_ctrl:		address of alarm control register
+ * @alarm_ctrl2:	address of alarm control2 register
+ * @alarm_rw:		base address of alarm read-write registers
+ * @alarm_en:		alarm enable mask
  */
 struct pm8xxx_rtc_regs {
 	unsigned int ctrl;
@@ -42,12 +42,12 @@ struct pm8xxx_rtc_regs {
 };
 
 /**
- * struct pm8xxx_rtc -  rtc driver internal structure
- * @rtc:		rtc device for this driver.
- * @regmap:		regmap used to access RTC registers
- * @allow_set_time:	indicates whether writing to the RTC is allowed
+ * struct pm8xxx_rtc -  RTC driver internal structure
+ * @rtc:		RTC device
+ * @regmap:		regmap used to access registers
+ * @allow_set_time:	whether the time can be set
  * @alarm_irq:		alarm irq number
- * @regs:		rtc registers description.
+ * @regs:		register description
  * @dev:		device structure
  */
 struct pm8xxx_rtc {
@@ -90,7 +90,7 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (rc)
 		return rc;
 
-	/* Disable RTC H/w before writing on RTC register */
+	/* Disable RTC */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE, 0);
 	if (rc)
 		return rc;
@@ -111,7 +111,7 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (rc)
 		return rc;
 
-	/* Enable RTC H/w after writing on RTC register */
+	/* Enable RTC */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE,
 				PM8xxx_RTC_ENABLE);
 	if (rc)
@@ -242,7 +242,7 @@ static int pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	if (rc)
 		return rc;
 
-	/* Clear Alarm register */
+	/* Clear alarm register */
 	if (!enable) {
 		rc = regmap_bulk_write(rtc_dd->regmap, regs->alarm_rw, value,
 				       sizeof(value));
@@ -269,13 +269,13 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 
 	rtc_update_irq(rtc_dd->rtc, 1, RTC_IRQF | RTC_AF);
 
-	/* Clear the alarm enable bit */
+	/* Disable alarm */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 				regs->alarm_en, 0);
 	if (rc)
 		return IRQ_NONE;
 
-	/* Clear RTC alarm register */
+	/* Clear alarm status */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
 				PM8xxx_RTC_ALARM_CLEAR, 0);
 	if (rc)
@@ -332,9 +332,6 @@ static const struct pm8xxx_rtc_regs pmk8350_regs = {
 	.alarm_en	= BIT(7),
 };
 
-/*
- * Hardcoded RTC bases until IORESOURCE_REG mapping is figured out
- */
 static const struct of_device_id pm8xxx_id_table[] = {
 	{ .compatible = "qcom,pm8921-rtc", .data = &pm8921_regs },
 	{ .compatible = "qcom,pm8058-rtc", .data = &pm8058_regs },
@@ -382,7 +379,6 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	/* Register the RTC device */
 	rtc_dd->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc_dd->rtc))
 		return PTR_ERR(rtc_dd->rtc);
@@ -390,7 +386,6 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	rtc_dd->rtc->ops = &pm8xxx_rtc_ops;
 	rtc_dd->rtc->range_max = U32_MAX;
 
-	/* Request the alarm IRQ */
 	rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->alarm_irq,
 					  pm8xxx_alarm_trigger,
 					  IRQF_TRIGGER_RISING,
-- 
2.39.1

