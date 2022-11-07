Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C429361F7F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiKGPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiKGPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:48:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB68DD3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:48:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a13so18298426edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BDYirpYZ5kfOHvkxSrtBuDWKGYWjPD6FnuUfORGWBTc=;
        b=N61PlqxwjqQnwv3OvI+EWHIUjyufpc88GAYSXe2k3Qb2N3zrydxbk9C60OjQBXKRzr
         9cUZtxpKU+mWXjf8A8mzB0H8eYEt/HoELb9CriiBFUEFXcl4sII0rw9wMMUsdg3HorFm
         qpbIyF0CJEkDKgyvbuJtLJV5s3DczZhbKPyEfZ+jH7ggc4K4hGucMma3Xiizhw5dv9N2
         iZ1iMd+hBBpVe7NX44xYJQ/E/JvOhdKFPLv2beaa3dIR3yHohsR5hn2/VmwAf/T9TjyS
         QI1cQ1p7Gko+33B/OnIfJj5GbxDRYufkrBUzD3nhgNdNbwS1sIMYFnVlIPQBlV/iHfjS
         vk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDYirpYZ5kfOHvkxSrtBuDWKGYWjPD6FnuUfORGWBTc=;
        b=KRfSTFUNkCVASk7/MxaBiUDu5eBQjbNl0ktBqnNuV28BgEG7N2ZVJeXFd11BxB7O3u
         CvgceoeDtYw5JIGGtRjzhE6MmvmO93nVJWSuYvzK9Z66677tJ4ij4Ij5Fuzlv8lGKAeH
         zln4ABhVEdN53+j61a+aTNXhO1y5a60jvWh/h0JRUn85IIaw25yVLr7FOT08KmjyYX1h
         jKc3BfWB/umU8cktJc1CTlLKodMENivEs3Gec/Oa+mQGBExB0mArkfe6uA/qCncsR5p7
         T+a589fTm3VotguPOETQ3PZTQ5UYNuBv264NiMjROFSo+/lPInOJWbbd9c/7IO7xLPdP
         bHDQ==
X-Gm-Message-State: ACrzQf2z7oFZzUp68c8RVJE7BDgPr4/CO3/khow2o2HONmL9T5J8ptxF
        jXU16jfRh0j+B/Rtd3JI6WW5fAEXaGiDEudcQIfZ7w==
X-Google-Smtp-Source: AMsMyM7zOBjN+DY54GaOFcaOAZYJ2+CY36CiwWfiLKrZNLYwlFnSiyAZculK/38l8emxDE0svopFaHLOams2uMneWEU=
X-Received: by 2002:aa7:d7c1:0:b0:463:1dcc:5fbc with SMTP id
 e1-20020aa7d7c1000000b004631dcc5fbcmr47586072eds.250.1667836124340; Mon, 07
 Nov 2022 07:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20221104063652.82789-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221104063652.82789-1-jiapeng.chong@linux.alibaba.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 7 Nov 2022 16:48:33 +0100
Message-ID: <CAG3jFyus_GX=9N0bYQbjuDENdjPurBmy1S_+0eFRsHsnAbCYAg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: sii9234: Remove the unused function sii9234_mode_valid()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 07:37, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function sii9234_mode_valid() is defined in the sii9234.c file, but
> not called elsewhere, so remove this unused function.
>
> drivers/gpu/drm/bridge/sii9234.c:870:31: warning: unused function 'bridge_to_sii9234'.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2735
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/sii9234.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
> index 5b3061d4b5c3..62b6bc8ca7af 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
> @@ -867,11 +867,6 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>         return 0;
>  }
>
> -static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
> -{
> -       return container_of(bridge, struct sii9234, bridge);
> -}
> -
>  static enum drm_mode_status sii9234_mode_valid(struct drm_bridge *bridge,
>                                          const struct drm_display_info *info,
>                                          const struct drm_display_mode *mode)
> --
> 2.20.1.7.g153144c
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
