Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602106F7BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjEEEaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjEEEag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:30:36 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6377DB3;
        Thu,  4 May 2023 21:30:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 59C3B5C0118;
        Fri,  5 May 2023 00:30:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 00:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1683261034; x=
        1683347434; bh=6DfSsWb3bU/3dTn29w4dujNv7ekBG/GKAAyXQwfRz14=; b=l
        KZtdradMd4DUEW9iPD/duA50WgnKtEPGv1SkK5pMyvDUH01YtENE4sWHa+pjjlBy
        I2yUKXb/v3KMRBkko1AhDiWLyiQc0fp1BraMXiC9yMJz+gztZj9AQZL/g/3XT1QR
        o6Di95oumEMCLKvL3G3wnsgY2uwOmC7DlTKw1TiwBnufW0J/sXPCXSjFw4UEWB4v
        DAfa91L92OsdPQ3ze8rcNeSsgIVrd9yiCQer6gu1n3CdqOZvzpliO6c3hRjsB91Y
        bDrQV/DVy0gmTY9iBHTASWaVht80H2s9Qw4OBCj88L7mXU5lcNxXJP3fcy+Zq/eA
        fndhHLrnVXn12iFGOqH4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1683261034; x=
        1683347434; bh=6DfSsWb3bU/3dTn29w4dujNv7ekBG/GKAAyXQwfRz14=; b=c
        RyiCnhAsQ0LOlLQrmZ6c8K47kPl8ak4nW5aM+llaJphfe0y1qjg/uLcC86FAEAWj
        FXyiGTR5zlFcE2KwTOAzQZgidC54RKDWppdLC4v2ainYsjNO2COSOLbDwnbBAS93
        f91OehZmctgUO0YiJyQ1U8Q27N9IIY+5Ac/DFbbbyQ+zMNsVGfj3ReZ+Jgsrw2cL
        ck37+E4IB5UKKg/FKIBR4/gG1ajYRhgzxy/dzP91zjw/g23eyJVFsuCxW/QM0/rQ
        QgoC24FrzAEOvD5zlCnHqCYk1AMf86jzgMQiJWhLf/s+GFFUyxzmjO6Rn0UuqAGx
        m3gI3ltEEC38jSEa6PFtQ==
X-ME-Sender: <xms:aoZUZDL1pUiSOr0DwfMu5AGLkPhbIcCaniFAkR5GIVI6gWI6IZ0MRQ>
    <xme:aoZUZHJuArcYDsJz6rtQhVduteAaTTeihCfig0hKe7yeK850tXurDmra79BjWnGIB
    vIjD-cs8F0YNyPkbn8>
X-ME-Received: <xmr:aoZUZLvKu7_Y2iJdJor5ShPMRE4d8pmxsFFEqFBDUhV-w9AapV85uyvU-bYP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:aoZUZMa_YK5yecFSWis6cNCwcL7g6uHTy2Qzpi_YB-AHyK1Iq86HZA>
    <xmx:aoZUZKZPSeZ62FaoDK2kSljoXYubHMDs5FP3jCS9L4UoxUNW8FDeww>
    <xmx:aoZUZACqtMw0qanDmuZLXqrX9oTfofoUG6vXMI1elYJtN8q_u3cv9w>
    <xmx:aoZUZPMKI0S0EFSiC4di8p7Yfv0LKYv2r5Go4gCxQ1h8kXiV7L7Zkg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 00:30:29 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        hdegoede@redhat.com, corentin.chary@gmail.com,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Fri,  5 May 2023 16:30:13 +1200
Message-Id: <20230505043013.2622603-2-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505043013.2622603-1-luke@ljones.dev>
References: <20230505043013.2622603-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the WMI methods used to turn off and adjust the
brightness of the secondary "screenpad" device found on some high-end
ASUS laptops like the GX650P series and others.

These methods are utilised in a new backlight device named:
- asus_screenpad

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
 drivers/platform/x86/asus-wmi.c               | 132 ++++++++++++++++++
 drivers/platform/x86/asus-wmi.h               |   1 +
 include/linux/platform_data/x86/asus-wmi.h    |   4 +
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index a77a004a1baa..df9817c6233a 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -97,4 +97,4 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Enable an LCD response-time boost to reduce or remove ghosting:
 			* 0 - Disable,
-			* 1 - Enable
+			* 1 - Enable
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1038dfdcdd32..0528eef02ef7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -200,6 +200,7 @@ struct asus_wmi {
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
+	struct backlight_device *screenpad_backlight_device;
 	struct platform_device *platform_device;
 
 	struct led_classdev wlan_led;
@@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+/* Screenpad backlight */
+
+static int read_screenpad_backlight_power(struct asus_wmi *asus)
+{
+	int ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
+
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
+	if (power == -ENODEV)
+		return err;
+	else if (power < 0)
+		return power;
+
+	if (bd->props.power != power) {
+		if (power != FB_BLANK_UNBLANK) {
+			/* Only brightness can power it back on */
+			ctrl_param = asus->driver->screenpad_brightness;
+			/* Min 1 or the screen won't turn on */
+			if (ctrl_param == 0)
+				ctrl_param = 1;
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
+							ctrl_param, NULL);
+		} else {
+			/* Ensure brightness is stored to turn back on with */
+			asus->driver->screenpad_brightness = bd->props.brightness;
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
+		}
+	} else if (power == FB_BLANK_UNBLANK) {
+		/* Only set brightness if powered on or we get invalid/unsync state */
+		ctrl_param = bd->props.brightness;
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);
+	}
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
+	if (power == -ENODEV)
+		power = FB_BLANK_UNBLANK;
+	else if (power < 0)
+		return power;
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
+
+	brightness = read_screenpad_brightness(bd);
+	if (brightness < 0)
+		return brightness;
+	/*
+	 * Counter an odd behaviour where default is set to < 13 if it was 0 on boot.
+	 * 60 is subjective, but accepted as a good compromise to retain visibility.
+	 */
+	else if (brightness < 60)
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
@@ -3823,6 +3947,13 @@ static int asus_wmi_add(struct platform_device *pdev)
 	} else if (asus->driver->quirks->wmi_backlight_set_devstate)
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT)) {
+		pr_warn("Begin asus_screenpad_init");
+		err = asus_screenpad_init(asus);
+		if (err && err != -ENODEV)
+			goto fail_backlight;
+	}
+
 	if (asus_wmi_has_fnlock_key(asus)) {
 		asus->fnlock_locked = fnlock_default;
 		asus_wmi_fnlock_update(asus);
@@ -3844,6 +3975,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 
 fail_wmi_handler:
 	asus_wmi_backlight_exit(asus);
+	asus_screenpad_exit(asus);
 fail_backlight:
 	asus_wmi_rfkill_exit(asus);
 fail_rfkill:
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
index 28234dc9fa6a..a2d94adb5c80 100644
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
2.40.0

