Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292065BE55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjACKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjACKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:42:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92CBA187
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:42:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so72646886ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MTCCvTLvkrq9UYZLIeqAgvmTL5kXy4L/w7DR6Wdybhw=;
        b=AYtJ2TrgpA5J3COpcPW59lGl4mbGQQHk7avrxHfY0zCeTZ1ZVgGKtLW+Z5uLe2BxJq
         d1g+zGq1CvsYsCH+qrik+I1PInp7bJeT5nzJEP+m9dzWYNtfS8hu8aqr6dmKJRAUKT6h
         wScok0759OWY4NEp3XXWQfvdaj2e/fWYFs3yQ91+fRo6a2p/ChruxIYAfaOoliWqr3nf
         CUNaDTBM2OvXdJeciGjsdV0WINKPtJbjGA6vOrpsBi2u8uy8ttI7Rlygel3rPGD3zGRW
         dRWXgTpQJlxywVxnytjbLdvK/GwGws4OWv3kBHeRroPVGOC1GdlYjDcOPw5e+gemKSSE
         okxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTCCvTLvkrq9UYZLIeqAgvmTL5kXy4L/w7DR6Wdybhw=;
        b=IoptIbOzbirrQlWksUTZudWHlz63AWfqHj4SYx2WxyATKrDdbuCXTCPmmBomP75G7j
         vJUQsBCneL4tGj09QrtW6I5yjF5p8Peh6mxbs3xavGdlQEA22uJ2Rl0mC9NKZQ1veqvM
         m1NBiG4NqIGmLbfAuSRmr3NAHkVC8qh3eKBojIj5rKkvum8LKMwp/jyXnJE1Zmqn+dFk
         2h20+Vtepm7mS/7fYCheCDv6RMQqXwmrzk5QMgdMYUsHy2hG7iLss680/OFzygafqVMV
         KRUd9HDo4Te2mMFuU2E/99WMJ6sMfV9rtVUq2O21v+gKTqv/4eX6r4xsxXzo93M5YNG+
         t6fg==
X-Gm-Message-State: AFqh2kp2aieH9MBpY6v+UpEYnbk2Rr5IINEJWQXYz1/YSsnucv48iaJg
        q5V17lvM2aXiy7A2LRYomD8=
X-Google-Smtp-Source: AMrXdXsAh7UObdy7ZWckLxIaybn6obM08nvXeefxVH68hT3Ehxco2PjCeLwxNbNb/FhznDDLcI9sEA==
X-Received: by 2002:a17:907:a809:b0:7c1:27a:d239 with SMTP id vo9-20020a170907a80900b007c1027ad239mr36098408ejc.34.1672742571978;
        Tue, 03 Jan 2023 02:42:51 -0800 (PST)
Received: from [0.0.0.0] ([134.134.139.78])
        by smtp.googlemail.com with ESMTPSA id e22-20020a170906045600b0073022b796a7sm14184184eja.93.2023.01.03.02.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:42:51 -0800 (PST)
Message-ID: <8b4448d0-d9ea-95a6-83ee-513fe73c793f@gmail.com>
Date:   Tue, 3 Jan 2023 12:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: juhapekka.heikkila@gmail.com
Subject: Re: [PATCH] drm/i915/display: Check source height is > 0
Content-Language: en-US
To:     Drew Davenport <ddavenport@chromium.org>,
        intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?Q?Juha-Pekka_Heikkil=c3=a4?= 
        <juha-pekka.heikkila@intel.com>
References: <20221226225246.1.I15dff7bb5a0e485c862eae61a69096caf12ef29f@changeid>
From:   Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
In-Reply-To: <20221226225246.1.I15dff7bb5a0e485c862eae61a69096caf12ef29f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Drew,

this is good find. I went looking where the problem is in and saw what 
you probably also saw earlier.

I was wondering if diff below would be better fix? I assume this would 
end up with einval or erange in your case but code flow otherwise would 
stay as is while fixing all future callers for same issue:

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c 
b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 10e1fc9d0698..a9948e8d3543 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -144,7 +144,7 @@ unsigned int intel_adjusted_rate(const struct 
drm_rect *src,
                                  const struct drm_rect *dst,
                                  unsigned int rate)
  {
-       unsigned int src_w, src_h, dst_w, dst_h;
+       unsigned int src_w, src_h, dst_w, dst_h, dst_wh;

         src_w = drm_rect_width(src) >> 16;
         src_h = drm_rect_height(src) >> 16;
@@ -155,8 +155,10 @@ unsigned int intel_adjusted_rate(const struct 
drm_rect *src,
         dst_w = min(src_w, dst_w);
         dst_h = min(src_h, dst_h);

-       return DIV_ROUND_UP_ULL(mul_u32_u32(rate, src_w * src_h),
-                               dst_w * dst_h);
+       /* in case src contained only fractional part */
+       dst_wh = max(dst_w * dst_h, (unsigned) 1);
+
+       return DIV_ROUND_UP_ULL(mul_u32_u32(rate, src_w * src_h), dst_wh);
  }

  unsigned int intel_plane_pixel_rate(const struct intel_crtc_state 
*crtc_state,


What do you think? I'll in any case come up with some test for this in igt.

/Juha-Pekka

On 27.12.2022 7.53, Drew Davenport wrote:
> The error message suggests that the height of the src rect must be at
> least 1. Reject source with height of 0.
> 
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> 
> ---
> I was investigating some divide-by-zero crash reports on ChromeOS which
> pointed to the intel_adjusted_rate function. Further prodding showed
> that I could reproduce this in a simple test program if I made src_h
> some value less than 1 but greater than 0.
> 
> This seemed to be a sensible place to check that the source height is at
> least 1. I tried to repro this issue on an amd device I had on hand, and
> the configuration was rejected.
> 
> Would it make sense to add a check that source dimensions are at least 1
> somewhere in core, like in drm_atomic_plane_check? Or is that a valid
> use case on some devices, and thus any such check should be done on a
> per-driver basis?
> 
> Thanks.
> 
>   drivers/gpu/drm/i915/display/skl_universal_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> index 4b79c2d2d6177..9b172a1e90deb 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> @@ -1627,7 +1627,7 @@ static int skl_check_main_surface(struct intel_plane_state *plane_state)
>   	u32 offset;
>   	int ret;
>   
> -	if (w > max_width || w < min_width || h > max_height) {
> +	if (w > max_width || w < min_width || h > max_height || h < 1) {
>   		drm_dbg_kms(&dev_priv->drm,
>   			    "requested Y/RGB source size %dx%d outside limits (min: %dx1 max: %dx%d)\n",
>   			    w, h, min_width, max_width, max_height);

