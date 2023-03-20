Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7766C1922
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjCTPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjCTPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:30:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9738E9D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:23:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so48282195edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679325783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVDaPGZx45ChPaTeFiNTT081faxaJUHl/4AYKG0K8nc=;
        b=u0Z+zKW9ItGEoMrinilBDZOfUYce2FROOZ5X1gNAPdIw7YZ3OAVs7422euKcy1CJN1
         cTj5SfsWPWeVMybfb8kwtN+BD7kpjKs+lzrMGmyZMaN/5Vjt7mel7qp2/r4KZmEE160J
         BrZvomm3KI//fIKent9LE9piMty3D64ogbRerTfWH64PNnbMoHwnCEv5+25bnQBrcKT/
         UxoUr8feDXRmHts0yZ2Jqdc3u+Rhbng8G/gfiIX6nkSfxcRz1CnpgO8TVrk12u+yMRGc
         GZI8mTg1C6SCZuUKBmUUztL3TF297XcMeY3CfTZG/aaWAbIHrHC5YWGWP3J0DpR5s+Mz
         Eu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVDaPGZx45ChPaTeFiNTT081faxaJUHl/4AYKG0K8nc=;
        b=mE4Jc95zmnSLI9mPuLVkPDfVMlxaIIjxNIHoE1vdK4BgPZz3ro2mly/j5jxggfDiHh
         /NPnwkd96piZRGxHyUuMIbiDwVbVvPm2D0hly9yPhr8o+PTSQVncFL58SmcnQbmsVJtv
         B5Ozlti9e+K7z8VC8c+QNpTWKo+DgO83qhEFl3c+DQABopPDnAsOEc9Cjtnj1EfxDCUu
         QDzDB2eJys+vnRihon8LqRncshIYtvNH+N9GkSEzLBP8kMtuLtVJt5fk3jBi6xdt/GQi
         FtcbryGFDlEkYwdvzA6iLcE2aQIda+b/5zTSm4Xl7J81ehulVlvOy3ocH6vIbc3OjstC
         cytQ==
X-Gm-Message-State: AO0yUKW4bn+M+SqJNJ8SV4kcTeHnmqmmyen5e6u/PdDvBiwFKwTC5a1n
        SgOnHKQVsAK/hQXc2HDarA//3Q==
X-Google-Smtp-Source: AK7set+tObm2TN65SCsQ06miimyVjfZ4uqz/BCzZulB+hm0vvsB0q9UQ4f+/BsMP4Dto4Ye0t1TjJA==
X-Received: by 2002:aa7:d713:0:b0:500:5627:a20b with SMTP id t19-20020aa7d713000000b005005627a20bmr7785052edq.1.1679325783402;
        Mon, 20 Mar 2023 08:23:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id j30-20020a508a9e000000b004af5968cb3bsm4971494edj.17.2023.03.20.08.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:23:02 -0700 (PDT)
Message-ID: <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
Date:   Mon, 20 Mar 2023 16:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
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

On 20/03/2023 15:49, Frank Li wrote:
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: usb3_lpm_clk
>>>>> +      - const: usb3_bus_clk
>>>>> +      - const: usb3_aclk
>>>>> +      - const: usb3_ipg_clk
>>>>> +      - const: usb3_core_pclk
>>>>> +
>>>>> +  assigned-clocks:
>>>>> +    items:
>>>>> +      - description: Phandle and clock specifier of IMX_SC_PM_CLK_PER.
>>>>> +      - description: Phandle and clock specifoer of
>> IMX_SC_PM_CLK_MISC.
>>>>> +      - description: Phandle and clock specifoer of
>>>> IMX_SC_PM_CLK_MST_BUS.
>>>>> +
>>>>> +  assigned-clock-rates:
>>>>> +    items:
>>>>> +      - description: Must be 125 Mhz.
>>>>> +      - description: Must be 12 Mhz.
>>>>> +      - description: Must be 250 Mhz.
>>>>
>>>> I would argue that both properties above are not needed. If your
>>>> hardware requires fixed frequencies, clock provider can fix them, can't it?
>>>
>>> Clock provider don't know fixed value and turn on only used by client.
>>
>> So maybe fix the clock provider? Or this device driver? Requiring by
>> binding specific frequencies for every board is a bit redundant.
> 
> It is not for every boards, it is common for a chip family.  Only a place to set for
> QM and QXP. 
> 
> The similar case is network driver, which require a specific frequency at clock assign.
> Generally frequency is fixed,  clock source name may change at difference chips. 

If frequency is always fixed, I don't understand why this is in DT
bindings. I would even say it should not be in DTS. We don't put into
DTS properties which are always the same, because otherwise they would
grow crazy big.

Best regards,
Krzysztof

