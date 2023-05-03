Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2A6F4F59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjECECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECECW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:02:22 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBBD2727;
        Tue,  2 May 2023 21:02:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 38D213200AAD;
        Wed,  3 May 2023 00:02:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 May 2023 00:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1683086538; x=1683172938; bh=VYBJO0UPR7
        6zN4C9WMT8MGqQxoqydDBNEJqhJ3yARCg=; b=g8lbJiQlpFvedpHAShPIn+dLfF
        V5L/Br5i2kP5ElbSxqOFvss8RP2A00AbpG1+QF0eiP88TgLEY3BLyPZ4sbm3EoIO
        OeJXSd0dndcsWyCsfctsWD11tKWnsTclPv6cQtjLjwLGZJ7G+Yn96HtdO8sET8qg
        0vudxIOwI+uDtcQWWLYKZzyY0PoMQAZN8ovFDsaVssl7CPy3fPF1ck2oCHMVGtAE
        wmnobYdwPrKSbVDLGovcLiJw+lPMIO3rIjWZ1reQC29yxGdmt7OzhtcqR5F1PvF+
        BE0Qn+hrlNiAHX9TWMdh+6g9gMDR/EfNlMaeTYqpzi+dvyDon9bL/31KVE9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683086538; x=1683172938; bh=VYBJO0UPR76zN
        4C9WMT8MGqQxoqydDBNEJqhJ3yARCg=; b=dLz7+xZi+IyygjWVykOkduA/cYXeX
        +z8LJE3QpHTnK1m8h6r1P5gN3rBEaIk5ujAA70qpCzkhAGBNfRKF9APO4dP6ZL6u
        slDlbq9jRvE914+R+t6rXxZYRQYx4PSKEQ50QpyVj7S6jFT3D0UtsEfzjhreW6Z2
        7TAHmZC4QEM/dCx4SzY/xxfVwWs2wm+nWhIpOdNjI6sxukyd8iKr7gB8WF9PuU9B
        /gsPrxjxOdosodrjwoLnC3v7/fTJ/dIDnDWxFLw8CUdR0u8+pDPKu6uEnszQjBL1
        IqRLCUVxcTgSRQnOrCHEzYAQdiWUX6jT0e4z5gmssJxSCF4LMPECz94uw==
X-ME-Sender: <xms:ytxRZA728e7gUhCzftYF3XzX3DKWtNjbybLFUn94-pP5QRFio8nIEA>
    <xme:ytxRZB509GDA_q35qtYY5kbC2555h-pZe3OFoNEQ5PLWrVxGkpd727XQjP17k7_Dp
    YstWfTgX9day5ELnSk>
X-ME-Received: <xmr:ytxRZPe8cO9tQUjEc-mcfRLaezaUHpBeY1d2aTwNWjTRPaorzyVSD2qMQi_2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ytxRZFLLXefDTPLUEyzVDNNf-ut73NmBc-eU9wZna48Gje7OZgsYOA>
    <xmx:ytxRZEICd4_3mKY4XExgteyQWC5CMPxw5VW4AdMGvddzVLBXyTtshw>
    <xmx:ytxRZGzecdMNofs2_RPAs98icEiYnbyhCzbUvqu540w8Hd6YW2W0vQ>
    <xmx:ytxRZM_6IPn8NMW4qfNwZ9sCmEpx-nZWWF0xUR0jZ05qLPXc9efYRg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 00:02:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        hdegoede@redhat.com, corentin.chary@gmail.com,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Wed,  3 May 2023 16:02:07 +1200
Message-Id: <20230503040207.257406-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the WMI methods used to turn off and adjust the
brightness of the secondary "screenpad" device found on some high-end
ASUS laptops like the GX650P series and others.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  20 +++
 drivers/platform/x86/asus-wmi.c               | 121 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |   4 +
 3 files changed, 145 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index a77a004a1baa..97028c919c03 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -98,3 +98,23 @@ Description:
 		Enable an LCD response-time boost to reduce or remove ghosting:
 			* 0 - Disable,
 			* 1 - Enable
+
+What:		/sys/devices/platform/<platform>/screenpad_enable
+Date:		May 2023
+KernelVersion:	6.4
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Enable the secondary "screenpad" screen found on some ASUS
+		devices which is typically a short screen mounted above the
+		keyboard and below the main screen:
+			* 0 - Disable,
+			* 1 - Enable
+
+What:		/sys/devices/platform/<platform>/screenpad_brightness
+Date:		May 2023
+KernelVersion:	6.4
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Control the brightness of the secondary "screenpad" screen
+		found on some ASUS devices:
+			* 0-255 where 255 is maximum brightness
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1038dfdcdd32..bd3975be9060 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -241,6 +241,10 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
 
+	bool screenpad_enable_available;
+	bool screenpad_brightness_available;
+	u8 screenpad_last_brightness;
+
 	bool kbd_rgb_mode_available;
 	bool kbd_rgb_state_available;
 
@@ -733,6 +737,113 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(gpu_mux_mode);
 
+/* screenpad switch *************************************************************/
+static ssize_t screenpad_enable_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_DISABLE);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
+}
+
+static ssize_t screenpad_enable_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result, err;
+	u8 enable;
+
+	err = kstrtou8(buf, 10, &enable);
+	if (err)
+		return err;
+
+	if (enable > 1)
+		return -EINVAL;
+
+	if (enable == 0) {
+		/* Get and store brightness before disabling */
+		asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &result);
+		if (result < 0)
+			return result;
+		asus->screenpad_last_brightness = result & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
+
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_DISABLE, enable, &result);
+	} else {
+		/* Setting the brightness is what re-enables the screenpad */
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
+								asus->screenpad_last_brightness,
+								&result);
+	}
+	if (err) {
+		dev_err(dev, "Failed to set screenpad_enable: %d\n", err);
+		return err;
+	}
+	if (result != 1) {
+		dev_warn(dev, "Failed to set screenpad_enable (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "screenpad_enable");
+
+	return count;
+}
+static DEVICE_ATTR_RW(screenpad_enable);
+
+/* screenpad brightness *************************************************************/
+static ssize_t screenpad_brightness_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	/* Check if the screen is enabled, if not, return last saved brightness */
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_DISABLE);
+	if (result < 0)
+		return result;
+	if (!result)
+		return asus->screenpad_last_brightness;
+
+	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &result);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result & ASUS_WMI_DSTS_BRIGHTNESS_MASK);
+}
+
+static ssize_t screenpad_brightness_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result, err;
+	u8 brightness;
+
+	err = kstrtou8(buf, 10, &brightness);
+	if (err)
+		return err;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, brightness, &result);
+	if (err) {
+		dev_err(dev, "Failed to set screenpad_brightness: %d\n", err);
+		return err;
+	}
+	if (result != 1) {
+		dev_warn(dev, "Failed to set screenpad_brightness (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "screenpad_brightness");
+
+	return count;
+}
+static DEVICE_ATTR_RW(screenpad_brightness);
+
 /* TUF Laptop Keyboard RGB Modes **********************************************/
 static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
@@ -3465,6 +3576,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_gpu_mux_mode.attr,
+	&dev_attr_screenpad_enable.attr,
+	&dev_attr_screenpad_brightness.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3497,6 +3610,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
 		ok = asus->gpu_mux_mode_available;
+	else if (attr == &dev_attr_screenpad_enable.attr)
+		ok = asus->screenpad_enable_available;
+	else if (attr == &dev_attr_screenpad_brightness.attr)
+		ok = asus->screenpad_brightness_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3760,6 +3877,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
+	asus->screenpad_enable_available = asus_wmi_dev_is_present(asus,
+								ASUS_WMI_DEVID_SCREENPAD_DISABLE);
+	asus->screenpad_brightness_available = asus_wmi_dev_is_present(asus,
+								ASUS_WMI_DEVID_SCREENPAD_LIGHT);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 28234dc9fa6a..978627aac87c 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,10 @@
 #define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
 #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
+/* This can only be used to disable the screen, not re-enable */
+#define ASUS_WMI_DEVID_SCREENPAD_DISABLE	0x00050031
+/* Writing a brightness re-enables the screen if disabled */
+#define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
-- 
2.40.0

