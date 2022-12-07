Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50F645979
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLGL4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:55:28 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063FD2E5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:55:27 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 08FCF5C01F3;
        Wed,  7 Dec 2022 06:55:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Dec 2022 06:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670414127; x=
        1670500527; bh=ZWVkqHVOQFKLI4IZL/T9xqCrBqZyvRPBzXa9RyXGtbE=; b=Y
        rtiQCdRCy+089coWBgM8ErPg628haYCSwYGtT4MbZBb9yB804A3zp7ULk+flRhIC
        PDN/9jsLMatTEGB0nblBnnSzJ9NsM7eFmHIrZ6VYj+uhIH2ksq0zRYGZnemQWNPX
        fzGsQlvIFj7yr8ldD9UipfJreeKDG37vQPiH3/iigLAqnsfvPP/vHq9qjMhVIs42
        se7jIfoWzFNXPv7L7kCTvrzagtwOG/geMKUZnUBYN6Ef6ON7nlr7jaOud+n/ad9x
        QgP6l50ARM7N2O5u+xfQAgiOWrlfMVUuUgXDXOqNepjXraI8kPMgagXADwE4lC7A
        QRXME2T54VsoiO1Q0mgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670414127; x=
        1670500527; bh=ZWVkqHVOQFKLI4IZL/T9xqCrBqZyvRPBzXa9RyXGtbE=; b=O
        i+2n8NryPCdFR3EygG7iyKn158U6xyvRwL4tLh4LO5BJ805Ips+Y9F1ZpXtJGCbN
        u9XLe+kq0ayUY7ewAaGAydqsvi93myl/aE7kPpdI8C7UjX30TE6leRjq+17uZtZ8
        QpjkVgufPIyIm8YLE5MJyX83LsvskGVOU8CvqIoTZ3yYQqMZeggvk2bjfHJSSFTX
        PeTFzP6rgzjGsDQx+1L7cFwybB48cIKVUXETYSZczZkfflWcv7JYfgmXlvaLjre0
        uxxAgwD4mus0UxMYY84AozDBSV9Kb89Uc8tbeT5iCf1XTA+Oll5M96dr5J+xX/2z
        HbpvPnKbtisdJ8QLONnFw==
X-ME-Sender: <xms:Ln-QY0Nk2Dtl46Jy0r9Eq8ip-Isuk9vq7rMHFMlEumu9Xfqvoa6NYQ>
    <xme:Ln-QY6_-8LT4JwjKYiM-NX5oP3QIDeVF5BggVOh_auyhfZepi7JqIliBmVvn18d-G
    I_ZlEBlqc_e9zVCxnM>
X-ME-Received: <xmr:Ln-QY7QCIhIxSMDn9oeOpe4FAaVE7yjpFki1fN1lSoxFeamglU7FjPxUJI3IVR0WfCDlgHNIB2l6OnQeFyrI1T4hdT3ZdG7BxwPhiDbf0RnkBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeevvdelieejgedvkeffheekheeilefhgefgffehteekueelvddtueffheet
    ledtffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Ln-QY8tKvCEwkMvEvn-7_FHjz-y_hwDLpy9VHBnWPYaFJKsT6OGwrg>
    <xmx:Ln-QY8f-xcEezXd2yVQoYM73DKkZaCNSb2dVfLLwKl-S_elKJig1Dw>
    <xmx:Ln-QYw3hjlYJenW__hTgLREyjaMdcI00_2wQmHq7p_qYfeKlAv760A>
    <xmx:L3-QY_Un0kNd6XhAMij5R_CA_zhidPqg9b4yzfcYFEJLRuo0D_FlWA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Dec 2022 06:55:26 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Wed, 07 Dec 2022 12:53:19 +0100
Subject: [PATCH 08/15] drm/vc4: hvs: Ignore atomic_flush if we're disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221207-rpi-hvs-crtc-misc-v1-8-1f8e0770798b@cerno.tech>
References: <20221207-rpi-hvs-crtc-misc-v1-0-1f8e0770798b@cerno.tech>
In-Reply-To: <20221207-rpi-hvs-crtc-misc-v1-0-1f8e0770798b@cerno.tech>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-8c583
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=pe2k0BPbXfvS6CAIBcCwRojjO6EKVGqS5JbuGrVO1bk=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkT6lb+n1NfmPCRocrEi/Mb+8oQE42VCou9k5bMFMpoYsg/
 LtnaUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIls4Wf4n/u1PvWO6ZnrtvrZgSs5tg
 WoNtS1efDtm/pjYmb7ySZGS4Z/OpN0PtyddOFGduO5CsGLzlPezA+0dNvZrLfqY9nfpVd/cQEA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_flush will be called for each CRTC even if they aren't enabled.

The whole code we have there will thus run without a properly affected
channel, which can then result in all sorts of weird behaviour.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 3582ede1a0aa..5fadbf219542 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -579,6 +579,9 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 		return;
 	}
 
+	if (vc4_state->assigned_channel == VC4_HVS_CHANNEL_DISABLED)
+		return;
+
 	if (debug_dump_regs) {
 		DRM_INFO("CRTC %d HVS before:\n", drm_crtc_index(crtc));
 		vc4_hvs_dump_state(hvs);

-- 
2.38.1
