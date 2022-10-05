Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0555F5B65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJEVGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJEVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:06:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E9696FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:06:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so13800060lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=g/6Eb24mLOHxVf5br9TYfEyQgn2xtXKbaRQwdcgrBWE=;
        b=ydHf7b4pv/lloQfbQYXuB6/nLWEhbNzNPzOrJF1g2ECmNf0aiXANzcv6EcYm7R4zuO
         11/V0LLM6rGIY28B487cJ3P58jKcJwCnhlaGDhXPANqNewJcnRYSQulYs0zSHXkVrWyR
         FfwQp2JpltwJ1V4W9elwWijoJx6FGvILWUhD7A5E3joa7glAhZrZdE0ohSEMkfsd0XWm
         wNj/V6AxjrodYiyqxJWV7LGRgGXgvXqp5pT2+HdRPvSh7XF5NWhSuM5Y/UMUMSdWffeZ
         k1CLMqsHIgW8ZqSAfiXyx3X3xAzMeWzcowJwRZ4neN77AHFiyVwDtZtWzUoh7U+6ee+V
         viDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=g/6Eb24mLOHxVf5br9TYfEyQgn2xtXKbaRQwdcgrBWE=;
        b=nY7D23wyMytmQVWGUsxGnjd/Sn3mBuXSfYevYndSNCW6SS9Eph38NJ7bmNBmuYqn7P
         m06hLTpwbDYWDNcmN9/eEJCPX+GY6jn9Adab9QpRpwhoR/E4enFU6G9riId4kt+wg0FQ
         2vjuUcjPczx5FbO31FcA0STDZXFS2HPL6R1dOWr1wnMdQp/RlLrEOA3o77L5CwO0mK3U
         +N5io/80VMFWHi8S2IKPqamom7/8l4p4VFQeHr+Z9UO9r32sT/cbk0Fyk7I82ph/S9sP
         Ii1kA+0ruqTRgWlR40/G0uptZZxL91S4SaAWr1ac/dnAPYucxzVtK2I1yZVxOcc8I6qE
         2DQQ==
X-Gm-Message-State: ACrzQf3w9glbMf6W3+kL9SSiYR1cnQjLzE8IXATZf+LHU6oen5iMmzdN
        IoIK9Zkm/awk7482jWY+qSHL+w==
X-Google-Smtp-Source: AMsMyM4e3qCLNZIcQ/19N9mQ0AcklxWtG1BSsl2+/ZmiVo6WOVAX0/IW4/v+5/Z8xp/8UxK/2ZTBhQ==
X-Received: by 2002:ac2:4c18:0:b0:4a2:6dbd:97d7 with SMTP id t24-20020ac24c18000000b004a26dbd97d7mr576117lfq.144.1665004000544;
        Wed, 05 Oct 2022 14:06:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bi9-20020a0565120e8900b0049a6a5d8ec4sm2459242lfb.188.2022.10.05.14.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:06:40 -0700 (PDT)
Message-ID: <14809708-df0b-1003-3f31-4f856b10d600@linaro.org>
Date:   Thu, 6 Oct 2022 00:06:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 5/7] drm/msm/dsi: Account for DSC's bits_per_pixel
 having 4 fractional bits
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
References: <20221005181657.784375-1-marijn.suijten@somainline.org>
 <20221005181657.784375-6-marijn.suijten@somainline.org>
 <CAA8EJpr=0w0KReqNW2jP8DzvXLgo_o6bKmwMOed2sXb6d8HKhg@mail.gmail.com>
 <20221005205845.rwkzyit4daizi3z4@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221005205845.rwkzyit4daizi3z4@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 23:58, Marijn Suijten wrote:
> On 2022-10-05 22:31:43, Dmitry Baryshkov wrote:
>> On Wed, 5 Oct 2022 at 21:17, Marijn Suijten
>> <marijn.suijten@somainline.org> wrote:
>>>
>>> drm_dsc_config's bits_per_pixel field holds a fractional value with 4
>>> bits, which all panel drivers should adhere to for
>>> drm_dsc_pps_payload_pack() to generate a valid payload.  All code in the
>>> DSI driver here seems to assume that this field doesn't contain any
>>> fractional bits, hence resulting in the wrong values being computed.
>>> Since none of the calculations leave any room for fractional bits or
>>> seem to indicate any possible area of support, disallow such values
>>> altogether.
>>>
>>> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 25 +++++++++++++++++--------
>>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>> index f42794cdd4c1..4717d49d76be 100644
>>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>> @@ -33,7 +33,7 @@
>>>
>>>   #define DSI_RESET_TOGGLE_DELAY_MS 20
>>>
>>> -static int dsi_populate_dsc_params(struct drm_dsc_config *dsc);
>>> +static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc_config *dsc);
>>>
>>>   static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
>>>   {
>>> @@ -908,6 +908,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>>          u32 va_end = va_start + mode->vdisplay;
>>>          u32 hdisplay = mode->hdisplay;
>>>          u32 wc;
>>> +       int ret;
>>>
>>>          DBG("");
>>>
>>> @@ -943,7 +944,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>>                  /* we do the calculations for dsc parameters here so that
>>>                   * panel can use these parameters
>>>                   */
>>> -               dsi_populate_dsc_params(dsc);
>>> +               ret = dsi_populate_dsc_params(msm_host, dsc);
>>> +               if (ret)
>>> +                       return;
>>>
>>>                  /* Divide the display by 3 but keep back/font porch and
>>>                   * pulse width same
>>> @@ -1769,7 +1772,7 @@ static char bpg_offset[DSC_NUM_BUF_RANGES] = {
>>>          2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
>>>   };
>>>
>>> -static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>>> +static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc_config *dsc)
>>>   {
>>>          int mux_words_size;
>>>          int groups_per_line, groups_total;
>>> @@ -1780,6 +1783,12 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>>>          int data;
>>>          int final_value, final_scale;
>>>          int i;
>>> +       u16 bpp = dsc->bits_per_pixel >> 4;
>>> +
>>> +       if (dsc->bits_per_pixel & 0xf) {
>>> +               DRM_DEV_ERROR(&msm_host->pdev->dev, "DSI does not support fractional bits_per_pixel\n");
>>> +               return -EINVAL;
>>> +       }
>>>
>>>          dsc->rc_model_size = 8192;
>>>          dsc->first_line_bpg_offset = 12;
>>> @@ -1801,7 +1810,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>>>          }
>>>
>>>          dsc->initial_offset = 6144; /* Not bpp 12 */
>>> -       if (dsc->bits_per_pixel != 8)
>>> +       if (bpp != 8)
>>>                  dsc->initial_offset = 2048;     /* bpp = 12 */
>>>
>>>          mux_words_size = 48;            /* bpc == 8/10 */
>>> @@ -1824,14 +1833,14 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>>>           * params are calculated
>>>           */
>>>          groups_per_line = DIV_ROUND_UP(dsc->slice_width, 3);
>>> -       dsc->slice_chunk_size = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8);
>>> +       dsc->slice_chunk_size = DIV_ROUND_UP(dsc->slice_width * bpp, 8);
>>
>> I'd still prefer if we can get closer to drm_dsc_compute_rc_parameters().
>> The mentioned function has the following code:
>>
>> vdsc_cfg->slice_chunk_size = DIV_ROUND_UP(vdsc_cfg->slice_width *
>>
>> vdsc_cfg->bits_per_pixel,
>>                                                            (8 * 16));
> 
> Fwiw this discussion happened in dsi_update_dsc_timing() where a similar
> calculation was the sole user of bits_per_pixel.  This function,
> dsi_populate_dsc_params(), has more uses of bits_per_pixel so it made
> more sense to compute and document this "discrepancy" up front.
> drm_dsc_compute_rc_parameters() doesn't document where this "16" comes
> from, unfortunately (requiring knowledge of the contents of the struct).
> 
>> In fact, could you please take a look if we can switch to using this
>> function and drop our code?
> 
> There's alread a:
> 
> 	/* FIXME: need to call drm_dsc_compute_rc_parameters() so that rest of
> 	 * params are calculated
> 	 */
> 
> And it was trivial to replace everything below that comment with this
> function call; I have not checked the math in detail but it assigns
> _every_ field that was also assigned here, and the resulting values
> provide an identical DCS PPS (which I happened to be printing to compare
> to downstream, leading to find all the issues solved in this series) and
> working phone screen.
> 
> Makes me wonder why this wasn't caught in review and replaced from the
> get-go...

Good question. Partially it was because everybody wanted to get DSC 
support in to unblock other features. Thus DSC supporting code received 
several bumps afterwards.

> Do you want me to do this in a v3, before applying this fractional-bits
> fix?  At that point this becomes the only user of bits_per_pixel:

Yes, please. This sounds like a perfect solution.

> 
> 	dsc->initial_offset = 6144; /* Not bpp 12 */
> 	if (bpp != 8)
> 		dsc->initial_offset = 2048;	/* bpp = 12 */
> 
> Note that intel_vdsc.c has the exact same code right where they fill
> vdsc_cfg->initial_offset:
> 
> 	int bpp = vdsc_cfg->bits_per_pixel >> 4;
> 
> I'm inclined to leave this as it is.
> 
> - Marijn

-- 
With best wishes
Dmitry

