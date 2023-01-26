Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1416B67CDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjAZOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjAZOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102B113E4;
        Thu, 26 Jan 2023 06:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 001D0B81DF6;
        Thu, 26 Jan 2023 14:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B115C4322E;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=ivf8oy7wqRDszm/BUrY97t3/c8yLV7KjrfeB3zeaq0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgXXlPuYv2IqtdbJcM1Rcx7qf1xF0zIhG6QWg1mFH2mZq7r4DxuIKFRjLg5xmOFRI
         r2gShAU7c6Du+NGn7P2HFOgg/lnnSX41hCqjMKt0PYDi96y1a6/15gi78ZXz/+3wvr
         MqjDbCgDFaeQq2UPZ3FTzT5hOlCXResTRl+F8ybwVuRdgixTsMy0n/Y2qaVzgQ7iVo
         NkxRTV3GGMgiJVkIdY4KB0/UxI+NM5IjUPE/A0xK+OOq98QWWY6cjVWmvCYkhUQ1/e
         Z3eByYTJ5VZvm7yvpx2wgvTh17Spzj041nFlrMm4edAKA28ey7OpF2IeTbbSakK8I3
         DfZc5CSBFS/oQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006ip-6j; Thu, 26 Jan 2023 15:23:05 +0100
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
Subject: [PATCH 14/24] rtc: pm8xxx: clean up local declarations
Date:   Thu, 26 Jan 2023 15:20:47 +0100
Message-Id: <20230126142057.25715-15-johan+linaro@kernel.org>
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

Clean up local declarations somewhat by using the reverse xmas style
consistently throughout.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 2f96a178595c..922aef0f0241 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -177,9 +177,9 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	u8 value[NUM_8_BIT_RTC_REGS];
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u8 value[NUM_8_BIT_RTC_REGS];
 	u32 secs;
 	int rc;
 
@@ -210,12 +210,12 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	int rc;
-	unsigned int ctrl_reg;
-	u8 value[NUM_8_BIT_RTC_REGS];
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u8 value[NUM_8_BIT_RTC_REGS];
+	unsigned int ctrl_reg;
 	u32 secs;
+	int rc;
 
 	rc = regmap_bulk_read(rtc_dd->regmap, regs->alarm_rw, value,
 			      sizeof(value));
@@ -238,11 +238,11 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static int pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
-	int rc;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u8 value[NUM_8_BIT_RTC_REGS] = {0};
 	unsigned int val;
+	int rc;
 
 	if (enable)
 		val = regs->alarm_en;
@@ -355,9 +355,9 @@ MODULE_DEVICE_TABLE(of, pm8xxx_id_table);
 
 static int pm8xxx_rtc_probe(struct platform_device *pdev)
 {
-	int rc;
-	struct pm8xxx_rtc *rtc_dd;
 	const struct of_device_id *match;
+	struct pm8xxx_rtc *rtc_dd;
+	int rc;
 
 	match = of_match_node(pm8xxx_id_table, pdev->dev.of_node);
 	if (!match)
-- 
2.39.1

