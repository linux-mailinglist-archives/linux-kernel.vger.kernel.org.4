Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA25EF223
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiI2JeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiI2Jdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:33:54 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54E14769F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:33:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4A43658080F;
        Thu, 29 Sep 2022 05:33:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Sep 2022 05:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664443992; x=
        1664451192; bh=z51q6M7mx14qdGQx2QTVYTR7F1avxSTsStcIE9sJ4nk=; b=U
        I+1xMX0+mBH4uaSmsTlb1798zcO5zs6liWQR95w/kCZRf0x6i16+dLGsdSwjR3cJ
        t8F3aCTvTvFsWz8NFWL4ZBBxqOcn8fvtiGEQl/YkBjQfqiuydr+ZbXxP0iCX6rvm
        Y+kReaDvXQnBiAIO9vlSbY4RD3xcm2JcbJdKMgB+SF3gMRVkK/fxq2pP2/OAnZyY
        nTmjGbNipyS2LvWXNwSMhZUGxW4MrtHkFf16wcOw/OqiBey4s0gLRSMn22/+oPZ3
        ovz4STPllx5LylVj778DwFRNPk2I3lvuYeO61Gslbb4a33lYEa4w2KHB2us/tFEb
        A/sQovxpykw+L6spgHAbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664443992; x=
        1664451192; bh=z51q6M7mx14qdGQx2QTVYTR7F1avxSTsStcIE9sJ4nk=; b=o
        ofLQm8+BAQeI+9PDrXLNlDvHh4bo5Blyg8wdHOogdrgxw27+Y7z95z/5O/Agcekm
        56VFgG1jdcE/Y1WErWD3TKW9OQKjj4pAhc8UUVCgVTj+Ol0/j+Z3AcfeTKPgvBEb
        BXAMAStdWY8+sEk1f82/1lmALCGWvgtTnZrgr3FkLM9H9gdvNTERpcEgxhQTT0sc
        2QoVaDRXrFwFSpa4kuy36Ih1I+D6V7LsY+a1kN6tW4vVIuz1LeAX0B7WARL3gi4E
        zpmvTgaZwu4iBOEmPrczZ3a3ZsyBnD0CDWhxYJYF5AnQntCsuBXF8puc+zQ1SZ6x
        hR2lcVreE8CHZtBm8vWvw==
X-ME-Sender: <xms:WGY1Y-cvNoic3bsz6PpU27rg10C8k0ygKvbjYhuU4vbP0ZNuqTmnOg>
    <xme:WGY1Y4MLBnHTDMdjFkPFWJ2unbtGfdDYeJG5-uf5RCXYlAPTdy_nek2oX8azm5da6
    bUiQoHi7lsMxKiAd-4>
X-ME-Received: <xmr:WGY1Y_jwDrxU32py7mXBUwAMBhVgAYOHnSBmsWJkMjsqVmBSmPeU5k-IL7js>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheplefhjedthedtgfdvgeetkeegfeeggfeifedvtdegffekteeivdehveef
    geekffejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:WGY1Y7_VXvhmlHW-SUUPTls6n6yZbBPtRQxyQqqRvp_d-IkGlE_Ndw>
    <xmx:WGY1Y6tgwt71Oy5X1GKRN32uJp8TEmZc5SDak3bsvjEsTL778nDj6A>
    <xmx:WGY1YyFnJ2TFER3oOuyddOjL00B9qGggvSm1NaWfz13oklIOf6wtEw>
    <xmx:WGY1Y7Nj5zjQA2nnR4y699kH6PA6F_vA0q7bzaO9bfpcLF9QsNyhjQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 05:33:11 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 29 Sep 2022 11:21:18 +0200
Subject: [PATCH 2/2] drm/vc4: hdmi: Check the HSM rate at runtime_resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220929-rpi-pi3-unplugged-fixes-v1-2-cd22e962296c@cerno.tech>
References: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech>
In-Reply-To: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=MSD2vZ/eZp3N8anWXRhYND6KpKxesXxyrB7C0/7arEo=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmmyb3F7t9edq6aafXujwaX+GQdPbd+he1LGn9kfNk/6cS1
 xDO/OkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRny2MDEunsT1wfij5WOHbzrAXli
 cP5+7gCbrCsriB4RJnwpP09wwM//03irkKST08IKhzN4xVY0aWkuc3h+2ZoX4Xk18v7t/NxAUA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If our HSM clock has not been properly initialized, any register access
will silently lock up the system.

Let's check that this can't happen by adding a check for the rate before
any register access, and error out otherwise.

Link: https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 2e28fe16ed5e..eb3aaaca2b80 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2889,6 +2889,7 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
 	unsigned long __maybe_unused flags;
 	u32 __maybe_unused value;
+	unsigned long rate;
 	int ret;
 
 	/*
@@ -2904,6 +2905,21 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Whenever the RaspberryPi boots without an HDMI monitor
+	 * plugged in, the firmware won't have initialized the HSM clock
+	 * rate and it will be reported as 0.
+	 *
+	 * If we try to access a register of the controller in such a
+	 * case, it will lead to a silent CPU stall. Let's make sure we
+	 * prevent such a case.
+	 */
+	rate = clk_get_rate(vc4_hdmi->hsm_clock);
+	if (!rate) {
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
+
 	if (vc4_hdmi->variant->reset)
 		vc4_hdmi->variant->reset(vc4_hdmi);
 
@@ -2925,6 +2941,10 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 #endif
 
 	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(vc4_hdmi->hsm_clock);
+	return ret;
 }
 
 static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)

-- 
b4 0.10.1
