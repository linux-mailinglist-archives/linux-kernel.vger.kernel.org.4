Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBB67D2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjAZRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjAZRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:10:22 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97B39BA4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:10:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 792605C044E;
        Thu, 26 Jan 2023 12:10:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jan 2023 12:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674753013; x=
        1674839413; bh=KkZyTKB81d/nOJvQoWokQtvq54uqplhHOELZ15UddQs=; b=X
        TzyCHmcXizZsSZG7dr7cTeH74nAHI023nfE9pezBRlqVbSfvGc2/HMQt8FP6kMlr
        bOmFLs4XjxXa+Lk3QEd4qYOp+7R3R7WFkHVFkbWeBgWf2cFuyl2fF8i1kjlfu0IZ
        sfIrs1YE5gedZYPx3d/bRrGHpbcDtFHS4g7tUHN8s82WPhji6JiwS0sMiMZo34OB
        gnuIf9VXUefHBmLlJK4fOj2T2TMCTyYVfXUxmMW3Oy3i+TaYnhjfenZrRZeOlXgN
        zYFSbwecdXGsny8NEw7RD3h0dtwH8LCrb8uQ5z5esC9nXj7rYVQSEsge0+xohgO5
        I8ahcSpel635PINldpYjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674753013; x=
        1674839413; bh=KkZyTKB81d/nOJvQoWokQtvq54uqplhHOELZ15UddQs=; b=X
        Js8ZxA8KkytZQ1JGokInNllJW5XDwIHCSrGnyCzMTcQ+0bIJXa4ktiuRcyLn864G
        XRJXxzIMUES18Au13rMSSMwa34/wbbraQLuT6V54hVkRrH2O72ZbvH8Yn9ITFt1b
        ESTr56hpQX9hwMZs/BttXTghZdbHpaAsNFKIpcbqsy8abHhZmkwsK4e9jBhw5enc
        EQw+7Za7LD6Nr6re6qPWBx4Gsep+PNmM3XCDMOk5yOlb5eKHVCggxixeMPMcFvYC
        hFec6cQIgZbgach7tblWN+A2lRPfoJEy5rRsDo1byrJLBwkQeacG8G2Ztdc5sxEp
        nSgQ0d6kB5X5UuldbbbRQ==
X-ME-Sender: <xms:9LPSYzS5Bc9Umn6_UA8X1ydFKAjI2dHgFxLMoEy5ofQx5SLuKCQLIw>
    <xme:9LPSY0yvumU2dqFsAkFivvwQWcxNr6yAkaPSWePOWElRAaiW9NOT7bfjSOQSnm9ka
    F7ZL79pw_roFCTRInE>
X-ME-Received: <xmr:9LPSY41Da4N9esJ3EyEd6XPpEucUXI7mT2pOByCyGYJbQGfPQl7gNRGcoC5b-vwzainDVh14paxY2KQ5PJYYh6b2ygQXXM4v7KdfnWNBGfktoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9LPSYzDdOyRVplfx2Z8USaYjiGIDFx99N7bTez-Y3k1V0TmtOrf_GQ>
    <xmx:9LPSY8gRuvos1sHt-t7n4DboMugxy9RrlBuVFll2nX72btXQSAcHLg>
    <xmx:9LPSY3reeULaG7r_eUgO3Skc42I1P7pkrH2towjgQ00z-w4dgyDZFg>
    <xmx:9bPSYzSJtpzdYVxm2VKTgX3QE3LjACmQXLCr3Qxc6c9Em_5TVjWfEA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 12:10:11 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 26 Jan 2023 18:05:49 +0100
Subject: [PATCH 4/4] Revert "drm/vc4: hdmi: Enforce the minimum rate at
 runtime_resume"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-rpi-display-fw-clk-cleanup-v1-4-d646ff6fb842@cerno.tech>
References: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
In-Reply-To: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=9Ul4tbyTDXUKD/MhonRAgF3FnEZjFKzNzSrNVoRgm2E=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmXNn0861dfqs2pGv4p36/t4IxX8z/1P8+blFBu05SYZfHw
 cSR3RykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACYy7yAjw+qlu0UYmyXdVyzbfu/uxs
 3r+9fWXZ8S3c5z7MQu40P/l0xi+F8SGdOt4Tx5cc4ywQ/MTQ1f2us9vbs/J9dpKV/MeKblwQEA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ae71ab585c819f83aec84f91eb01157a90552ef2.

Commit ae71ab585c81 ("drm/vc4: hdmi: Enforce the minimum rate at
runtime_resume") was introduced to work around an issue partly due to
the clk-bcm2835 driver on the RaspberryPi0-3.

Since we're not using that driver for our HDMI clocks, we can now revert
it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e82fe17c9532..18d84aab54bb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3350,15 +3350,6 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	unsigned long rate;
 	int ret;
 
-	/*
-	 * The HSM clock is in the HDMI power domain, so we need to set
-	 * its frequency while the power domain is active so that it
-	 * keeps its rate.
-	 */
-	ret = clk_set_min_rate(vc4_hdmi->hsm_clock, HSM_MIN_CLOCK_FREQ);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
 	if (ret)
 		return ret;

-- 
2.39.1
