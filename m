Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22E743377
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjF3ESM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjF3ESH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:18:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F62D78;
        Thu, 29 Jun 2023 21:18:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 74CD53200993;
        Fri, 30 Jun 2023 00:18:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 00:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688098683; x=
        1688185083; bh=H/pUv3JCTYWhxJUqPomsdfiSjJ4CWy36omlus/C29XY=; b=S
        lrdTj/0us1dt4y+be3qEc470vYYYbpkXQsNd/PD/zrIc9PmeWiXoUbNWxdcdjlin
        /vdfEKGbMI6cLwtZjJm87LyByQP7f/Jmcx/W+Z29ojZUmRma5OlkBjVjDEx4Gnp7
        e7xAkjxMI0f5mG6j1psobZs4ty6e7GtybP46oZGwf1WXfl8k/ymSmsQKQp5s2WQ4
        Tx63Do/EEyJbqUVi3PGMsLzEq3j3hCoP81U1AzNeTbZFmJlpmQ8Pp//LCrPcGzsi
        bAPUwbj5IklG/EiHJ5vCoZU7RZE+b56uAHcaLKuB4igsLBY6TA1IMmvV7EgP8MiU
        Wcrxn2vt929COhvLQQvdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688098683; x=
        1688185083; bh=H/pUv3JCTYWhxJUqPomsdfiSjJ4CWy36omlus/C29XY=; b=p
        TW9Xr46DmOYa/irZY0maKloJxYvC8LskpBq2ofcM19DpyhjaedyvfZmPC8Srx4Bq
        Nf8ZPVOqe8A/mKAvQA6Im+jDeWdFeJGeCgzS9TlAwfzuSlgjnL7s7k176cZPD1ME
        Piux2G/wdPuo+THF4M+hsmpmQ6CCo/gRKChQbIuC4yoyt6sWDYFZe+Xl1qRPP74M
        J/7QFBWfRdbQwHCnwzFaG4ASCQzaMHMrEaeJVdi2JWxGbNNwoUmsxXgVy5EI1KI5
        xyAo1ddIL2ykF8WOTociQqvfBi0VHfAn3UNoyBHhFW8DcjLm9l0DPZR1/ZwwxNZ1
        wVzNStnmxk3aIfn/QDapQ==
X-ME-Sender: <xms:e1eeZBthdS9QGbxmfL2rTnCertl5hcEEx83jPfN1U1KhTF0R-Ebtqg>
    <xme:e1eeZKe2EuHW7iBuHbzAch4jRkxazkY3PhTBRsMXciiSfNAJtHfJV726ASDWfu4y5
    kkBqlHeVKm6wdt6x5s>
X-ME-Received: <xmr:e1eeZEwnZtDRIQTLRJgxOABMGS4B3Kcr3ybRU_Gud80LqJNObE2scyqUI3ST>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:e1eeZINvwOkQ4k65HlYt43jTEkMWSp0LyuMq6DuBzpa34W3eHMHKdQ>
    <xmx:e1eeZB_xJg7NWrlq7Gg-sAouylm5KYV3aMrdONGlXxcRKnv6mDnLcg>
    <xmx:e1eeZIUgsa65VFQbSNqfRxzfyn1nB8jqETLaELMgK4K3Y5kUPglucQ>
    <xmx:e1eeZKM4Q6GhJd80PJ9jEvS4DOIT30M36Asc5ITHWu_-X9d1tPYGqA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 00:18:00 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Fri, 30 Jun 2023 16:17:43 +1200
Message-ID: <20230630041743.911303-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630041743.911303-1-luke@ljones.dev>
References: <20230630041743.911303-1-luke@ljones.dev>
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

Add support for the WMI methods used to turn off and adjust the
brightness of the secondary "screenpad" device found on some high-end
ASUS laptops like the GX650P series and others.

These methods are utilised in a new backlight device named asus_screenpad.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 128 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 133 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 62cee13f5576..967c92ceb041 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -25,6 +25,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
@@ -212,6 +213,7 @@ struct asus_wmi {
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
+	struct backlight_device *screenpad_backlight_device;
 	struct platform_device *platform_device;
 
 	struct led_classdev wlan_led;
@@ -3839,6 +3841,123 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+/* Screenpad backlight *******************************************************/
+
+static int read_screenpad_backlight_power(struct asus_wmi *asus)
+{
+	int ret;
+
+	ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
+	if (ret < 0)
+		return ret;
+	/* 1 == powered */
+	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+}
+
+static int read_screenpad_brightness(struct backlight_device *bd)
+{
+	struct asus_wmi *asus = bl_get_data(bd);
+	u32 retval;
+	int err;
+
+	err = read_screenpad_backlight_power(asus);
+	if (err < 0)
+		return err;
+	/* The device brightness can only be read if powered, so return stored */
+	if (err == FB_BLANK_POWERDOWN)
+		return asus->driver->screenpad_brightness;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
+	if (err < 0)
+		return err;
+
+	return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
+}
+
+static int update_screenpad_bl_status(struct backlight_device *bd)
+{
+	struct asus_wmi *asus = bl_get_data(bd);
+	int power, err = 0;
+	u32 ctrl_param;
+
+	power = read_screenpad_backlight_power(asus);
+	if (power < 0)
+		return power;
+
+	if (bd->props.power != power) {
+		if (power != FB_BLANK_UNBLANK) {
+			/* Only brightness > 0 can power it back on */
+			ctrl_param = max(1, asus->driver->screenpad_brightness);
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
+						    ctrl_param, NULL);
+		} else {
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
+		}
+	} else if (power == FB_BLANK_UNBLANK) {
+		/* Only set brightness if powered on or we get invalid/unsync state */
+		ctrl_param = bd->props.brightness;
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);
+	}
+
+	/* Ensure brightness is stored to turn back on with */
+	asus->driver->screenpad_brightness = bd->props.brightness;
+
+	return err;
+}
+
+static const struct backlight_ops asus_screenpad_bl_ops = {
+	.get_brightness = read_screenpad_brightness,
+	.update_status = update_screenpad_bl_status,
+	.options = BL_CORE_SUSPENDRESUME,
+};
+
+static int asus_screenpad_init(struct asus_wmi *asus)
+{
+	struct backlight_device *bd;
+	struct backlight_properties props;
+	int err, power;
+	int brightness = 0;
+
+	power = read_screenpad_backlight_power(asus);
+	if (power < 0)
+		return power;
+
+	if (power != FB_BLANK_POWERDOWN) {
+		err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
+		if (err < 0)
+			return err;
+	}
+	/* default to an acceptable min brightness on boot if too low */
+	if (brightness < 60)
+		brightness = 60;
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */
+	props.max_brightness = 255;
+	bd = backlight_device_register("asus_screenpad",
+				       &asus->platform_device->dev, asus,
+				       &asus_screenpad_bl_ops, &props);
+	if (IS_ERR(bd)) {
+		pr_err("Could not register backlight device\n");
+		return PTR_ERR(bd);
+	}
+
+	asus->screenpad_backlight_device = bd;
+	asus->driver->screenpad_brightness = brightness;
+	bd->props.brightness = brightness;
+	bd->props.power = power;
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static void asus_screenpad_exit(struct asus_wmi *asus)
+{
+	backlight_device_unregister(asus->screenpad_backlight_device);
+
+	asus->screenpad_backlight_device = NULL;
+}
+
 /* Fn-lock ********************************************************************/
 
 static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
@@ -4504,6 +4623,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 	} else if (asus->driver->quirks->wmi_backlight_set_devstate)
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT)) {
+		err = asus_screenpad_init(asus);
+		if (err && err != -ENODEV)
+			goto fail_screenpad;
+	}
+
 	if (asus_wmi_has_fnlock_key(asus)) {
 		asus->fnlock_locked = fnlock_default;
 		asus_wmi_fnlock_update(asus);
@@ -4527,6 +4652,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_backlight_exit(asus);
 fail_backlight:
 	asus_wmi_rfkill_exit(asus);
+fail_screenpad:
+	asus_screenpad_exit(asus);
 fail_rfkill:
 	asus_wmi_led_exit(asus);
 fail_leds:
@@ -4553,6 +4680,7 @@ static int asus_wmi_remove(struct platform_device *device)
 	asus = platform_get_drvdata(device);
 	wmi_remove_notify_handler(asus->driver->event_guid);
 	asus_wmi_backlight_exit(asus);
+	asus_screenpad_exit(asus);
 	asus_wmi_input_exit(asus);
 	asus_wmi_led_exit(asus);
 	asus_wmi_rfkill_exit(asus);
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index a478ebfd34df..5fbdd0eafa02 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -57,6 +57,7 @@ struct quirk_entry {
 struct asus_wmi_driver {
 	int			brightness;
 	int			panel_power;
+	int			screenpad_brightness;
 	int			wlan_ctrl_by_user;
 
 	const char		*name;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index d17ae2eb0f8d..61ba70b32846 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,10 @@
 #define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
 #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
+/* This can only be used to disable the screen, not re-enable */
+#define ASUS_WMI_DEVID_SCREENPAD_POWER	0x00050031
+/* Writing a brightness re-enables the screen if disabled */
+#define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
-- 
2.41.0

