Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215106EB3A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjDUVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjDUVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:31:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4A26A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 14:31:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2aa39ce5d26so14075391fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682112694; x=1684704694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BB/WE7LZaA1/Vs5ezQQVF1bVLfOPlPyiztA5xMMxinE=;
        b=aOr25wl73fUY388Fa0aRueT5u7yEQpF/ibKrcOEovjQxq+JOx0H71sQ7ZEFZGZ9gYb
         JEcCkCC/Xui/V2QhFNZqLubsKZck9qCGly+8LuIoILLSoFK83DyGScd0NNEvg26A55XE
         +esaS2t/hRdUQk4LlJG/fb+psdOURdMMlKSv9KkmUtITiVLTZbReht2un6e6AWt0sqIJ
         BJFLYADcLQ9H+ViZiEo0gv1jvarSanCrY9UPZDijz6rdAH/GxPRCcu2NbpFr8o6co+N+
         nOS7A4Ym4pX60/SAb2CVauQZeJRnW/nuPlum83UQTklA7Wse796LAZPdgWSfl2574Qai
         JVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112694; x=1684704694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BB/WE7LZaA1/Vs5ezQQVF1bVLfOPlPyiztA5xMMxinE=;
        b=XZ6zMSd4m3HlMqsV7nXxNpjQ2lTrTns8aW4n6/ntjWWCLZy3XHY0eaNgM4WS/lAe1b
         1sSfJe7IJWvc9Xesh+s1AQaUn/QeFXjrG2D8qewEhIRw8MlmKev1Nph8xLUGE01IsgZc
         pKUeAPVLcfPVJwWbSA4YmPOJHUywE4xgED2/ukp9NE9zd+POWj4vDPYtq6RMq+2Fequr
         EJLXwzmrbPExXXbe5tbJb+lMfhbtesiAx+/J2h2+NAI9PBkGNq7RWzLvPPiucMToIlSK
         Bc+XIECVSN/mUglqeyP30jLV7WgL6WnLfI0sFoTJbteRZEAi32wtrMXtpfhy1zNuM0TC
         Aeiw==
X-Gm-Message-State: AAQBX9ddLde1CQWFvjApXqEukOA6XO0v7tdphJnEgfxdulVesQo2bZDa
        uiWoQdv+PxjKEtLDANEBZwT5Yw==
X-Google-Smtp-Source: AKy350YrSMIBZXsKHdCUp3uJ8QDs7WbfuEQo0f77Sl0GBVPoGdytji0JOLUz8bmGCv9pYSMpAv6zGA==
X-Received: by 2002:a05:6512:38b0:b0:4ea:4793:facf with SMTP id o16-20020a05651238b000b004ea4793facfmr1468101lft.13.1682112694149;
        Fri, 21 Apr 2023 14:31:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b004e83fbba141sm683509lfo.164.2023.04.21.14.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 14:31:33 -0700 (PDT)
Message-ID: <ee585ca0-b8a2-4ffd-a3a2-2639ac912377@linaro.org>
Date:   Sat, 22 Apr 2023 00:31:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 4/5] drm/msm/dpu: calculate DSC encoder parameters
 dynamically
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1682033114-28483-1-git-send-email-quic_khsieh@quicinc.com>
 <1682033114-28483-5-git-send-email-quic_khsieh@quicinc.com>
 <c8089d0f-c8cd-6a24-718f-682145d04f02@linaro.org>
 <95a37ba2-29b5-47b9-48df-1bd4e4c409c5@quicinc.com>
 <62df2f48-2553-72f0-43e4-9a5d4027ab81@linaro.org>
 <e1294f23-5eda-6aa1-0363-a4d503d2fa59@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <e1294f23-5eda-6aa1-0363-a4d503d2fa59@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 00:30, Kuogee Hsieh wrote:
> 
> On 4/21/2023 2:13 PM, Dmitry Baryshkov wrote:
>> On 22/04/2023 00:07, Kuogee Hsieh wrote:
>>>
>>> On 4/20/2023 5:27 PM, Dmitry Baryshkov wrote:
>>>> On 21/04/2023 02:25, Kuogee Hsieh wrote:
>>>>> During DSC preparation, add run time calculation to figure out what
>>>>> usage modes, split mode and merge mode, is going to be setup.
>>>>>
>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>> ---
>>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 56 
>>>>> ++++++++++++++++-------------
>>>>>   1 file changed, 32 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>> index 2fdacf1..5677728 100644
>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>> @@ -529,17 +529,9 @@ void dpu_encoder_helper_split_config(
>>>>>   bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>>>>>   {
>>>>>       struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>>>>> -    int i, intf_count = 0, num_dsc = 0;
>>>>> +    struct msm_display_topology *topology = &dpu_enc->topology;
>>>>>   -    for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
>>>>> -        if (dpu_enc->phys_encs[i])
>>>>> -            intf_count++;
>>>>> -
>>>>> -    /* See dpu_encoder_get_topology, we only support 2:2:1 
>>>>> topology */
>>>>> -    if (dpu_enc->dsc)
>>>>> -        num_dsc = 2;
>>>>> -
>>>>> -    return (num_dsc > 0) && (num_dsc > intf_count);
>>>>> +    return (topology->num_dsc > topology->num_intf);
>>>>>   }
>>>>>     static void dpu_encoder_get_topology(
>>>>> @@ -1861,41 +1853,57 @@ static void dpu_encoder_prep_dsc(struct 
>>>>> dpu_encoder_virt *dpu_enc,
>>>>>       struct dpu_encoder_phys *enc_master = dpu_enc->cur_master;
>>>>>       struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
>>>>>       struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
>>>>> +    struct msm_display_topology *topology = &dpu_enc->topology;
>>>>>       int this_frame_slices;
>>>>>       int intf_ip_w, enc_ip_w;
>>>>> -    int dsc_common_mode;
>>>>> +    int dsc_common_mode = 0;
>>>>>       int pic_width;
>>>>>       u32 initial_lines;
>>>>> +    int num_dsc, num_intf;
>>>>>       int i;
>>>>>         for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
>>>>>           hw_pp[i] = dpu_enc->hw_pp[i];
>>>>>           hw_dsc[i] = dpu_enc->hw_dsc[i];
>>>>> -
>>>>> -        if (!hw_pp[i] || !hw_dsc[i]) {
>>>>> -            DPU_ERROR_ENC(dpu_enc, "invalid params for DSC\n");
>>>>> -            return;
>>>>> -        }
>>>>
>>> Why?
>>>
>>> MAX_CHANNELS_PER_ENC == 2
>>>
>>> This works for dsi since it use 2 dsc encoder.
>>>
>>> Since DP only use one dsc encoder, this will cause it return at loop 
>>> 2 without execute dpu_encoder_dsc_pipe_cfg().
>>
>> Then the loop should go up to num_dsc rather than MAX_CHANNELS_PER_ENC
>>
>>>
>>>>
>>>>>       }
>>>>>   -    dsc_common_mode = 0;
>>>>> +    num_dsc = topology->num_dsc;
>>>>> +    num_intf = topology->num_intf;
>>>>> +
>>>>>       pic_width = dsc->pic_width;
>>>>>   -    dsc_common_mode = DSC_MODE_MULTIPLEX | DSC_MODE_SPLIT_PANEL;
>>>>>       if (enc_master->intf_mode == INTF_MODE_VIDEO)
>>>>>           dsc_common_mode |= DSC_MODE_VIDEO;
>>>>>   +    /*
>>>>> +     * If this encoder is driving more than one DSC encoder, they
>>>>> +     * operate in tandem, same pic dimension needs to be used by
>>>>> +     * each of them.(pp-split is assumed to be not supported)
>>>>> +     *
>>>>> +     */
>>>>> +
>>>>>       this_frame_slices = pic_width / dsc->slice_width;
>>>>>       intf_ip_w = this_frame_slices * dsc->slice_width;
>>>>> +    enc_ip_w = intf_ip_w;
>>>>> +
>>>>> +    intf_ip_w /= num_intf;
>>>>> +
>>>>> +    if (num_dsc > 1)
>>>>> +        dsc_common_mode |= DSC_MODE_SPLIT_PANEL;
>>>>> +
>>>>> +    if (dpu_encoder_use_dsc_merge(&dpu_enc->base)) {
>>>>> +        dsc_common_mode |= DSC_MODE_MULTIPLEX;
>>>>> +        /*
>>>>> +         * in dsc merge case: when using 2 encoders for the same
>>>>> +         * stream, no. of slices need to be same on both the
>>>>> +         * encoders.
>>>>> +         */
>>>>> +        enc_ip_w = intf_ip_w / 2;
>>>>
>>>> So do you want to get enc_ip_w / 2 or enc_ip_w / num_intf / 2 here?
>>> enc_ip_w / num_intf / 2
>>
>> But previously we had enc_ip_w = intf_ip_w / 2. Was it because of the 
>> assumption that num_intf = 1?
> i think so since there is no num_intf involve at previous code.

Ack.

>>
>>>>
>>>>> +    }
>>>>>   -    /*
>>>>> -     * dsc merge case: when using 2 encoders for the same stream,
>>>>> -     * no. of slices need to be same on both the encoders.
>>>>> -     */
>>>>> -    enc_ip_w = intf_ip_w / 2;
>>>>>       initial_lines = dpu_encoder_dsc_initial_line_calc(dsc, 
>>>>> enc_ip_w);
>>>>>   -    for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
>>>>> +    for (i = 0; i < num_dsc; i++)
>>>>>           dpu_encoder_dsc_pipe_cfg(dpu_enc, hw_dsc[i], hw_pp[i], dsc,
>>>>>                       dsc_common_mode, initial_lines);
>>>>>   }
>>>>
>>

-- 
With best wishes
Dmitry

