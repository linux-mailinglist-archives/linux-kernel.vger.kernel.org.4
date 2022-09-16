Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B505BA391
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 02:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIPAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIPAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:46:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E427857D3;
        Thu, 15 Sep 2022 17:46:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E565F5C017D;
        Thu, 15 Sep 2022 20:46:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Sep 2022 20:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1663289195; x=1663375595; bh=rAkof9cLu14wZYnqIpfOS4n0J
        VHqZxl+jYCd09cLVKY=; b=X47oEd+kRy1T93c3u71EhvDRT62E+nXn2dWnITtr4
        cuwTtCSCl8KDHRDqo0Ee3tvfQIo9RJBRSLWoRal1BP0w6f0bUft/CoLjt+ku1xyW
        RT3BEzyX9dEjbm5tqyTePkB/C+hIsfjJ1sbjzEHZuS4uIwOU8Jy6iQGHTWfZy/oL
        SHJSeIGT7+jrXnuEoo5hA2JOaWVxRDYJGotYKzI8IPg3L5S+SDqbZG0XJT0k0CRN
        v28ueZUrWm1BDTN6ZFaemBIrJAv7+5IFvNlozbW8RKGg1Tp6qsJSLpYKKWnc55s6
        IvOHwd3k7dCiPNJ90omK8jrTe7csVz1Z7JSfS5s2bCdwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663289195; x=1663375595; bh=rAkof9cLu14wZYnqIpfOS4n0JVHqZxl+jYC
        d09cLVKY=; b=s5r/DnE58+V/FA+vJPkSoBP+ekYsWfHz0p8B5zBEelIKPbIfC/4
        BYL+PAngH1pwdTiQfo9HgFJaeZJVq6WKNT/lFon1hw8bOuNPtKFpKtCTJ7q5n1+z
        OAN4rH3RaLCoQN9YTPNMR8M6IuOD9ODJwyhyTrOxbMPOW2X8lEKSbkcaxP8yJM6V
        44Nu2vzesit8AHbnxvDYUq4lNxsxT+Y1egg+5R7ctkdWATe7l2cTe5u0iVHpKEV/
        wEZcStl997WNSI+bqHMiHPNAd2bAGVRK/twIJgfZj13bmhNA3nsBCQp+bYuM0SGA
        ddEiwM0GigZUu5/PgOBQ8eR2zQrzyk+MFOg==
X-ME-Sender: <xms:a8cjY9zSAPf4piQfz61oPxvOtDtUW6jggpbzGYc1eFLIhW6q7InnPw>
    <xme:a8cjY9SLkVuZdOzcm6l5jFoTllQ3Tx3mFjYE-ZM2KbMUyowP9OPFtXPWrxgBQHX3n
    3mJsSKKkYCCfREUR4s>
X-ME-Received: <xmr:a8cjY3VZaXdo2ECubPKsjSIXWhdLmoJ-F8Qb6ozc7ptXiggDmSdzcZ4AEIhL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:a8cjY_ig-bApxXRDRSe0HzSOLe3pTdJrg_qlbVuqrcfiiymuDovoRw>
    <xmx:a8cjY_AdzFHnOwbceWH-6rCfH6W-7zbQitbVRM8QsaSeIfpE00almA>
    <xmx:a8cjY4L79HAueiZ1tj7VzseDDoK-tL1vTAFrCgo0rEJTK0zzmduggA>
    <xmx:a8cjYxCzhTHJeWTzykE5Ex_mzOJ-72zPhKSevgUtu_Ogvpe4-8qCXA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Sep 2022 20:46:30 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, corentin.chary@gmail.com, linux@roeck-us.net,
        jdelvare@suse.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Expand support of GPU fan to read RPM and label
Date:   Fri, 16 Sep 2022 12:46:23 +1200
Message-Id: <20220916004623.10992-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previously added patch to add support for pwm change for TUF laptops
also is usuable for more than TUF. The same method `0x00110014` is
used to read the fan RPM.

Add two extra attributes for reading fan2 plus fan2 label.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 36 +++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ae46af731de9..7fe6ce25da0a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -72,6 +72,7 @@ module_param(fnlock_default, bool, 0444);
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
+#define ASUS_GPU_FAN_DESC		"gpu_fan"
 #define ASUS_FAN_DESC			"cpu_fan"
 #define ASUS_FAN_MFUN			0x13
 #define ASUS_FAN_SFUN_READ		0x06
@@ -2078,6 +2079,30 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 }
 
 /* GPU fan on modern ROG laptops */
+static ssize_t fan2_input_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int value;
+	int ret;
+
+	ret = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL, &value);
+	if (ret < 0)
+		return ret;
+
+	value &= 0xffff;
+
+	return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value * 100);
+}
+
+static ssize_t fan2_label_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%s\n", ASUS_GPU_FAN_DESC);
+}
+
 static ssize_t pwm2_enable_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2127,9 +2152,12 @@ static ssize_t pwm2_enable_store(struct device *dev,
 /* Fan1 */
 static DEVICE_ATTR_RW(pwm1);
 static DEVICE_ATTR_RW(pwm1_enable);
-static DEVICE_ATTR_RW(pwm2_enable);
 static DEVICE_ATTR_RO(fan1_input);
 static DEVICE_ATTR_RO(fan1_label);
+/* Fan2 - GPU fan */
+static DEVICE_ATTR_RW(pwm2_enable);
+static DEVICE_ATTR_RO(fan2_input);
+static DEVICE_ATTR_RO(fan2_label);
 
 /* Temperature */
 static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
@@ -2140,6 +2168,8 @@ static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm2_enable.attr,
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_label.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_fan2_label.attr,
 
 	&dev_attr_temp1_input.attr,
 	NULL
@@ -2160,7 +2190,9 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	    || attr == &dev_attr_pwm1_enable.attr) {
 		if (asus->fan_type == FAN_TYPE_NONE)
 			return 0;
-	} else if (attr == &dev_attr_pwm2_enable.attr) {
+	} else if (attr == &dev_attr_fan2_input.attr
+	    || attr == &dev_attr_fan2_label.attr
+	    || attr == &dev_attr_pwm2_enable.attr) {
 		if (asus->gpu_fan_type == FAN_TYPE_NONE)
 			return 0;
 	} else if (attr == &dev_attr_temp1_input.attr) {
-- 
2.37.3

