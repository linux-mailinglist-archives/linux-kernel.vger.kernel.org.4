Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322AA63B404
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiK1VMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiK1VMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:12:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50065FC2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:12:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id be13so19433472lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Wg0FgM2Orw88oTGpYnOUGrRTtFH/7dZwXha7m3Sb08=;
        b=j4YxivKfu8MyQ0dLW0qfVvluU36t7AQnA4ZjkVERLv18LWW3+Q7aBKSo+pdlkRik+y
         dF8K3U1nIIOkBUDayIR+LGOqTyRSg+3CXJog8ns4nXkt5gU2DJKJ/5BEjonEbOxOoou/
         d9zSaV/Vet6flJWHpyc58ZHof0HFvA7jecTTEUwcpSVE2/xK7AaU8laWap6N9FTBVglL
         v0ZT9E+cMklQk8PiKvUmxI2+RF2bs0NShVH15uOQjMZWYPNYfCcnwhj3IRYP/osQG+q0
         XJ95met7AKXYSYo5FadJpTHhoclQreI0QB/jpR4Qmpt8z1qVfYJqcmxfw20l94gGbaME
         GyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wg0FgM2Orw88oTGpYnOUGrRTtFH/7dZwXha7m3Sb08=;
        b=wRuvq2Se/r/Z6VXyb/iGz/0GabvZubvVg92GnsSKB+sHE2K6nAhww43XtjEsNYbLVZ
         W1Gm3ud/HfFwhZhxgCRibk6l9VGtLBaDNs9m9MRRm1zpqkffgQjoTSRuvWmKPjqr17yR
         gIHAeQDZ/9R/d8F/uB8JjyjYC9AuzwMdzvha1A4jwkLO9objVuJSHrCZjcPf1fnmir05
         Uh7Zq13FLHoc8V+eyy03hOBvG9ORpG2q6+nqERtKXl9Tuqif2cwvyEc8lPpSytpurpJj
         LZWNrol5jXCBjte+M+tqMr8DsdmcjWPOTevcM0RX3yIcgNiA0RKgIzXreJgdPPTVXMP1
         3R9Q==
X-Gm-Message-State: ANoB5pnvP2aby3Peb5O1SSZDnf4GGRIM2I2JiN1oAErOgTBa0pnakb/I
        DjisITRcG6yNZmVcJmLC70dKhw==
X-Google-Smtp-Source: AA0mqf5NrZJbHLEbExj+hXBM+igCd5Wmefbf4DR51zlmRJrxDv9pmNXUka4OCThviiOrgFyIE9w5TA==
X-Received: by 2002:ac2:4bd4:0:b0:4b4:aed7:4aa5 with SMTP id o20-20020ac24bd4000000b004b4aed74aa5mr11972463lfq.447.1669669927117;
        Mon, 28 Nov 2022 13:12:07 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id k5-20020ac257c5000000b004a2511b8224sm1859403lfo.103.2022.11.28.13.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 13:12:06 -0800 (PST)
Message-ID: <e8524b45-8d85-d491-d9b9-749d3c1c7a92@linaro.org>
Date:   Mon, 28 Nov 2022 22:12:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>,
        =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125223400.94515-1-matti.lehtimaki@gmail.com>
 <90d231c6-1f16-74ea-ddf7-5e09a51a93ea@gmail.com>
 <cce01dbd-e2b7-3d6b-9c83-af3790f3ee89@linaro.org> <1912229.PYKUYFuaPT@g550jk>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1912229.PYKUYFuaPT@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.11.2022 22:06, Luca Weiss wrote:
> On Montag, 28. November 2022 21:59:06 CET Konrad Dybcio wrote:
>> On 28.11.2022 18:01, Matti Lehtimäki wrote:
>>> On 28.11.2022 16.41, Konrad Dybcio wrote:
>>>> On 25.11.2022 23:34, Matti Lehtimäki wrote:
>>>>> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
>>>>> b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts index
>>>>> 1c52337af560..859e91c16c61 100644
>>>>> --- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
>>>>> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
>>>>> @@ -133,7 +133,8 @@ wcnss@d200000 {
>>>>>               no-map;
>>>>>           };
>>>>>   -        adsp@d900000 {
>>>>> +        /delete-node/ adsp@dc00000;
>>>>
>>>> Please delete nodes by referencing the label like so:
>>>>
>>>> /delete-node/ &adsp_region;
>>>
>>> When I created the devicetree I was asked to do the opposite for the
>>> smem_region [1] which I had originally deleted using the label near top of
>>> the file but then moved next to the relevant node, where I cannot use
>>> label when deleting it. Should the smem_region also be moved to the top
>>> of the file if I move this delete-node there so the file would be
>>> consistent?
>> In [1] you were asked to move the delete-node statement, not to alter
>> the argument. Referencing nodes by label is allowed globally in the DTS.
>> The removal should stay inside reserved-memory.
> 
> Having e.g. this doesn't build, you get "syntax error" error
> 
>   reserved-memory {
>       /delete-node/ &venus_region;
>   };
> 
> Not sure exactly why, but that's the reason everything's outside of the root 
> node if you use labels (don't ask me why labels lead to syntax error but 
> specifying the name manually works)
> 
Hm.. The DT spec does not seem to limit where this syntax should work..
Perhaps it's a bug in DTC then.

Unless it does and I simply don't see it.

Konrad
>>
>> Konrad
>>
>>> [1]
>>> https://lore.kernel.org/linux-arm-msm/CAA8EJpqUH_v1GXEYF62Z3DBtFu_305_h4D
>>> 36aCnBr38bo5HoJw@mail.gmail.com/
> 
> 
> 
> 
