Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F57627D62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiKNMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiKNMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:09:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B5B84
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:09:53 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so18942358lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNxCofBcbIeVXQpJg4d6J4pQ3z4dOkx5gsNXPSK+q14=;
        b=ucvmXj6N6tou5HBUfuCOxKebeYi8+OMPzqC9PPPdYkO0Ok5z9h2wvWqDkMHcTX+poz
         3cZNMArXG+vL67Ao8IV6Xd/ZtaL6m2Ip0bWv41vfItDRmZw/AwHIqcUaHPdEAzXhoTTm
         BzHlS7Pq4cM2jcPGW5SpRQWvWUy8FIfyEJZTUy7BNBK7rJX9L3Vse2KttoQCM4Yc2NCb
         X3BzOGRe2qWQpzUj0mTOFliat4qlybTkrk8/Qd7WPGMoWuB7OgTItwHKX4w4fC4DcJcV
         HVaiB1obEicfYCUegeVjwRyj+B8OF3nK87v+Ml0CU3P/htUTD/DPBbFCvE0v9Y+hH7Wl
         LIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNxCofBcbIeVXQpJg4d6J4pQ3z4dOkx5gsNXPSK+q14=;
        b=lX7Pp96JwxWOYjqojQx1jWelGOBEIjDxM6xESmoMkA1vn/dnlow7GY4e5WdsFFk8Z3
         96TN2Q1fR8WMOR/qZhH6aE6isMGB5vj8pmi2Ju4RJCugas22l6XY8tv8Zupl1kpv0tzh
         8V8ihYUQrO5TkOHCNxS/eNR9qBk7oSbv1qI0BQoY/smxAMOVd6ijkfJ6QXgpA8I8PgKu
         NQ8etyoWzqr0H/G2FpIDRP5oJJblupjYTLlFkUs3gfw85FU17Q7tnV2vP609bYRdfa1p
         iJIWM/fgE9cZbVlNLafcjJxKeX3GFoQCuFxgqZILlKgZKkecwSNP3z0cpaZbHbnvz+Ff
         92Vw==
X-Gm-Message-State: ANoB5pnMYL+NI3dNnvzJYHDvAAT7ZamXjmtkGlNwayU0alPulnZf6Db1
        XU9jKv+FJtGX20tbF+UEIPjJEw==
X-Google-Smtp-Source: AA0mqf5g+dqZa5LypIi6W9GnNoqEZM1/7LsEFGd3SxBYWf8DwN7+1IHCwTh9GQWqAFq/oIL8J4UTXw==
X-Received: by 2002:ac2:4945:0:b0:4a2:5897:2b44 with SMTP id o5-20020ac24945000000b004a258972b44mr4446724lfi.431.1668427791293;
        Mon, 14 Nov 2022 04:09:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05651c232400b002771057e0e5sm1999559ljb.76.2022.11.14.04.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:09:50 -0800 (PST)
Message-ID: <8179b5f5-5292-692b-15c4-5d83dee85789@linaro.org>
Date:   Mon, 14 Nov 2022 13:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/10] ASoC: dt-bindings: Rework Qualcomm APR/GPR Sound
 nodes for SM8450
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <06da072c-8cf0-8181-3c32-4592fe41f9c2@linaro.org>
 <0ee5db9e-d80c-947d-73d6-6214e9299b23@linaro.org>
 <48883bd6-217d-f513-316c-2b5caf486e5e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <48883bd6-217d-f513-316c-2b5caf486e5e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 12:50, Srinivas Kandagatla wrote:
> 
> 
> On 14/11/2022 07:48, Krzysztof Kozlowski wrote:
>> On 11/11/2022 17:15, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
>>>> Adding sound support for Qualcomm SM8450 SoC (and later for SC8280XP) brought
>>>> some changes to APR/GPR services bindings.  These bindings are part of
>>>> qcom,apr.yaml:
>>>>
>>>>     apr-or-gpr-device-node <- qcom,apr.yaml
>>>>       apr-gpr-service@[0-9] <- qcom,apr.yaml
>>>>         service-specific-components <- /schemas/sound/qcom,q6*.yaml
>>>>
>>>> The schema for services (apr-gpr-service@[0-9]) already grows considerably and
>>>> is still quite not specific.  It allows several incorrect combinations, like
>>>> adding a clock-controller to a APM device.  Restricting it would complicate the
>>>> schema even more.  Bringing new support for sound on Qualcomm SM8450 and
>>>> SC8280XP SoC would grow it as well.
>>>
>>> Why would this grow? All the dsp services are static and they will not
>>> change per SoC unless there is a total firmware change in DSP.
>>
>> They grow now with SM8450 which requires changes there. Otherwise DTS
>> does not pass with current bindings. The bindings before my fixing in
>> 2022 were really incomplete. Now they are complete, but:
>> 1. Not for SM8450 - this will bring new things,
>> 2. Very unspecific as they allow multiple invalid configurations.
>>
> Okay, I looked at all the patches, they are fine as it is, the confusion 
> part is the subject and comments which are misleading and trying to say 
> that these are specific to SM8450 or SC8280XP. Infact this is not true, 
> none of these changes are specific to any SoC, they are part of AudioReach.

They are part of bringing audio on SM8450, at the end we all are SoC
centric... we do not bring support for AudioReach just for itself,
right? We bring it because we want to have something working on SM8450
and further...

Best regards,
Krzysztof

