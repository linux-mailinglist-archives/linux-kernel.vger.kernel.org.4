Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016F720312
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjFBNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjFBNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:19:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076AE67
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:19:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so552260a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711943; x=1688303943;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AL6U3/LQtPsSpL2edMdeHjfgSwujh1CtL4Li08D5DHs=;
        b=pyC6LRH2rMaASgz2UmMPd3ADLZrFuBVBFLUOOXcAxWFnky8vafdBQsVIyqsfgiogcb
         yo4FW5xHchmJUazBm3DBNYDPE3BepBXNEERQXVmgiZkwITQ0ZnmVihzPn86TjW5OFMF/
         QLrPoPEbcoKXIenJ6OPJi8Rthh4JRXih5OTCmKLPHzaO5Q+ss0UMQcJpe6dLbRN6v8i+
         3cDjQzXg4XPOPBxJArZoOthApo8ZORoAEloRP7SHNG3MJzJdG6IH5KMb2lpUzKNx3R73
         4TllygpfqMPP+owJl6MIa5i28NgAj2KPC34C61ykSM3ip1HImbFBWuLUJUsQrAv1jyh3
         6cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711943; x=1688303943;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AL6U3/LQtPsSpL2edMdeHjfgSwujh1CtL4Li08D5DHs=;
        b=E3Cnc8oo924SI+HZdLd9UtOQDbie87Il12BXmJCCWWa0nu5di2OZ375A30SeU1tCEh
         Dz45QEwIni2ND1/Bq9DPSIuf3PoNMZkL6Xr7kNcpysHWloF3xKka3j9VYh4q+5+Awobi
         Cw2cey2UK2AQhAiMSwl/TBf/thzMukoFuG8Qv5nm7PlbKU4Poh1Fut2tn80nAfh7JE8p
         Qanb+3m0/YeGo9T4ni/svGq6tcYv9SyYvtW9nR5uXXmNEwGrSxzNvvQEgOvG3+7O0WGl
         9XZi45J2B9R8jHs7hVNBZlIvuIy7XrFJOifRuDetF8GBoJ0uMsR3w8QgnwgGT7QnW6o5
         P7lg==
X-Gm-Message-State: AC+VfDxqlnzDFaBxQL2My7GUjrNXuy3v0lS77J1g2oGxpCJTCKI6EijG
        b32TOl3y7fsY/bNnHR5z03NPeA==
X-Google-Smtp-Source: ACHHUZ4lfHUVchhkj0FLIuh1zMCNcKzc073RQWJcEmJpWsqUawWDIMPhIfzIQDTofF7iZBwWVjkUCw==
X-Received: by 2002:a05:6402:1513:b0:50b:fb29:1d8f with SMTP id f19-20020a056402151300b0050bfb291d8fmr1941563edw.0.1685711942755;
        Fri, 02 Jun 2023 06:19:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7d945000000b00516323ef3a9sm677267eds.49.2023.06.02.06.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:19:02 -0700 (PDT)
Message-ID: <5b537617-a9cb-609b-790d-3dda4b3933ec@linaro.org>
Date:   Fri, 2 Jun 2023 15:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [EXT] Re: [PATCH 2/2] dt-bindings: i2c: imx-lpi2c: Add bus
 recovery example
To:     Carlos Song <carlos.song@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230529074302.3612294-1-carlos.song@nxp.com>
 <20230529074302.3612294-2-carlos.song@nxp.com>
 <ed004607-5a23-564a-3185-a63af87783e5@linaro.org>
 <VI1PR04MB5005E43373DB10A9FD726AD7E8489@VI1PR04MB5005.eurprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <VI1PR04MB5005E43373DB10A9FD726AD7E8489@VI1PR04MB5005.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as my previous email probably got lost. If you got it twice,
apologies.

On 31/05/2023 12:22, Carlos Song wrote:
> Hi,
> 	Thanks for you reply. 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, May 30, 2023 10:59 PM
>> To: Carlos Song <carlos.song@nxp.com>; Aisheng Dong
>> <aisheng.dong@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> Anson.Huang@nxp.com
>> Cc: Clark Wang <xiaoning.wang@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> linux-i2c@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 2/2] dt-bindings: i2c: imx-lpi2c: Add bus recovery
>> example
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> On 29/05/2023 09:43, carlos.song@nxp.com wrote:
>>> From: Clark Wang <xiaoning.wang@nxp.com>
>>>
>>> Add i2c bus recovery configuration example.
>>
>> Why? That's just example... also with coding style issue.
>>
>>>
>>> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
>>> Signed-off-by: Carlos Song <carlos.song@nxp.com>
>>> ---
>>>  .../devicetree/bindings/i2c/i2c-imx-lpi2c.yaml   | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>>> b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>>> index 4656f5112b84..62ee457496e4 100644
>>> --- a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>>> @@ -58,6 +58,16 @@ properties:
>>>    power-domains:
>>>      maxItems: 1
>>>
>>> +  pinctrl-names:
>>> +    minItems: 1
>>> +    maxItems: 3
>>
>> What's the benefit of this? Entries should be defined but without it is not really
>> helpful. Anyway not explained in commit msg.
>>
>>> +
>>> +  scl-gpios:
>>> +    maxItems: 1
>>> +
>>> +  sda-gpios:
>>> +    maxItems: 1
>>
>> You don't need these two. Anyway not explained in commit msg.
>>
> 
> Sorry for confusing you with the poor commit log and without
> full description.
> 
> The reason why we need sending the patch for dt-binding is :
> We sent out a patch for I.MX LPI2C bus support recovery function.
> When LPI2C use recovery function, lpi2c controller need to switch the 
> SCL pin and SDA pin to their GPIO function.  So I think the scl-gpio and
> sda-gpio property need to be added in the dt-bindings.

Why do you think they are not in the bindings already?

> 
> And alternative pinmux settings are described in a separate pinctrl state "gpio". 
> So maybe "gpio" pinctrl item need to be added.
> 
> I would like to know whether the above changes are really unnecessary according to above case?
> Or because of the vague commit log, you are misled and think that our patch is not necessary to add examples.


I claim your patch has zero effect. Can you prove otherwise?

Proof is with DTS example and result of dtbs_check.

> 
> Is there no need to add sda/scl-gpios property or no need to add maxItems: 1?

I think entire patch can be dropped.

> We also find the sci-gpio and sda-gpio have been defined in the ref: /schemas/i2c/i2c-controller.yaml. 
> So is this the root cause of no need to add these properties?

Yes.


Best regards,
Krzysztof

