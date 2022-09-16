Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7406F5BA9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIPJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIPJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:59:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB7DFE0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:59:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n10so4585522wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UVm1C95vT38GM94e6CViaFZISiegXpJ1e7DF2NSTPTI=;
        b=bhYPUvW7uobCHqRcA9Vj3ZjaW6xL99IdwqjFC8qM0Jl4ZXfwe92iy9BbxTFUuk0khN
         4ym1RzCTQZsi4TEKidMBSeqvmJ9V7bs7vIlN/hnDuU+zM4bwNV3Nyu3tCH1tdocT7Vsh
         jMfXbyM+Py1tJmmaxS724Iv1w8wDV7bbQNO+B2FZnKu6qNsqozCEa8YzL7mJGGOH4hfc
         cCqYJnF6TJ8d+1dRoMMibMX+UFCeGV41zSr5qW8MK7KPlGVpVDr4hCc2HRA4jMtjy4ah
         yUzAj7IJJiGtiQWLJW1gn47jG7RkxzWpSSe/2Rijg1l90saoVJR8QfWyYssbN4/DSkjL
         1cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UVm1C95vT38GM94e6CViaFZISiegXpJ1e7DF2NSTPTI=;
        b=DPxYIqLvqV8wxQLRaVFfF2bfrZBMhi6BMLbDLz1+BBzrueE+l4GjRcoh+4H8a5a5r+
         /vJ9yFJb92PgD9HROewSFllMSFX0sDTiujyaarTk71+OfZ/xibPHh0R0xbMT28T5pRWE
         Xiquh4dAn+7/7bwVc0Dbyf845gLGtgWwZTRPd48CMbeOC85KuDpHovm3ViEZ3IaSKx4E
         UvDlvfm45OdlInQdA932The6anrk2U61GcrTdnlIyR1e8Ff9VRDXugZc7mjebJeZGdkE
         EyRE9DKLNH2jqrqJqqcItvEyFchkzlqhXmzfCOtQnUbzirBeeGs9JUSEgdjaPivzxaFM
         Pr9Q==
X-Gm-Message-State: ACrzQf28nyCjqwD4gqIkx8gZPGPkhn+GtDzxE+SVgxerw9XHkT+mA5QN
        AuvQ2LSmYhdNFAFAwiACwSgWIg==
X-Google-Smtp-Source: AMsMyM5h1UeC2XNVcdubto3gNXr5RqMo2zbFaKy9N4TJIeCelFSv6htEok5vkMZvu0/B7fVzaBF/Eg==
X-Received: by 2002:a05:6000:1d81:b0:226:fa3a:8721 with SMTP id bk1-20020a0560001d8100b00226fa3a8721mr2320700wrb.475.1663322378789;
        Fri, 16 Sep 2022 02:59:38 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id n6-20020a1c7206000000b003b4764442f0sm1690179wmc.11.2022.09.16.02.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:59:38 -0700 (PDT)
Message-ID: <a56aad01-222d-5637-7757-2a1afeed945d@linaro.org>
Date:   Fri, 16 Sep 2022 10:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220913092908.1708931-1-peng.fan@oss.nxp.com>
 <638002c3-f402-96d3-7eb8-991f7f05f703@linaro.org>
 <DU0PR04MB94173A2BEB0DA8EC22E3EBDD88469@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB94173A2BEB0DA8EC22E3EBDD88469@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 01:11, Peng Fan wrote:
>> Subject: Re: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
>>
>> On 13/09/2022 11:29, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX8M Family features an anatop module the produces PLL to clock
>>> control module(CCM) root clock. Add the missing yaml file.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V2:
>>>  Drop syscon, use clock-controller
>>>  Add fsl vendor prefix
>>>  Add interrupt property
>>>
>>>  dts update not included, so there will be dtbs_check fail.
>>>
>>>  .../bindings/clock/fsl,imx8m-anatop.yaml      | 46 +++++++++++++++++++
>>>  1 file changed, 46 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
>>> b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
>>> new file mode 100644
>>> index 000000000000..2c0efa58d898
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
>>> @@ -0,0 +1,46 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id:
>>>
>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>> +cetree.org%2Fschemas%2Fclock%2Ffsl%2Cimx8m-
>> anatop.yaml%23&amp;data=05
>>>
>> +%7C01%7Cpeng.fan%40nxp.com%7Ca3a47985f9d9452744af08da9590fe79
>> %7C686ea
>>>
>> +1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637986747221860721%7CU
>> nknown%7C
>>>
>> +TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
>> iLCJXV
>>>
>> +CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=I4LSaFBDMZv%2FcgFyIR1w
>> m2Irc%2F%2F
>>> +Z9eKChPCJY7XMfDo%3D&amp;reserved=0
>>> +$schema:
>>>
>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>> +cetree.org%2Fmeta-
>> schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cpeng.fan%
>>>
>> +40nxp.com%7Ca3a47985f9d9452744af08da9590fe79%7C686ea1d3bc2b4c6
>> fa92cd9
>>>
>> +9c5c301635%7C0%7C0%7C637986747221860721%7CUnknown%7CTWFpb
>> GZsb3d8eyJWI
>>>
>> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> C3000%
>>>
>> +7C%7C%7C&amp;sdata=dm5exAJpmPmY%2B0vCuZtpzt7k8GHeKZKtitSvep0
>> 5G%2Bw%3D
>>> +&amp;reserved=0
>>> +
>>> +title: NXP i.MX8M Family Anatop Module
>>> +
>>> +maintainers:
>>> +  - Peng Fan <peng.fan@nxp.com>
>>> +
>>> +description: |
>>> +  NXP i.MX8M Family anatop PLL module which generates PLL to CCM root.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - fsl,imx8mm-anatop
>>> +          - fsl,imx8mq-anatop
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx8mn-anatop
>>> +              - fsl,imx8mp-anatop
>>> +          - const: fsl,imx8mm-anatop
>>
>> You dropped syscon which solves part of my previous comment. I suggested
>> to make it proper clock provider, so you would need clock-cells. Any reason
>> it is no a real clock provider?
> 
> oh. I overlooked this point. The current i.MX8M linux clk driver directly
> search the node to get anatop base:
> https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/clk/imx/clk-imx8mp.c#L416
> 
> Not take it as a real clock provider from linux view.
> 
> I will add clock-cells in v3.

Why the Linux driver appeared before bindings? Broken implementation is
not a valid reason to push such bindings. :/


Best regards,
Krzysztof
