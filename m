Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96527660F48
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAGOBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjAGOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:01:02 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812D6E419
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 06:01:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay40so2892102wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2I/eTObjkPPviFPq7Ba0PIoAz1YjPpKFw7wwoFQUyM=;
        b=Uuo3wazl0s7stz9aUgPbZzWJdGAMJsNazthuQTP1ebqgibwyO8ovFHP85eK+QwFgbF
         DLLmDcMjOLNrvPvelMKrJ3cHmyhU9czB7UzCagzONp/YqN1H0v3nLjIBpPRGRXitEJIc
         bFyiFYbGUdq8RKMulVCuts+1Khe6NoBUIxLg+ZCooG1GtmtfePTucIn9OX2UNpHpt4yx
         3+TZnRiynDqJMAYhbqyeOf7J34xmOzbrUe2atkEdf+XL6GnxURMbwAzNMPRiMQ8ylRT5
         9FQhZrCi1Pl5o/lRZLX8MORoeC9VWnB9ZsIl51jzKoUGdFsg3CeTCVdibs5VsVIW3Jqr
         3i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2I/eTObjkPPviFPq7Ba0PIoAz1YjPpKFw7wwoFQUyM=;
        b=JRKxXGnKysH+JzxjfhMwR3CzSF5GEEKad9Jh1FZNNdiOJ/N9kiZA+xcGT63bJKdVws
         pqQuo1/22YMLw5Ts3WA0qflMOOnbyGoBWEVOxuGoSBJu828tErBQ83hKw8WbYd/mBrOx
         2eKmUEv432njKHp0qhBUnDJ2dqUBngGr06Rwd7fvEyU4UKkdiYhzLkxmhnfXcwOz2gPp
         jCHM+op4ZI2aP58j5vCkh86fPatIp+Qm3Q7b7fVMi1tB1DHMzWA2ZrDeQtt9onV/RyOs
         o0b60ttDkTDL5Tb8fndsUhKykay8Hv2FteFlk1GenoR4YItCHo9q+e8hjDDHXArnfC4i
         4TXg==
X-Gm-Message-State: AFqh2kqkAwy0jN8WRUZB2KzeudLq2Yv3K6ArgJcZybS5SF2OA8vKyVv+
        vb1IZ641g21pAD1Te06LCR4h2A==
X-Google-Smtp-Source: AMrXdXtSo5oyhzZvyF5i8un4Ys36MC38zJsfmQVtdvYCzcPvH/mOWXTNeLCt/YYFDgWzXtzB0Ha3ZA==
X-Received: by 2002:a05:600c:15c2:b0:3d3:5132:a637 with SMTP id v2-20020a05600c15c200b003d35132a637mr41543118wmf.18.1673100059210;
        Sat, 07 Jan 2023 06:00:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c0a0c00b003cfa81e2eb4sm5351404wmp.38.2023.01.07.06.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 06:00:58 -0800 (PST)
Message-ID: <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
Date:   Sat, 7 Jan 2023 15:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230105213856.1828360-1-andreas@kemnade.info>
 <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
 <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
 <20230107144336.2ecff4f9@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107144336.2ecff4f9@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2023 14:43, Andreas Kemnade wrote:
> On Sat, 7 Jan 2023 14:23:08 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 06/01/2023 20:33, Andreas Kemnade wrote:
>>> On Fri, 6 Jan 2023 09:41:01 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> On 05/01/2023 22:38, Andreas Kemnade wrote:  
>>>>> Currently make dtbs_check shows lots of errors because imx*.dtsi does
>>>>> not use single compatibles but combinations of them.
>>>>> Allow all the combinations used there.
>>>>>
>>>>> Patches fixing the dtsi files according to binding documentation were
>>>>> submitted multiple times and are commonly rejected, so relax the rules.
>>>>> Example:
>>>>> https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
>>>>>
>>>>> Reason: compatibility of new dtbs with old kernels or bootloaders.
>>>>>
>>>>> This will significantly reduce noise on make dtbs_check.
>>>>>
>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>> ---
>>>>>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 24 +++++++++++++++++++
>>>>>  1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>>>> index dc6256f04b42..118ebb75f136 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>>>> @@ -37,6 +37,30 @@ properties:
>>>>>            - fsl,imx8mm-usdhc
>>>>>            - fsl,imxrt1050-usdhc
>>>>>            - nxp,s32g2-usdhc    
>>>>
>>>> You must drop the items from enum above. Binding saying:
>>>> compatible="A"
>>>> or:
>>>> compatible="A", "B"
>>>>
>>>> is not correct. Either A is or is not compatible with B.
>>>>  
>>> hmm, here we have A = B + some additional features
>>> or
>>> A = B + some additional features and additional quirks required.  
>>
>> So why do you allow A alone?
>>
> because A is full-compatible, and B is half-compatible, because
> the additional required quirks are not applied.

As I explained you in private message you sent me:

That's not how compatibles are working. If device is not compatible with
B, then you cannot have it as fallback, so the patch is not correct.

If device is A and is compatible with B, then keeping A and A+B is also
incorrect because it is redundant.

This is not only here, it's everywhere, so I do not see the point to
make exception for this device. Patch is incorrect.

Best regards,
Krzysztof


>>>
>>> For the latter we have e.g.
>>> A=
>>> static const struct esdhc_soc_data usdhc_imx6sx_data = {
>>>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>>>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>>>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE
>>>                         | ESDHC_FLAG_BROKEN_AUTO_CMD23,
>>> };
>>> B=
>>> static const struct esdhc_soc_data usdhc_imx6sl_data = {
>>>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>>>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
>>>                         | ESDHC_FLAG_HS200
>>>                         | ESDHC_FLAG_BROKEN_AUTO_CMD23,
>>> };
>>>
>>> so there is the difference in ESDHC_FLAG_STATE_LOST_IN_LPMODE.
>>> That might make no difference in some usage scenario (e.g. some bootloader
>>> not doing any LPMODE), but I wonder why
>>> we need to *enforce* specifying such half-compatible things.  
>>
>> I asked to remove half-compatible. Not to enforce.
>>
> well B is half-compatible, I (and others) have sent patches to remove,
> but they were rejected. I consider these patches the way to go.

No, they are not correct.

Best regards,
Krzysztof

