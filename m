Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F725BE667
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiITMxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiITMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:53:23 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B375FE3;
        Tue, 20 Sep 2022 05:53:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7921F3200A0C;
        Tue, 20 Sep 2022 08:53:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 20 Sep 2022 08:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663678388; x=
        1663764788; bh=5Cc2S/zQVAffcAyuSwlU7SwrejWyJZT6LOsl2nIBccg=; b=x
        HZjhJACzsIjchHSoEGtKM6fih5rcS5UMLXhA0VKE31Y68n0cAsamtdckte7qOnyY
        n/yWS/roxQ1yulD10fHE+wECaFgWi3y0UsLQamEPeALq5ei1ror/+Qq/iYhdkiA9
        dAh87iCaQbIIQRi+CuiyvUMUMDDBrnqLDC981nprQiNIJj36PmFUM1sbGNI2MKu3
        yNehaS0UVwWXlgfC5qVQcpickyt9DNcVrILZdl8gw4wLCEM0tycUVjFsSa6tfRH+
        MLJN8QVXViLvwtoODebxg/j0oFzpFqjPX9a8224hbSfKtqaGa/Q/ZGtyqcKjIiMc
        mdew2Y8O8fogRr0hisW6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663678388; x=
        1663764788; bh=5Cc2S/zQVAffcAyuSwlU7SwrejWyJZT6LOsl2nIBccg=; b=S
        lqnTfqSEvCr0p5IJGeT/GzosqpnyB5qoI/2iILg8r/9mvaqvs8I3+b6q648d6bjr
        EmnOj9jSXHRgH4V4Dv+bmw/N1LhdTC26ljJJNJZwTGI7QjqAgF11TUXJHN9s6J4q
        BpjFa44qlvMoWQ9QBRgpqJE2XoR5QsGrb65rk3N7KnnPNvdr8MA56XR9NqSprBA3
        EsG7YmM5C0qSg4T9F74JqaXIyWxHoSj6CWvarcriqaGs33YLZC3vCmHYgyVQbPqT
        djSmdSU7/nTX2HjopwV1sVRxrHnkRqty32ykzvtZFZn4VV+gJXsm9rsAhLlTiMP4
        rimChMMpqKgQZ+Yt2PPTQ==
X-ME-Sender: <xms:tLcpY_Rv1ZynshTqfVaOZt5W0eBH5KfKH6RNPqijiPHE5xoxulBzbQ>
    <xme:tLcpYwz_W55bMb_63sQ7cZh8UWpFDYoy6Sbr4ST6kQASjya1KkBEtRCsp-0YIGuKZ
    YZa513sRtXw3sYjigk>
X-ME-Received: <xmr:tLcpY024wJJ-itMRlO6SIZTRD-XGBxjhGIY6-2ZmaosKgtGxFUkNBjCF4QS5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvledgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tLcpY_ASg5PGkbQBR96CbfF-Igf-jkR7M4msVNAP_zXLi6iM6FrMlQ>
    <xmx:tLcpY4h0VmMPenncwu8gcd1xf4gLtG6ui532VfXufImD7wvWtqx-hQ>
    <xmx:tLcpYzpqyNbvKa5RMGsFg24_bQ1Lp_NkCogB5d4ynenqeDVnne620w>
    <xmx:tLcpY0yxLkGc3BY1O-9UGTuvPAvfqqPxFc56ycDwjAx4SR52vQccaQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Sep 2022 08:53:08 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 20 Sep 2022 14:50:23 +0200
Subject: [PATCH v2 4/7] drm/vc4: hdmi: Fix hdmi_enable_4kp60 detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220815-rpi-fix-4k-60-v2-4-983276b83f62@cerno.tech>
References: <20220815-rpi-fix-4k-60-v2-0-983276b83f62@cerno.tech>
In-Reply-To: <20220815-rpi-fix-4k-60-v2-0-983276b83f62@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Boyd <sboyd@kernel.org>, Emma Anholt <emma@anholt.net>,
        Ray Jui <rjui@broadcom.com>, Maxime Ripard <mripard@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=XWjpwgSgO/e0xPKi2xqW6eLYT6GXogPpdSxziMgFD2I=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMma2/mquKa7py22cvVg/X7IJKx/58+QJZqBVl735mTIz2LK
 aJfpKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwEQ+uDEybBB4kDk3l9POjIuv7YFBxU
 nvDl2P2XJMr7pfvvtwm7ffgeGf3utpwvJyBrNvfnN4/2m37gvZG1Nu6RYXv36x4bgKc+VzRgA=
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

In order to support higher HDMI frequencies, users have to set the
hdmi_enable_4kp60 parameter in their config.txt file.

We were detecting this so far by calling clk_round_rate() on the core
clock with the frequency we're supposed to run at when one of those
modes is enabled. Whether or not the parameter was enabled could then be
inferred by the returned rate since the maximum clock rate reported by
the firmware was one of the side effect of setting that parameter.

However, the recent clock rework we did changed what clk_round_rate()
was returning to always return the minimum allowed, and thus this test
wasn't reliable anymore.

Let's use the new clk_get_max_rate() function to reliably determine the
maximum rate allowed on that clock and fix the 4k@60Hz output.

Fixes: e9d6cea2af1c ("clk: bcm: rpi: Run some clocks at the minimum rate allowed")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 1e5f68704d7d..3b75ac6fa0db 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -46,6 +46,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/rational.h>
 #include <linux/reset.h>
+#include <soc/bcm2835/raspberrypi-clocks.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/hdmi-codec.h>
 #include <sound/pcm_drm_eld.h>
@@ -2966,7 +2967,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	if (variant->max_pixel_clock == 600000000) {
 		struct vc4_dev *vc4 = to_vc4_dev(drm);
-		long max_rate = clk_round_rate(vc4->hvs->core_clk, 550000000);
+		unsigned long max_rate = rpi_firmware_clk_get_max_rate(vc4->hvs->core_clk);
 
 		if (max_rate < 550000000)
 			vc4_hdmi->disable_4kp60 = true;

-- 
b4 0.10.0
