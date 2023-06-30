Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88A743472
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjF3Fgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjF3Fgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1010C3;
        Thu, 29 Jun 2023 22:36:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 181FB3200983;
        Fri, 30 Jun 2023 01:36:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 01:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103402; x=
        1688189802; bh=mR7QSVgW/nu39AuwrZ0rmfk/cdu9OmaRYy7gYgT4/qg=; b=w
        JK76dQegZVX2AcB+2qYzzgriDfKJqWT24Dl2nDadwWT8FagYyfxufpPfTQW5O9T2
        96U2x+1T9aWhtSEn49P7nifxBiXnVxqYHdnT8/0OLiCJdo5tw7P/1Hwh5g/vQlCj
        wIipq/qlVnoTYg8I8uMskU+XGRQY5jzVPL6WCecFdzevDIZWhfsdrPr0WzC4rjWY
        eD1RyGiTDiylOMOdDgjYxTdleKi6jQdYwo2Mq/KzUGuNDA9vUavLq4p1t2XEUFEx
        rpHuCyho06TU9cRu9udzxdCN7WIc7oD2O5EhhM9avGf6lb5J+cOJLiCeB7CLQlKt
        ddb6LiOd+t3E8CxL3afxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103402; x=
        1688189802; bh=mR7QSVgW/nu39AuwrZ0rmfk/cdu9OmaRYy7gYgT4/qg=; b=G
        IMDHkguwxtLiWi7C3sTKPtInmoqGwbxfIdAGQWCBvD+CF9kL2Tumx0Mr9ZRO6alH
        G69jklMD9C4uHJPjn7jAoshXxDQ32G+S2OjnvODim+d92nmr2o0I3CqOoOeylspb
        6w4cU79K5NSSwLVrkziiN66imYXohHr1Q1gEkGFEBEVhuQXuTKBddk6jMwLL6zjd
        o0/7GWgJxz1cERBfbmjJGVuyCMjVyKIRCziDUafWW54cQRlMubKO9LbDgPKWbv/K
        V/hR2AXEJuW8N17B+nm9yz9/JAOQljS+szkxAn9/va8NAf755T0G5ee7OgY1XwD0
        C+V7TQ7zOmqNF7tbDEEnw==
X-ME-Sender: <xms:6mmeZCha34pUlftNjRUC9dwB2N7_TiPGELLzaNe0gL9gN5wjiqjQNA>
    <xme:6mmeZDBv7-DBUY6-5I4o3jZJciGmacjmQ53XIFuZml-agKxP9nA9NZ_jiuOSXONYx
    Amrk8sNqxE4-zpvGdo>
X-ME-Received: <xmr:6mmeZKHPd_utFwPJ7MB5WW07FPUJaeunC_y4POToUkxTZn8wQjoLldWh6mf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedunecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:6mmeZLR53QGQx7ipsxMOKfIfWWs_M1NUcNCeSmYw_JRaZ4zxOt7Bwg>
    <xmx:6mmeZPxN2Ew6NSyhj5bnKp7xFMIw_QPre-t1W6KH__dcHgz667O-eQ>
    <xmx:6mmeZJ44YPt1uzK9FePi2DxWYwCtRYbzeTB_P9K11Ee753fzITRhXg>
    <xmx:6mmeZGwl00-vSN7IPWZd2iPQqC-fEcCEzYgbdD_GvrAGHUObf_vh8Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:39 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 8/8] platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG
Date:   Fri, 30 Jun 2023 17:35:52 +1200
Message-ID: <20230630053552.976579-9-luke@ljones.dev>
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

Expose various CPU and dGPU tunables that are available on many ASUS
ROG laptops. The tunables shown in sysfs will vary depending on the CPU
and dGPU vendor.

All of these variables are write only and there is no easy way to find
what the defaults are. In general they seem to default to the max value
the vendor sets for the CPU and dGPU package - this is not the same as
the min/max writable value. Values written to these variables that are
beyond the capabilities of the CPU are ignored by the laptop.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  58 ++++
 drivers/platform/x86/asus-wmi.c               | 285 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |   9 +
 3 files changed, 352 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 5624bdef49cb..caaccd28fabf 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -126,3 +126,61 @@ Description:
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
+
+What:		/sys/devices/platform/<platform>/ppt_pl1_spl
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
+		Shown on Intel+Nvidia or AMD+Nvidia based systems.
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_pl2_sppt
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
+		on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems.
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_fppt
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only.
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_apu_sppt
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the APU SPPT limit. Shown on full AMD systems only.
+			* min=5, max=130
+
+What:		/sys/devices/platform/<platform>/ppt_platform_sppt
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the platform SPPT limit. Shown on full AMD systems only.
+			* min=5, max=130
+
+What:		/sys/devices/platform/<platform>/nv_dynamic_boost
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the dynamic boost limit of the Nvidia dGPU:
+			* min=5, max=25
+
+What:		/sys/devices/platform/<platform>/nv_temp_target
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the target temperature limit of the Nvidia dGPU:
+			* min=75, max=87
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1fc9e8afc2f3..d9a353081f91 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -117,6 +117,16 @@ module_param(fnlock_default, bool, 0444);
 /* Mask to determine if setting temperature or percentage */
 #define FAN_CURVE_PWM_MASK		0x04
 
+/* Limits for tunables available on ASUS ROG laptops */
+#define PPT_TOTAL_MIN		5
+#define PPT_TOTAL_MAX		250
+#define PPT_CPU_MIN			5
+#define PPT_CPU_MAX			130
+#define NVIDIA_BOOST_MIN	5
+#define NVIDIA_BOOST_MAX	25
+#define NVIDIA_TEMP_MIN		75
+#define NVIDIA_TEMP_MAX		87
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
@@ -247,6 +257,15 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
 
+	/* Tunables provided by ASUS for gaming laptops */
+	bool ppt_pl2_sppt_available;
+	bool ppt_pl1_spl_available;
+	bool ppt_apu_sppt_available;
+	bool ppt_plat_sppt_available;
+	bool ppt_fppt_available;
+	bool nv_dyn_boost_available;
+	bool nv_temp_tgt_available;
+
 	bool kbd_rgb_mode_available;
 	bool kbd_rgb_state_available;
 
@@ -946,6 +965,244 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 	NULL,
 };
 
+/* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
+static ssize_t ppt_pl2_sppt_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL2_SPPT, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_pl2_sppt: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_pl2_sppt (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl2_sppt");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_pl2_sppt);
+
+/* Tunable: PPT, Intel=PL1, AMD=SPL ******************************************/
+static ssize_t ppt_pl1_spl_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL1_SPL, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_pl1_spl: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_pl1_spl (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl1_spl");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_pl1_spl);
+
+/* Tunable: PPT APU FPPT ******************************************************/
+static ssize_t ppt_fppt_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_FPPT, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_fppt: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_fppt (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_fpu_sppt");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_fppt);
+
+/* Tunable: PPT APU SPPT *****************************************************/
+static ssize_t ppt_apu_sppt_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < PPT_CPU_MIN || value > PPT_CPU_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_APU_SPPT, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_apu_sppt: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_apu_sppt (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_apu_sppt");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_apu_sppt);
+
+/* Tunable: PPT platform SPPT ************************************************/
+static ssize_t ppt_platform_sppt_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < PPT_CPU_MIN || value > PPT_CPU_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PLAT_SPPT, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_platform_sppt: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_platform_sppt (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_platform_sppt");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_platform_sppt);
+
+/* Tunable: NVIDIA dynamic boost *********************************************/
+static ssize_t nv_dynamic_boost_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < NVIDIA_BOOST_MIN || value > NVIDIA_BOOST_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_DYN_BOOST, value, &result);
+	if (err) {
+		pr_warn("Failed to set nv_dynamic_boost: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set nv_dynamic_boost (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_dynamic_boost");
+
+	return count;
+}
+static DEVICE_ATTR_WO(nv_dynamic_boost);
+
+/* Tunable: NVIDIA temperature target ****************************************/
+static ssize_t nv_temp_target_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 value;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < NVIDIA_TEMP_MIN || value > NVIDIA_TEMP_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_THERM_TARGET, value, &result);
+	if (err) {
+		pr_warn("Failed to set nv_temp_target: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set nv_temp_target (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_temp_target");
+
+	return count;
+}
+static DEVICE_ATTR_WO(nv_temp_target);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3775,6 +4032,13 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
+	&dev_attr_ppt_pl2_sppt.attr,
+	&dev_attr_ppt_pl1_spl.attr,
+	&dev_attr_ppt_fppt.attr,
+	&dev_attr_ppt_apu_sppt.attr,
+	&dev_attr_ppt_platform_sppt.attr,
+	&dev_attr_nv_dynamic_boost.attr,
+	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	NULL
@@ -3812,6 +4076,20 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
+	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
+		ok = asus->ppt_pl2_sppt_available;
+	else if (attr == &dev_attr_ppt_pl1_spl.attr)
+		ok = asus->ppt_pl1_spl_available;
+	else if (attr == &dev_attr_ppt_fppt.attr)
+		ok = asus->ppt_fppt_available;
+	else if (attr == &dev_attr_ppt_apu_sppt.attr)
+		ok = asus->ppt_apu_sppt_available;
+	else if (attr == &dev_attr_ppt_platform_sppt.attr)
+		ok = asus->ppt_plat_sppt_available;
+	else if (attr == &dev_attr_nv_dynamic_boost.attr)
+		ok = asus->nv_dyn_boost_available;
+	else if (attr == &dev_attr_nv_temp_target.attr)
+		ok = asus->nv_temp_tgt_available;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
@@ -4077,6 +4355,13 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
+	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
+	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
+	asus->ppt_fppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_FPPT);
+	asus->ppt_apu_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_APU_SPPT);
+	asus->ppt_plat_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
+	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
+	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index ea80361ac6c7..16e99a1c37fc 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -86,6 +86,15 @@
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 #define ASUS_WMI_DEVID_MID_FAN_CURVE	0x00110032
 
+/* Tunables for AUS ROG laptops */
+#define ASUS_WMI_DEVID_PPT_PL2_SPPT		0x001200A0
+#define ASUS_WMI_DEVID_PPT_PL1_SPL		0x001200A3
+#define ASUS_WMI_DEVID_PPT_APU_SPPT		0x001200B0
+#define ASUS_WMI_DEVID_PPT_PLAT_SPPT	0x001200B1
+#define ASUS_WMI_DEVID_PPT_FPPT			0x001200C1
+#define ASUS_WMI_DEVID_NV_DYN_BOOST		0x001200C0
+#define ASUS_WMI_DEVID_NV_THERM_TARGET	0x001200C2
+
 /* Power */
 #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
 
-- 
2.41.0

