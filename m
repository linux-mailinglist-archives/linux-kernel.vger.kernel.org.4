Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB77361C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFTC53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFTC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:21 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773C10CB;
        Mon, 19 Jun 2023 19:57:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C3FE85C01F3;
        Mon, 19 Jun 2023 22:57:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 22:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229839; x=
        1687316239; bh=I3tnp+mvvRjS8iBgvTLyJ+F7dhMK7joB/j/1+I6s5OA=; b=Q
        t/pmuPDeRtBQo208LusYXlL3i6+gIuCTEzDM+DVJ0eO+iiZlLX0xqbTjJvUTHfzL
        2Du/09RFh0vQ//JoRt58VOSj9wI8y2zGLuixJEfnOjXFBqlmw/P5GCOWu7v6Kr5N
        S9mxBQMp63Fo/3d3VFGffLOBAxTVnPQldGEQ9j/oEvlGm+TfAFTpPQV0VHtdBrkI
        nmpVMhbPbvAl21hvrqF1/d4PKS1th6x/c1M2Le95xxjZA5odP4J76HLc+GU8HWwd
        yDUmH15qwqmSm0zioDawK7gMzBLYL7G5yUB5nBTZKUONrn0zCBUrrkRoAv2EyUoF
        me4enkalMeVv8j4dj/6hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229839; x=
        1687316239; bh=I3tnp+mvvRjS8iBgvTLyJ+F7dhMK7joB/j/1+I6s5OA=; b=i
        WsLiK6dN2kpV4fDebywrxCLkPKNievDtFOrVnwFBWXkNc5lSx8C14QQggA3FhQr3
        HlOqRc3RSImJqZCPr4cJyEDIe9+r0p7the82f7DB03Z03sjM9KoIgz+u9aKyCwCa
        wwePzgJVeokkNvGPuVELESULS3rgoWEpJi6yiMwvewoabT5jMPMut+dSsXI9sC7E
        eyj6ahMYgABgjdR0ks/YV5UMjNm1hz6BaqAES5HdoIUH0cjpjb/ZdagfP1YH8H4Y
        uRa4w1gnsGFAXAO0yohSeeYI6Kn5qt76XNdeeqC9G6/zgGEfH22fBDsSvCRHAJxr
        O1u99ObPNyRdDahnLnnmw==
X-ME-Sender: <xms:jxWRZCfgeyktOEkuDy2zYEcOMx4ICSGhYA_15JZiBDmxf6FNQ9bx9A>
    <xme:jxWRZMOWC7OuMxJ4FvUrdQ1YiSOk5Fbp5uvBB3GzxTGhk-5-WGn0SIm2vNgXcgazQ
    Ck0XQAJgl87KNx482Q>
X-ME-Received: <xmr:jxWRZDi7hrLsKaUJfTwdpBuPyHL3ktI2e947NfuPyUesV-6Duwr__ZJpG3yd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:jxWRZP9yFXywjt9c1U_4DBJevtcNW3cNSndd9yFnyEe_5A1o0tbHvg>
    <xmx:jxWRZOvUynt8I_7_uFe_ir104KbQUFXprjkGGQZXR-zoobClZmFFiA>
    <xmx:jxWRZGFmMoQthJm2glPherXbLm8nv4hkOT8WXZ-ZOZtkQRwVxSR0rQ>
    <xmx:jxWRZL9X5O8MPuHnN-Y_O0tK3ycaoOvdK6wMxENRvibXdlLBvlBbBQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:16 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/8] platform/x86: asus-wmi: add WMI method to show if egpu connected
Date:   Tue, 20 Jun 2023 14:56:37 +1200
Message-Id: <20230620025641.53197-5-luke@ljones.dev>
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
2.40.1

