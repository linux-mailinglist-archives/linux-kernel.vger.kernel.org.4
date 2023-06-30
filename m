Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9ED74346E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjF3Fgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjF3Fgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F83E3585;
        Thu, 29 Jun 2023 22:36:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A4C70320098C;
        Fri, 30 Jun 2023 01:36:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 30 Jun 2023 01:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688103392; x=
        1688189792; bh=bWv6npFXhdXxLcYc0Px3FglQvMChhuV4rcjQEuBLYbk=; b=Y
        Zk/LMaq/CDrkbNzgDOA8FxLB5xK1jRPgdPxfsIs/aHcNnCDkvLGqcQyjvRwIX7MX
        ay2npQQYjLAPqYzHc66CH3T2VrS+IlPAjjNCLatrRuJ4HCTSM7Bz6BHbc8ZBOq0/
        PAAZVweeItWkFIY3cq52OC+OAO9kcpsF2Nex2sEF6oMbYxvi5Uh6HSnVLXVQMD/L
        hN1f7l5SQ1SpCQDG5aWgitevI/wbnA4N6TjHeuXo4Bnsn0m79JXFncAN4jSAfqzI
        XGFc5S9K9QgxTNwqFlUdInVwEZmN3yykCE5bG1BMJUe5fa6jWvocI/N6xQChkgdv
        gvP4X2jLGoFLnSORwZiBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688103392; x=
        1688189792; bh=bWv6npFXhdXxLcYc0Px3FglQvMChhuV4rcjQEuBLYbk=; b=O
        AbS+R0ycqgXv4b7My5WBhW49FOY9YfxEhkTZBaMGGKpvEpUJblrT09okc81zrLiL
        3vGnjs/0FmFlPSVlNPZJuG9Ha4SBjh2ydIV38WxKI/fyNokDWmPYPOLO4UnwiI/n
        E7KqINhoelctPCUuXYVGGZSzBkkvuY57hj/sT5at2K8eMa+kC7OMTkPyh+N2BPI4
        AdseyPoKBiJylttW1s/9Id3gmkv+XjQfay0Z8tgyleCTwPbf8xLA9ZiprR8ZQXoH
        fjmqk10Ix/FpVCL/4LvHfCs9hAgFCdBBEWUVqbs0cn7arhqjA5HYtS1VbgYv+4L3
        CBFvnALAbw1bwJRNuDElA==
X-ME-Sender: <xms:4GmeZOKMeroLSIIbFsHlOiy3Dyw2tLX_N8ef9TJT4VrYyE68uI6aQA>
    <xme:4GmeZGIkD6Xf9K44n36gDm7ryvRoLWC__qeD29rP7gN_jBBWJMXub8oCNM_bVmA7v
    bO6OUCUkxbDJl2raUs>
X-ME-Received: <xmr:4GmeZOvh2l_D_zErOPzdD4iYcS1zVh9wojfa7gfEFLCBJVrXV4ciV0MPmyj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedunecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:4GmeZDa_ssp_SVoLPVbopdptzO2mlTpODqJr-btjbGt6dYmngdaaKQ>
    <xmx:4GmeZFay8TuKs2Bz9cStHVNg8x0y9OItUkFm1Zze8QW1g0yRrc4PGg>
    <xmx:4GmeZPDOUCg1edYyHoKmAD0GrpufQMrOHyzQiD-pUhjCvkyHVM1t-g>
    <xmx:4GmeZB6L8jVkkUpO2j2y6ER6Umyf42ryLEvW98UqFYeve5bYbprYZA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:36:28 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 6/8] platform/x86: asus-wmi: add safety checks to gpu switching
Date:   Fri, 30 Jun 2023 17:35:50 +1200
Message-ID: <20230630053552.976579-7-luke@ljones.dev>
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
2.41.0

