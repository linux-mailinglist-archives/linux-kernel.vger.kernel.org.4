Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A37361BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFTC5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFTC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCE10CB;
        Mon, 19 Jun 2023 19:57:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5550A5C01EA;
        Mon, 19 Jun 2023 22:57:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 22:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229836; x=
        1687316236; bh=lUTuHDqLTLgI45JDTkN4av/NgduImU02Ny3VO4Ijj6g=; b=d
        HtUwnyX/3j8S4JGu1ZwdVf5HQq4gUhHadbYZsz2OhFipiukeT9VVW2YusMtM/ayG
        KICWzaw15szJnjKiTCRgINK/LJSpMPaoFvEuX7VJCFLdgIPBl3UA1TZISQetznRu
        GYGws9hjgXarg0ShX2014NT9Mj97i5PKlrlglfEmiGTNqiXd9QlBg35McZVBNVsI
        z0h6iZbWxta/E3Jv3Tarcw7F182OO8yIZzE1keCvMa//L0HA0SOzLZ5Mu1dlfBya
        Bc0EQFP6nGSI7KqnAZ87zkFE6jbUUK3lDusLpFQcqu90Bt8khSrt8rxpSAb+aWGP
        /ji/i7JEJvEeLf6juAtWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229836; x=
        1687316236; bh=lUTuHDqLTLgI45JDTkN4av/NgduImU02Ny3VO4Ijj6g=; b=c
        cuAQzbmhgLbhdpr0hN3XNCeR6tls8h+zLCPVH/6t5Q6FndYW4eRzlN5JVftEDb+c
        XlY5k+/u5sdWlAdptgCUiDH+Fe29ES+z+kn3EXwAKxQqgUWKjyRj1hFY+ifPLmAk
        dLonmtxZ0Yhi/0CKbO1QlH5gAIl15O6FH7ND0WKO1Rq6TyisGWSHiWGsAUHb+cPn
        KJYZcvjhukFEmWXz1NM89/k8h9ILD/Bz+QL+oSi13RzSesqBsytZaLDHfof1HtPd
        I22Vmq9XBTuZj23k9hfwfzx9dmo/fe84gJ315Fq1GCzkCcvLIF9/jb6vnNVn7BKL
        6Mul/ZUfIDSmtlo19bV1A==
X-ME-Sender: <xms:jBWRZB3rY3B3wCgeaAXeg7P68qz0MTIvO6LZQ5qMU3X79H_dpg5Y_Q>
    <xme:jBWRZIFFecxnGLNqeuj49BzKt_DJxRkIriSKbZkVnFEXV0K6QQXCPz4SRhpF0M8Ff
    _zOXMmEiUop3pmuNJM>
X-ME-Received: <xmr:jBWRZB7WYOyz5E6oXEjlw-RcAxDDZcr7j47ZnOpH5DA-hnNlXBghNhDJALUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:jBWRZO2KJVKh0uLK3Z0VeIHKqQoNojupxBsosUNfe4_bfiYN6DqPfg>
    <xmx:jBWRZEHZjIneEl6kJjU1VlI5wcG9uGFE20xsWT59Bt-NXfPqronE9Q>
    <xmx:jBWRZP-C-0KDxm1InJtqlw__gY3YDoFkDSmNnDWDDiH4pxaPLsGDIw>
    <xmx:jBWRZP0xM67qYpiLerUbqkbVQbMkG1JhjIAZdngjad3YKYmXxklUwQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:13 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/8] platform/x86: asus-wmi: support middle fan custom curves
Date:   Tue, 20 Jun 2023 14:56:36 +1200
Message-Id: <20230620025641.53197-4-luke@ljones.dev>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620025641.53197-1-luke@ljones.dev>
References: <20230620025641.53197-1-luke@ljones.dev>
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
2.40.1

