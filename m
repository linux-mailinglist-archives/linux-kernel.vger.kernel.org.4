Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50FD6F80F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjEEKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjEEKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:42:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932819417
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:42:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efeea05936so1783811e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683283325; x=1685875325;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COOjcdCjdWceGojCiyQ9EoIifaQ5M03oYyGp/LrLOiY=;
        b=seRV8YQO8KAFVM4QeDZgq9cRPqiFJoYGTzli7b6Xbr7d7eJ1c9e+8PyhZDW++C88cr
         Yl2gGI+zDHlgvzttFtbA4iOIjKsMphiJzEv47MAdz18xbqS7VF5OUdEgcSn5Y/vtyEJS
         0Sw34QDTjru5n0ic9cTx0B3KhDTouKkBdHHR43Q2spVbj06FNxBJ2qFQKITc2so7aplJ
         IYcVZdHY4rF0jgpn7uC7PqCa65CK0lfJetpWTZLAjXcAY3/2bqvgldUC6/Fa+sUeUTgj
         WJ5jae46EzSwOBj4kOR3w37Ro43tl2aeUi3FSeXckfqkWff3FX3QpXgQfxvedtXXmT4t
         WG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683283325; x=1685875325;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COOjcdCjdWceGojCiyQ9EoIifaQ5M03oYyGp/LrLOiY=;
        b=JrrpaDItH3YLwXPsSjwVwMwAtF1XGY/MMo25dSHMSVsqYEL0AVdyP6ygKEr2a/mYfS
         gC4kpoj17dLKPvRmBp9DqNTPYPJ4xt8Cz4SsgZyYxCrcGmt9x3uA+VXDpGKPOu5O6fHv
         cgM6M5ZMCYQKbrznxu34c7uLkQbqhDMBKnypYDT2JfUmEg9H2XJWlt2msnM9cPmpYqUJ
         zFfex5PBPxgDCAdFILLthNoG0XXxV0M1VSKJdcDcEydwc7/l2XDxG3IabyQtGDzHamj7
         0tFh8uBsS4wzl+sMkJUzjiuqF8FBx/rHSWOZ+W4VRgCSqpH2UHbQAMzXDdqtKPggZ8bh
         uY5w==
X-Gm-Message-State: AC+VfDzxj+XDJRLwoEmZ6yBxcONGpvhgp4BZYDXe7cl5BruV+1NIfhU7
        GPFNTPKCOdoa0LcR+UeTCgz/4Q==
X-Google-Smtp-Source: ACHHUZ6u21MN/11ziWz+2XAscXNbKqN5rneQNv0HN+Gh+m1ze7iea56BnmlwNjQyguo/lNptncD7jg==
X-Received: by 2002:a05:6512:962:b0:4ed:d5ce:7df0 with SMTP id v2-20020a056512096200b004edd5ce7df0mr433024lft.7.1683283324890;
        Fri, 05 May 2023 03:42:04 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y12-20020a19750c000000b004ee85d1444esm238224lfe.208.2023.05.05.03.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 03:42:04 -0700 (PDT)
Message-ID: <de752956-7a96-95bf-f28b-78429b9d671e@linaro.org>
Date:   Fri, 5 May 2023 12:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <1683196599-3730-5-git-send-email-quic_dikshita@quicinc.com>
 <02f5d449-a64b-8f5e-6b72-2fdf8d9bafbe@linaro.org>
 <b5fa8e0a-1663-e386-cffe-e7feb16d8733@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/4] venus: return P010 as preferred format for 10 bit
 decode
In-Reply-To: <b5fa8e0a-1663-e386-cffe-e7feb16d8733@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 11:03, Dikshita Agarwal wrote:
> 
> On 5/4/2023 10:50 PM, Konrad Dybcio wrote:
>>
>> On 4.05.2023 12:36, Dikshita Agarwal wrote:
>>> If bit depth is detected as 10 bit by firmware, return
>>> P010 as preferred decoder format to the client.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> ---
>>>   drivers/media/platform/qcom/venus/vdec.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>>> index 69f7f6e..ed11dc2 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -1468,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
>>>       inst->out_width = ev_data->width;
>>>       inst->out_height = ev_data->height;
>>>   -    if (inst->bit_depth != ev_data->bit_depth)
>>> +    if (inst->bit_depth != ev_data->bit_depth) {
>>>           inst->bit_depth = ev_data->bit_depth;
>>> +        if (inst->bit_depth == VIDC_BITDEPTH_10)
>>> +            inst->fmt_cap = &vdec_formats[3];
>>> +        else
>>> +            inst->fmt_cap = &vdec_formats[0];
>> This doesn't scale and is very error-prone, please enumerate the
>> entries and assign it using the enumerator, like:
>>
>> enum {
>>     VDEC_FORMAT_FOO,
>>     ...
>> };
>>
>> ... vdec_formats[] = {
>>     [VDEC_FORMAT_FOO] = { foo, bar, baz }
>> }
>>
>> Konrad
> 
> I agree, this can be improved but I would prefer making that change as separate patch.
> 
> As this is not only related to HDR 10 decoding, there are other places in the code which will require similar change.
This is not a very strong argument.

You can't add code that will break very easily whenever somebody touches
that array and pinky-promise to fix it some time later, just because you
want to get your feature merged faster, this is not drivers/staging.

Konrad

> 
> Thanks,
> 
> Dikshita
> 
>>> +    }
>>>         if (inst->pic_struct != ev_data->pic_struct)
>>>           inst->pic_struct = ev_data->pic_struct;
