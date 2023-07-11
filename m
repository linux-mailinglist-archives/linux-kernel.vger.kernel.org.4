Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D0F74FAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGKWT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKWT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:19:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B910DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:19:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so100376711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689113963; x=1691705963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5q1KrjOHXjT68Y0PaVbVveaMBA+COJ1l8a0LXRUu520=;
        b=gd9Om2oTt4fCPEtYkeiyxFlIDMTo1FumrjkynH6jqrvdcW3mvV3HBKK8B2Z4nEGEJ4
         ylgBeYb9xIbTHHUFDI004O/SJNdUyQskQHhWknDVWmHBGJgm5TEYJIoSanRR4CDmhYNN
         jPIMhBf4JSdVXkqF2pfMFhm+J0urwFsgQWdl2Q7x/69clT5YRhq97mUQ9cEYmlZRycqW
         Nd1cUNbwaHIFhxS88NwYYlMKz68ENqSHzdxvBnCQ9fK93stJ1v3//ZQIFbk2WaQQ8RsV
         rE6NBxuiWHXlDW7qa48lubFiMPYK1sjW4bz8n8OdLHAvIk0C8zDQtC0jz8vb5sXSKsG8
         BeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689113963; x=1691705963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5q1KrjOHXjT68Y0PaVbVveaMBA+COJ1l8a0LXRUu520=;
        b=HvLc/9ps7lHs/EjJAF7ydl20xzP+0GkAMLgqu06w60d82nLWy79TBMcPgJ9NCS8t68
         uuwzJ/Q3me6f0pM3jz74fjHFEjrNNmxQyItc3e3zZwdctLcQQdAXt1CnFPT8ow6Ud4+9
         cacMmIbqFmB47HznRqmgG4Rjp+eRy9w3dWfMm6a22NXpYw0jHf0U+03MVoj7FHKm8IpQ
         +x0Mn9ojbGa/wBWNiUShP8erf8eBQrApftL3XwBrl/u963JstVf+8+/NW2jRPHrTViwW
         BDUGSoLUz53J2ghkQKLfNrSC0AoWy7ayQQFzNuT0bbsCT3muumEO37iY6A0b820kW0PR
         Vz5w==
X-Gm-Message-State: ABy/qLbcqyPSwHEzBnIj/ptbnYH8xBjz8at7hEX2NRXHPuNQqefzikRA
        HpytSU+7RxdcQTCr4TBSXjV/yw==
X-Google-Smtp-Source: APBJJlFpcD/UoHhzXSzKq1S+oRrlXgyKj4ujiUr7kye+kXhPCSmvqBUFf+bUEdnKtddza9VkwuDFBw==
X-Received: by 2002:a2e:7e02:0:b0:2b7:7ab:3c60 with SMTP id z2-20020a2e7e02000000b002b707ab3c60mr13752134ljc.32.1689113963153;
        Tue, 11 Jul 2023 15:19:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j23-20020a2e8017000000b002b6daf32c7csm630129ljg.97.2023.07.11.15.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 15:19:22 -0700 (PDT)
Message-ID: <916d6b67-0f37-3814-4a15-d4a6fd6891ab@linaro.org>
Date:   Wed, 12 Jul 2023 01:19:22 +0300
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
 <e17db728-d91b-a2b3-08a9-1dd1fde9c727@linaro.org>
 <53ca10d5-c1e0-285a-30b9-4e9a2a1b70c9@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <53ca10d5-c1e0-285a-30b9-4e9a2a1b70c9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 01:07, Jessica Zhang wrote:
> 
> 
> On 7/10/2023 1:11 PM, Dmitry Baryshkov wrote:
>> On 10/07/2023 22:51, Jessica Zhang wrote:
>>>
>>>
>>> On 6/30/2023 1:27 AM, Pekka Paalanen wrote:
>>>> On Fri, 30 Jun 2023 03:42:28 +0300
>>>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>>> On 30/06/2023 03:25, Jessica Zhang wrote:
>>>>>> Add support for pixel_source property to drm_plane and related
>>>>>> documentation.
>>>>>>
>>>>>> This enum property will allow user to specify a pixel source for the
>>>>>> plane. Possible pixel sources will be defined in the
>>>>>> drm_plane_pixel_source enum.
>>>>>>
>>>>>> The current possible pixel sources are DRM_PLANE_PIXEL_SOURCE_FB and
>>>>>> DRM_PLANE_PIXEL_SOURCE_COLOR. The default value is *_SOURCE_FB.
>>>>>
>>>>> I think, this should come before the solid fill property addition. 
>>>>> First
>>>>> you tell that there is a possibility to define other pixel sources, 
>>>>> then
>>>>> additional sources are defined.
>>>>
>>>> Hi,
>>>>
>>>> that would be logical indeed.
>>>
>>> Hi Dmitry and Pekka,
>>>
>>> Sorry for the delay in response, was out of office last week.
>>>
>>> Acked.
>>>
>>>>
>>>>>>
>>>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/drm_atomic_state_helper.c |  1 +
>>>>>>    drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++
>>>>>>    drivers/gpu/drm/drm_blend.c               | 81 
>>>>>> +++++++++++++++++++++++++++++++
>>>>>>    include/drm/drm_blend.h                  |  2 +
>>>>>>    include/drm/drm_plane.h                  | 21 ++++++++
>>>>>>    5 files changed, 109 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c 
>>>>>> b/drivers/gpu/drm/drm_atomic_state_helper.c
>>>>>> index fe14be2bd2b2..86fb876efbe6 100644
>>>>>> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
>>>>>> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
>>>>>> @@ -252,6 +252,7 @@ void 
>>>>>> __drm_atomic_helper_plane_state_reset(struct drm_plane_state 
>>>>>> *plane_state,
>>>>>>        plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
>>>>>>        plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>>>>>> +    plane_state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
>>>>>>        if (plane_state->solid_fill_blob) {
>>>>>>            drm_property_blob_put(plane_state->solid_fill_blob);
>>>>>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c 
>>>>>> b/drivers/gpu/drm/drm_atomic_uapi.c
>>>>>> index a28b4ee79444..6e59c21af66b 100644
>>>>>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>>>>>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>>>>>> @@ -596,6 +596,8 @@ static int 
>>>>>> drm_atomic_plane_set_property(struct drm_plane *plane,
>>>>>>            drm_property_blob_put(solid_fill);
>>>>>>            return ret;
>>>>>> +    } else if (property == plane->pixel_source_property) {
>>>>>> +        state->pixel_source = val;
>>>>>>        } else if (property == plane->alpha_property) {
>>>>>>            state->alpha = val;
>>>>>>        } else if (property == plane->blend_mode_property) {
>>>>>
>>>>> I think, it was pointed out in the discussion that drm_mode_setplane()
>>>>> (a pre-atomic IOCTL to turn the plane on and off) should also reset
>>>>> pixel_source to FB.
>>>
>>> I don't remember drm_mode_setplane() being mentioned in the 
>>> pixel_source discussion... can you share where it was mentioned?
>>
>> https://lore.kernel.org/dri-devel/20230627105849.004050b3@eldfell/
>>
>> Let me quote it here:
>> "Legacy non-atomic UAPI wrappers can do whatever they want, and program
>> any (new) properties they want in order to implement the legacy
>> expectations, so that does not seem to be a problem."
>>
>>
>>>
>>> I'd prefer to avoid having driver change the pixel_source directly as 
>>> it could cause some unexpected side effects. In general, I would like 
>>> userspace to assign the value of pixel_source without driver doing 
>>> anything "under the hood".
>>
>> s/driver/drm core/
>>
>> We have to remain compatible with old userspace, especially with the 
>> non-atomic one. If the userspace calls ioctl(DRM_IOCTL_MODE_SETPLANE), 
>> we have to display the specified FB, no matter what was the value of 
>> PIXEL_SOURCE before this ioctl.
> 
> 
> Got it, thanks the clarification -- I see your point.
> 
> I'm already setting plane_state->pixel_source to FB in 
> __drm_atomic_helper_plane_reset() and it seems to me that all drivers 
> are calling that within their respective plane_funcs->reset().
> 
> Since (as far as I know) reset() is being called for both the atomic and 
> non-atomic paths, shouldn't that be enough to default pixel_source to FB 
> for old userspace?

No, this will not clean up the state between userspace apps. Currently 
the rule is simple: call DRM_IOCTL_MODE_SETPLANE, get the image from FB 
displayed. We should keep it so.

>>>
>>>>>
>>>>>> @@ -671,6 +673,8 @@ drm_atomic_plane_get_property(struct drm_plane 
>>>>>> *plane,
>>>>>>        } else if (property == plane->solid_fill_property) {
>>>>>>            *val =state->solid_fill_blob ?
>>>>>>                state->solid_fill_blob->base.id : 0;
>>>>>> +    } else if (property == plane->pixel_source_property) {
>>>>>> +        *val = state->pixel_source;
>>>>>>        } else if (property == plane->alpha_property) {
>>>>>>            *val =state->alpha;
>>>>>>        } else if (property == plane->blend_mode_property) {
>>>>>> diff --git a/drivers/gpu/drm/drm_blend.c 
>>>>>> b/drivers/gpu/drm/drm_blend.c
>>>>>> index 38c3c5d6453a..8c100a957ee2 100644
>>>>>> --- a/drivers/gpu/drm/drm_blend.c
>>>>>> +++ b/drivers/gpu/drm/drm_blend.c
>>>>>> @@ -189,6 +189,18 @@
>>>>>>     *    solid_fill is set up with 
>>>>>> drm_plane_create_solid_fill_property(). It
>>>>>>     *    contains pixel data that drivers can use to fill a plane.
>>>>>>     *
>>>>>> + * pixel_source:
>>>>>> + *    pixel_source is set up with 
>>>>>> drm_plane_create_pixel_source_property().
>>>>>> + *    It is used to toggle the source of pixel data for the plane.
>>>>
>>>> Other sources than the selected one are ignored?
>>>
>>> Yep, the plane will only display the data from the set pixel_source.
>>>
>>> So if pixel_source == FB and solid_fill_blob is non-NULL, 
>>> solid_fill_blob will be ignored and the plane will display the FB 
>>> that is set.
>>
>> correct.
>>
>>>
>>> Will add a note about this in the comment docs.
>>>
>>>>
>>>>>> + *
>>>>>> + *    Possible values:
>>>>
>>>> Wouldn't hurt to explicitly mention here that this is an enum.
>>>
>>> Acked.
>>>
>>>>
>>>>>> + *
>>>>>> + *    "FB":
>>>>>> + *        Framebuffer source
>>>>>> + *
>>>>>> + *    "COLOR":
>>>>>> + *        solid_fill source
>>>>
>>>> I think these two should be more explicit. Framebuffer source is the
>>>> usual source from the property "FB_ID". Solid fill source comes from
>>>> the property "solid_fill".
>>>
>>> Acked.
>>>
>>>>
>>>> Why "COLOR" and not, say, "SOLID_FILL"?
>>>
>>> Ah, that would make more sense :)
>>>
>>> I'll change this to "SOLID_FILL".
>>>
>>>>
>>>>>> + *
>>>>>>     * Note that all the property extensions described here apply 
>>>>>> either to the
>>>>>>     * plane or the CRTC (e.g. for the background color, which 
>>>>>> currently is not
>>>>>>     * exposed and assumed to be black).
>>>>>> @@ -648,3 +660,72 @@ int 
>>>>>> drm_plane_create_solid_fill_property(struct drm_plane *plane)
>>>>>>        return 0;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL(drm_plane_create_solid_fill_property);
>>>>>> +
>>>>>> +/**
>>>>>> + * drm_plane_create_pixel_source_property - create a new pixel 
>>>>>> source property
>>>>>> + * @plane: drm plane
>>>>>> + * @supported_sources: bitmask of supported pixel_sources for the 
>>>>>> driver (NOT
>>>>>> + *                     including DRM_PLANE_PIXEL_SOURCE_FB, as it 
>>>>>> will be supported
>>>>>> + *                     by default).
>>>>>
>>>>> I'd say this is too strong. I'd suggest either renaming this to
>>>>> extra_sources (mentioning that FB is enabled for all the planes) or
>>>>> allowing any source bitmask (mentioning that FB should be enabled 
>>>>> by the
>>>>> caller, unless there is a good reason not to do so).
>>>>
>>>> Right. I don't see any problem with having planes of type OVERLAY that
>>>> support only solid_fill and no FB. Planes of type PRIMARY and CURSOR I
>>>> would expect to always support at least FB.
>>>>
>>>> Atomic userspace is prepared to have an OVERLAY plane fail for any
>>>> arbitrary reason. Legacy userspace probably should not ever see a plane
>>>> that does not support FB.
>>>
>>> Got it... If we allow the possibility of FB sources not being 
>>> supported, then should the default pixel_source per plane be decided 
>>> by the driver too?
>>>
>>> I'd forced FB support so that I could set pixel_source to FB in 
>>> __drm_atomic_helper_plane_state_reset(). If we allow more flexibility 
>>> in the default pixel_source value, I guess we can also store a 
>>> default_pixel_source value in the plane_state.
>>
>> I'd say, the FB is a sane default. It the driver has other needs, it 
>> can override the value in drm_plane_funcs::reset().
>>
>>>
>>
>> [skipped the rest]
>>
>> -- 
>> With best wishes
>> Dmitry
>>

-- 
With best wishes
Dmitry

