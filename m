Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9F743468
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjF3Fgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjF3Fg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:26 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288F3593;
        Thu, 29 Jun 2023 22:36:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 43B5E3200983;
        Fri, 30 Jun 2023 01:36:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 30 Jun 2023 01:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103381; x=
        1688189781; bh=x0NWRw+Ml4xfFfMxC4QlVOlD9apc5xmU8rzFplB/f6g=; b=M
        D8Zlt4lu7VLWfeGFldSfBCUv+jQ0fOzUKrcQrIRigVXLNbzQfRSSHpmvECseL09n
        Hy/xmcIuYe7IRzxYZH6eL3A2ItaREY5vHA7vawHxA6KorS0FyAcNvYSQ1jcV81YG
        rRbHejuZWDQZV9WDK3ZOiYpK6W6TjiWfD2NOjpCgoyr+rKzIG/r0ZXbDZLhjk5aA
        5jYh9ReoHWNc8mDELatZpasCs6GcemGW3mVDw9TaMobvF8QZQN5xtd66QJ8P+egQ
        JF8R3IFrae70NCBY8muInmpF+EZwYIjnTBcvREHeYjt04gvL5Y6QWv9y101JCx47
        /0FfdvhE5XTRK6BvPE/Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103381; x=
        1688189781; bh=x0NWRw+Ml4xfFfMxC4QlVOlD9apc5xmU8rzFplB/f6g=; b=H
        qz4RKxowc2c/XpO+C5koXJvt8QWA34+VWODyB2rTwCj5+x2IiAtmvtkpdqxQHFPy
        OCvP5T99C1KiD2GFUy0ESzFwxIbIXd26yWSzbkNrnqNAxSIDU68I2U9oCffyoX9s
        j3zWytOi5kf/hGECt6QkZl6Wfh3dthV+q9/RMW791+n2FhstyMgY1RThUu5hdkYB
        xokKb6kbX0YA23sCHSykyo/uDgQcc+Q47S1XpyYbW/XMMVaqPz6cpqKKuOUMwSGr
        edmOWAx/WzTVh5K04M5Y0K68ymWoZb9tIEKXjgSXIZdScgdxlV/S9gT76Jgx06uT
        4OvOrfly0nag4IXR91QBQ==
X-ME-Sender: <xms:1WmeZJagvT-Nbkbcz0-ytPeUu-9V4ZgXkKlliWJrz0xTCCd6iGTDCg>
    <xme:1WmeZAZAQujwEMvNOOJ0THzCphyd-VO4TEvklSnysoJbyJcxOi972jxoS5KDHRime
    szuFRvBNBtOL5PUfR0>
X-ME-Received: <xmr:1WmeZL_-opp4Ul9zyU2mDzZVpoJIbUklklOeAlKFqxQXSaRAQFO1erca0TAt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:1WmeZHp9PQdIzgm1OzeYSzpofQxE_hQyWN18siGS4zxJASLvE-TzTA>
    <xmx:1WmeZErNpQgOYxDOfGVZyfAg2-ToYakxHImqPVUzrheGyYAZQwz8Ug>
    <xmx:1WmeZNSAJ5Lltw7fN_Wiw_YH0ZbEOeVEPchlmIqoUOSonxqcnVao6g>
    <xmx:1WmeZMLXc7Kv1c_WgiYXeWDAA_BXxQmoce7B-et7hMr6MWTeUFRt_Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:18 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 4/8] platform/x86: asus-wmi: add WMI method to show if egpu connected
Date:   Fri, 30 Jun 2023 17:35:48 +1200
Message-ID: <20230630053552.976579-5-luke@ljones.dev>
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

Exposes the WMI method which tells if the eGPU is properly connected
on the devices that support it.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++++++++-
 drivers/platform/x86/asus-wmi.c               | 21 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  4 +++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index eb29e3023c7b..878daf7c2036 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -107,4 +107,13 @@ Description:
 		Get the current charging mode being used:
 			* 1 - Barrel connected charger,
 			* 2 - USB-C charging
-			* 3 - Both connected, barrel used for charging
\ No newline at end of file
+			* 3 - Both connected, barrel used for charging
+
+What:		/sys/devices/platform/<platform>/egpu_connected
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Show if the egpu (XG Mobile) is correctly connected:
+			* 0 - False,
+			* 1 - True
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index fb27218e51cf..0c8a4a46b121 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -243,6 +243,7 @@ struct asus_wmi {
 
 	bool charge_mode_available;
 	bool egpu_enable_available;
+	bool egpu_connect_available;
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
 
@@ -709,6 +710,22 @@ static ssize_t egpu_enable_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* Is eGPU connected? *********************************************************/
+static ssize_t egpu_connected_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
+}
+
+static DEVICE_ATTR_RO(egpu_connected);
+
 /* gpu mux switch *************************************************************/
 static ssize_t gpu_mux_mode_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -3645,6 +3662,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_charge_mode.attr,
 	&dev_attr_egpu_enable.attr,
+	&dev_attr_egpu_connected.attr,
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_gpu_mux_mode.attr,
 	&dev_attr_lid_resume.attr,
@@ -3677,6 +3695,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->charge_mode_available;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
+	else if (attr == &dev_attr_egpu_connected.attr)
+		ok = asus->egpu_connect_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
@@ -3943,6 +3963,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 
 	asus->charge_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CHARGE_MODE);
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
+	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 329efc086993..2034648f8cdf 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -100,7 +100,9 @@
 /* Charging mode - 1=Barrel, 2=USB */
 #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
 
-/* dgpu on/off */
+/* epu is connected? 1 == true */
+#define ASUS_WMI_DEVID_EGPU_CONNECTED	0x00090018
+/* egpu on/off */
 #define ASUS_WMI_DEVID_EGPU		0x00090019
 
 /* dgpu on/off */
-- 
2.41.0

