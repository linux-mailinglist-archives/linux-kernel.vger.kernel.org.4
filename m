Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557635F7B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJGPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJGPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:53:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCBEFC1D3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:53:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a12so6178132ljr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ke80GF96XIn5dnJKIcuCkBMxiAcfiTBdb+oRsJGr3GY=;
        b=XAA47aQG1XFomJxq7ypgUxXnVpvGgm9AhLskN22erxqeylEByrxSAVRMorIMMMiFWw
         EpN+riIF0QrsH0N/Xq8P1BMGm5nEnj1fGTYAY+tOh3JkczzpaB0UTaJjpWToieHrZ1xB
         S+ZCS7hln7rO6CYTftV85r8s791Xmy/hebogxhWO04HCFCQkbqEptRkME1cd79OvMLco
         liIFRNYUPB9oNhPxqtQhhRM246KIYH7uyITbhfkp2qz0WZB6DI1r0EqCd6D/jlLhjgUc
         v4EqlWiyi9ClJKA6OvvPnRznxDHm+Ch/9Vxn+gIZ1VcQIhD9zXjN7BhC2Klk5CnDE4jY
         unkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke80GF96XIn5dnJKIcuCkBMxiAcfiTBdb+oRsJGr3GY=;
        b=koM/AKlBs+oTV2MuS/Who7bbeD7fjSbtPtBOiZNymVXatufXUAUZkha6XJA74vhWj4
         dZoI5u4Q5KsyDOYG/+xgBSpNlTAD9/5IzaFwQGX7Ar6NLl1nd5qNC1AZJDlGFGpeKNF8
         WR91FREkc1eUaNwu1MxEqVIOBFFllmqJi1yrbiFFJ8wUFk/kxRlNJ9Ea8E+mS4NNjO4f
         Qe3YaG1K7iUbwQGNR2Oa17oYgZAVhMY4S6Q8ceUbUms5mZq85DmFvswYzXqM51iujz2+
         KXIAOWsm8sOc9fZ2uD7c46V1YbvQ9m7ERYWyJEVUwSKF/aW+qfj7ebF1WRkXNSSIBbox
         V8ZQ==
X-Gm-Message-State: ACrzQf0094ot9PiufQT6uayrV3CRQG9UphsIVm5A04y6umgeifaePK+g
        5UBsGwnBecwm/eaK3rLoOc3UHw==
X-Google-Smtp-Source: AMsMyM4bSnybE3WOr1MN+mIV7WG4biaIIqbIpy7mKbpcu2nqBicmv2kL5rtSTMvg8au/AHy1C1Mx5A==
X-Received: by 2002:a2e:7211:0:b0:26d:fea5:c7e3 with SMTP id n17-20020a2e7211000000b0026dfea5c7e3mr1860778ljc.101.1665157994928;
        Fri, 07 Oct 2022 08:53:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d12-20020ac244cc000000b00497ad8e6d07sm334078lfm.222.2022.10.07.08.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 08:53:14 -0700 (PDT)
Message-ID: <530a4682-c7d8-d4e1-8050-bc2baa0a1877@linaro.org>
Date:   Fri, 7 Oct 2022 17:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
 <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
 <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
 <0852ffa5-9996-0f42-c5a8-d1fe9d39887e@linaro.org>
 <9a98d026-7f70-a69b-64de-c77419888e42@amd.com>
 <9e006307-f7c7-c68a-e5c3-d0d0b2807d87@linaro.org>
 <8ce3ee59-bc37-ea97-c94d-b6f4f9c28751@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8ce3ee59-bc37-ea97-c94d-b6f4f9c28751@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 00:50, Larson, Bradley wrote:
> On 9/16/22 2:56 AM, Krzysztof Kozlowski wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On 13/09/2022 22:57, Larson, Bradley wrote:
>>> On 9/8/22 4:27 AM, Krzysztof Kozlowski wrote:
>>>> On 01/09/2022 22:37, Larson, Bradley wrote:
>>>>> On 9/1/22 12:20 AM, Krzysztof Kozlowski wrote:
>>>>>> On 01/09/2022 02:01, Larson, Bradley wrote:
>>>>>>
>> Wait, can we skip the driver entirely? I am not reviewing your driver 
>> and what it creates under /dev. 
> 
> Yes, see precise answer requested below.
> 
>>> In comparision, the pensando device is also on the other end of spi,
>>> four chip selects with /dev created for each for userspace control,
>>> and one child device on cs0 for hw reset emmc that the Linux block
>>> layer controls (single bit managed only by kernel).
>>>
>>> Pensando:
>>> &spi0 {
>>>           num-cs = <4>;
>>>           cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
>>>                      <&porta 7 GPIO_ACTIVE_LOW>;
>>>           status = "okay";
>>>           system-controller@0 {
>>>                   compatible = "amd,pensando-elbasr";
>>>                   reg = <0>;
>>>                   #address-cells = <1>;
>>>                   #size-cells = <0>;
>>>                   spi-max-frequency = <12000000>;
>>>
>>>                   rstc: reset-controller {
>>>                           compatible = "amd,pensando-elbasr-reset";
>>>                           #reset-cells = <1>;
>>>                   };
>>>           };
>>>
>>>           system-controller@1 {
>>>                   compatible = "amd,pensando-elbasr";
>>>                   reg = <1>;
>>>                   spi-max-frequency = <12000000>;
>>>           };
>>>
>>>           system-controller@2 {
>>>                   compatible = "amd,pensando-elbasr";
>>>                   reg = <2>;
>>>                   spi-max-frequency = <12000000>;
>>>                   interrupt-parent = <&porta>;
>>>                   interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>           };
>>>
>>>           system-controller@3 {
>>>                   compatible = "amd,pensando-elbasr";
>>>                   reg = <3>;
>>>                   spi-max-frequency = <12000000>;
>>>           };
>>> };
>> You replied with quite a response of which 90% is unrelated talk about 
>> driver. Please be specific. We talk here only about hardware.
>> Your last DTS might be the answer, but you never explicitly wrote 
>> it... So let's check if I understand it correctly. Only some of elbasr 
>> block contain reset control?
> 
> Yes, only the elbasr block accessed on CS0 provides reset control.  The 
> other 3 blocks don't have any reset control and never will.

I see, that could explain the subnode. However:
1. You still do not use any resources in the subnode (it does not have
any in DT).

2. Your driver instantiates subdevice not based on existing of subnode
or characteristics of a device (e.g. compatible), but on hard-coded
chip-select line. The reset driver directly takes parent's regmap - no
other resources.

Therefore this does not look like dedicated piece of hardware and should
be just part of parent node.

> 
>> This however does not answer my questions before.... You keep ignoring 
>> them. So please answer yes or no: "Are there other sub-devices?"
> 
> No
> 
>> " and your binding is incomplete?"
> 
> No
> 
>> and a new question: "Is reset block (amd,pensando-elbasr-reset) 
>> re-usable so it will appear in different device (not in 
>> amd,pensando-elbasr)?"
> 
> No its not re-usable

So squash it with parent node.

Best regards,
Krzysztof

