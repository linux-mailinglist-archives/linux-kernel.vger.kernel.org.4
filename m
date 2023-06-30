Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8615743463
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjF3Fg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjF3FgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:19 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD72D78;
        Thu, 29 Jun 2023 22:36:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 079D9320098C;
        Fri, 30 Jun 2023 01:36:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 01:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103376; x=
        1688189776; bh=J5Y4dx1tZFnnSjeHMvtCaqCyhXJYhqnkpp50GoTLBdg=; b=c
        IOMuKR2xIUrJ8tx6CjYa+F6PYB3k/heUhnFJw1bEJEdrVkBQXxbDk1JOJVFj+OIm
        6u6ul7oUOqpC4fp4WWMsZ29jOXCYVM+HNg9F2qiXOfABpX6n/pQeLAYQq692jKwL
        E+vrSI6f5N9JoSgMhJpDBluD/4iV4bw6u8GWXyq3C/ilFenh+d6wYdwuO9Jcpe1R
        6OuYX07r62wrKXSr1mnJ3TU2EnVmEbto4leqgSsHIbVJb3xGpP65ewfykrPatjLx
        t2T3a3tSPrItTOhzvkfAxFKONVHBEyfbDkDFgMgca7njq1M7DEIqFR/aCIlJWNn6
        D0IVmlbUqiMF2U8WKuj/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103376; x=
        1688189776; bh=J5Y4dx1tZFnnSjeHMvtCaqCyhXJYhqnkpp50GoTLBdg=; b=e
        k1P5xrJU1lx/H5MEPcHDYYR46dkcfZy0s7PJoWhRaA2wNGH4yW5jB1LEF/DUAmwN
        kXg9zgIJrwML39a9g/gcxYrpz8XaPgi1iOwOziy0yhW97GEfBXu9O/Vj0hh1K610
        aqpkF3bjOW6Xg9mXUHBnGswSTnjaF9pF1EsunkTvQheIefAcFVCT9Ih6DCu2pqhb
        hxsKCEx/wOd6cvT0dVJTm8uTaqWYqwkw4eovxNQMgXG8tjG6Abou7AyldLBLmtnx
        Aboo+0FlnjpGaK2WdTFPcT+CnSBSBT8g+Nci3g9fNe/3swrbbWRyN+ojLDeAoPMa
        jy5qHRjFeCCPRx8kUICUw==
X-ME-Sender: <xms:0GmeZDM_2R77RO8EONmDN1FAsydEAZk8KVv-LkFDNOHX2i15K25RLQ>
    <xme:0GmeZN_WQRZA1o-BtIrZo_Fji7wX3_cMwHGRrF-s5ueYLi5nFffVqaQ7-fBqR0Rc5
    2CawF8s-jIRteaqSiU>
X-ME-Received: <xmr:0GmeZCQvCRACFlFAcZVC3-PMDYDT4-v1AtM7ntIVbMqj0_HFOjeHOt-WAv1i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:0GmeZHvWVgaV-ytAlQFY6ax0ko4EXqMZhiayCaVIfXOnYiCDwhMt5g>
    <xmx:0GmeZLeYU1fOU-Rarbi2GIlBfmIbCReKXpX2_X9pj8WAJHGQPfjHuQ>
    <xmx:0GmeZD0MZ0WaSRv-oZR7ZaDf2mByY-1qS63zLo1BS5BI6kLROvmr-w>
    <xmx:0GmeZNvW2hmrders-iJ8gClthBwTzS7msKpgaGh0n9shcVth5k62nQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:13 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 3/8] platform/x86: asus-wmi: support middle fan custom curves
Date:   Fri, 30 Jun 2023 17:35:47 +1200
Message-ID: <20230630053552.976579-4-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630053552.976579-1-luke@ljones.dev>
References: <20230630053552.976579-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for fan curves defined for the middle fan which
is available on some ASUS ROG laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 77 +++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 375d25ae0aca..fb27218e51cf 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -113,6 +113,7 @@ module_param(fnlock_default, bool, 0444);
 #define FAN_CURVE_BUF_LEN		32
 #define FAN_CURVE_DEV_CPU		0x00
 #define FAN_CURVE_DEV_GPU		0x01
+#define FAN_CURVE_DEV_MID		0x02
 /* Mask to determine if setting temperature or percentage */
 #define FAN_CURVE_PWM_MASK		0x04
 
@@ -253,7 +254,8 @@ struct asus_wmi {
 
 	bool cpu_fan_curve_available;
 	bool gpu_fan_curve_available;
-	struct fan_curve_data custom_fan_curves[2];
+	bool mid_fan_curve_available;
+	struct fan_curve_data custom_fan_curves[3];
 
 	struct platform_profile_handler platform_profile_handler;
 	bool platform_profile_support;
@@ -2080,6 +2082,8 @@ static ssize_t pwm1_enable_store(struct device *dev,
 		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
 	if (asus->gpu_fan_curve_available)
 		asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
+	if (asus->mid_fan_curve_available)
+		asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
 
 	return count;
 }
@@ -2531,6 +2535,9 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	if (fan_dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
 		fan_idx = FAN_CURVE_DEV_GPU;
 
+	if (fan_dev == ASUS_WMI_DEVID_MID_FAN_CURVE)
+		fan_idx = FAN_CURVE_DEV_MID;
+
 	curves = &asus->custom_fan_curves[fan_idx];
 	err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
 					   FAN_CURVE_BUF_LEN);
@@ -2819,6 +2826,42 @@ static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point7_pwm, fan_curve,
 static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_pwm, fan_curve,
 			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
 
+/* MID */
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, fan_curve_enable, FAN_CURVE_DEV_GPU);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point6_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point7_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point8_temp, fan_curve,
+			       FAN_CURVE_DEV_GPU, 7);
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point6_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point7_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point8_pwm, fan_curve,
+			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
+
 static struct attribute *asus_fan_curve_attr[] = {
 	/* CPU */
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
@@ -2856,6 +2899,24 @@ static struct attribute *asus_fan_curve_attr[] = {
 	&sensor_dev_attr_pwm2_auto_point6_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point7_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point8_pwm.dev_attr.attr,
+	/* MID */
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point5_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point6_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point7_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point8_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point5_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point6_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point7_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point8_pwm.dev_attr.attr,
 	NULL
 };
 
@@ -2875,6 +2936,9 @@ static umode_t asus_fan_curve_is_visible(struct kobject *kobj,
 	if (asus->gpu_fan_curve_available && attr->name[3] == '2')
 		return 0644;
 
+	if (asus->mid_fan_curve_available && attr->name[3] == '3')
+		return 0644;
+
 	return 0;
 }
 
@@ -2904,7 +2968,14 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 	if (err)
 		return err;
 
-	if (!asus->cpu_fan_curve_available && !asus->gpu_fan_curve_available)
+	err = fan_curve_check_present(asus, &asus->mid_fan_curve_available,
+				      ASUS_WMI_DEVID_MID_FAN_CURVE);
+	if (err)
+		return err;
+
+	if (!asus->cpu_fan_curve_available
+		&& !asus->gpu_fan_curve_available
+		&& !asus->mid_fan_curve_available)
 		return 0;
 
 	hwmon = devm_hwmon_device_register_with_groups(
@@ -2973,6 +3044,8 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
 	if (asus->gpu_fan_curve_available)
 		asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
+	if (asus->mid_fan_curve_available)
+		asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
 
 	return 0;
 }
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 2c03bda7703f..329efc086993 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -83,6 +83,7 @@
 #define ASUS_WMI_DEVID_MID_FAN_CTRL 0x00110031
 #define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
+#define ASUS_WMI_DEVID_MID_FAN_CURVE	0x00110032
 
 /* Power */
 #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
-- 
2.41.0

