Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130574345E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF3FgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjF3FgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:09 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E210C3;
        Thu, 29 Jun 2023 22:36:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A19B2320097B;
        Fri, 30 Jun 2023 01:36:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 01:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103366; x=
        1688189766; bh=9LoAP+lBJvN0CB58nNnqiigraBS5nNzcGrpOaynMiyM=; b=l
        K78Ij8M9TMWOgvTqmjHgozTkSju81NN0h0srfKtcTclZGuaSrLLxRzGnGWgCK660
        PFS/U2fA2P7J/TwnbJc13f6S1soyBEil6ux9m5ZsNUxh+9D8KCeosyX6gthUATMO
        EF1udh09hJutwXD2dQXoG56/EPtn8GJzBL2FRjsh+9WV1TmH/P7YVam9BF7tlXf9
        NVfWh3oxfUVcp9vYUGne6fMaS1uHKRU4QEfdlQbQ6qiHCmD6kfJn3wXqH9/BA0i5
        UxwSLuNwKhYOdOP+UJplQB+ko2vaTh4TKT0PSgcf0s0raIYm+WjuonFDBty4K4nf
        bvHBiKPE57ZTZLnJ3cNaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103366; x=
        1688189766; bh=9LoAP+lBJvN0CB58nNnqiigraBS5nNzcGrpOaynMiyM=; b=h
        89N3O7PLKiSGlGZkMzudZL8sQZnHml5XG045RhrsGBX7nTRFHYfdS/F4JBrXQul3
        9hGTsbeLDvTOjnxow3FGu9T5yHsu7WY2rP4Wusjm/vGabx7/65F5PVc+cBi+XyfF
        Qa3U8Uc1LjFHU4JS+j2w5/wOSqOm3MYuDPFzMvB6bsyFzf/EDloYJWKrkaR3gtwQ
        HmFg5PKdVgc+w92OUYtZ8gJ4ohK3q7SyV1tpozQtgRjnjOd7fgCgR8RYsSdxc6c4
        43A4lCfu/eJEPVCgxqN1GDudrsu0Qemzg1Yvr43H9AB6d+eoA+GS8VCcwwQoCW20
        sCjwDdYgotEiwOfgXOLbw==
X-ME-Sender: <xms:xWmeZFy_mpFP2D_5CppjvzeDHk1Pc4MpIYmJRcMfQGnH6gUvj2iHRw>
    <xme:xWmeZFQ-ln9gd_wRZGeu-PVH1ElMU4nC3lUZOxF_ZZj42wZ7_DxeEik5i83qzFfqi
    11nZRbu5lIDu8AxMZQ>
X-ME-Received: <xmr:xWmeZPVZyJMwDNCeJYuBn70zC4I5PLikOlyO2bD85algHJq50tpH7XnBOSfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:xWmeZHjX35VseIuTdBcD1NDSTVMIdJ_2_nd3bEmS_WJYjLgJhmIyiA>
    <xmx:xWmeZHBSyNqqU9AYI6bVLOQvgWRkaQxy43CmX6e2Y5rSN_vx7X9wrA>
    <xmx:xWmeZAJWgsFxVQk9o7nTwMIz7YbT55vbgy3Vv5g7exX5QghnsjmfZg>
    <xmx:xmmeZJAFHEIdzwEp7vRCJBf4mT9r1RLwUt7BxE-TzTsWeixnua30Yw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:02 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/8] platform/x86: asus-wmi: add support for showing charger mode
Date:   Fri, 30 Jun 2023 17:35:45 +1200
Message-ID: <20230630053552.976579-2-luke@ljones.dev>
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
2.41.0

