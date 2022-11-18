Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0462F8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiKRPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiKRPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:02:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C291518
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:00:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j16so8577380lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ejPHwWhRmHSRQorQPyiZQmxAgpus80eMs4KMNjOC6I=;
        b=Fp3bwh5Qttpmf5pwrLNjCu8SC5IeWJltXikOyixAv8EulOPlAOwhCIr6Ou4zAyhsUl
         0YEfGTyOREhf9RDGoRv3jCzRP+QuhKAEa9QWVoZed/KkvDmKiOOBA7Hkg6uSqcPy5I9/
         +BEzmzxoOXn4z9wxnvosYjzi93R3+rKsHsc7zka+Ear3Sw5QYN3JmgfIxybm3lpyNWES
         au7dZSbb5GDnNtgwGIELHN2ACEEu6vXl2FCduW5/Fn8zICKH7KzcEqyqZQp4vqJNVCok
         TESes1mLW5kwjoruMU/RhMQIiMBjrS8li/Fs9Mdst7EuHfU5VRUMx9ypuWU1ijUNmOwk
         1qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ejPHwWhRmHSRQorQPyiZQmxAgpus80eMs4KMNjOC6I=;
        b=Txz4NJ9EqHcYtORApct0USdcw05QAUJKjwBp/moUDtR3ILJBMmt8ZJcQ6en7Oo0hk8
         wZnF7xeJZQnUbGM9qG/NNEMttSHZIeD0HvyOMqKdGkOOFuYnWv4rv6Lw84twZh8Py1Uk
         3vT3uQpUlMUT7m+Nghl+qfdm0cTNa5ZXUT+19ldZa+w+C/Q63c0lm0mgMKNdoUgMAh6o
         01cDNuQTDPcJcMCVZMmqz5Rot4LCTTBf6/kU+Qxa4aq5EHjaEeOpD9fZslhZp6OZxV8J
         2g+gb0OYrgyTD+wd3LatDWaAx7vnJOQFDUtlXEDkemydMHnoJkKOyGurZDV42O76rUFm
         qtSg==
X-Gm-Message-State: ANoB5pnomtSorAT0wOt5ZJDRvbd2ZxLaj1URb7acO4+VtLPiB0pmbrkm
        PV1U0vAqE7srySilnW1ZM2wRyg==
X-Google-Smtp-Source: AA0mqf7It8sdcMVMFx689iqJi2eBfnhzy6hh6ZyVvqfeeu3/XoOFjwvWqSXJ4zQX/L9AwR9aEE26dw==
X-Received: by 2002:a19:ae18:0:b0:4aa:c879:5bc with SMTP id f24-20020a19ae18000000b004aac87905bcmr2471996lfc.498.1668783636900;
        Fri, 18 Nov 2022 07:00:36 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512314c00b004b0317a1035sm692304lfi.109.2022.11.18.07.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 07:00:36 -0800 (PST)
Message-ID: <8b2999d9-87e4-fe29-6283-15200a052131@linaro.org>
Date:   Fri, 18 Nov 2022 17:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/3] drm/msm/disp/dpu1: add helper to know if display
 is builtin
Content-Language: en-GB
To:     Kalyan Thota <kalyant@qti.qualcomm.com>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@chromium.org" <robdclark@chromium.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
References: <1668773807-19598-1-git-send-email-quic_kalyant@quicinc.com>
 <1668773807-19598-3-git-send-email-quic_kalyant@quicinc.com>
 <5dddeaa9-aab1-e437-a3ed-8ad242d50171@linaro.org>
 <BN0PR02MB81424044EB8F918A99ECE3ED96099@BN0PR02MB8142.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <BN0PR02MB81424044EB8F918A99ECE3ED96099@BN0PR02MB8142.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 16:37, Kalyan Thota wrote:
> 
> 
>> -----Original Message-----
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Sent: Friday, November 18, 2022 6:09 PM
>> To: Kalyan Thota (QUIC) <quic_kalyant@quicinc.com>; dri-
>> devel@lists.freedesktop.org; linux-arm-msm@vger.kernel.org;
>> freedreno@lists.freedesktop.org; devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; robdclark@chromium.org;
>> dianders@chromium.org; swboyd@chromium.org; Vinod Polimera (QUIC)
>> <quic_vpolimer@quicinc.com>; Abhinav Kumar (QUIC)
>> <quic_abhinavk@quicinc.com>
>> Subject: Re: [PATCH v3 2/3] drm/msm/disp/dpu1: add helper to know if display is
>> builtin
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>> any links or attachments, and do not enable macros.
>>
>> On 18/11/2022 15:16, Kalyan Thota wrote:
>>> Since DRM encoder type for few encoders can be similar (like eDP and
>>> DP) find out if the interface supports HPD from encoder bridge to
>>> differentiate between builtin and pluggable displays.
>>>
>>> Changes in v1:
>>> - add connector type in the disp_info (Dmitry)
>>> - add helper functions to know encoder type
>>> - update commit text reflecting the change
>>>
>>> Changes in v2:
>>> - avoid hardcode of connector type for DSI as it may not be true
>>> (Dmitry)
>>> - get the HPD information from encoder bridge
>>>
>>> Changes in v3:
>>> - use bridge type instead of bridge ops in determining connector
>>> (Dmitry)
>>>
>>> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27
>> +++++++++++++++++++++++++++
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>>>    2 files changed, 33 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> index 9c6817b..574f2b0 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> @@ -15,6 +15,7 @@
>>>    #include <drm/drm_crtc.h>
>>>    #include <drm/drm_file.h>
>>>    #include <drm/drm_probe_helper.h>
>>> +#include <drm/drm_bridge.h>
>>>
>>>    #include "msm_drv.h"
>>>    #include "dpu_kms.h"
>>> @@ -217,6 +218,32 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>>>        15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>>>    };
>>>
>>> +bool dpu_encoder_is_builtin(struct drm_encoder *encoder) {
>>> +     struct drm_bridge *bridge;
>>> +     int ops = 0;
>>> +
>>> +     if (!encoder)
>>> +             return false;
>>> +
>>> +     /* Get last bridge in the chain to determine connector type */
>>> +     drm_for_each_bridge_in_chain(encoder, bridge)
>>> +             if (!drm_bridge_get_next_bridge(bridge))
>>> +                     ops = bridge->type;
>>
>> Why don't we check the connector type directly? You should not assume that
>> connector's type is equal to the latest bridge's type.
> 
> if we need to get the type from connector, need to do something as below.
> Are you thinking on the same lines ?
> 
> "to_drm_bridge_connector" macro needs to be moved to drm_bridge_connector.h
> 
> struct drm_bridge_connector *bridge_connector;
> 
> drm_connector_list_iter_begin(dev, &conn_iter);
> 	drm_for_each_connector_iter(connector, &conn_iter) {
> 
> 		bridge_connector = to_drm_bridge_connector(connector);
> 		if (bridge_connector->encoder == encoder) {
> 			type = connector->connector_type;
> 			break;
> 		}
> 	}
> drm_connector_list_iter_end(&conn_iter);

No. You can not depend on the idea that every connector is 
drm_bridge_connector. Some bridges might create their own connectors. 
However you can do it in the following way:

drm_connector_list_iter_begin(dev, &iter);
drm_for_each_connector_iter(connector, &iter) {
  if (connector->possible_encoders & drm_encoder_mask(encoder)) {
     builtin = (connector->connector_type == DRM_MODE_CONNECTOR_LVDS) || 
...;
     break;
   }
}
drm_connector_list_iter_end(&iter);

return builtin;


> 
> 
>>> +
>>> +     switch (ops) {
>>> +     case DRM_MODE_CONNECTOR_Unknown:
>>> +     case DRM_MODE_CONNECTOR_LVDS:
>>> +     case DRM_MODE_CONNECTOR_eDP:
>>> +     case DRM_MODE_CONNECTOR_DSI:
>>> +     case DRM_MODE_CONNECTOR_DPI:
>>> +     case DRM_MODE_CONNECTOR_WRITEBACK:
>>> +     case DRM_MODE_CONNECTOR_VIRTUAL:
>>
>> Unknown, WRITEBACK and VIRTUAL are not builtin (for the point of CTM at
>> least).
>>
>>> +             return true;
>>> +     default:
>>> +             return false;
>>> +     }
>>> +}
>>>
>>>    bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>>>    {
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>>> index 9e7236e..7f3d823 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>>> @@ -224,4 +224,10 @@ void dpu_encoder_cleanup_wb_job(struct
>> drm_encoder *drm_enc,
>>>     */
>>>    bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc);
>>>
>>> +/**
>>> + * dpu_encoder_is_builtin - find if the encoder is of type builtin
>>> + * @drm_enc:    Pointer to previously created drm encoder structure
>>> + */
>>> +bool dpu_encoder_is_builtin(struct drm_encoder *drm_enc);
>>> +
>>>    #endif /* __DPU_ENCODER_H__ */
>>
>> --
>> With best wishes
>> Dmitry
> 

-- 
With best wishes
Dmitry

