Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9F7361C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFTC57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFTC5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B7A1994;
        Mon, 19 Jun 2023 19:57:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A0AA5C01F5;
        Mon, 19 Jun 2023 22:57:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 22:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229850; x=
        1687316250; bh=XyYZavQtwXjIJqr+Wx4YS9kbDJ4aeW/qdYMdNX69/gU=; b=G
        SF7Y3ahXA2YOb5KxbzirV312WbXX1deQzuyBAx80rTDQrSMYJblueSoN1tqTDDud
        7dvhBMRof5umexvpQnl6B/aokr442nqEOyPnngmgDQNNGSN73PRBNUNkRVB+HIU8
        TovT5nznPeMZJz3ZCnxhe/H1DQUgxkiNNV6ga6qyof+aT5ZrmxxV6D3GGDzAe6HF
        Tq0LF5e/dWjPiNbX3vGfD5RNT4X7B0Xd55xHJtACwKSm90TBgCRbOv4bgqxHV+b6
        F9IchEknaqHlQzyCrzSoD68rADPJTfoDnH8LsZS6aVCUu7+dPh0KpuNSRX4SYyUI
        see9ZrGODS08j4Ch3yF+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229850; x=
        1687316250; bh=XyYZavQtwXjIJqr+Wx4YS9kbDJ4aeW/qdYMdNX69/gU=; b=E
        R7NpZCYr9WzpS7ise/LsXSlBKFqMaKGpLSo8tUzqdKLe6qgyR2jFbWRKQY22P+O+
        I04hjaRokXdt8YuxsSPyYavxUoJryADbrnYrP5rvCrxIBsm2b3Vvlc8OP/PJl6i+
        DFdtD96sCCZf9+Ob+azTMkq+spYRpTMAsR8vo7NzslW7S1AhWkc2LEdBjFdTv98C
        M+QzjEw8qnxJ0UfJy/6/9YiOClCr1/Hsbn5CV5+NXy+vTMRTy0U7i7a43ye7FvST
        WHj5JCLML8Z61Dw9LRTIFq8SuRq9Q9JxpmLxcYyW+7Ja+WxTH5vuMcxkCzfyx/Oi
        12EWGSS+348ydusXAWpLg==
X-ME-Sender: <xms:mhWRZKC9omxkytnOZCVEoOLDpQVMt_Wu2IP-0tuo4s4Oc-3wcCHAqQ>
    <xme:mhWRZEiZHk_Qw25VL9LezddDtGgIP8qTZOVdsjjxzDwslhjp9bit4g7-ifs2zHWRL
    yvAAGL31xYIAoI-kl8>
X-ME-Received: <xmr:mhWRZNlLfuOgPAW8d8QeVZ2zaEhgHuWASC4dK6v4LF5xTF_sxnhjHQEw3rJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:mhWRZIyt2rPvEoEhnlYdhknysSN4_2-apuDCokKyH_RLpSl7aAXHig>
    <xmx:mhWRZPRwW63HAnGG03M5JuyqtbczFn5ykxx6yN-CU0T68aC81VVk2g>
    <xmx:mhWRZDbsQDE_3lrEN1IsIK8ISjb6uwtTR_l070yrieFQZxI8XMYkaw>
    <xmx:mhWRZIQFAbvP1K0aS7lfXJO0N2K2TxXY29X-Cr6hneaN3ey3hkBpyQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:27 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 7/8] platform/x86: asus-wmi: support setting mini-LED mode
Date:   Tue, 20 Jun 2023 14:56:40 +1200
Message-Id: <20230620025641.53197-8-luke@ljones.dev>
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

Support changing the mini-LED mode on some of the newer ASUS laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
 drivers/platform/x86/asus-wmi.c               | 53 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 878daf7c2036..5624bdef49cb 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -117,3 +117,12 @@ Description:
 		Show if the egpu (XG Mobile) is correctly connected:
 			* 0 - False,
 			* 1 - True
+
+What:		/sys/devices/platform/<platform>/mini_led_mode
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Change the mini-LED mode:
+			* 0 - Single-zone,
+			* 1 - Multi-zone
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 602426a7fb41..1fc9e8afc2f3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -265,6 +265,7 @@ struct asus_wmi {
 	bool battery_rsoc_available;
 
 	bool panel_overdrive_available;
+	bool mini_led_mode_available;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -1820,6 +1821,54 @@ static ssize_t panel_od_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(panel_od);
 
+/* Mini-LED mode **************************************************************/
+static ssize_t mini_led_mode_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
+}
+
+static ssize_t mini_led_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 mode;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &mode);
+	if (result)
+		return result;
+
+	if (mode > 1)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
+
+	if (err) {
+		pr_warn("Failed to set mini-LED: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set mini-LED mode (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "mini_led_mode");
+
+	return count;
+}
+static DEVICE_ATTR_RW(mini_led_mode);
+
 /* Quirks *********************************************************************/
 
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
@@ -3727,6 +3776,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
 	&dev_attr_panel_od.attr,
+	&dev_attr_mini_led_mode.attr,
 	NULL
 };
 
@@ -3764,6 +3814,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->throttle_thermal_policy_available;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
+	else if (attr == &dev_attr_mini_led_mode.attr)
+		ok = asus->mini_led_mode_available;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4026,6 +4078,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
+	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
 
 	err = fan_boost_mode_check_present(asus);
 	if (err)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 2034648f8cdf..ea80361ac6c7 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -66,6 +66,7 @@
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
 #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
+#define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.40.1

