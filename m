Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D17361BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjFTC5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFTC5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:40 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0510E2;
        Mon, 19 Jun 2023 19:57:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D0CD15C01F4;
        Mon, 19 Jun 2023 22:57:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 22:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687229846; x=
        1687316246; bh=I8Xbl0BJKPKnoyHohJOj+6eHAELlgJ6aFeDPrAiW/Gk=; b=U
        l27cz2Ow6Iux71DMKTU/qE+7APTsz3GrOvM1cDM8MY4739+fnsRd+f8xQzvuJLS8
        fQu6r8Jfk4NEKPsI0tjSomyKucdStsyQ0gQZ0TGTjIDJMtbOcWsc3guu4TvyVnU8
        MowVi+89gVjrATf2lAG8NruSOpjWOGXHZDRtAM2aTlz1vjJrZrkWJ/z6XLLND7gy
        OtRph6CyDLQSmWu9b/ZJmLbFQ75uLIBVYubeucK8EK0ZA3kytnNK+IR3mjdR9km2
        pMsO7kGRQu9s4KC0I046HwuGFERmgLFdJE+TKs5/tn9k6MuF5FZ0ZYQ5eLBHQEoz
        aTCeDlqCgbLNz8Hb18TkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687229846; x=
        1687316246; bh=I8Xbl0BJKPKnoyHohJOj+6eHAELlgJ6aFeDPrAiW/Gk=; b=d
        L1ub+6ozQsGMvzSk2rEfK1h6H16yBCI7ytDvl4g5PQ/gfdzK2DR7Agd8Isk6C4gZ
        4y3bs7B0zAezqah+Uf3Lzx5yOND5lFcwEobfT16aFA1ggEixD+dXcRIbC7TueZll
        hvrh6eey6/0LB6XSNLHQ37GStLiODjzGKWONbqiFpGmuO1cD0VsYtP4D7PCMH8fV
        PBGdmxEsrOYhahuwkHtlqrlcj/liO5MfWL9nVbVSZx0h0ZeP5qfui6MeL3p571ZV
        gChzmu8uRQcZ6q7AhBzDag/mDYu28K8P+mNmOqg1K9JWk5X8Ex7i4WfGlc/QkaGP
        457tMSaSuZoRsBIekG4FQ==
X-ME-Sender: <xms:lhWRZJl2pKsuYOrbn3iaAnbY-mO6enPiUMakzvLzVx-l3KSgFIYVYg>
    <xme:lhWRZE0RliKjrkScI7f_gCGM7apgdHA30kk4YjhUerrPm72vceg6kUHC8wYBbOr-6
    cXwDHllJ6dA7u9rLnA>
X-ME-Received: <xmr:lhWRZPrjzD1SnieUJbsGWw-HumHbUNslkzmQsocXm6CUS02_r12JW1bcbUF1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:lhWRZJkZa6B4f2gcTWdQsqNU7d5t1RuZfjOOmWJd4ghprz6ZQmGg2g>
    <xmx:lhWRZH0g6Qm7cXt5hiZF7a096JdJnsiujQMU6i8sPvhm8Z7Knloj4A>
    <xmx:lhWRZIu_lYXgLVGXv_QikIoIEnI_gdkFfkssjqebKtxdlyl8MnB3bw>
    <xmx:lhWRZMmIip3ncSLCk7R4ih7oSYFZsVOvdJH1jte3AS0ArVzqBLHCog>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:23 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 6/8] platform/x86: asus-wmi: add safety checks to gpu switching
Date:   Tue, 20 Jun 2023 14:56:39 +1200
Message-Id: <20230620025641.53197-7-luke@ljones.dev>
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

Add safety checking to dgpu_disable, egpu_enable, gpu_mux_mode.

These checks prevent users from doing such things as:
- disabling the dGPU while is muxed to drive the internal screen
- enabling the eGPU which also disables the dGPU, while muxed to
  the internal screen
- switching the MUX to dGPU while the dGPU is disabled

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 50 ++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821addb284d7..602426a7fb41 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -645,6 +645,18 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	if (disable > 1)
 		return -EINVAL;
 
+	if (asus->gpu_mux_mode_available) {
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+		if (result < 0)
+			/* An error here may signal greater failure of GPU handling */
+			return result;
+		if (!result && disable) {
+			err = -ENODEV;
+			pr_warn("Can not disable dGPU when the MUX is in dGPU mode: %d\n", err);
+			return err;
+		}
+	}
+
 	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &result);
 	if (err) {
 		pr_warn("Failed to set dgpu disable: %d\n", err);
@@ -693,7 +705,7 @@ static ssize_t egpu_enable_store(struct device *dev,
 	if (enable > 1)
 		return -EINVAL;
 
-	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	if (err < 0)
 		return err;
 	if (err < 1) {
@@ -702,6 +714,18 @@ static ssize_t egpu_enable_store(struct device *dev,
 		return err;
 	}
 
+	if (asus->gpu_mux_mode_available) {
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+		if (result < 0)
+			/* An error here may signal greater failure of GPU handling */
+			return result;
+		if (!result && enable) {
+			err = -ENODEV;
+			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
+			return err;
+		}
+	}
+
 	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
 	if (err) {
 		pr_warn("Failed to set egpu disable: %d\n", err);
@@ -764,6 +788,30 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 	if (optimus > 1)
 		return -EINVAL;
 
+	if (asus->dgpu_disable_available) {
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_DGPU);
+		if (result < 0)
+			/* An error here may signal greater failure of GPU handling */
+			return result;
+		if (result && !optimus) {
+			err = -ENODEV;
+			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %d\n", err);
+			return err;
+		}
+	}
+
+	if (asus->egpu_enable_available) {
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU);
+		if (result < 0)
+			/* An error here may signal greater failure of GPU handling */
+			return result;
+		if (result && !optimus) {
+			err = -ENODEV;
+			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\n", err);
+			return err;
+		}
+	}
+
 	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
 	if (err) {
 		dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
-- 
2.40.1

