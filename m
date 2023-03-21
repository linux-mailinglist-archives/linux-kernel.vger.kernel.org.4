Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F267B6C2A87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCUGiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCUGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:38:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EBE3B65A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:37:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so55525262edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679380654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+KGeUp/wxOIZjrDPkHjblyuhe5J5nJa9fCaHcyiZw=;
        b=BCi0uaCvv0+js1ecGX2/NRV5aUU6/IiNSTvSB4IiiLLJGg7DhzHLMBfwqoTXl+d5qB
         O3m7iLjMOxi3eTn9Nx7+fU7M5PXE48TLcl5bn/feaRAEKYqYaWMwa8oU2FysPGejYS6j
         SFtaEIyCHf/ct/pw3lXJP57bH9Fqh4RSD5XDFD6Q11dAjj+Xz1pbMFfvA2VbREGenwRE
         4SVfJTB7+jnQ9wjYMnAbpfeSS3cNj81DlR2IQwR3Vjj5TKWkQdQek967Kr6kFtlWXiXz
         sVSOe9Ywpg93cmPXy3vfpPosmOWjhuel+sR7beCS86CtU5VzQ9QuZyP1xAxruciHIL0r
         hrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+KGeUp/wxOIZjrDPkHjblyuhe5J5nJa9fCaHcyiZw=;
        b=JXfaKo+75ze2k2AfRqBDdkByO0cctgHe7DdwzvfWL+7gyc/dfczC5vB0RHxRW86Ti9
         CcyFOIrBNHbAMqMMiJDD2mCyk+D/sRBZHA7mZNPKM5hgE50y8vSEU2EpozcatpWV8tI0
         R8gxFh0dDI9Gm8BvfAHubUsiq4gSc83DYR5I4SPIxDrsbmzdOBvFz6bsRfekiRmTyWD1
         5cWwc/fh5raTrzKTnvCYOcxceWsqXx/wHI4UjpP1SKdfBxv49JAIPMcb1igrIk9cwIL5
         tKbmUdjw+KmCeVk1H7yWaBH61MX37hf78Gx0XUtnz+xOTpADwmpawo77iFDAVVzTWrs5
         r+7w==
X-Gm-Message-State: AO0yUKVo3uaJGcM0dT9tXl5WMig8LlZnAMoNEh3/mfCk1OUkh9CS/aj+
        cFiBvg9uZMcZb4uIW0q114w/1w==
X-Google-Smtp-Source: AK7set/T00OguACk3viJY9WGs6qdtUM6xsHRWD3xyJzjHRX/K4nsguPr/BBF2Vtic1IdmXJWJVDqUQ==
X-Received: by 2002:a17:906:39da:b0:92c:a80e:225f with SMTP id i26-20020a17090639da00b0092ca80e225fmr1794550eje.52.1679380654368;
        Mon, 20 Mar 2023 23:37:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm5332603ejc.86.2023.03.20.23.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:37:33 -0700 (PDT)
Message-ID: <48bdca7a-e4ec-a2e4-ff0d-dc9a08bf799e@linaro.org>
Date:   Tue, 21 Mar 2023 07:37:33 +0100
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
 <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
 <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <fc5c76d1-51cd-5992-9bfa-06f57874fc03@linaro.org>
 <AM6PR04MB4838C6B05F46AD94153DDC8388809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <614fa099-e666-03da-1b11-29cc804bf847@linaro.org>
 <AM6PR04MB4838FC9492065F4DBCABE60D88809@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB4838FC9492065F4DBCABE60D88809@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 20:59, Frank Li wrote:
>>
>> The second is a good example - as you can see, there is a choice of
>> values, so they are not exactly fixed.
>>
>>>
>>> Such frequency information is necessary.  We can put to dts or clock drivers.
>> The clock driver
>>
>> If this is the argument, then the answer is NAK. Sorry, but DTS is not
>> for offloading fixed stuff just because you do not want to work on
>> drivers. The same for discoverable stuff.
>>
>>> Become bigger, or dts become bigger.  I think the key point is if property to
>> descript hardware information.
>>
>> You have to understand that with your binding you are not allowing to
>> any changes of these frequencies.
> 
> Do you means it should be okay if one of  clocks is not fixed?

We have here long discussion why does your binding require fixed
frequencies, because this is something unusual and not recommended. And
if they are really fixed, then device driver probably should make the
choice of frequencies.

> 
> Previous owner already left nxp.  I double checked our documents and scfw source code. 
> I miss understood a clock SC_PM_CLK_MST_BUS, which actually mapped to IP's aclk, which
> ware 100Mhz to 600Mhz. 
> 
>>
>> Best regards,
>> Krzysztof
> 

Best regards,
Krzysztof

