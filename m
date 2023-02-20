Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682C069CB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjBTNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBTNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:10:07 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE19D538
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:10:04 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b13so2084391ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXPP8v5Me9ivNoHQ306aXdAuISsblqiSjG1puCpj0yQ=;
        b=R84wIUvdDXaOchL9oK69XjlSdwtT1eJGbkMutWTGmyGgOFMn+1/F2qxZBDj4gH8QcR
         Zx5M97qEXj2qZ1qk299LPooHL5gW/BccECBM+69IIhWCCQBAoTD4um34lv2SNbGQUZjJ
         ibYe4mSvY50GvzHjwqJ0ToxD8kqEd5sGCJW8Hyxm3gb8vMUgBgo6Bn2IL0+y6aOyDOlx
         4iAtGB4nf9td+arSNz6hCW/I6odo1GzR7VsPrg35mo2LHZt+42R1fp66c6CAlobE66zI
         d1lRYrHDXrEFu+D6NRzddEUaudMScskhvo0sF2xM6IKbbOyK2lUQjAeExQ8z/RJ7+rsV
         adyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXPP8v5Me9ivNoHQ306aXdAuISsblqiSjG1puCpj0yQ=;
        b=5Qi53HEsX9S+LtYZeHw4Ee1cObQq50jbb0sR252pEMebnnJjjOgEYFtYY7ZhEMARSs
         6DA7feGIk86inrpdvWRPLpnlFzbjzBreT+KlfBGHLxBxotf1W57EJjiIM2VGYoN9kxQa
         hUlKuUYy/y4htDiDeUAvTW4yQD8JlobrAdJ3yA/46Zu5CRFDINJHYwaGSY7L0fHQYqZg
         +YjTA6S+W2BxYZSV+/VFPjspyB9bs52YJwIWoqvtEYcP3k8CfTupJuReMY2f6gaD7ypp
         gOIynEP0UMCns1BJi7njgP4h2wHTxG/qhK2bKotz7KIX0OiDEBv7pzb/udsfU4CPEBwx
         potw==
X-Gm-Message-State: AO0yUKWOKgOmNZiomBRGAXgqas4MGeF91rsUBfBkTMgDzncaSgsozK3N
        VfqIco7SmlI0bmg/oeP9bJVCCw==
X-Google-Smtp-Source: AK7set/5hkcbqDQjuszf4v7bV6XAO+pNUKVXF/eLSFcvADD1XSYN5HZGhYOgH/zB9LAx1JZo9yuaPQ==
X-Received: by 2002:a2e:a4a9:0:b0:294:66bc:7605 with SMTP id g9-20020a2ea4a9000000b0029466bc7605mr435943ljm.30.1676898602985;
        Mon, 20 Feb 2023 05:10:02 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id t28-20020a2e8e7c000000b002946be8475esm341419ljk.135.2023.02.20.05.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:10:02 -0800 (PST)
Message-ID: <22c180ed-0ef9-7ef5-9c13-31fd658e5fa8@linaro.org>
Date:   Mon, 20 Feb 2023 14:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 2/6] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-2-67aed8fdfa61@linaro.org>
 <20230217231330.GA2238521-robh@kernel.org>
 <c2bfa6b0-edee-b492-d40e-cf43291b90d4@linaro.org>
 <1274e18b-e35e-7997-68ea-22aa11592720@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1274e18b-e35e-7997-68ea-22aa11592720@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.02.2023 12:27, AngeloGioacchino Del Regno wrote:
> Il 18/02/23 01:26, Konrad Dybcio ha scritto:
>>
>>
>> On 18.02.2023 00:13, Rob Herring wrote:
>>> On Fri, Feb 17, 2023 at 12:08:25PM +0100, Konrad Dybcio wrote:
>>>> CPR3 and newer can be fed per-OPP voltage adjustment values for both
>>>> open- and closed-loop paths to make better decisions about settling
>>>> on the final voltage offset target. Document these properties.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>   .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
>>>>   1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>>>> index a30ef93213c0..93cc88434dfe 100644
>>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>>>> @@ -34,6 +34,20 @@ patternProperties:
>>>>           minItems: 1
>>>>           maxItems: 2
>>>>   +      qcom,opp-cloop-vadj:
>>>> +        description: |
>>>> +          A value representing the closed-loop voltage adjustment value
>>>
>>> A value?
>>>
>>>> +          associated with this OPP node.
>>>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>>>> +        maxItems: 2
>>>
>>> Or 2 values?
>> Right, this description doesn't make any sense if you're just
>> looking at the documentation without looking at the driver..
>>
>> Generally, each CPR3 instance can have multiple "threads"
>> (each one of which regulates voltage for some on-SoC IP or
>> part of it). The nth entry in the qcom,opp-[co]loop-vadj
>> array corresponds to a voltage offset for the nth thread.
>>
>> If the nth entry in the array is missing, the driver assumes
>> the arr[0] one is "global" to this CPR3 instance at this OPP
>> level and applies it to all threads. ...and looking at it
>> again, this is sorta just bad design, especially if you
>> take into account that there's no known user of CPR3 that
>> employs more than 2 threads.
>>
>> I'll remove that from the driver and make the description clearer.
>>
> 
> description:
>   Represents the closed-loop voltage adjustment associated with
>   this OPP node.
> 
> P.S.: Drop '|' here and on oloop!
> 
> This binding is intended to support either single or multiple CPR threads;
> the driver's behavior is unimportant as bindings describe the hardware,
> not the driver.
Correct, but specifying just one value regardless of the number of threads
is not in the spirit of representing things clearly. These properties do
not describe the hardware. They let us pass configuration values that are
specific to the SoC hosting the CPR, not to the CPR itself.

Konrad
> 
> Regards,
> Angelo
> 
>>
>> Also, only noticed now.. "qcom,sdm630-cprh" was not documented,
>> so that's to be fixed for the next submission as well!
>>
>>
>> Konrad
>>>
>>>> +
>>>> +      qcom,opp-oloop-vadj:
>>>> +        description: |
>>>> +          A value representing the open-loop voltage adjustment value
>>>> +          associated with this OPP node.
>>>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>>>> +        maxItems: 2
>>>> +
>>>>       required:
>>>>         - opp-level
>>>>         - qcom,opp-fuse-level
>>>>
>>>> -- 
>>>> 2.39.1
>>>>
> 
> 
> 
