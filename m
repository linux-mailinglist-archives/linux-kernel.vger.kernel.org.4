Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09EE69C87E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBTKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBTKYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:24:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100B974C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:24:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id w27so1108208lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4VbNHQrOu9ybISC4/mWj8LiqMpeLrJa5tqtRupc92k=;
        b=SdCJPDxs3CvxMeEjKC1jOG8vZ2SSqpBbHMY5fFiJxZyG+Ub32EsZOM6Ibw3EGMGfH/
         qXxn+/e+vli6X6lGkngRgi5TfeLAgPWozO33DyZWiCGMTPJs08SloRzrC3T51V3XsR1B
         juuCAMg49DVYibdw0ecpxv++AepBJLY+EZMwyVG2rQ/ePTnp2wbpZvR5c5fnJhPG8g27
         NNUu92wDnqgleG9fIBYenlLBvnB2iMAm5zOlgV5Rwk6/X3CN12tVKHARt003srlOi0hQ
         6WMLzJTRySmN3oc9PIluKKoMn0h903vCmeSd3W0aSd4SEsx1ivgHZnSWzUDSCbWw28yz
         ECvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4VbNHQrOu9ybISC4/mWj8LiqMpeLrJa5tqtRupc92k=;
        b=p+qB+o0hnVNydqk8ggE9Gp0VkeJsOZbQbsp4grAAAY5diTRNxQSNL30UFH/xIHOEUQ
         LZbG4CVf3WUmFlTa8OP9q+24VjV9AnLAo2zomHYCl/mAII5NVl/n8pszpKpeGK/18rYF
         bIkTn02Bqt3FPlaFezHUQHuwe4Qld0Yn3CU/JBTljLMqZ3QO7lnCyhSNqbLP00G2LqSJ
         nXL6isffVQKuzI1Z7nnyhCvOOD7nzmNIqnnoviU5pRw6q8FNlGSkG+0NKQ64NeHqzzma
         HfKCfG3QdEJITrNaGjGMl14GHB9rLvgAfOyDzK1BSJGgrZfMXkjSAjUgBmxQEWOZAeQ9
         YuxQ==
X-Gm-Message-State: AO0yUKUYLuUylhuqLTwfal/711NITY/+b309F0HPL71GqbRkKWbWolme
        nq8Y173fi6FM/IN9P1+rWODllA==
X-Google-Smtp-Source: AK7set+RjsnQil+2UlBqrRTdxjm5Q0FKhxaCLdglUFvzLdjXZ+vfm4bdrBiYRGmhQvqEstvJWIx5nw==
X-Received: by 2002:ac2:4f10:0:b0:4dd:840d:462 with SMTP id k16-20020ac24f10000000b004dd840d0462mr60626lfr.21.1676888660919;
        Mon, 20 Feb 2023 02:24:20 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id c16-20020a197610000000b004d545f1e0ccsm278586lff.187.2023.02.20.02.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:24:20 -0800 (PST)
Message-ID: <3d2e681b-0cc0-5d86-7d40-63022a5358c9@linaro.org>
Date:   Mon, 20 Feb 2023 11:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111316.306241-1-konrad.dybcio@linaro.org>
 <c49904be-d842-fc12-a443-17f229d53166@linaro.org>
 <a4eaccfd-34ba-15f3-033f-165b46c43317@linaro.org>
 <a158bca2-78bf-5b38-60fe-88118e8b4ad7@linaro.org>
 <ab35cdcf-53ae-a3f2-fc08-d0f58c51a0ae@linaro.org>
 <48cb00cd-961c-b72f-fba8-1842d658e289@linaro.org>
 <d4ffa9f0-797e-7a32-147e-64aa46d7e197@linaro.org>
 <e6d397bb-dd5d-8308-eb07-3aeb2589115c@linaro.org>
 <fbece9d6-2204-2534-e44f-29c29cc56413@linaro.org>
 <9a0245af-b7f3-0874-385b-47c86d6e6a60@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9a0245af-b7f3-0874-385b-47c86d6e6a60@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.02.2023 15:49, Krzysztof Kozlowski wrote:
> On 18/02/2023 12:23, Konrad Dybcio wrote:
>>
>>
>> On 18.02.2023 11:14, Krzysztof Kozlowski wrote:
>>> On 17/02/2023 22:13, Bryan O'Donoghue wrote:
>>>> On 17/02/2023 12:24, Krzysztof Kozlowski wrote:
>>>>> First, it would be nice to know what was the intention of Bryan's commit?
>>>>
>>>> Sorry I've been grazing this thread but, not responding.
>>>>
>>>> - qcom,dsi-ctrl-6g-qcm2290
>>>>
>>>> is non-compliant with qcom,socid-dsi-ctrl which is our desired naming 
>>>> convention, so that's what the deprecation is about i.e. moving this 
>>>> compat to "qcom,qcm2290-dsi-ctrl"
>>>
>>> OK, then there was no intention to deprecate qcom,mdss-dsi-ctrl and it
>>> should be left as allowed compatible.
>> Not sure if we're on the same page.
> 
> We are.
> 
>>
>> It wasn't intended to deprecate [1] "qcom,qcm2290-dsi-ctrl", "qcom-mdss-dsi-ctrl";
>> (newly-introduced in Bryan's cleanup patchset) but it was intended to deprecate
>> [2] "qcom,dsi-ctrl-6g-qcm2290"; which was introduced long before that *and* used in
>> the 6115 dt (and it still is in linux-next today, as my cleanup hasn't landed yet).
>>
>> [3] "qcom,dsi-ctrl-6g-qcm2290", "qcom,mdss-dsi-ctrl" was never used (and should never
>> be, considering there's a proper compatible [1] now) so adding it to bindings
>> didn't solve the undocumented-ness issue. Plus the fallback would have never
>> worked back then, as the DSI hw revision check would spit out 2.4.1 or 2.4.
>> which is SC7180 or SDM845 and then it would never match the base register, as
>> they're waay different.
> 
> All these were known. I was asking about "qcom,mdss-dsi-ctrl", because
> the original intention also affects the way we want to keep it now
> (unless there are other reasons).
Okay, so we want to deprecate:

"qcom,dsi-ctrl-6g-qcm2290", "qcom,mdss-dsi-ctrl"

because it is:

1) non-compliant with the qcom,socname-hwblock formula
2) replaceable since we rely on the fallback compatible
3) "qcom,dsi-ctrl-6g-qcm2290" alone would have been expected to
   be fixed in the DTSI similar to other SoCs

Is that correct?

Because 2) doesn't hold, as - at the time of the introduction
of Bryan's patchset - the fallback compatible would not have
been sufficient from the Linux POV [1], though it would have been
sufficient from the hardware description POV, as the hardware
on the SoC *is* essentially what qcom,mdss-dsi-ctrl refers to.

[1] The driver would simply not probe. It *would be* Linux-correct
after my code-fixing series was applied, but I think I'm just failing
to comprehend what sort of ABI we're trying to preserve here :/

Konrad

> 
> Best regards,
> Krzysztof
> 
