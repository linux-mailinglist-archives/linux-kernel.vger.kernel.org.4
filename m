Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D36C1BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCTQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCTQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:34:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E91FF2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:27:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so2099408eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679329644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnwEPxx5YL7Zi9KDhWj9Zn5PB5/beeG3PJ/g8T7eV2A=;
        b=xRcg+DCrSBd/eo+qM0Lw4k0Vt8NlLOOh1A3iakfND6UM34tnNbgLXSoa8tQ0643p4j
         DJcZZ9pZ4pSmJf+q7NSbi4iNO1V0OKB7oshHqnN86H2OGSweWdKpXAyiS+nINaiZKv40
         5jLYZ6OUxuykProx0xFju8xLeQb61h+pf6sB6OqW9TOUqhQfG4CThGLnMD5OSwSOP8J8
         p1N2HqgnfCQWiuyJt1H6588nhuWjKxktwKWH4m1SXzQbSSog9XiuR/OzBgerpzIMZsc3
         9z0qF1JmwUpBSFeUGN8NjLGvzTSECMvi+l1Tk4lo9vl7Ig50bwHLL0LuFSt/hBOKTgRP
         /Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnwEPxx5YL7Zi9KDhWj9Zn5PB5/beeG3PJ/g8T7eV2A=;
        b=oHJlD9SX30CLdH0mLtrdy8MEPz6UJgGVg/M6F+MUlkRPZQWJ0NjX9TBtUhEvM56NkG
         RrJEIYatemj4gIbNlXCP9X7Y6D1pFSLjMQA1qq2o+zuHl+xj3pxYmcrzfqxjVbUw15Xm
         8uxWO70QSoe07qPHrqxPP1Zl0XNXk57ahURoQwNaPbz3eTusoF6AA6P/jdFNCjwpKMRh
         NWAZ8NdWnget7JnmO7ei4L0rHnyL2AUjPnEtZVVnlL33UVND4lOxSUnGwbLgmO+0yRrI
         +i/NHOtwiGCEArd6SWBZ4Nxxas+c4FGgdXyjQXUxhIgBF9Nq48DiwIQlo72aQRe53R3G
         Njtg==
X-Gm-Message-State: AO0yUKU0czd8CtJjw8Rf5pJsL8E4Tb+jDnaGP9ndFXAz5m+EBxQyqbWg
        Q90iyzApeflzNl0L2w6l+gtB3A==
X-Google-Smtp-Source: AK7set/Pob6U/DYlrD/H/KyyBeppvFxPMq7piDaQGnQG1fbu46kGcOBrV0ICBwN/T15mV1Z0zOGACw==
X-Received: by 2002:a17:906:2b56:b0:922:d34e:2ba1 with SMTP id b22-20020a1709062b5600b00922d34e2ba1mr10035489ejg.63.1679329644492;
        Mon, 20 Mar 2023 09:27:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709064d0500b00923f05b2931sm4588816eju.118.2023.03.20.09.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:27:23 -0700 (PDT)
Message-ID: <fc5c76d1-51cd-5992-9bfa-06f57874fc03@linaro.org>
Date:   Mon, 20 Mar 2023 17:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
To:     Frank Li <frank.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
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
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
 <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
 <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
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

On 20/03/2023 17:22, Frank Li wrote:
>>>>>>> +  assigned-clocks:
>>>>>>> +    items:
>>>>>>> +      - description: Phandle and clock specifier of
>> IMX_SC_PM_CLK_PER.
>>>>>>> +      - description: Phandle and clock specifoer of
>>>> IMX_SC_PM_CLK_MISC.
>>>>>>> +      - description: Phandle and clock specifoer of
>>>>>> IMX_SC_PM_CLK_MST_BUS.
>>>>>>> +
>>>>>>> +  assigned-clock-rates:
>>>>>>> +    items:
>>>>>>> +      - description: Must be 125 Mhz.
>>>>>>> +      - description: Must be 12 Mhz.
>>>>>>> +      - description: Must be 250 Mhz.
>>>>>>
>>>>>> I would argue that both properties above are not needed. If your
>>>>>> hardware requires fixed frequencies, clock provider can fix them, can't
>> it?
>>>>>
>>>>> Clock provider don't know fixed value and turn on only used by client.
>>>>
>>>> So maybe fix the clock provider? Or this device driver? Requiring by
>>>> binding specific frequencies for every board is a bit redundant.
>>>
>>> It is not for every boards, it is common for a chip family.  Only a place to set
>> for
>>> QM and QXP.
>>>
>>> The similar case is network driver, which require a specific frequency at
>> clock assign.
>>> Generally frequency is fixed,  clock source name may change at difference
>> chips.
>>
>> If frequency is always fixed, I don't understand why this is in DT
>> bindings. I would even say it should not be in DTS. We don't put into
>> DTS properties which are always the same, because otherwise they would
>> grow crazy big.
> 
> Although frequency is fixed, clock name may change for difference platform.
> 
>                 assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
>                                  	     <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
>                                  	     <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
>                assigned-clock-rates = <125000000>, <12000000>, <250000000>;
>  
> some platform use IMX_SC_R_USB_2, other platform may use IMX_SC_R_USB_3.

This I understand, you wrote it above, so nothing new and my concerns
are still there.

Best regards,
Krzysztof

