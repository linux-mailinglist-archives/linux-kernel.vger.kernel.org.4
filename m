Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B327361BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjFTC5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTC5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E910CE;
        Mon, 19 Jun 2023 19:57:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C7E565C01E4;
        Mon, 19 Jun 2023 22:57:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 22:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229832; x=
        1687316232; bh=i2v99NqpJrZxAzLHsyMCcMd30q0IFnY2dIA+JESeIh8=; b=d
        KoNkgBGYUqzm2MyCdEBOpeVHf/gJ4KkT0cPooKtsix0niehPf0Yq5I4FwjvBg4+J
        f6t5qSpjr/QemhAUx44GjHJaDbVoBeWo3oRmKJWCbFV3g7gQvE13SgGtPUnKcVev
        C8m7bkj5Ej/6CpoKlnwwoHd4TLPadq3iG8TP0Y246wvwkBKnSbxX4CLwQHYjZqLj
        MHtnSRae0YgQaVyxzPWq32zP29YnTmx65PGpSqNV0YHLQfzORoogOrXeZWi6v6lK
        ikk4l9JprQqVaoqGx4+7wu6Hi4CA543qQ36ZXrGcfo1wgHCCMkZCImYaaM9w2LNH
        zqQbRAXFSc5hLlkz+lBfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229832; x=
        1687316232; bh=i2v99NqpJrZxAzLHsyMCcMd30q0IFnY2dIA+JESeIh8=; b=P
        mwIt3y+m6nKhG6cfmUH+qMqXD1Z0m9e0YSpsofvRpTHzd1AdViCcFsjuBXO98jgR
        FVXEdbZ55EK2YL7ZLJLmgOXj1eCQ5rT86y/LwYBenkjB8VOVU8+Wn8LkEeV3UCex
        CBky3zDgo3DLbrLQ5FBhMzZZXMrd+wcyZvWI5K6EoSQ8u5gBpRiZ89nBw5hbjVXR
        /+747MnTg6USfaZgaiiU0V0BCeaYj8O0K403YSvaWzl3GI6gP/wAXqWCjQSdbrBY
        wrz8vq32NHYL7UDyPmyC2ty8sL7ynaROFWA52NkjcxtCh4MMFLH5Nnk2+ldE8tby
        sx6mNAIIpdvdCYX908eZQ==
X-ME-Sender: <xms:iBWRZFtCb-vVyuGxIe6PyS5tXy8Xiar8TqZFk8MPo2I0hSlB089KFg>
    <xme:iBWRZOce15ERde2PSUa2OOWdVCgTJXG3qJxLbZR5MedTIplk19uuAkAPPsnzjtEP6
    pDRw7A5A5vjbrsU9fs>
X-ME-Received: <xmr:iBWRZIwKsCTsQtsdpsUY2FCVPj2cWML6D_9WpCOSMYQMSM0VbqhBV9qqQSP1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:iBWRZMOxYS79YDJj2uMscHC6SzpEC9FXXhY_TVJPHX_rxAwaKqKq1w>
    <xmx:iBWRZF-mVbu5_7udwlpo5Q0As4Ojo56bRs9j05nvTVqMb3mtF0Q77A>
    <xmx:iBWRZMXMa_lFqSnao93DTSOivVIsdUWxhWWYkw0oDbnSnRCwDFJqHw>
    <xmx:iBWRZOMw8ki4F3rFB2TvAw0z-RVmAWMg524TNMCgC30tkPWNpmWphg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:09 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/8] platform/x86: asus-wmi: add support for showing middle fan RPM
Date:   Tue, 20 Jun 2023 14:56:35 +1200
Message-Id: <20230620025641.53197-3-luke@ljones.dev>
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

Some newer ASUS ROG laptops now have a middle/center fan in addition
to the CPU and GPU fans. This new fan typically blows across the
heatpipes and VRMs betweent eh CPU and GPU.

This commit exposes that fan to PWM control plus showing RPM.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 91 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f23375d5fb82..375d25ae0aca 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -72,6 +72,7 @@ module_param(fnlock_default, bool, 0444);
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
+#define ASUS_MID_FAN_DESC		"mid_fan"
 #define ASUS_GPU_FAN_DESC		"gpu_fan"
 #define ASUS_FAN_DESC			"cpu_fan"
 #define ASUS_FAN_MFUN			0x13
@@ -229,8 +230,10 @@ struct asus_wmi {
 
 	enum fan_type fan_type;
 	enum fan_type gpu_fan_type;
+	enum fan_type mid_fan_type;
 	int fan_pwm_mode;
 	int gpu_fan_pwm_mode;
+	int mid_fan_pwm_mode;
 	int agfn_pwm;
 
 	bool fan_boost_mode_available;
@@ -2129,6 +2132,31 @@ static ssize_t fan2_label_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", ASUS_GPU_FAN_DESC);
 }
 
+/* Middle/Center fan on modern ROG laptops */
+static ssize_t fan3_input_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int value;
+	int ret;
+
+	ret = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_MID_FAN_CTRL, &value);
+	if (ret < 0)
+		return ret;
+
+	value &= 0xffff;
+
+	return sysfs_emit(buf, "%d\n", value * 100);
+}
+
+static ssize_t fan3_label_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", ASUS_MID_FAN_DESC);
+}
+
 static ssize_t pwm2_enable_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2175,6 +2203,52 @@ static ssize_t pwm2_enable_store(struct device *dev,
 	return count;
 }
 
+static ssize_t pwm3_enable_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->mid_fan_pwm_mode);
+}
+
+static ssize_t pwm3_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int state;
+	int value;
+	int ret;
+	u32 retval;
+
+	ret = kstrtouint(buf, 10, &state);
+	if (ret)
+		return ret;
+
+	switch (state) { /* standard documented hwmon values */
+	case ASUS_FAN_CTRL_FULLSPEED:
+		value = 1;
+		break;
+	case ASUS_FAN_CTRL_AUTO:
+		value = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = asus_wmi_set_devstate(ASUS_WMI_DEVID_MID_FAN_CTRL,
+				    value, &retval);
+	if (ret)
+		return ret;
+
+	if (retval != 1)
+		return -EIO;
+
+	asus->mid_fan_pwm_mode = state;
+	return count;
+}
+
 /* Fan1 */
 static DEVICE_ATTR_RW(pwm1);
 static DEVICE_ATTR_RW(pwm1_enable);
@@ -2184,6 +2258,10 @@ static DEVICE_ATTR_RO(fan1_label);
 static DEVICE_ATTR_RW(pwm2_enable);
 static DEVICE_ATTR_RO(fan2_input);
 static DEVICE_ATTR_RO(fan2_label);
+/* Fan3 - Middle/center fan */
+static DEVICE_ATTR_RW(pwm3_enable);
+static DEVICE_ATTR_RO(fan3_input);
+static DEVICE_ATTR_RO(fan3_label);
 
 /* Temperature */
 static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
@@ -2192,10 +2270,13 @@ static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
 	&dev_attr_pwm2_enable.attr,
+	&dev_attr_pwm3_enable.attr,
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_label.attr,
 	&dev_attr_fan2_input.attr,
 	&dev_attr_fan2_label.attr,
+	&dev_attr_fan3_input.attr,
+	&dev_attr_fan3_label.attr,
 
 	&dev_attr_temp1_input.attr,
 	NULL
@@ -2221,6 +2302,11 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	    || attr == &dev_attr_pwm2_enable.attr) {
 		if (asus->gpu_fan_type == FAN_TYPE_NONE)
 			return 0;
+	} else if (attr == &dev_attr_fan3_input.attr
+	    || attr == &dev_attr_fan3_label.attr
+	    || attr == &dev_attr_pwm3_enable.attr) {
+		if (asus->mid_fan_type == FAN_TYPE_NONE)
+			return 0;
 	} else if (attr == &dev_attr_temp1_input.attr) {
 		int err = asus_wmi_get_devstate(asus,
 						ASUS_WMI_DEVID_THERMAL_CTRL,
@@ -2264,6 +2350,7 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 static int asus_wmi_fan_init(struct asus_wmi *asus)
 {
 	asus->gpu_fan_type = FAN_TYPE_NONE;
+	asus->mid_fan_type = FAN_TYPE_NONE;
 	asus->fan_type = FAN_TYPE_NONE;
 	asus->agfn_pwm = -1;
 
@@ -2278,6 +2365,10 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL))
 		asus->gpu_fan_type = FAN_TYPE_SPEC83;
 
+	/* Some models also have a center/middle fan */
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MID_FAN_CTRL))
+		asus->mid_fan_type = FAN_TYPE_SPEC83;
+
 	if (asus->fan_type == FAN_TYPE_NONE)
 		return -ENODEV;
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index f90cafe26af1..2c03bda7703f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -80,6 +80,7 @@
 #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
 #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
 #define ASUS_WMI_DEVID_GPU_FAN_CTRL	0x00110014
+#define ASUS_WMI_DEVID_MID_FAN_CTRL 0x00110031
 #define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 
-- 
2.40.1

