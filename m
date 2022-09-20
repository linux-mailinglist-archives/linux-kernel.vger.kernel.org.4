Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC75BDFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiITIY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiITIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:24:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60896B170
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:22:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s10so2068312ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1cDSjDOhceVETBaMTiU2M1PsWnTuyDsSVHNXNrhgk4I=;
        b=O8IMJTj8AHYjo1Wg2J3GAMAciwdnSQiccRm1uvGUT7B0TWw7UsJSVEeTWptFhO6qdn
         UluocDnaC67liYim340oYX0mqtbqxnJKgJ61wepnS+ihZmGbHLgPukX1amsQW+l1Hy1+
         rIAR/GnCyU4GpwnIDdwxVoYHhMyl1kgveKRYgRp3TVZbfxmeEsaeGEaJCg4mwVYgdZpj
         wxHTFqSqKc0dmKQOstD+IcpmFIRKRkLk5nVgjovFjucpyTRlkaMp1rpQeY8fL2Vn2nap
         APiMyAQX5JjGlWaYZbujS/5GXeZELnELaH7lVjsIdVqWuyajlwcvTG3HK/JLd+cCPCTB
         UjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1cDSjDOhceVETBaMTiU2M1PsWnTuyDsSVHNXNrhgk4I=;
        b=5UJYZpwHcd1RVSFi20Bg6tpddwqt8G10L3bdJ1aelvFvX8+wF831nI4K8pg5ehqOb2
         N2Yiex7DQ/uQwXxf+egZCuZF07ivmHo4gnCjsBn3GqzG66zp/vbXpxmOORH/PZuUEbf+
         P2Aq2F7W7t6KB5m9XDAiXxqgslTUHl3D2rmelgAp8Ao5sFpTAHxLJqH87LjOHJCGQbOM
         XSI3yE2KC7ZcnCGt4xjOxe+D0kGK9OSJTErBmRS1aHOFldKmmm5Xsh9m1Ut5fxNSFIEv
         AJTZMJSVzz6PQRGFEH7YhCw3WDc2l62AhW+7wpN2V/7IYNZ8xEtg90ZNS2ugcukn079I
         OzRw==
X-Gm-Message-State: ACrzQf1fzUeaE8ZydPOY0qyEjluCL27E+s7OWPTgs/+/cDNqWO4DxdoY
        zhq2aDLRLSNnDTlycx3pxJYkEg==
X-Google-Smtp-Source: AMsMyM7iA9m2jqenY+W7IAbO4QxMOPI3pJM40MRd4pMpQtJNu+S4kh/ol536Eqivmp12aMP9a6FCpw==
X-Received: by 2002:a05:651c:17a1:b0:26c:87c:c104 with SMTP id bn33-20020a05651c17a100b0026c087cc104mr6323368ljb.419.1663662111668;
        Tue, 20 Sep 2022 01:21:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o16-20020ac25e30000000b00492ea54beeasm185736lfg.306.2022.09.20.01.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:21:50 -0700 (PDT)
Message-ID: <2b0e6e33-ef76-4bd4-8894-53f9a3fe68b4@linaro.org>
Date:   Tue, 20 Sep 2022 10:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220714122322.63663-1-tmaimon77@gmail.com>
 <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org>
 <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
 <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org>
 <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
 <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org>
 <CAP6Zq1gyDW8ZwwAZ1jyfNEZa09WN-biZZJY8tBmW_gzMzpj3ZA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1gyDW8ZwwAZ1jyfNEZa09WN-biZZJY8tBmW_gzMzpj3ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:59, Tomer Maimon wrote:
>>>>>>> +      pinctrl: pinctrl@f0800000 {
>>>>>>> +        compatible = "nuvoton,npcm845-pinctrl";
>>>>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
>>>>>>> +        #address-cells = <1>;
>>>>>>> +        #size-cells = <1>;
>>>>>>> +        nuvoton,sysgcr = <&gcr>;
>>>>>>> +
>>>>>>> +        gpio0: gpio@f0010000 {
>>>>>>
>>>>>> gpio@0
>>>>>>
>>>>>> Is this really a child block of the pinctrl? Doesn't really look like it
>>>>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
>>>>>> so, then pinctrl should be a child of it. But that doesn't really work
>>>>>> too well with gpio child nodes...
>>>>> the pin controller mux is handled by sysgcr this is why the sysgcr in
>>>>> the mother node,
>>>>> and the pin configuration are handled by the GPIO registers.  each
>>>>> GPIO bank (child) contains 32 GPIO.
>>>>> this is why the GPIO is the child node.
>>>>
>>>> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
>>> The pin controller using the sysgcr to handle the pinmux, this is why
>>> the sysgcr is in the mother node, is it problematic?
>>
>> You said pin-controller mux registers are in sysgcr, so it should not be
>> used via syscon.
> Sorry but maybe I missed something.
> the sysgcr is used for miscellaneous features and not only for the pin
> controller mux, this is why it used syscon and defined in the dtsi:
>                 gcr: system-controller@f0800000 {
>                         compatible = "nuvoton,npcm845-gcr", "syscon";
>                         reg = <0x0 0xf0800000 0x0 0x1000>;
>                 };
>>
>> Please provide address map description to convince us that this is
>> correct HW representation.
> GCR (sysgcr) registers 0xf0800000-0xf0801000 - used for miscellaneous
> features, not only pin mux.
> GPIO0 0xf0010000-0xf0011000
> GPIO1 0xf0011000-0xf0012000
> ...
> GPIO7 0xf0017000-0xf0018000
>>

Then why your pinctrl is in sysgcr IO range? (pinctrl@f0800000)

Your map looks quite different from what you described in example.

Best regards,
Krzysztof
