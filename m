Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061156C58E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCVViL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCVViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:38:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA512071
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:38:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ew6so15684512edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679521087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrjlrNcfn2mmziEO3x+pNGeDWkarVNn7kINkXKyOq2Y=;
        b=u1Hvbp9SHZUSkEDpNJ0aD7ieE0m7D4nAS7Y6lSvET7/Dwdok6RuddmpbqRYy5PPaC/
         E3yQGWAXE0WEx7/+eFQaXj+UIcAjUmxD1vJ5t5DOeDEhSs75qAC3xyKOuyiSJI8FXjL3
         z4C8JC3K8CDFn7jUWh8Jp2/tff3MY/yGGzncN30J+6vG63ZRPhsMavcnjEsH5bUtDl0k
         skJwwrCVIwokjeIGaDB0bk6s/QYn9SAHW9SVxILuovJrtNRJz2JUwY7aPlTg/0oeAh++
         omx1YqfHayXeykaRexdNpkYUlE+OTr7ln4w5+k/tkVpmh+FLZTcYVACsSvXDmNs48kGF
         OcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679521087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrjlrNcfn2mmziEO3x+pNGeDWkarVNn7kINkXKyOq2Y=;
        b=gA+k8BKfK12NmIUyS+2xWt8KzsTYRVBFF9z0L1BupnAJ95mmOZfnn9EDcQjTzNFtzZ
         xmgVGldqbMhsJdsLSuZcHzG4P9Yh/BztAYnUR8gsEvcV/1n9qMxWGEQ+Gf/2lYf3Zt/x
         ZaAxoklnigSEFjp/iWmgPFG4qQHYjZOmhlHTS6zSOah+cf3kdL1lrm1S/lJANpWgZsOK
         9JpgyPiCfzm0BXZ1adErAlVc/tGjkN6cON3QvFqwoVXKcwRizoFcFkAUQXU5iCsOqqsv
         g3kPJ5fzmOWQ6tLqk7FF78eDKqBRpOx6cBhfOm65Q+0hkE1o5oBvNzoDqX2gRvEUElyN
         hsZg==
X-Gm-Message-State: AO0yUKXVpr0wo8bcquPtBy3Rpuf6vWrvK8Xw1fQn2cm/9R3MIOz8pa7R
        fAQfs1IOTsdNQnFGa4vn8kUBIw==
X-Google-Smtp-Source: AK7set+k9ltTTvSqmwn/z4nRY3/pstfnsddGGJqfFmR31mGM6fBJouZlScKgS8g5Y+De28klXKy4eg==
X-Received: by 2002:a17:906:2753:b0:908:7fed:f0f with SMTP id a19-20020a170906275300b009087fed0f0fmr9139652ejd.42.1679521087215;
        Wed, 22 Mar 2023 14:38:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:626d:5729:6e71:4c22? ([2a02:810d:15c0:828:626d:5729:6e71:4c22])
        by smtp.gmail.com with ESMTPSA id zc14-20020a170906988e00b00927f6c799e6sm7797581ejb.132.2023.03.22.14.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:38:06 -0700 (PDT)
Message-ID: <835cda64-5d42-1ff3-aa8f-0802fe3d705f@linaro.org>
Date:   Wed, 22 Mar 2023 22:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
 <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
 <AM6PR04MB483828FC1083E3C98930DF6488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b5d67af0-ed08-e243-2c0c-92f1f002e552@linaro.org>
 <AM6PR04MB483841E17BEEE4F9EC596DBA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB483841E17BEEE4F9EC596DBA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 22:36, Frank Li wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, March 22, 2023 4:32 PM
>> To: Frank Li <frank.li@nxp.com>
>> Cc: devicetree@vger.kernel.org; festevam@gmail.com; imx@lists.linux.dev;
>> kernel@pengutronix.de; krzysztof.kozlowski+dt@linaro.org; linux-arm-
>> kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de;
>> shawnguo@kernel.org
>> Subject: Re: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
>> imx8qm cdns3 glue bindings
>>
>> Caution: EXT Email
>>
>> On 22/03/2023 15:34, Frank Li wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Wednesday, March 22, 2023 2:32 AM
>>>> To: Frank Li <frank.li@nxp.
>>>>> +      - const: usb3_aclk
>>>>> +      - const: usb3_ipg_clk
>>>>> +      - const: usb3_core_pclk
>>>>> +
>>>>> +  assigned-clocks:
>>>>> +    items:
>>>>> +      - description: Phandle and clock specifoer of
>>>> IMX_SC_PM_CLK_MST_BUS.
>>>>
>>>> Drop useless pieces so "Phandle and clock specifoer of " and name the
>>>> hardware, not the syntax.
>>>>
>>>>> +
>>>>> +  assigned-clock-rates:
>>>>> +    items:
>>>>> +      - description: Should be in Range 100 - 600 Mhz.
>>>>
>>>> That's better but I still do not understand why do you need it in the
>>>> bindings. You never actually answered this question.
>>>
>>> I am not sure 100% sure the reason.
>>> I think difference system target's  axi bus frequency is difference,
>>> And just one time work, needn't software to manage it.
>>> Following other driver's code style may be another reason.
>>
>> That's the reason of heaving it in DTS. But I am asking about bindings.
>> You do understand you define here interface?
> 
> I defined here is descript AXI frequency for usb controller. Supposed difference
> Platform will have difference working frequency.  

I don't understand how does this answer my concerns of having it in DT
bindings. If you do not add it, you "will have difference working
frequency", so what's the point?

Best regards,
Krzysztof

