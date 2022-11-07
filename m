Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD061EE38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiKGJHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiKGJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:07:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96A165A7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:07:49 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d6so15840274lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tar8Dp4mljhBmjwrdOwrws2ECC/3EaCdTGBDIP/7cts=;
        b=BxRh6u+y7OSEEJbIVgnLJWd4UhFNfi+A9TYGGnXSAWlW1GPM9LEHnPfkh1nMBFmU9j
         fQJc/xqKeyab4d5Hu5TZ+yTp4G/i/sFb0wUYLiX4xBibXvTPj8XHbAgg1wkti4L34art
         npAj/oK0g4681MLXBAtw8xqQIfCgelRM3bBFgL6tOKNFgNCX6fLq1d9GBzK4SL/XRELR
         AJZOaaEmV1wQH09Y6+3riOZ7+q0i4xQt3+I67VdKdAxkMZXvfTiKw2XjwGy9jKWQdb0X
         GWcAERu+Mr0GXMrg33GXsiH/4dtMTC5A0oeQIIVTH27+4XkXNglctDKAo/VN7ahbu0BU
         Swzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tar8Dp4mljhBmjwrdOwrws2ECC/3EaCdTGBDIP/7cts=;
        b=mnL4oDm/h9uIXfDGH4MXF09DzlkW3BHo78reWIspxWU47nPk/zkqC3YfgmYBicero7
         OlrIiAdt+0lwN7qIYGQeJvlxlHF5cnFO2UDlcKJS9xtnYZY8cddiAPvo3s5pxlE2I+Xs
         oVUrgJeO8XkLtIRFfC6II1RHreP4wwMDwFHxAUscSwJqYMQyYfsiEaYmZ6gnWzlEHt1f
         r6mJpVu7Z+tjgwgNurX236Vdr4wnBG77rxsWX8oup4kW/ZEvBy+gWjbl9BcR7GZ6Zv1+
         /lRNxTy341MBLBAxiHA2YJpOPWLWJeU4qQOFeOAdUDQOCjEj0nxVDphu80p22rBixhQo
         soNg==
X-Gm-Message-State: ACrzQf2J4ZvQbkgPS3gYuEJ/3DsNXXPi17KPL+QDvjtT/Y3bHAfiXpO8
        9zD4mwuXKPQEMKntNYw0ZsQBjii3dPByKw==
X-Google-Smtp-Source: AMsMyM5ZtVrYCA930ehbNLYtzdGYkU20aC73QbF8WB8lmIU8GvucDIvQb4VYEHEXoykNpriHqtXu1g==
X-Received: by 2002:ac2:551c:0:b0:4a2:3c32:aff5 with SMTP id j28-20020ac2551c000000b004a23c32aff5mr19188188lfk.31.1667812067548;
        Mon, 07 Nov 2022 01:07:47 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j13-20020a2e824d000000b0026c2d2a9b92sm1088312ljh.101.2022.11.07.01.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:07:46 -0800 (PST)
Message-ID: <ff0a5f73-b45e-b670-e36f-d3002180fa3e@linaro.org>
Date:   Mon, 7 Nov 2022 10:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 6/9] crypto: qce: core: Add new compatibles for qce
 crypto driver
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
 <20220920114051.1116441-7-bhupesh.sharma@linaro.org>
 <b4016460-f43a-13f8-432e-47c27237e005@linaro.org>
 <9b111583-519b-95a6-15b5-243e88dc8d39@linaro.org>
 <37b509ff-4fc2-73f1-b135-c0930075ec29@linaro.org>
 <94ff2006-0051-19be-5eee-a5f71a07e26b@linaro.org>
 <20221107034343.iyknmiztjuxcuqqs@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107034343.iyknmiztjuxcuqqs@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 04:43, Bjorn Andersson wrote:
> On Wed, Sep 21, 2022 at 12:22:03PM +0530, Bhupesh Sharma wrote:
>> On 9/21/22 11:57 AM, Krzysztof Kozlowski wrote:
>>> On 21/09/2022 08:16, Bhupesh Sharma wrote:
>>>>
>>>>
>>>> On 9/20/22 8:42 PM, Krzysztof Kozlowski wrote:
>>>>> On 20/09/2022 13:40, Bhupesh Sharma wrote:
>>>>>> Since we decided to use soc specific compatibles for describing
>>>>>> the qce crypto IP nodes in the device-trees, adapt the driver
>>>>>> now to handle the same.
>>>>>>
>>>>>> Keep the old deprecated compatible strings still in the driver,
>>>>>> to ensure backward compatibility.
>>>>>>
>>>>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>>> Cc: herbert@gondor.apana.org.au
>>>>>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>>>> ---
>>>>>>    drivers/crypto/qce/core.c | 9 +++++++++
>>>>>>    1 file changed, 9 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
>>>>>> index 63be06df5519..99ed540611ab 100644
>>>>>> --- a/drivers/crypto/qce/core.c
>>>>>> +++ b/drivers/crypto/qce/core.c
>>>>>> @@ -291,8 +291,17 @@ static int qce_crypto_remove(struct platform_device *pdev)
>>>>>>    }
>>>>>>    static const struct of_device_id qce_crypto_of_match[] = {
>>>>>> +	/* Following two entries are deprecated (kept only for backward compatibility) */
>>>>>>    	{ .compatible = "qcom,crypto-v5.1", },
>>>>>>    	{ .compatible = "qcom,crypto-v5.4", },
>>>>>
>>>>> This is okay, so there is no ABI break.
>>>>
>>>> Great. Thanks for the confirmation.
>>>>
>>>>>> +	/* Add compatible strings as per updated dt-bindings, here: */
>>>>>> +	{ .compatible = "qcom,ipq4019-qce", },
>>>>>> +	{ .compatible = "qcom,ipq6018-qce", },
>>>>>> +	{ .compatible = "qcom,ipq8074-qce", },
>>>>>> +	{ .compatible = "qcom,msm8996-qce", },
>>>>>> +	{ .compatible = "qcom,sdm845-qce", },
>>>>>> +	{ .compatible = "qcom,sm8150-qce", },
>>>>>> +	{ .compatible = "qcom,sm8250-qce", },
>>>>>
>>>>> This is a bit odd... you have 7 devices which are simply compatible or
>>>>> even the same. This should be instead one compatible.
>>>>>
>>>>> I don't really get why do you want to deprecate "qcom,crypto-v5.1".
>>>>> Commit msg only says "we decided" but I do not know who is "we" and "why
>>>>> we decided like this". If you want to deprecate it, perfectly fine by
>>>>> me, but please say in commit msg why you are doing it.
>>>>
>>>> I understand. This patchset has been in flight for some time and hence I
>>>> might have missed sharing some detailed information about the review
>>>> comments and rework done along the way (in the cover letter for this
>>>> series).
>>>>
>>>> Coming back to your concern, here is the relevant background:
>>>> - Please see:
>>>> https://lore.kernel.org/linux-arm-msm/20210316222825.GA3792517@robh.at.kernel.org/
>>>>
>>>> - Rob shared some comments on the v1 series regarding the soc-specific
>>>> compatibles. He mentioned in the above thread that 'you should stick
>>>> with SoC specific compatibles as *everyone* else does (including most
>>>> QCom bindings).'
>>>>
>>>> - So, while I had proposed "qcom,crypto-v5.1" (for ipq6018) and
>>>> "qcom,crypto-v5.4" (for sdm845, sm8150) etc. as the compatible(s) in the
>>>> v1 series, I shifted to using the soc-specific compatibles from the v2
>>>> series, onwards.
>>>
>>> Then the reason could be - Reviewers preferred SoC-based compatible
>>> instead of IP-block-version-based.
>>>
>>> What is confusing is the difference between that link and here. That
>>> link wanted to introduce 4 different compatibles... and here you have
>>> even 7 compatibles being the same.
>>
>> The link points to v1 version and we are on v7 currently. So there have been
>> other comments and reworks along the way :)
>>
>> All of these have been referred to in the cover letter logs.
>>
>> Again please refer to Vladimir's comments on v5 version here, where he
>> suggested adding soc compatibles for 'ipq8074' and 'msm8996' as well.
>>
>> -
>> https://lore.kernel.org/lkml/7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org/
>> -
>> https://lore.kernel.org/lkml/f5b7c89c-3bdd-1e1e-772e-721aa5e95bbf@linaro.org/
>> -
>> https://lore.kernel.org/lkml/7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org/
>>
>> Also the 7 SoC compatibles do not point to the same crypto IP version. We
>> have two IP versions currently supported upstream, "qcom,crypto-v5.1" and
>> "qcom,crypto-v5.4" (with patches for support for newer versions under work
>> and can be expected to land upstream in near future).
>>
>> However, if you suggest, we can add some comments in the dt-binding doc
>> to reflect which SoC supports which version.
>>
>>>> - Basically, since we are going to have newer qce IP versions available
>>>> in near future, e.g. "qcom,crypto-v5.5" etc, and we will have 2 or more
>>>> SoCs also sharing 1 version, these compatibles would grow and become
>>>> more confusing. IMO, having a soc-specific compatible in such cases is
>>>> probably a much cleaner approach.
>>>>
>>>> Hope this helps answer some of your concerns and provides some relevant
>>>> background information.
>>>
>>> Sure, but I still think you should have only one compatible in the
>>> driver in such case. You don't have differences between them from the
>>> driver point of view, so the devices seem to be compatible.
>>>
>>> If not, what are the differences?
>>
>> There can always be requirements for compatible specific handling done in
>> the driver. See Bjorn's comment here for example:
>> https://lore.kernel.org/lkml/YZKhqJuFlRVeQkCc@builder.lan/ , as an example
>> of 'clk_get' calls conditional based on the compatible instead.
>>
> 
> How about providing a generic compatible without the version number
> (i.e. qcom,crypto) and then in the DT binding require this and
> qcom,<platform>-crypto, and if we have such quirky integration behavior
> for a particular platform we can add the special handling in the driver
> for the platform compatible.
> 
> (And we obviously keep the two existing version-based compatibles in the
> driver, for backwards compatibility)

In general, compatibles should not be generic, just like wild-cards or
family-types. All are discouraged because they do not reflect hardware
or cause troubles later, when it turns out generic is not generic
enough... We had such cases where a wild-card (which is another way to
represent a "generic" compatible) turned out to be incompatible with a
specific version matched by it.

What are you going to do when this happens? Have a generic compatible
which covers only some of implementations? Using a generic compatible
for specific hardware is admitting "we do not know what is generic, so
we make something up and hope it stays generic".


Best regards,
Krzysztof

