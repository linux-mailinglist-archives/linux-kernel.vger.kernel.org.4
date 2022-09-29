Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0635EF222
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiI2JeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiI2Jdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:33:33 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CA2BD1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:32:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48EB65807F5;
        Thu, 29 Sep 2022 05:32:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 29 Sep 2022 05:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664443973; x=
        1664451173; bh=9DXErVDZkFiRNLl9wXwpy0RHuJ8YN9ETuAW3hhAaQMI=; b=I
        aZZ1kRMs2Fwr2H7uRi4KBinORsTE5yXXBG7y4AwQH7KWr0XzsWLSpIBZGqV+9V24
        +SIeHcctjjxF8LBkaOjZZYccpnCPsEvM/Is/BBy9zPv8gfiP1Kjk3fupu5WpYYtu
        ur0optrRAxLVxnN8DZi4pUf5Q4+PY5N+tvUMTwUs/5Yjdpg790TzVzh/8cfasQGo
        7EHQXNoaf0Ev4Gtc0CbyYK5gtj0j1h2kyiA7OiaizjsytV7yoUfCO0MzWcz4KgvH
        FZMWvG6+OlVvvh3wyJwp57Mhlf55ZYBaCXa6HbNWr1AMfTfLodvN9qT1SGdVZFQR
        INWtPOLyXw8uPpdCi4CdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664443973; x=
        1664451173; bh=9DXErVDZkFiRNLl9wXwpy0RHuJ8YN9ETuAW3hhAaQMI=; b=M
        ecTpIrS1GTsO9y0qAHeueAlOkDQ7zRPiaGZs3NJ0SjZv9WnyVHjJdkJ+gTS7FEgq
        +MlJNmFR7fm1ekDXIuszDaHaLJC59FKvBoC/rEb64tptQ8HG1F0LnTFWbiIhEwXZ
        p2qYozLKaw3z+OaSfvARP8u9MW5Ws474mCExatm2X4VpXfWNBeOcn4Et9VR65T/Z
        ObkL7PBQH0YCq8h99JwdtHeT159c/qR6+NoejDAnvNXmmX2NsF2xXq5wk78fuBmx
        AeQC2iBGhd3XC0hbcNxYYceo777cuDLz27iGU1FqlhfftNeEbjoVdKO6xXrm/tiU
        pMsgRBdltFNeVPeIsn/iQ==
X-ME-Sender: <xms:RWY1Yxjw3z0apySlMxkhSD4RXSCCayj5Z2qc5-qxMwHr7kTMBk6Daw>
    <xme:RWY1Y2DmJPh3jYHw7pRVzjYagFpkUvMEE80CSh-YlUD51aiyvRO_IfGOa6uqcp54M
    gj2A2lyqpwBSpSPKgo>
X-ME-Received: <xmr:RWY1YxGvkGaDGwWcoGQUJKYfT7HmKAxcvOlwFclMkua2i0Bk52FbzILDc0XP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheplefhjedthedtgfdvgeetkeegfeeggfeifedvtdegffekteeivdehveef
    geekffejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:RWY1Y2Q8cw_wLjtAlaT0HEZxE1a3i8GVcYNhuKTV2fjj2YN7DpnWZw>
    <xmx:RWY1Y-xSxrwZNhDzmpA5pLydyiYpsPfkMEl4ulR29KpbOxG3DV1dcQ>
    <xmx:RWY1Y87yZyl557Z8dttIn9lCRpoGNQkLu2QjvIlgG3N0uVs48XGk6g>
    <xmx:RWY1Y7xaj-q-G-LKKJtBlGEnTXDSGzhkkAEl2whuSL-57mD_9tlNNA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 05:32:52 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 29 Sep 2022 11:21:17 +0200
Subject: [PATCH 1/2] drm/vc4: hdmi: Enforce the minimum rate at runtime_resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=vw5GYKVofRMN0BICe1OTXBSgFwnYR+ttdoLy4ksyuLE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmmyb0zl99hKC7UfbZh9iXj3gn/A/0bM+qj9sXJfQzrW5h7
 17K4o5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABM5osnwz/iyZ2NGZEr9hu4LBSqrz8
 q+vRS4+MEz4dI0/bvNq3Ituhj++yz/XZo7X/fgQYnk2O3cd6f2GTp/y8yUvMty4oO4/Q17BgA=
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

This is a revert of commit fd5894fa2413 ("drm/vc4: hdmi: Remove clock
rate initialization"), with the code slightly moved around.

It turns out that we can't downright remove that code from the driver,
since the Pi0-3 and Pi4 are in different cases, and it only works for
the Pi4.

Indeed, the commit mentioned above was relying on the RaspberryPi
firmware clocks driver to initialize the rate if it wasn't done by the
firmware. However, the Pi0-3 are using the clk-bcm2835 clock driver that
wasn't doing this initialization. We therefore end up with the clock not
being assigned a rate, and the CPU stalling when trying to access a
register.

We can't move that initialization in the clk-bcm2835 driver, since the
HSM clock we depend on is actually part of the HDMI power domain, so any
rate setup is only valid when the power domain is enabled. Thus, we
reinstated the minimum rate setup at runtime_suspend, which should
address both issues.

Link: https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
Fixes: fd5894fa2413 ("drm/vc4: hdmi: Remove clock rate initialization")
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 199bc398817f..2e28fe16ed5e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2891,6 +2891,15 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	u32 __maybe_unused value;
 	int ret;
 
+	/*
+	 * The HSM clock is in the HDMI power domain, so we need to set
+	 * its frequency while the power domain is active so that it
+	 * keeps its rate.
+	 */
+	ret = clk_set_min_rate(vc4_hdmi->hsm_clock, HSM_MIN_CLOCK_FREQ);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
 	if (ret)
 		return ret;

-- 
b4 0.10.1
