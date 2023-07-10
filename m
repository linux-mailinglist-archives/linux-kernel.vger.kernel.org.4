Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DD74DEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGJULj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGJULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:11:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFE92
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:11:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f954d7309fso6108160e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689019894; x=1691611894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63YPDYqKVHA/21Ij1dK8gns5R7NZnbig472At5QRpgU=;
        b=E5N+9eb9VAzhgj2ZYKsctyy6Vz8TFAO+5Sz2nNRXr/jOJR8EGjAA8CAuyBWebysnr6
         pR2zgH426vzjVnzzTZChr+PWfniXXxaJbCZDz2PsQguwuGvjkT0dxU2XbuZXVJzwL3bC
         oAy66hFGaoIJYmkk3B4p2jbNwXgq5Llhb2cm7xDGmuLQH9103Zm+/fWvi8G5vg/yfQOW
         oH7zdYIw27C+WuYzhAIXKAEObGhnGIraP7Zdv/BGuZGz2CNvT6Eg8FQesDKAACVFVnfN
         mZo/a/iiYgXT+EdC6PFqlYwVx8WL4WCJFkz7rUaoyXeAB3o/hd/nY8wF3qfPyHTQdFrE
         eDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019894; x=1691611894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63YPDYqKVHA/21Ij1dK8gns5R7NZnbig472At5QRpgU=;
        b=Zp2vKBf3K2/rs3rNvqp7kL8OA+vRfhxSO1e+oN2HW1ZS9TMOMLzZATOmO1eF69olEo
         BynRtLbEMpiZKc/tA3CU0VxyOIsxpaYWx+sTAmS9IH+PDK06+hbC7meI9Q0pfsslMRS8
         2W4ENpCjRFHQixCYHxjrghzb6Gid7BDiiK/jeNcl0wPPy1fvjhIReUWGxfw0fF50sgCe
         09ecTWqOl6w6szFF7h4TslVjKszi61INbMVa59MZt22bgUPFGW+pUxXE5TeV40ivziK/
         F7IHOojDbH7SUMSGgtdfAMDGtDwO+wQMJ6Nc0Ve7F2nUD01JreQLJJjQk7A9f6M56rUy
         YIIg==
X-Gm-Message-State: ABy/qLZo1r8prooKPjbpMEVXbA1EG6TQCO7YYFMkLs6N7d5XcC147P0z
        KMqxHt4kR69C3lh3WMf6JXdr3g==
X-Google-Smtp-Source: APBJJlFLoMG2x7TKa+tE+UsW2e9G6ohcfl0sTmI2Gsdp4Rb+BaoHJaomgBaKIJKM+eosP5hLuRQvjw==
X-Received: by 2002:a05:6512:6c5:b0:4f8:7041:e46a with SMTP id u5-20020a05651206c500b004f87041e46amr6288046lff.18.1689019893816;
        Mon, 10 Jul 2023 13:11:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u13-20020ac2518d000000b004fbb1f70ceesm32513lfi.227.2023.07.10.13.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 13:11:33 -0700 (PDT)
Message-ID: <e17db728-d91b-a2b3-08a9-1dd1fde9c727@linaro.org>
Date:   Mon, 10 Jul 2023 23:11:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC v4 2/7] drm: Introduce pixel_source DRM plane property
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, contact@emersion.fr,
        laurent.pinchart@ideasonboard.com, sebastian.wick@redhat.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
 <20230404-solid-fill-v4-2-f4ec0caa742d@quicinc.com>
 <6e3eec49-f798-ff91-8b4d-417d31089296@linaro.org>
 <20230630112708.4d3a08a7@eldfell>
 <eb78b4d6-6da2-1cb5-5fab-01d7bf233111@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <eb78b4d6-6da2-1cb5-5fab-01d7bf233111@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 22:51, Jessica Zhang wrote:
> 
> 
> On 6/30/2023 1:27 AM, Pekka Paalanen wrote:
>> On Fri, 30 Jun 2023 03:42:28 +0300
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>>
>>> On 30/06/2023 03:25, Jessica Zhang wrote:
>>>> Add support for pixel_source property to drm_plane and related
>>>> documentation.
>>>>
>>>> This enum property will allow user to specify a pixel source for the
>>>> plane. Possible pixel sources will be defined in the
>>>> drm_plane_pixel_source enum.
>>>>
>>>> The current possible pixel sources are DRM_PLANE_PIXEL_SOURCE_FB and
>>>> DRM_PLANE_PIXEL_SOURCE_COLOR. The default value is *_SOURCE_FB.
>>>
>>> I think, this should come before the solid fill property addition. First
>>> you tell that there is a possibility to define other pixel sources, then
>>> additional sources are defined.
>>
>> Hi,
>>
>> that would be logical indeed.
> 
> Hi Dmitry and Pekka,
> 
> Sorry for the delay in response, was out of office last week.
> 
> Acked.
> 
>>
>>>>
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_atomic_state_helper.c |  1 +
>>>>    drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++
>>>>    drivers/gpu/drm/drm_blend.c               | 81 
>>>> +++++++++++++++++++++++++++++++
>>>>    include/drm/drm_blend.h                   |  2 +
>>>>    include/drm/drm_plane.h                   | 21 ++++++++
>>>>    5 files changed, 109 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c 
>>>> b/drivers/gpu/drm/drm_atomic_state_helper.c
>>>> index fe14be2bd2b2..86fb876efbe6 100644
>>>> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
>>>> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
>>>> @@ -252,6 +252,7 @@ void 
>>>> __drm_atomic_helper_plane_state_reset(struct drm_plane_state 
>>>> *plane_state,
>>>>        plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
>>>>        plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>>>> +    plane_state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
>>>>        if (plane_state->solid_fill_blob) {
>>>>            drm_property_blob_put(plane_state->solid_fill_blob);
>>>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c 
>>>> b/drivers/gpu/drm/drm_atomic_uapi.c
>>>> index a28b4ee79444..6e59c21af66b 100644
>>>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>>>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>>>> @@ -596,6 +596,8 @@ static int drm_atomic_plane_set_property(struct 
>>>> drm_plane *plane,
>>>>            drm_property_blob_put(solid_fill);
>>>>            return ret;
>>>> +    } else if (property == plane->pixel_source_property) {
>>>> +        state->pixel_source = val;
>>>>        } else if (property == plane->alpha_property) {
>>>>            state->alpha = val;
>>>>        } else if (property == plane->blend_mode_property) {
>>>
>>> I think, it was pointed out in the discussion that drm_mode_setplane()
>>> (a pre-atomic IOCTL to turn the plane on and off) should also reset
>>> pixel_source to FB.
> 
> I don't remember drm_mode_setplane() being mentioned in the pixel_source 
> discussion... can you share where it was mentioned?

https://lore.kernel.org/dri-devel/20230627105849.004050b3@eldfell/

Let me quote it here:
"Legacy non-atomic UAPI wrappers can do whatever they want, and program
any (new) properties they want in order to implement the legacy
expectations, so that does not seem to be a problem."


> 
> I'd prefer to avoid having driver change the pixel_source directly as it 
> could cause some unexpected side effects. In general, I would like 
> userspace to assign the value of pixel_source without driver doing 
> anything "under the hood".

s/driver/drm core/

We have to remain compatible with old userspace, especially with the 
non-atomic one. If the userspace calls ioctl(DRM_IOCTL_MODE_SETPLANE), 
we have to display the specified FB, no matter what was the value of 
PIXEL_SOURCE before this ioctl.


> 
>>>
>>>> @@ -671,6 +673,8 @@ drm_atomic_plane_get_property(struct drm_plane 
>>>> *plane,
>>>>        } else if (property == plane->solid_fill_property) {
>>>>            *val = state->solid_fill_blob ?
>>>>                state->solid_fill_blob->base.id : 0;
>>>> +    } else if (property == plane->pixel_source_property) {
>>>> +        *val = state->pixel_source;
>>>>        } else if (property == plane->alpha_property) {
>>>>            *val = state->alpha;
>>>>        } else if (property == plane->blend_mode_property) {
>>>> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
>>>> index 38c3c5d6453a..8c100a957ee2 100644
>>>> --- a/drivers/gpu/drm/drm_blend.c
>>>> +++ b/drivers/gpu/drm/drm_blend.c
>>>> @@ -189,6 +189,18 @@
>>>>     *    solid_fill is set up with 
>>>> drm_plane_create_solid_fill_property(). It
>>>>     *    contains pixel data that drivers can use to fill a plane.
>>>>     *
>>>> + * pixel_source:
>>>> + *    pixel_source is set up with 
>>>> drm_plane_create_pixel_source_property().
>>>> + *    It is used to toggle the source of pixel data for the plane.
>>
>> Other sources than the selected one are ignored?
> 
> Yep, the plane will only display the data from the set pixel_source.
> 
> So if pixel_source == FB and solid_fill_blob is non-NULL, 
> solid_fill_blob will be ignored and the plane will display the FB that 
> is set.

correct.

> 
> Will add a note about this in the comment docs.
> 
>>
>>>> + *
>>>> + *    Possible values:
>>
>> Wouldn't hurt to explicitly mention here that this is an enum.
> 
> Acked.
> 
>>
>>>> + *
>>>> + *    "FB":
>>>> + *        Framebuffer source
>>>> + *
>>>> + *    "COLOR":
>>>> + *        solid_fill source
>>
>> I think these two should be more explicit. Framebuffer source is the
>> usual source from the property "FB_ID". Solid fill source comes from
>> the property "solid_fill".
> 
> Acked.
> 
>>
>> Why "COLOR" and not, say, "SOLID_FILL"?
> 
> Ah, that would make more sense :)
> 
> I'll change this to "SOLID_FILL".
> 
>>
>>>> + *
>>>>     * Note that all the property extensions described here apply 
>>>> either to the
>>>>     * plane or the CRTC (e.g. for the background color, which 
>>>> currently is not
>>>>     * exposed and assumed to be black).
>>>> @@ -648,3 +660,72 @@ int drm_plane_create_solid_fill_property(struct 
>>>> drm_plane *plane)
>>>>        return 0;
>>>>    }
>>>>    EXPORT_SYMBOL(drm_plane_create_solid_fill_property);
>>>> +
>>>> +/**
>>>> + * drm_plane_create_pixel_source_property - create a new pixel 
>>>> source property
>>>> + * @plane: drm plane
>>>> + * @supported_sources: bitmask of supported pixel_sources for the 
>>>> driver (NOT
>>>> + *                     including DRM_PLANE_PIXEL_SOURCE_FB, as it 
>>>> will be supported
>>>> + *                     by default).
>>>
>>> I'd say this is too strong. I'd suggest either renaming this to
>>> extra_sources (mentioning that FB is enabled for all the planes) or
>>> allowing any source bitmask (mentioning that FB should be enabled by the
>>> caller, unless there is a good reason not to do so).
>>
>> Right. I don't see any problem with having planes of type OVERLAY that
>> support only solid_fill and no FB. Planes of type PRIMARY and CURSOR I
>> would expect to always support at least FB.
>>
>> Atomic userspace is prepared to have an OVERLAY plane fail for any
>> arbitrary reason. Legacy userspace probably should not ever see a plane
>> that does not support FB.
> 
> Got it... If we allow the possibility of FB sources not being supported, 
> then should the default pixel_source per plane be decided by the driver 
> too?
> 
> I'd forced FB support so that I could set pixel_source to FB in 
> __drm_atomic_helper_plane_state_reset(). If we allow more flexibility in 
> the default pixel_source value, I guess we can also store a 
> default_pixel_source value in the plane_state.

I'd say, the FB is a sane default. It the driver has other needs, it can 
override the value in drm_plane_funcs::reset().

> 

[skipped the rest]

-- 
With best wishes
Dmitry

