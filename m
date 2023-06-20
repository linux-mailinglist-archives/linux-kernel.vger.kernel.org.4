Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870C47361C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFTC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFTC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:58:10 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B110DE;
        Mon, 19 Jun 2023 19:57:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F28135C01F3;
        Mon, 19 Jun 2023 22:57:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 22:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229853; x=
        1687316253; bh=320HCxo0m6kqsTndJmmY8l9xJ3+BedXN0i38xL7mNwQ=; b=u
        mDcJSERBSJI9yCIl3k70MvctiU9ltynKcSj6YwKEfJFUk+Lt5Ml496RuhVSNvuzP
        ipP42JeHs1a4i6M4K3o1TyhaPUD1O2phOdjGqRwC5FQrGKzL2PM59+qhhmvxhKta
        iVEFNfDF18lmsM/03drgET8K+Z5RTL+dPSRa4m+OFFFHm/frFbt05JFFAtpMJvYb
        pCaIIiwcjcfWpZImAK5mmc+j2e+kEizqVCX2AgqYmWHagvmWh6PqRLjJmXTlRrCj
        MCQtmDSY4y0VHrq55vjn+3wyBBTKQVrN3GH4xD0heIRtulB8w+o+pd+S+eKYfYvU
        HZBP0CFXAPynBQdpfMt/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229853; x=
        1687316253; bh=320HCxo0m6kqsTndJmmY8l9xJ3+BedXN0i38xL7mNwQ=; b=j
        hhqgncBCIgwU1Rv7lz1TM5RzQSJtGENImMEVZcPjd4Qet4wpXS4dlQvNqzx6YWKo
        m+zZl84eEi9ZKejyf2RFM6CwxAwajjFGD+NcSoRiumq0i33GSeiB9KvAKNb9ioch
        IfXy5zKTS8TK9D9IBjrv6qlxa/oKlwOJDi7hxqViBTz2CkegnU+cn0Tdh70GvFhU
        chMsDX8aa9/Biy19mrqSgwXLQD8nBAqYXM2C0bQdmw/aOoeGebLjDO6dxmcIxM7g
        /Q2qB2UTPjC3bHLiI8fXWF+5Tca9lc10QeipQL44f0yenrA11WgTy8QJhVdWCCKX
        bpLNo8h7QnQ9QA4SvjUYQ==
X-ME-Sender: <xms:nRWRZKbi1KzaAiMzyng3otmSA3DuMNZa1ed9qc5XwkWlt_1tvd4__Q>
    <xme:nRWRZNbAQwceq_5DiDjY5Uz5yDSFx_iVpevRHSv3AOBPBECrQHC4hRSsRGJE_e6rj
    HTCV401MVffbFn0N48>
X-ME-Received: <xmr:nRWRZE-3wUdsqLEDUQZtCdfzRDONl3ZYtYykvnbaaYqnWkVeLfC2bXD2miPb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:nRWRZMpy41sAcP5H-GT_c43zs4QPlmO6p8YcF0wO3odgmzz0YAAaLA>
    <xmx:nRWRZFogdbM6S59jZ1pdJOCGZsZjxN-vwBRacrvFrYT_NaRX0oHWpA>
    <xmx:nRWRZKQ-zgMq6wpz9pyzDgHyd6m2bDpQVlwX5K_0-1XNl9xXB5heVg>
    <xmx:nRWRZJIsF_M5ubHU9-lytwX8kU32hoUPtMPU9_S413gIAcUCGvxFcA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:30 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 8/8] platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG
Date:   Tue, 20 Jun 2023 14:56:41 +1200
Message-Id: <20230620025641.53197-9-luke@ljones.dev>
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
 .../ABI/testing/sysfs-platform-asus-wmi       |  72 ++++
 drivers/platform/x86/asus-wmi.c               | 365 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  11 +
 3 files changed, 448 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 5624bdef49cb..64c1c76d3fb8 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -126,3 +126,75 @@ Description:
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
+
+What:		/sys/devices/platform/<platform>/ppt_total
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Package Power Target total of CPU, corresponds to PL1 on Intel:
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_sppt
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Slow Package Power Tracking Limit of CPU, corresponds to PL2 on Intel:
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_fppt
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Fast Package Power Tracking Limit of CPU:
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_edc
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Electrical Design Current for the CPU, peak current:
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_tdc
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the Thermal Design Current for the CPU, sustained current:
+			* min=5, max=250
+
+What:		/sys/devices/platform/<platform>/ppt_limit
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the CPU PPT limit:
+			* min=5, max=130
+
+What:		/sys/devices/platform/<platform>/ppt_limit_slow
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the CPU PPT slow limit:
+			* min=5, max=130
+
+What:		/sys/devices/platform/<platform>/nv_gpu_boost
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the extra current boost of the Nvidia dGPU:
+			* min=5, max=25
+
+What:		/sys/devices/platform/<platform>/nv_gpu_temp_target
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the temperature limit of the Nvidia dGPU:
+			* min=75, max=87
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1fc9e8afc2f3..62cee13f5576 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -117,6 +117,16 @@ module_param(fnlock_default, bool, 0444);
 /* Mask to determine if setting temperature or percentage */
 #define FAN_CURVE_PWM_MASK		0x04
 
+/* Limits for tunables available on ASUS ROG laptops */
+#define PPT_TOTAL_MIN	5
+#define PPT_TOTAL_MAX	250
+#define PPT_CPU_MIN	5
+#define PPT_CPU_MAX	130
+#define NVIDIA_GPU_BOOST_MIN	5
+#define NVIDIA_GPU_BOOST_MAX	25
+#define NVIDIA_GPU_TEMP_MIN	75
+#define NVIDIA_GPU_TEMP_MAX	87
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
@@ -247,6 +257,17 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
 
+	/* Tunables provided by ASUS for gaming laptops */
+	bool ppt_total_available;
+	bool ppt_edc_available;
+	bool ppt_tdc_available;
+	bool ppt_sppt_available;
+	bool ppt_limit_available;
+	bool ppt_limit_slow_available;
+	bool ppt_fppt_available;
+	bool nv_gpu_boost_available;
+	bool nv_gpu_temp_target_available;
+
 	bool kbd_rgb_mode_available;
 	bool kbd_rgb_state_available;
 
@@ -946,6 +967,312 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 	NULL,
 };
 
+/* Tunable: PPT Total **********************************************************/
+static ssize_t ppt_total_store(struct device *dev,
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
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_TOTAL, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_total: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_total (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_total");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_total);
+
+/* Tunable: PPT EDC **********************************************************/
+static ssize_t ppt_edc_store(struct device *dev,
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
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_EDC, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_edc: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_edc (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_edc");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_edc);
+
+/* Tunable: PPT TDC ***********************************************************/
+static ssize_t ppt_tdc_store(struct device *dev,
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
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_TDC, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_tdc: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_tdc (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_tdc");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_tdc);
+
+/* Tunable: PPT APU sPPT ******************************************************/
+static ssize_t ppt_sppt_store(struct device *dev,
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
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_SPPT, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_sppt: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_sppt (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_sppt");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_sppt);
+
+/* Tunable: PPT APU fPPT ******************************************************/
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
+/* Tunable: PPT APU limit *****************************************************/
+static ssize_t ppt_limit_store(struct device *dev,
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
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_LIMIT, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_limit: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_limit (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_limit");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_limit);
+
+/* Tunable: PPT limit slow ****************************************************/
+static ssize_t ppt_limit_slow_store(struct device *dev,
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
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_LIMIT_SLOW, value, &result);
+	if (err) {
+		pr_warn("Failed to set ppt_limit_slow: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set ppt_limit_slow (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_limit_slow");
+
+	return count;
+}
+static DEVICE_ATTR_WO(ppt_limit_slow);
+
+/* Tunable: NVIDIA GPU boost **************************************************/
+static ssize_t nv_gpu_boost_store(struct device *dev,
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
+	if (value < NVIDIA_GPU_BOOST_MIN || value > NVIDIA_GPU_BOOST_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_GPU_BOOST, value, &result);
+	if (err) {
+		pr_warn("Failed to set nv_gpu_boost: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set nv_gpu_boost (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_gpu_boost");
+
+	return count;
+}
+static DEVICE_ATTR_WO(nv_gpu_boost);
+
+/* Tunable: NVIDIA GPU temperature target *************************************/
+static ssize_t nv_gpu_temp_target_store(struct device *dev,
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
+	if (value < NVIDIA_GPU_TEMP_MIN || value > NVIDIA_GPU_TEMP_MAX)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_GPU_TEMP_TARGET, value, &result);
+	if (err) {
+		pr_warn("Failed to set nv_gpu_temp_target: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set nv_gpu_temp_target (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_gpu_temp_target");
+
+	return count;
+}
+static DEVICE_ATTR_WO(nv_gpu_temp_target);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3775,6 +4102,15 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
+	&dev_attr_ppt_total.attr,
+	&dev_attr_ppt_edc.attr,
+	&dev_attr_ppt_tdc.attr,
+	&dev_attr_ppt_sppt.attr,
+	&dev_attr_ppt_fppt.attr,
+	&dev_attr_ppt_limit.attr,
+	&dev_attr_ppt_limit_slow.attr,
+	&dev_attr_nv_gpu_boost.attr,
+	&dev_attr_nv_gpu_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	NULL
@@ -3812,6 +4148,24 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
+	else if (attr == &dev_attr_ppt_total.attr)
+		ok = asus->ppt_total_available;
+	else if (attr == &dev_attr_ppt_edc.attr)
+		ok = asus->ppt_edc_available;
+	else if (attr == &dev_attr_ppt_tdc.attr)
+		ok = asus->ppt_tdc_available;
+	else if (attr == &dev_attr_ppt_sppt.attr)
+		ok = asus->ppt_sppt_available;
+	else if (attr == &dev_attr_ppt_fppt.attr)
+		ok = asus->ppt_fppt_available;
+	else if (attr == &dev_attr_ppt_limit.attr)
+		ok = asus->ppt_limit_available;
+	else if (attr == &dev_attr_ppt_limit_slow.attr)
+		ok = asus->ppt_limit_slow_available;
+	else if (attr == &dev_attr_nv_gpu_boost.attr)
+		ok = asus->nv_gpu_boost_available;
+	else if (attr == &dev_attr_nv_gpu_temp_target.attr)
+		ok = asus->nv_gpu_temp_target_available;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
@@ -4077,6 +4431,17 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
+	asus->ppt_total_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_TOTAL);
+	asus->ppt_edc_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_EDC);
+	asus->ppt_tdc_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_TDC);
+	asus->ppt_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_SPPT);
+	asus->ppt_fppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_FPPT);
+	asus->ppt_limit_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_LIMIT);
+	asus->ppt_limit_slow_available = asus_wmi_dev_is_present(asus,
+								ASUS_WMI_DEVID_PPT_LIMIT_SLOW);
+	asus->nv_gpu_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_GPU_BOOST);
+	asus->nv_gpu_temp_target_available = asus_wmi_dev_is_present(asus,
+								ASUS_WMI_DEVID_NV_GPU_TEMP_TARGET);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index ea80361ac6c7..d17ae2eb0f8d 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -86,6 +86,17 @@
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 #define ASUS_WMI_DEVID_MID_FAN_CURVE	0x00110032
 
+/* Tunables for AUS ROG laptops */
+#define ASUS_WMI_DEVID_PPT_TOTAL	0x001200A0
+#define ASUS_WMI_DEVID_PPT_EDC		0x001200A1
+#define ASUS_WMI_DEVID_PPT_TDC		0x001200A2
+#define ASUS_WMI_DEVID_PPT_SPPT		0x001200A3
+#define ASUS_WMI_DEVID_PPT_LIMIT	0x001200B0
+#define ASUS_WMI_DEVID_PPT_LIMIT_SLOW	0x001200B1
+#define ASUS_WMI_DEVID_PPT_FPPT		0x001200C1
+#define ASUS_WMI_DEVID_NV_GPU_BOOST	0x001200C0
+#define ASUS_WMI_DEVID_NV_GPU_TEMP_TARGET	0x001200C2
+
 /* Power */
 #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
 
-- 
2.40.1

