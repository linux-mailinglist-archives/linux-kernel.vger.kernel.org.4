Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCD6F221F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347278AbjD2Bfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjD2Bfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:35:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE372134
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:35:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so3021245e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682732141; x=1685324141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxRlt7xFBtroIE2klrBllvLJLQfgkFj7/E1EFBuveSs=;
        b=OwGnDdNkSUZrbP5R/E0/iv3d9+3hudriAg7vwXDig95tEGKmMyTCA6efi9YuE3PXXs
         /fFdMxziFmVkgE80HxQ73MEriLaT2fEgviSgUdz1FnECPh2X1WVOemzCUZapyl1JeFMN
         dHLoDktcG/0z2GJTIZVUGbCAFvKhJcF5hB2RfAz9K8HCW9L43UzJ9ZpUSsOIXjQcAMrB
         7TEtm4+ux6PpBsSfsPapIMebvJoP6uxgD7xgcUpBxzh7WO+trhKj7KPfVfRxkDPXvWrB
         5T56w9wWOr900CBxcPSUg3Rhj1jGxHFEiYsG8Nwxw0kG8vyOYjiuUhpdYf7JfYjNnu9l
         MmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682732141; x=1685324141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxRlt7xFBtroIE2klrBllvLJLQfgkFj7/E1EFBuveSs=;
        b=jjmReMVFt4AxSi/QnEa1xWldhgadDFWu0vWw+04FLkasHgjbLAQVmBj1xfZkLrSlXn
         ve1SylzLLLgr1QapEUMNKESYcjIiFVEXIGWOxT/OsLh7jFytq/ggtp+/vKuoPf4UcWNf
         hjR48Yfu/LOjwjdQP2zFm0qwXR5I6+ZwC6dgUydwFMbXwAY3PgE7JP7VWWgIr6W+MuGf
         pWqbtnYPK82GDqWayXQSTt0/D9mnogy0TtnmvdzKx8Zi1a3I4/lTuktaS3OD8hyl9wpR
         xzmXawocpr0jTfPeXdRSLBJesh9xmrCC0dPhSuhFuC8ijNqxu+h0DshrnoDZTzObcooP
         cO3A==
X-Gm-Message-State: AC+VfDwmluz0t4TH/kFGhjmeVmH9y3WUYob0wDk7O57E5E2Lo/APd3OQ
        8vB/Tddy8su8xbq+jKlyfIz7nQ==
X-Google-Smtp-Source: ACHHUZ6nVeyKUSGK2CwwUVUNM1Cfs2Oq/SHdoPsCwiM5ncvxYkxl4dzZzo5OIWJw5kH8gQmGUqF3Cg==
X-Received: by 2002:a05:600c:2242:b0:3eb:39e0:3530 with SMTP id a2-20020a05600c224200b003eb39e03530mr5033110wmm.41.1682732140896;
        Fri, 28 Apr 2023 18:35:40 -0700 (PDT)
Received: from [10.6.148.94] ([212.140.138.218])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b003f0aa490336sm29042322wmc.26.2023.04.28.18.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 18:35:40 -0700 (PDT)
Message-ID: <f4884e43-f21e-13a6-65f5-623c101cb823@linaro.org>
Date:   Sat, 29 Apr 2023 04:35:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 7/7] drm/msm/dpu: calculate DSC encoder parameters
 dynamically
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
 <1682725511-18185-8-git-send-email-quic_khsieh@quicinc.com>
 <51edf131-8fe0-2187-a4ba-744cc0c81a99@linaro.org>
 <def3011f-d8e7-3090-47f2-ec13a650337e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <def3011f-d8e7-3090-47f2-ec13a650337e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 04:22, Abhinav Kumar wrote:
> 
> 
> On 4/28/2023 5:52 PM, Dmitry Baryshkov wrote:
>> On 29/04/2023 02:45, Kuogee Hsieh wrote:
>>> During DSC preparation, add run time calculation to figure out what
>>> usage modes, split mode and merge mode, is going to be setup.
>>
>> This patch doesn't determine the mode. It changes programming of DSC 
>> bits according to the mode being selected.
>>
> 
> The term mode is a bit confusing here but he is referring to 
> dsc_common_mode.

Yes, that's clear. The patch description is not correct.

> 
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 56 
>>> ++++++++++++++++-------------
>>>   1 file changed, 31 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> index 2fdacf1..3d18642 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> @@ -529,17 +529,9 @@ void dpu_encoder_helper_split_config(
>>>   bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>>>   {
>>>       struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>>> -    int i, intf_count = 0, num_dsc = 0;
>>> +    struct msm_display_topology *topology = &dpu_enc->topology;
>>> -    for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
>>> -        if (dpu_enc->phys_encs[i])
>>> -            intf_count++;
>>> -
>>> -    /* See dpu_encoder_get_topology, we only support 2:2:1 topology */
>>> -    if (dpu_enc->dsc)
>>> -        num_dsc = 2;
>>> -
>>> -    return (num_dsc > 0) && (num_dsc > intf_count);
>>> +    return (topology->num_dsc > topology->num_intf);
>>>   }
>>>   static void dpu_encoder_get_topology(
>>> @@ -1861,41 +1853,55 @@ static void dpu_encoder_prep_dsc(struct 
>>> dpu_encoder_virt *dpu_enc,
>>>       struct dpu_encoder_phys *enc_master = dpu_enc->cur_master;
>>>       struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
>>>       struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
>>> -    int this_frame_slices;
>>> +    struct msm_display_topology *topology = &dpu_enc->topology;
>>>       int intf_ip_w, enc_ip_w;
>>> -    int dsc_common_mode;
>>> -    int pic_width;
>>> +    int dsc_common_mode = 0;
>>
>> Please don't top-init variables unless required (or unless they are 
>> constant).
>>
>>>       u32 initial_lines;
>>> +    int num_dsc = topology->num_dsc;
>>> +    int num_intf = topology->num_intf;
>>>       int i;
>>> -    for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
>>> +    for (i = 0; i < num_dsc; i++) {
>>>           hw_pp[i] = dpu_enc->hw_pp[i];
>>>           hw_dsc[i] = dpu_enc->hw_dsc[i];
>>>           if (!hw_pp[i] || !hw_dsc[i]) {
>>>               DPU_ERROR_ENC(dpu_enc, "invalid params for DSC\n");
>>>               return;
>>> -        }
>>> +        }
>>
>> What is the difference here?
>>
>>>       }
>>> -    dsc_common_mode = 0;
>>> -    pic_width = dsc->pic_width;
>>> +    intf_ip_w = dsc->pic_width;
>>> -    dsc_common_mode = DSC_MODE_MULTIPLEX | DSC_MODE_SPLIT_PANEL;
>>>       if (enc_master->intf_mode == INTF_MODE_VIDEO)
>>>           dsc_common_mode |= DSC_MODE_VIDEO;
>>> -    this_frame_slices = pic_width / dsc->slice_width;
>>> -    intf_ip_w = this_frame_slices * dsc->slice_width;
>>> -
>>>       /*
>>> -     * dsc merge case: when using 2 encoders for the same stream,
>>> -     * no. of slices need to be same on both the encoders.
>>> +     * If this encoder is driving more than one DSC encoder, they
>>> +     * operate in tandem, same pic dimension needs to be used by
>>> +     * each of them.(pp-split is assumed to be not supported)
>>> +     *
>>
>> Extra empty line. Also the comment doesn't make sense here anymore. We 
>> already have comment for the division by two below.
>>
>>>        */
>>> -    enc_ip_w = intf_ip_w / 2;
>>> +    enc_ip_w = intf_ip_w;
>>> +
>>> +    intf_ip_w /= num_intf;
>>> +
>>> +    if (num_dsc > 1)
>>> +        dsc_common_mode |= DSC_MODE_SPLIT_PANEL;
>>> +
>>> +    if (dpu_encoder_use_dsc_merge(&dpu_enc->base)) {
>>> +        dsc_common_mode |= DSC_MODE_MULTIPLEX;
>>> +        /*
>>> +         * in dsc merge case: when using 2 encoders for the same
>>> +         * stream, no. of slices need to be same on both the
>>> +         * encoders.
>>> +         */
>>> +        enc_ip_w = intf_ip_w / 2;
>>> +    }
>>> +
>>>       initial_lines = dpu_encoder_dsc_initial_line_calc(dsc, enc_ip_w);
>>> -    for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
>>> +    for (i = 0; i < num_dsc; i++)
>>>           dpu_encoder_dsc_pipe_cfg(dpu_enc, hw_dsc[i], hw_pp[i], dsc,
>>>                       dsc_common_mode, initial_lines);
>>>   }
>>

-- 
With best wishes
Dmitry

