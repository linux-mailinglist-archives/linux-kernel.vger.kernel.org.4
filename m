Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8AD743471
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjF3Fgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjF3Fgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE803596;
        Thu, 29 Jun 2023 22:36:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E0229320097B;
        Fri, 30 Jun 2023 01:36:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 30 Jun 2023 01:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103397; x=
        1688189797; bh=wsVYQogneSxXEgP9jYbruJvxTZh+2SC+W+ytbO/Zypg=; b=k
        NsDp+zaAMdypVg1UIjeTsRe1P/Wu49sf36GOLV7/RVay6FyzPxf82gfSxosOeF2l
        CQOpnYWA15M1KaRVovNhEfY8R2kf8DOtYRJ1chKljmxUUFsU1tb3vAcdzY+Ao3fb
        A2r5jU968u9AI35WAhXJojzvhQaWpQibzug8tWzQAcQAhDARc6zOSX2D1mhAu8R5
        jxEHmRpZQf3ANnNrY7ODY90TmtOZwSk37GmNJOHxm3URgz6q+QVVuZ3S+HH2NLFO
        PfQu//8Z8L7PSr8rb/oSN4rpfL3oAT5BiKhfD5/fr0kWdKGurPmUG/X4Bh1vByl3
        U5VhmUhUAo4wADltihOuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103397; x=
        1688189797; bh=wsVYQogneSxXEgP9jYbruJvxTZh+2SC+W+ytbO/Zypg=; b=S
        srMUOaYv32UxT74CqyiHubViKQJoqEQ2UbBEsiKqCaNIWW90n4yEGmn3qhQa410K
        jtOLuNUiS+TzIMielKA1O3CUwEzyawyeFTHejO6CZZszyr1iaywo96iEI8AK4PEw
        ctU/wPsi611mEi6yYdPPFVlXn8ujTY0L3XTU9v5FkO7iO1gZCwrHvo8Q7oYRrPLS
        aAGQJtDsTd7OCBCAtWMdDC9hDlrli/bsGHZRwt71LJUCSpoILUVAU1e/T1/CTRCd
        3vP2IH3BkuhrYt69bV58BMmAxk9BBk1pIGMvy0gWmRDUk9WtbT7c1NSTacqEhmC7
        Ofc/egYR/D7n38ULiyxVw==
X-ME-Sender: <xms:5WmeZN2thYWMvF1ZXcqXwQI2vFx_kFLuPSKpjSd1n1TvapVhjGTaUg>
    <xme:5WmeZEGx0SkR22i6YRrKKg1YDOF4rF7zIoLRT1OVymiqhp022a-Ivp1cpXPzLJCR1
    t-Sz_-2N3VhHRO5pek>
X-ME-Received: <xmr:5WmeZN421fBPSXDKzMbMQ0O7TLZUShSvDTUi5nOg9lFfHj_Tb7hYGpMID8dd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedvnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:5WmeZK08n3f_KQ9EitPXrROUcoR9qUk5txYNfsr1qHV8vZD8PMCDVA>
    <xmx:5WmeZAEIEDHTDIqw9h2SbPWHpvjUHc2h8U5FlYE2m24p-03m9DS__Q>
    <xmx:5WmeZL_q1goAZUhBN84cL5vdlk0kztpMGUWCajNBtiREangOkwov0A>
    <xmx:5WmeZL0NfuVCGOYpN0A0FxK1l0WCPcLWA1SfPNa4PXtp32WeuUN4SQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:34 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 7/8] platform/x86: asus-wmi: support setting mini-LED mode
Date:   Fri, 30 Jun 2023 17:35:51 +1200
Message-ID: <20230630053552.976579-8-luke@ljones.dev>
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
2.41.0

