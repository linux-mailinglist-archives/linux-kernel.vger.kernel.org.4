Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A42743460
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjF3FgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjF3FgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:14 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F32D78;
        Thu, 29 Jun 2023 22:36:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CBD6F3200984;
        Fri, 30 Jun 2023 01:36:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 01:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103371; x=
        1688189771; bh=q518sSnivonxiIIgOlInc+YEC37Hekh7BSRQImbPyxI=; b=Z
        69iCx3mp4R/Co/9U29vEZtGBbijKzUJ1VNAgqUvvaYhAQYNiOun62VlujgaarQH+
        U8RqazgXiRPZdP3ZJHLQOGAzMmkAIs/opGGppPD6vjDG7EwodPLXYjszFhQEUC5Y
        GB2dExOecntDR9+PPZqXJmKugXFvvVeYwSOq3aQadTg72QyFojr4HJUEgN83P9sj
        MQqoI+P6M7yAVbEc8i1Ic6vSBNwLduanxYf/iISt5ZhNM18wuCgpcDYiJQbpuaSe
        0U50qdwbWgwoT69L4NF9Dq8Nl81VYAaG3hr4JRLDNzrj+AtXhI7qxDm45XXquRP+
        EaYU8HH4yViRh5jUxlMkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103371; x=
        1688189771; bh=q518sSnivonxiIIgOlInc+YEC37Hekh7BSRQImbPyxI=; b=h
        JPrB4761tq+9Ld1E2EJL21PUgK+Tyb5WuwUTguTiS2sPpvxx9lYQ7dT+yzry6fYW
        nN0MOOjJhKUicOF8pEoZ4BKJJClaFt1NgmjfIZ9Wf/7M8bf/WdNVARZaKYIzoXi5
        /rnm3tz1Hxbz8f8/gjyIAIcPZpeULzxqbIP+KE9i5t5Y0hU9/ZjRK+t0Nm2QVdo2
        AfD4Nxaaxw6sZ6LFhd2MmwJWsMOGz9Mr4mbIwiYIkReqKnwuF8a0eO28B9+xgmni
        6NikXR9ciUfQiOOw6+ktg/HVf54t7/MGkOG/d9K4YcnnO96r0mbWMN+BqFtupXi+
        RqgfylmfKi+JVru61/Cew==
X-ME-Sender: <xms:y2meZKFlOXpdmuSaXwaMGW6XyNO0UsHL0BgLix4bQftu1nX7dxhMUg>
    <xme:y2meZLUHITK5clUrpHBW9JXgaEMGtXnFK4r1OaqnvUJ10BF-M_PCvBJhDnygO4Z5D
    plnK2FSyDBH3QV6RGo>
X-ME-Received: <xmr:y2meZEI-OQ1uiKEg0Uj14heoQ28aaQ1gM4CE4Y5OvBNmdRWu6d2xMol4Wfu1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:y2meZEE6CvXgtskaRwBHz6AA9moMWs3dg_WkjWsoo1um_cl2ByRyfw>
    <xmx:y2meZAX44NPYniZphVHMmNrtSvKOPIk6-VrNq0p1BSJLvdVpgefagg>
    <xmx:y2meZHO0INHquaumrsFvpk0D7psUq95hnqFV8sBvDiZwHKJtoQEDAg>
    <xmx:y2meZDHp30xj6BrVFDWljQjMDJ_paUP7wrqjlAD7IRTOrSrJGtS7jA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:07 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/8] platform/x86: asus-wmi: add support for showing middle fan RPM
Date:   Fri, 30 Jun 2023 17:35:46 +1200
Message-ID: <20230630053552.976579-3-luke@ljones.dev>
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
2.41.0

