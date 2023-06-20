Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4847361DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjFTDBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjFTDB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:01:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4D10FB;
        Mon, 19 Jun 2023 20:00:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C3EA5C00DA;
        Mon, 19 Jun 2023 23:00:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 23:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687230059; x=
        1687316459; bh=8JJJGvecB76heOSDqt4yLzgdvqNbFt8UdFibgQb9Bkk=; b=x
        KIwx395LPC55sd5bBXtrB9532A4dMz7pdqbxlxhhzJ/dMbgLjrDg5sRoORWuu/Re
        eQns4w6TJM9cIzPABP6p7CRsJKQuhsj2JXKdztcYS+lbIILZKXiQpMPGuwo/tPVg
        vuYgvVhQZxlO7TZIhdFS0a2HKbCifZ/VPpW/P4KyAbUqqM1qD0tJwdiZZSg1msag
        +gwhRWz5kIKYkerTjNW9GbaCcJM/M80M1uSzjarOcauo3xGCkiJKiMTkUoZ0ch8+
        3K7Taol/Od5LIPVVheyQeAPXmmAf5AEESNaSt/sAiLJyXySXPpxeKtEwptpfJztl
        78YJ2RYy/h7ULi4Rkydzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687230059; x=
        1687316459; bh=8JJJGvecB76heOSDqt4yLzgdvqNbFt8UdFibgQb9Bkk=; b=P
        ywV456lv+OIzk2uFs+kcD6WNA0HwzGP0WJKEgk452lXuXFIXutwdP31dv0CScjy6
        1qKMCmGcgSNxsmQDCoXKb/M4C0W0FSwhSBNjfURw0mfunPsVpe1MOxuHHtmJGb9U
        n5uiMXh7TmKkwXiZ6ZjqFYsGSLk7Go5i42h0Sjcxp1gx0Red+1UUFv5RLMvRIAWt
        +UCq5XG6RCRfC9T+VFIaGsO4DXpvWGE6jp3l4CRnKGkP+mtyMGWyKtFA7AxThRNy
        ooN4Je4VI361iwh0oQta0l6GMYCz1rY5jQY8czK+BpUCTo0IkO4FWTKqbOFDEZ0I
        A4NIatV+sis4c8PjRZvoA==
X-ME-Sender: <xms:axaRZLLm-A1dR4XHDuhsou7D7AQQA-e36-hnRAaR7bigh5DS7Ccj5w>
    <xme:axaRZPJBTOL_k-bmkJ33t9FczruncYv5CCiKyA4NMyQXc0aGCo3PdC8QH_mJnSLFe
    _3EejnEwOd3rSpx7iY>
X-ME-Received: <xmr:axaRZDvYL3xjM3JMai46Xs4Xqn6sAfDiGkZnudkMMoSN-6lWJlc7SXSoZyzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:axaRZEZ_66GnxTwPt_xPF0Kq2EWqmFQvb4taAcE5nsVAmK3JQYVwjg>
    <xmx:axaRZCbZacopLE43tm3eONVaFJvDWMGsQoJVYCPwsSTOZns4p-Qutg>
    <xmx:axaRZIA1GOybgBqtlxho9D0uGwKdgphEf8vhakB1gMD9uuqRp3GFpQ>
    <xmx:axaRZK4s8qHHMHHHSvoJUsaC1F8-q1VvDHIWLTZu3HuXbPMEnsk2ng>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 23:00:55 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Tue, 20 Jun 2023 15:00:33 +1200
Message-Id: <20230620030033.55033-2-luke@ljones.dev>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620030033.55033-1-luke@ljones.dev>
References: <20230620030033.55033-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c            | 129 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 134 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 62cee13f5576..c87fbd81d658 100644
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
@@ -3839,6 +3841,124 @@ static int is_display_toggle(int code)
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
+	int power, brightness;
+
+	power = read_screenpad_backlight_power(asus);
+	if (power < 0)
+		return power;
+
+	brightness = read_screenpad_brightness(bd);
+	if (brightness < 0)
+		return brightness;
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
+	/*
+	 * Counter an odd behaviour where default is set to < 13 if it was 0 on boot.
+	 * 60 is subjective, but accepted as a good compromise to retain visibility.
+	 */
+	if (brightness < 60)
+		brightness = 60;
+
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
@@ -4504,6 +4624,12 @@ static int asus_wmi_add(struct platform_device *pdev)
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
@@ -4527,6 +4653,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_backlight_exit(asus);
 fail_backlight:
 	asus_wmi_rfkill_exit(asus);
+fail_screenpad:
+	asus_screenpad_exit(asus);
 fail_rfkill:
 	asus_wmi_led_exit(asus);
 fail_leds:
@@ -4553,6 +4681,7 @@ static int asus_wmi_remove(struct platform_device *device)
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
2.40.1

