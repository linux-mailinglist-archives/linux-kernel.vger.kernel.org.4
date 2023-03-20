Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF046C0A91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCTG1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjCTG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:26:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86C3597;
        Sun, 19 Mar 2023 23:26:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id iw3so11378974plb.6;
        Sun, 19 Mar 2023 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679293617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a00IFrfnw2eP3aBoOdd3PiLje9YjLbhrfjpITW/tA1k=;
        b=G8QZZUE3Z19kup0/jT2H+kfn6FLOMSqxbVXoBvLtYuDkixzft3mbxHPltWN2yFC/oU
         TYQOGmRMu4s3e3fuB5RzzI8UVQWdIjT+++7wSl1gLCSRI3+SzvAXJZKRHEiveip1760u
         7D1Oa+1wFyYtf6rreRrsUPCVCD6kMbvG3ChaZQ1mwhyduCdbkko981yeE4ls7lPwb6D6
         CV7On/Pvfg1NceEV1M+0tT47yEV+a+PhUVZgQ1CL0Ug5E+tBDmRdnRR9qmibSZedy+OQ
         hFmMycHW/EbJAxyEqBqq4PA0olOI4/w6pUZb8YuIEDCgDnRAVEIuntODPr5XImNaPFjw
         +Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679293617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a00IFrfnw2eP3aBoOdd3PiLje9YjLbhrfjpITW/tA1k=;
        b=jYJBzDvRhE+49Z4K5vHr6L5UBuSK1YX8JHsUxQ/nRQLZYZ9crjDcVnZ3MYmfE55+eA
         Xn5gPg9Hg19bYWEdQUP95yBiEZVenqDxQV/gHm6pKMi4qjoDiFEUZEMhny0OWE7z611P
         IJ5MLGL7GDvu+Dp0JI154RyLum2MDHtbGkbgHKcuxzYWt+v/b8KlZ8GlVHArDFWuwurK
         LaKKhsPb5tZ6VJlO7gXU47iyOjsmNuOX5vGm2SvlBox/1s+Iea6l0t1EtW/tP8x4EVAQ
         O3Kegpr4/ymAcsPphdI6pqhLH2JxiGfmtyAV+hhREjs4eHcV5FIiIlTLpBfUcYqF2iVF
         GJkQ==
X-Gm-Message-State: AO0yUKV6jUzelho2yipH/LElIPnhCcYUPt2VmuwM6ompOA5jfNhR/q+E
        WFJlM9yEdPDMnuuo9PFkv58=
X-Google-Smtp-Source: AK7set+cy3CP0Y/5GQ8tEhoRqvIB947R3Q6hzn4nVrPMn1mCccHGAYXfBxJqXu/JmBGUGiZsjI1inA==
X-Received: by 2002:a17:902:fb8b:b0:1a0:6721:6cdb with SMTP id lg11-20020a170902fb8b00b001a067216cdbmr14004368plb.40.1679293616921;
        Sun, 19 Mar 2023 23:26:56 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b0019aa6bf4450sm5786074plr.188.2023.03.19.23.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 23:26:56 -0700 (PDT)
Message-ID: <c6ca0988-f2a4-54ea-941b-1c84d1368239@gmail.com>
Date:   Mon, 20 Mar 2023 14:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-10-ychuang570808@gmail.com>
 <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
 <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
 <4d62376f-1b33-62ac-2ed9-6b71ae7485a2@gmail.com>
 <fd0cb506-707a-4f5d-b917-de6a03787f6a@linaro.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <fd0cb506-707a-4f5d-b917-de6a03787f6a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/19 下午 07:05, Krzysztof Kozlowski wrote:
> On 18/03/2023 05:30, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> Thanks for your advice.
>>
>>
>> On 2023/3/16 下午 03:39, Krzysztof Kozlowski wrote:
>>> On 16/03/2023 08:37, Krzysztof Kozlowski wrote:
>>>> On 15/03/2023 08:28, Jacky Huang wrote:
>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>
>>>>> Add documentation to describe nuvoton ma35d1 reset driver bindings.
>>>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>>>> prefix is already stating that these are bindings.
>>
>> OK, I will fix it.
>>
>>
>>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>>> ---
>>>>>    .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>>>>>    1 file changed, 50 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..f66c566c6dce
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>>> @@ -0,0 +1,50 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Nuvoton MA35D1 Reset Controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>>>>> +  - Jacky Huang <ychuang3@nuvoton.com>
>>>>> +
>>>>> +description:
>>>>> +  The system reset controller can be used to reset various peripheral
>>>>> +  controllers in MA35D1 SoC.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: nuvoton,ma35d1-reset
>>>>> +
>>>>> +  regmap:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +    description: Phandle to the register map node.
>>>> You need to be specific what is this. As you can easily check, there is
>>>> no such property in any devices. I don't understand why do you need it
>>>> in the first place.
>>           reset: reset-controller {
>>               compatible = "nuvoton,ma35d1-reset";
>>               regmap = <&sys>;
>>               #reset-cells = <1>;
>>           };
>>
>> The dt_binding_check check report an error about the above "regmap".
>>
>> I found that add this can pass the test.
> Do not add properties to bindings to "pass the test". That's not the
> goal of bindings. Add there properties because they make sense...
>
> Anyway, you did not answer my question at all. So one by one - address them:
> 1. As you can easily check, there is no such property in any devices.
> Explanation: do you see it anywhere in existing bindings?

Yes, I cannot find it in all bindings. I know it's wrong.

> 2. I don't understand why do you need it in the first place.
> Explanation: your binding suggest this is not needed. If you think
> otherwise, you need to provide rationale.
>
>
>
> Best regards,
> Krzysztof
>

Now we have removed regmap and modify the dtsi as:

     sys: system-management@40460000 {
         compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
         reg = <0x0 0x40460000 0x0 0x200>;

         reset: reset-controller {
             compatible = "nuvoton,ma35d1-reset";
             #reset-cells = <1>;
         };
     };

In the reset driver, we obtain the regmap by parent node:
     parent = of_get_parent(dev->of_node); /* parent should be syscon 
node */
     reset_data->regmap = syscon_node_to_regmap(parent);
     of_node_put(parent);

We have it tested OK on ma35d1 SOM board.
And it pass the dt_binding_check and dtbs_check.

Best regards,
Jacky Huang



