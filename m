Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9760464C802
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiLNLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiLNLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:30:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E25FB9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:30:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so9948334lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gVPnjiA948WNcevhqGSpPP2HMt7OqVHldGniXk84UM=;
        b=Lh7tjeJ22Z6ScJIbiKY8Yvt4BFpID6nvUzVnsJlbA8UXeSw1Tk3UdCpluiPNuAId4T
         VGEAX4jKVkQAtjZ6TLt7P9E66U6SbdAl6MwQm5xuLN9eKCVpZAlurlTdq0bNl9aoJMod
         NihGDfl7OH2fVa7R7fEG1phe4MMsbAv+SkGs9aFXJqCw1iBzWJm+Q/hgH5M4DVwN5bD5
         dqRGvEY/VCvSE24cgIHK348fiuZCi4zAryvDQrOlb3324yc8n0AUTrskyDb5eAIz8kIx
         cmCnhw6I+qOIFugJtpWBgrdrlBB3Te9++AU7jqJAgkma6WxBynXhQRgy/7pHNzkahqRo
         taBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gVPnjiA948WNcevhqGSpPP2HMt7OqVHldGniXk84UM=;
        b=s/w7Fv+tEyeFAAUGZ0iB7aXY3vQsp3F220sWMyZPBB08sOkV5m8kLFeESUAbf91gQs
         on3TFjYy6cZyHyFCn8mup330ZmS/+Y254i7wU6AhrKGbeV7iybazzeM3o9vwS4ohI84h
         GCOjRl+JpWt8E/delq7QPo2pGfCe+dh9I+6QNxzyuW3GR5sIk/p3xDDMuUxUtTDh2vYK
         FHwzlXGT4Eob1oX9wSiPZcDyEK9zx4ncePl+3zJnPyAtZbcbJ7rB8/Bu7do4GHczEJlo
         Uy1N4ltpc9tYfw7Ftr5CD6yc2ZTazRsN781NHIaRVX7i+sEtc9DoCIFqpo2T0N38kb86
         93Vg==
X-Gm-Message-State: ANoB5pk6A1MvmUMonds4tsZw2PxkdQL5m9cJLml0jqM7DZhjfb+IttlR
        7huiCwdScZvmYsx2Fj/sCyE69A==
X-Google-Smtp-Source: AA0mqf6Xoz3kya10ZQ/Ql5zecpMXHP3jkJjMRsWTp33bS8hGEplDCCV8FhUy3gFXN4+WznZ8HFeK2g==
X-Received: by 2002:a05:6512:3e26:b0:4a4:68b7:deaf with SMTP id i38-20020a0565123e2600b004a468b7deafmr9714761lfv.11.1671017444786;
        Wed, 14 Dec 2022 03:30:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l2-20020a194942000000b00497b198987bsm777801lfj.26.2022.12.14.03.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:30:44 -0800 (PST)
Message-ID: <963cb30a-187a-57d1-65eb-34f9f8ed6315@linaro.org>
Date:   Wed, 14 Dec 2022 12:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] dt-bindings: remoteproc: qcom: sc7180: Update
 memory-region requirements
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-3-quic_sibis@quicinc.com>
 <612c1019-11c0-38b6-e1d5-1a52f1456989@linaro.org>
 <ea4e9a35-5468-820a-9e28-9cdf129b77e5@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ea4e9a35-5468-820a-9e28-9cdf129b77e5@quicinc.com>
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

On 14/12/2022 11:25, Sibi Sankar wrote:
> 
> 
> On 12/14/22 01:11, Krzysztof Kozlowski wrote:
>> On 13/12/2022 15:07, Sibi Sankar wrote:
>>> Update the bindings to reflect the addition of the new modem metadata
>>> carveout reference to the memory-region property.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
>>>   .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml    | 3 ++-
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
>>> index e4a7da8020f4..b1402bef0ebe 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
>>> @@ -95,6 +95,7 @@ properties:
>>>       items:
>>>         - description: MBA reserved region
>>>         - description: modem reserved region
>>> +      - description: metadata reserved region
>>
>> Which makes the third item now required, also for all out of tree DTS
>> and other users of the bindings. Please write a bit more in commit msg
>> why this is necessary (e.g. was it broken before?). I assume the driver
>> does not break the ABI?
> 
> I'll pad the commit msg with some of the additional info from patch 4.
> commit c44094eee32f "arm64: dma: Drop cache invalidation from
> arch_dma_prep_coherent()" exposed a bug in the driver affecting SoCs
> from msm8996 on wards. The application processor accessing the
> dynamically allocated region after giving control to the modem results
> in a XPU violation. The recommended fix was to use a no-map carveout
> instead and memunmap before giving control to the modem. The future
> kernels that are paired with an older dtbs would crash during modem

Then it's an ABI break.

> bootup since we would continue to use dma_alloc_attr. But all the other
> combinations (old kernel/new dtb) will continue to work.

Does it mean that old kernel with old DTB was working? If yes, then it's
ABI break without clear benefits.

Best regards,
Krzysztof

