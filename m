Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB0743964
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF3KdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjF3KdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:33:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B330DF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso27154031fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688121199; x=1690713199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BV6pMCNFBELZthFQNdbEPY0LFf8oujVmtU/HlHM5O6w=;
        b=La97SAtUMDaQJPXoGRraZ0zdFoKriXSnJyG5uqhKNWQLBvzsNLIa3sVbPGjI/Hyn6r
         CwAUr8zFLmuU1Hw6/1WHilfZMHUbRmEi3qC+ryRszPZL6yTQZGTK/Fzq93hyTrPBE3ld
         lvLHmDjSPBltv0e0WuW3AvCI1sVhEa6O7rxJXMNLcxJnQHKJ9hdlugyO7Ta3UAvdfsjR
         vXB49PmJZrbWS40WXb320dBMOKwsnfMToxiq20oHb9+hWxDzy1gJT0GxGHFPpm6iJkbV
         RdnaTWKi8hXixIY83GUyhOPj4PwhlGU5Rk3YCCUOP8WZj09ShQyDQ6kSgG8jPXJ5z+t+
         JreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121199; x=1690713199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BV6pMCNFBELZthFQNdbEPY0LFf8oujVmtU/HlHM5O6w=;
        b=W+Ku4H6CYdJ7JVzJzlTX1CoAXTeQQQdlTHNqsYDRB2OsaA7F+NXcWEkcV+uud79OZe
         XKANRY4I7bT6ICl9h1irK1yBNesz9SRqRzor5jSMtuOJUSEBqwDml9bC7o8f5TjKJGc+
         CaFjtcJSCo57Ubw1VM77i48P6bDBgguo6vMKntJrXLlsFe6tONLJY1FOSn+RJUkCQq/y
         EKYhZhG8GDqbqnK5QQJKPPxq9uNruRp/qB9cAdPipnOyJKgxiUSpICGDR3aBSDLZzeHv
         0f6aj37JLK7IyGr2wr1zlhQHKZbpGDvLIfCNFDhsX9g909uoqGp7+aJ+8R6MGi2SaZPB
         qHlQ==
X-Gm-Message-State: ABy/qLaK0BoDwOOItQ5H6Nv/aR9SSqTaswJw3YJFNCIfjrxscZiO49bZ
        JgjKDZY8Hg+QczN/I0PrifTBkQ==
X-Google-Smtp-Source: APBJJlEQ56WLGrt67F0epM2MytRHTKau3I6Ew1h+D6xetubMMeQ1wj68PFO/tnppTDhXOMB2EaKmOA==
X-Received: by 2002:a05:6512:280d:b0:4fb:18f4:4cd4 with SMTP id cf13-20020a056512280d00b004fb18f44cd4mr2161674lfb.55.1688121199585;
        Fri, 30 Jun 2023 03:33:19 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b003fbb06af219sm6875419wmm.32.2023.06.30.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 03:33:18 -0700 (PDT)
Message-ID: <972b7cc7-77de-e332-ba41-b96c01dc7939@linaro.org>
Date:   Fri, 30 Jun 2023 13:33:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v4 1/7] drm: Introduce solid fill DRM plane property
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
 <20230404-solid-fill-v4-1-f4ec0caa742d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230404-solid-fill-v4-1-f4ec0caa742d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 03:25, Jessica Zhang wrote:
> Document and add support for solid_fill property to drm_plane. In
> addition, add support for setting and getting the values for solid_fill.
> 
> To enable solid fill planes, userspace must assign a property blob to
> the "solid_fill" plane property containing the following information:
> 
> struct drm_solid_fill_info {
> 	u8 version;
> 	u32 r, g, b;
> };
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
>   drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_blend.c               | 33 +++++++++++++++++++
>   include/drm/drm_blend.h                   |  1 +
>   include/drm/drm_plane.h                   | 43 ++++++++++++++++++++++++
>   5 files changed, 141 insertions(+)

Also, I think the point which we missed up to now. Could you please add 
both new properties to dri/N/state debugfs?

-- 
With best wishes
Dmitry

