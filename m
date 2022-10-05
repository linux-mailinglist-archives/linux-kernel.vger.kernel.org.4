Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C835F50C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJEI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJEI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:27:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB15EDE3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:27:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o7so17257833lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IROOtMiWph57gn0ct7I+JCQbFPdP6AiF2nUfr9wx6CM=;
        b=xMeC7HAQIwVutCD8b29xg26dmrwmfBnH7K19j2zP1DxlVwHeSRZ500++1U+oUwQlzl
         2bxIYYv/vZf1emS3iA/KnhCeU1xv7d1mGLuGbthucClF0MAFschFq9EfazAE/tKtntqV
         WPxechXG0HuM/nfDKqDFrgWZtRfk9PyBLKkrDUSXzOqHqZLejASlG14ut6YUF7agc0J2
         R+r9pvJaktCXChWj9aCeZYFmjx7BAwnAZl5ITMcNqVdt4T9U5noCfYuh6tkeplWkATYl
         UI9RPvvrO8m0sq8ZLAxB4U3a9uV2/GRcm1Ym2GVOt4Rqt3DpgbYqYSUiTS5cQP/ayqnR
         azQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IROOtMiWph57gn0ct7I+JCQbFPdP6AiF2nUfr9wx6CM=;
        b=pu/cD55ep/SBn9dvFdQ1G+oNtJ7jcH7RSDnLjQ4x3W8oGCZhHcUqa8NQtfASXJ5OAm
         +v2H910j8MK2/YauBZnm0yYUOM9Sz9FIYXNY+m13r3X26uNIb2ox9q8JxHApClpgUKJ0
         XF/jBgmw0o+9AMX/lQNlZzm2JHdCCNMvcXslL4JY3CuJyPzzApuLMhmMlPpYKML9ykzo
         CHw98MFo+iOPo6GRzng5el86MCDPJCcEoJMadIbH6yP/bj541J69WqS12XBuH0HVQZ/N
         REDwjex1s5QGTKO1Ceo0qTqbYJ5nTvM7GE0vWo1eh2gJCA04TXuc1OEp3OHtG2a7edwj
         GOWA==
X-Gm-Message-State: ACrzQf2tWDsPWnnr1/YG8XAPLDLXDHSMsJ5Zr0ypDbtNVu9anHF6k6sq
        XG9zCsrx53UEQAmQhUCCZGP9zQ==
X-Google-Smtp-Source: AMsMyM5xFylqIBoGW+dzSnXtcZZ0m8qZQ3FQzzBLiN/8TGcYOHdRM/g0vtrYWXJpxtwIHJjxYN0olg==
X-Received: by 2002:a05:6512:467:b0:4a2:3f6d:324a with SMTP id x7-20020a056512046700b004a23f6d324amr4610234lfd.487.1664958429677;
        Wed, 05 Oct 2022 01:27:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j2-20020a056512398200b0049486c66140sm2268073lfu.119.2022.10.05.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 01:27:09 -0700 (PDT)
Message-ID: <14872934-93f1-baab-7f1a-cfc55ffd0531@linaro.org>
Date:   Wed, 5 Oct 2022 10:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com>
 <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
 <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
 <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
 <9664a623-3c58-49e8-1b9a-69335d844448@linaro.org>
 <CAA8EJprQoCQzr2x0JA9_b3MDE=oOTODyHD23debEL1MCE1mWBA@mail.gmail.com>
 <095742cb-61cc-af5d-848c-48b2ea5528ea@quicinc.com>
 <CAA8EJpoqKCj4tyX-617YJH5zqkR_C=1LVMeLXcCxZFgOPjRZ=g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpoqKCj4tyX-617YJH5zqkR_C=1LVMeLXcCxZFgOPjRZ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 23:05, Dmitry Baryshkov wrote:
> On Tue, 4 Oct 2022 at 18:52, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>
>>
>> On 10/4/2022 2:36 AM, Dmitry Baryshkov wrote:
>>> On Tue, 4 Oct 2022 at 09:53, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>> On 04/10/2022 00:14, Dmitry Baryshkov wrote:
>>>>> On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>>>>>
>>>>>> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>>>>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>>>>>>>
>>>>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>>>>> ---
>>>>>>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>>> index c5b76c9f7ad0..b47a5dda3c3e 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>>>>>> @@ -51,6 +51,8 @@ properties:
>>>>>>>>            - qcom,scm-sm8250
>>>>>>>>            - qcom,scm-sm8350
>>>>>>>>            - qcom,scm-sm8450
>>>>>>>> +          - qcom,scm-qdu1000
>>>>>>>> +          - qcom,scm-qru1000
>>>>> I think after seeing all the patchsets it's time to ask the following
>>>>> question. Do we really need a duplicate compatibility families:
>>>>> qdu1000 vs qru1000? I'd suggest using a single set of compatibile
>>>>> strings in most of the cases.
>>>>> Settle down onto a single name (qdu,qru, qdru, whatever) and define
>>>>> distinct compat strings only when there is an actual difference?
>>>>>
>>>>> E.g .we don't have separate compatible strings for all the sda660,
>>>>> apq8096, etc. unless this is required by the corresponding hardware
>>>>> block not being compatible with corresponding sdm or msm counterpart.
>>>>>
>>>> I am not that fluent in Qualcomm naming, so let me ask - what are the
>>>> differences between QDU and QRU?
>>>>
>>>> For compatible (and/or similar) devices the general recommendation is to
>>>> have specific compatibles followed by fallback. Even if devices are
>>>> very, very, very similar, usually the recommendation still stays.
>>> Well, true. But in some cases we handle this by using a single set of
>>> compatibles. Consider e.g. sa8155 vs sm8150 (sa8155 overrides just few
>>> compats that differ). Or qrb5165 vs sm8250 (there is no separate
>>> qrb5165.dtsi). APQ8096 (#include "msm8996.dtsi"). Etc.
>>>
>>> I'd say this really depends on the actual difference between qru and qdu.
>>
>> To add some clarification, there's pretty little functional difference between the QDU (Distributed Unit) and the QRU (Radio Unit); they're largely the same SoC from the kernel's standpoint. I wasn't sure if it made more sense to separate the compat strings or mash them together (using qdru to specify that it applies to both), so I kept separate compat strings in case there was a separate RU/DU use case down the line and also to avoid some confusion (I guess that didn't work though). It makes the most sense in my mind to just use the qdru compat string for the things that apply to both SoCs (which is most of what's submitted currently) and then we can do qdu/qru specific override strings for more specific drivers.
> 
> Unless Krzysztof or Bjorn have other opinion, I'd suggest adding a
> single compat string, It might be qcom,qdru1000-foo or just
> qcom,qdu1000-foo (with having a separate qcom,qru1000-foo where
> applicable). But the final decision is from Rob, Krzysztof and Bjorn.

If qdru1000 is a real SoC name, then it is fine. But it seems it is
rather a wildcard, which in general is discouraged. Go with qdu1000 and
optionally prepended with qru1000.

Best regards,
Krzysztof

