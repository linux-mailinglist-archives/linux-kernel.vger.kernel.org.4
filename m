Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDA5BF6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIUGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIUGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:52:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19480F6D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:52:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y11so5445854pjv.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZHM4glH/lLw2QOmsfReWSEKEYl56FKNM69zB9VOK1rU=;
        b=tY2hfE4z9cjAj7K3+No2dsJRHekRr+JRTUJBWX9CNe1oI1llIeIM8yOgIkA7B5QsEl
         +ILN5d7eOyD0n7k/fatsSdzFxhO+egnECvFe9ToWSNJ/H3mFPR7CbqYjSHGUhaIIvimE
         /YtLrDmP+5+iha0gAGulvq+PYQM/nSltWsAp2B5wVQ2b4LOTPSYTkBTtZ9yWH9t9vQ5L
         kwpL6Q+2/KUdA8pOIMmuCEh5HMkx3fk3fCs5LhL7QGvd1mBZuNQmwwcJBzRMifjBblkS
         jKemUx05YzSgmruN7aYzZn/ytdLGM9fVBlKoaNi9HtghkiKDB8dMrbdLKJdan67PRwNN
         LcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZHM4glH/lLw2QOmsfReWSEKEYl56FKNM69zB9VOK1rU=;
        b=cwPqhV3TT1HvwNzamPRYxpTDv6pl6VyZabip/Vhojwe7KS8Xkx3NFkQDtopqlgCg3n
         YiUJVTZ1n+qigX8iMOlTQXNemeCLSoi40B671l9QxSlfI8uVyVIA4DsdfJSun3BkkofT
         mVR+alf2NeltWHznV+QCAjb3kIud0PPzUjYYL3+j6pC8rzkFACGAtUs1vrV+EZmx79EQ
         6sd3qkPa2bGpk/TBZK8mzRljTTQkXqRcIJltcs/ZOCeKmX5MUwnG0l8sUUAq6sYOFKB3
         Af7N6AoruyGSkDjlojUPramRmP2iu02zD8tnQlGq8XqHg5EwHtqIqX8yYHEVmYSKwp9P
         DOxA==
X-Gm-Message-State: ACrzQf2sEfpqBBguatWr4SsPO1cusm/M4l0d4qNaAIOeQbFHNpni+x8z
        scCpwuo4uY60eDcw49wmV/mkYg==
X-Google-Smtp-Source: AMsMyM7xAOLC+XQo96Ct3mZkMVxCdnxUdM0LcQO6uekjtAf2NwpxQvbTE/ou+6FzPD0SKXFoHM5tDQ==
X-Received: by 2002:a17:90b:3b43:b0:202:d053:d305 with SMTP id ot3-20020a17090b3b4300b00202d053d305mr7971031pjb.229.1663743130454;
        Tue, 20 Sep 2022 23:52:10 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5? ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm1121028plg.4.2022.09.20.23.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:52:09 -0700 (PDT)
Message-ID: <94ff2006-0051-19be-5eee-a5f71a07e26b@linaro.org>
Date:   Wed, 21 Sep 2022 12:22:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 6/9] crypto: qce: core: Add new compatibles for qce
 crypto driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, andersson@kernel.org, bhupesh.linux@gmail.com,
        davem@davemloft.net, Jordan Crouse <jorcrous@amazon.com>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
 <20220920114051.1116441-7-bhupesh.sharma@linaro.org>
 <b4016460-f43a-13f8-432e-47c27237e005@linaro.org>
 <9b111583-519b-95a6-15b5-243e88dc8d39@linaro.org>
 <37b509ff-4fc2-73f1-b135-c0930075ec29@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <37b509ff-4fc2-73f1-b135-c0930075ec29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 11:57 AM, Krzysztof Kozlowski wrote:
> On 21/09/2022 08:16, Bhupesh Sharma wrote:
>>
>>
>> On 9/20/22 8:42 PM, Krzysztof Kozlowski wrote:
>>> On 20/09/2022 13:40, Bhupesh Sharma wrote:
>>>> Since we decided to use soc specific compatibles for describing
>>>> the qce crypto IP nodes in the device-trees, adapt the driver
>>>> now to handle the same.
>>>>
>>>> Keep the old deprecated compatible strings still in the driver,
>>>> to ensure backward compatibility.
>>>>
>>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: herbert@gondor.apana.org.au
>>>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>> ---
>>>>    drivers/crypto/qce/core.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
>>>> index 63be06df5519..99ed540611ab 100644
>>>> --- a/drivers/crypto/qce/core.c
>>>> +++ b/drivers/crypto/qce/core.c
>>>> @@ -291,8 +291,17 @@ static int qce_crypto_remove(struct platform_device *pdev)
>>>>    }
>>>>    
>>>>    static const struct of_device_id qce_crypto_of_match[] = {
>>>> +	/* Following two entries are deprecated (kept only for backward compatibility) */
>>>>    	{ .compatible = "qcom,crypto-v5.1", },
>>>>    	{ .compatible = "qcom,crypto-v5.4", },
>>>
>>> This is okay, so there is no ABI break.
>>
>> Great. Thanks for the confirmation.
>>
>>>> +	/* Add compatible strings as per updated dt-bindings, here: */
>>>> +	{ .compatible = "qcom,ipq4019-qce", },
>>>> +	{ .compatible = "qcom,ipq6018-qce", },
>>>> +	{ .compatible = "qcom,ipq8074-qce", },
>>>> +	{ .compatible = "qcom,msm8996-qce", },
>>>> +	{ .compatible = "qcom,sdm845-qce", },
>>>> +	{ .compatible = "qcom,sm8150-qce", },
>>>> +	{ .compatible = "qcom,sm8250-qce", },
>>>
>>> This is a bit odd... you have 7 devices which are simply compatible or
>>> even the same. This should be instead one compatible.
>>>
>>> I don't really get why do you want to deprecate "qcom,crypto-v5.1".
>>> Commit msg only says "we decided" but I do not know who is "we" and "why
>>> we decided like this". If you want to deprecate it, perfectly fine by
>>> me, but please say in commit msg why you are doing it.
>>
>> I understand. This patchset has been in flight for some time and hence I
>> might have missed sharing some detailed information about the review
>> comments and rework done along the way (in the cover letter for this
>> series).
>>
>> Coming back to your concern, here is the relevant background:
>> - Please see:
>> https://lore.kernel.org/linux-arm-msm/20210316222825.GA3792517@robh.at.kernel.org/
>>
>> - Rob shared some comments on the v1 series regarding the soc-specific
>> compatibles. He mentioned in the above thread that 'you should stick
>> with SoC specific compatibles as *everyone* else does (including most
>> QCom bindings).'
>>
>> - So, while I had proposed "qcom,crypto-v5.1" (for ipq6018) and
>> "qcom,crypto-v5.4" (for sdm845, sm8150) etc. as the compatible(s) in the
>> v1 series, I shifted to using the soc-specific compatibles from the v2
>> series, onwards.
> 
> Then the reason could be - Reviewers preferred SoC-based compatible
> instead of IP-block-version-based.
> 
> What is confusing is the difference between that link and here. That
> link wanted to introduce 4 different compatibles... and here you have
> even 7 compatibles being the same.

The link points to v1 version and we are on v7 currently. So there have 
been other comments and reworks along the way :)

All of these have been referred to in the cover letter logs.

Again please refer to Vladimir's comments on v5 version here, where he 
suggested adding soc compatibles for 'ipq8074' and 'msm8996' as well.

- 
https://lore.kernel.org/lkml/7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org/
- 
https://lore.kernel.org/lkml/f5b7c89c-3bdd-1e1e-772e-721aa5e95bbf@linaro.org/
- 
https://lore.kernel.org/lkml/7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org/

Also the 7 SoC compatibles do not point to the same crypto IP version. 
We have two IP versions currently supported upstream, "qcom,crypto-v5.1" 
and "qcom,crypto-v5.4" (with patches for support for newer versions 
under work and can be expected to land upstream in near future).

However, if you suggest, we can add some comments in the dt-binding doc
to reflect which SoC supports which version.

>> - Basically, since we are going to have newer qce IP versions available
>> in near future, e.g. "qcom,crypto-v5.5" etc, and we will have 2 or more
>> SoCs also sharing 1 version, these compatibles would grow and become
>> more confusing. IMO, having a soc-specific compatible in such cases is
>> probably a much cleaner approach.
>>
>> Hope this helps answer some of your concerns and provides some relevant
>> background information.
> 
> Sure, but I still think you should have only one compatible in the
> driver in such case. You don't have differences between them from the
> driver point of view, so the devices seem to be compatible.
> 
> If not, what are the differences?

There can always be requirements for compatible specific handling done 
in the driver. See Bjorn's comment here for example: 
https://lore.kernel.org/lkml/YZKhqJuFlRVeQkCc@builder.lan/ , as an 
example of 'clk_get' calls conditional based on the compatible instead.

This series is to get some early comments and might need some further 
rework / rearrangement.

However, I would request Rob to share his views as well on the soc 
specific compatibles, since it was originally his suggestion. I can 
rework the patchset accordingly.

Thanks,
Bhupesh
