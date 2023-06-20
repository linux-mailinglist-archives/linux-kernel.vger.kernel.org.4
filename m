Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B547361B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFTC5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFTC5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:10 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266F10CB;
        Mon, 19 Jun 2023 19:57:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D8945C01EF;
        Mon, 19 Jun 2023 22:57:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 22:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229829; x=
        1687316229; bh=JAa2+5OdKdG1aE9dm0qeBtCZnBJBWtJ16Oa1u/aXq1c=; b=a
        HRyjjeebR+MN4XUwK21uK//2996g945qYh2beELHP90mbv7vEm08p+KvspyY7pMH
        kKu0mwLyK8Dlz6KK3naw0kOanh1yK2rBESuabGGGn2dMDkqJg937FhEzD4sZPMAy
        r3q2ZYNyC7zpi5t5IEGm5pvzQjF+5pU4Bz6iPvTU/Pm9x7I65N+l7UiP1GceUQoD
        lKv33h0KaD8YRJQf1lorSdL8txyceRoPUUSaArgyyuCHRvdhReCZvWW5Njq1V5pd
        MxMkRj2yw3eb8GYwZ0zGf2AoROyT8ap6ZUR6ekkhd1RBfhMmyBrRuyWrRfQc/ICW
        kR904FX1LBRHMPqab7tTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229829; x=
        1687316229; bh=JAa2+5OdKdG1aE9dm0qeBtCZnBJBWtJ16Oa1u/aXq1c=; b=U
        ETfuI+8103LMF52K+2WdH6c4k45OELYUvEnN9faqYpEwZ3TCdLSM8nm7wf702Pft
        RvOxI+TMfdy2RjtqF3e91btwneh3A4oeggf988F7VuR93o/CTGedG8xRgVghWFj5
        1J3Wez2+nPkPgYXLHTZwy4CgmZvpK5R1q+DJ1bFAUkX0Sll6E8jk/1gmrQO664u5
        VhYI2jqc9r1pp7PNgg7EfMG9EomRxseLg2NFoDkc0eCG3OPHGvxtvZoUwivldolb
        30Fmu/OvwKULxQzDk/TDBTUGK2JKLQpUWtOBaX+iKV5JBMVFMZrIxGovYv5J3Iqd
        MoXUpoL18w+8cYIbJmhoA==
X-ME-Sender: <xms:hRWRZDMLXM9Bc90DQFmKLK3L9LUxkbLJR2rrl4WZsCwqxsp6K5Vxrw>
    <xme:hRWRZN-yOtH29FZKKSYSMmAR4b_AOun1T45M0Hc6QFAzOxvXn4tPZPpmkTgKxP0KG
    RvNwDSyQqnSizn7ylk>
X-ME-Received: <xmr:hRWRZCTbphH5OCeju1KHpTdnJu1_7RKZqHhSG2THdDn27oAl5iT42hNhAe1N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:hRWRZHsSAe9k9V03PMB1MFkn6jJaEsrdwECm86nxIOT3sPOpBQJ_Kg>
    <xmx:hRWRZLckt6nsPSQ0wh5NSLslDJLpx4E_wqvCAW_LNuvYvJON3gx6vg>
    <xmx:hRWRZD2okdlgbsVh9pWEzqfDxurUJp7EBWnwb23kz27KpvtvOeKe9g>
    <xmx:hRWRZNuywjRN4D3Rs2T354N9KJ-52-gPubs0hPe4-xnom0BqjkxLLQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:05 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/8] platform/x86: asus-wmi: add support for showing charger mode
Date:   Tue, 20 Jun 2023 14:56:34 +1200
Message-Id: <20230620025641.53197-2-luke@ljones.dev>
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

Expose a WMI method in sysfs platform for showing which connected
charger the laptop is currently using.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 10 +++++++++
 drivers/platform/x86/asus-wmi.c               | 21 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index a77a004a1baa..eb29e3023c7b 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -98,3 +98,13 @@ Description:
 		Enable an LCD response-time boost to reduce or remove ghosting:
 			* 0 - Disable,
 			* 1 - Enable
+
+What:		/sys/devices/platform/<platform>/charge_mode
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Get the current charging mode being used:
+			* 1 - Barrel connected charger,
+			* 2 - USB-C charging
+			* 3 - Both connected, barrel used for charging
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1038dfdcdd32..f23375d5fb82 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -237,6 +237,7 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool charge_mode_available;
 	bool egpu_enable_available;
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
@@ -586,6 +587,22 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 		asus_wmi_tablet_sw_report(asus, result);
 }
 
+/* Charging mode, 1=Barrel, 2=USB ******************************************/
+static ssize_t charge_mode_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result, value;
+
+	result = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CHARGE_MODE, &value);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", value & 0xff);
+}
+
+static DEVICE_ATTR_RO(charge_mode);
+
 /* dGPU ********************************************************************/
 static ssize_t dgpu_disable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -3462,6 +3479,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
+	&dev_attr_charge_mode.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_gpu_mux_mode.attr,
@@ -3491,6 +3509,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_charge_mode.attr)
+		ok = asus->charge_mode_available;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
@@ -3757,6 +3777,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	asus->charge_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CHARGE_MODE);
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 28234dc9fa6a..f90cafe26af1 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -95,6 +95,9 @@
 /* Keyboard dock */
 #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
 
+/* Charging mode - 1=Barrel, 2=USB */
+#define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
+
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_EGPU		0x00090019
 
-- 
2.40.1

