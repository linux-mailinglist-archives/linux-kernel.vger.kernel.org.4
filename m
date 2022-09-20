Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA25BE0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiITIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiITIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:47:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765B40E18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:47:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so2600436lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bPC0wOWHS3IfkpyiNHTrPOKy7lllIftEAhOiSZ57lWE=;
        b=xx1IH7gi6vuXdqBC8gCyQHJnBpx94OKrk8RWttmSL7BTYXLGZYOAlUaOt5XuevZRnI
         9mSoFEAlQNRW61/D2d1n/yX+9Dpz8Yu6GH3mETVc/M1epxE3yWY+B1QVJSFOqmmDrR7T
         xRXFcc8j6PJmvvPziypomGMvbLcSUw8Zw5j+9gguuGJHRlf4aLbzn6XIoIFLgN/F8c8z
         HJfRm3xT9jZxkfNdJxEZKyb6cZJ+UA0/c8SRFXYiowtu1Vmx4Y8RhqEbIf57ZdIwtSv/
         G9u7MDQwRP+0LWtaOjq1H5EGhEDOJU0yCBXB261I5VwDV7N3/ApG/rF8WseQw7wYCd4q
         JIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bPC0wOWHS3IfkpyiNHTrPOKy7lllIftEAhOiSZ57lWE=;
        b=pFrBspUw76VPkMcltoqlNVUlqmcPfuATToSU4P9jzTlxKr4lqjUP3yQEkElwFlWimj
         z4TT2Vsg22McWdIbOHKLQXNKB0q3UMdbf1+xaLioKZttg2FUQ4rovrR+/Gf5WS6PqcL+
         rvtIicaGzi1FU0WJcHsK1Llv4ndA6BtwbGvPdHLsIfGAV85klkgrJe4rTImfO9Ai6ihm
         BbLYwW8/sEDniKRkV3iiRIA8NvqZPxR2n1izQkruvwtu7I86E9b6YZw4fW3dhsT3W1Lz
         BXVr4EpsWozY0kkv/qfK7seafPEKXYudbaL/p3MghgPaZD2jhmjF+D0J32ZxJh/MP9jT
         DRPA==
X-Gm-Message-State: ACrzQf0LxITfwODaeCoIcVBg608C61wLYPwCQojhvVlbExHXacsiejaL
        yNGihOX6yhLqoae1EVL84xkRcQ==
X-Google-Smtp-Source: AMsMyM5H098ZyPcH4hQiK06tnggqiLZI22yq2+Z+n6Ilu5uMR/fxGiIdZGjRfa+iAg143TZk4rwxyw==
X-Received: by 2002:a05:6512:3c9f:b0:49d:d486:96d7 with SMTP id h31-20020a0565123c9f00b0049dd48696d7mr7980206lfv.596.1663663660813;
        Tue, 20 Sep 2022 01:47:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q9-20020ac246e9000000b0049486c66140sm205437lfo.119.2022.09.20.01.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:47:40 -0700 (PDT)
Message-ID: <6f1ad082-74e4-e4e7-9304-5cdd95cc9f66@linaro.org>
Date:   Tue, 20 Sep 2022 10:47:39 +0200
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
 <2b0e6e33-ef76-4bd4-8894-53f9a3fe68b4@linaro.org>
 <CAP6Zq1iwW6HvvfM684VLG0ZT-0OLKT0udW4bHxsZsTMEypo2sg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iwW6HvvfM684VLG0ZT-0OLKT0udW4bHxsZsTMEypo2sg@mail.gmail.com>
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

On 20/09/2022 10:32, Tomer Maimon wrote:
> On Tue, 20 Sept 2022 at 11:21, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/09/2022 09:59, Tomer Maimon wrote:
>>>>>>>>> +      pinctrl: pinctrl@f0800000 {
>>>>>>>>> +        compatible = "nuvoton,npcm845-pinctrl";
>>>>>>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
>>>>>>>>> +        #address-cells = <1>;
>>>>>>>>> +        #size-cells = <1>;
>>>>>>>>> +        nuvoton,sysgcr = <&gcr>;
>>>>>>>>> +
>>>>>>>>> +        gpio0: gpio@f0010000 {
>>>>>>>>
>>>>>>>> gpio@0
>>>>>>>>
>>>>>>>> Is this really a child block of the pinctrl? Doesn't really look like it
>>>>>>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
>>>>>>>> so, then pinctrl should be a child of it. But that doesn't really work
>>>>>>>> too well with gpio child nodes...
>>>>>>> the pin controller mux is handled by sysgcr this is why the sysgcr in
>>>>>>> the mother node,
>>>>>>> and the pin configuration are handled by the GPIO registers.  each
>>>>>>> GPIO bank (child) contains 32 GPIO.
>>>>>>> this is why the GPIO is the child node.
>>>>>>
>>>>>> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
>>>>> The pin controller using the sysgcr to handle the pinmux, this is why
>>>>> the sysgcr is in the mother node, is it problematic?
>>>>
>>>> You said pin-controller mux registers are in sysgcr, so it should not be
>>>> used via syscon.
>>> Sorry but maybe I missed something.
>>> the sysgcr is used for miscellaneous features and not only for the pin
>>> controller mux, this is why it used syscon and defined in the dtsi:
>>>                 gcr: system-controller@f0800000 {
>>>                         compatible = "nuvoton,npcm845-gcr", "syscon";
>>>                         reg = <0x0 0xf0800000 0x0 0x1000>;
>>>                 };
>>>>
>>>> Please provide address map description to convince us that this is
>>>> correct HW representation.
>>> GCR (sysgcr) registers 0xf0800000-0xf0801000 - used for miscellaneous
>>> features, not only pin mux.
>>> GPIO0 0xf0010000-0xf0011000
>>> GPIO1 0xf0011000-0xf0012000
>>> ...
>>> GPIO7 0xf0017000-0xf0018000
>>>>
>>
>> Then why your pinctrl is in sysgcr IO range? (pinctrl@f0800000)
> you suggest using pinctrl@0 or pinctrl@f0010000 and not
> pinctrl@f0800000 because 0xf0800000 is the GCR address that serve
> miscellaneous features and not only pinmux controller ?

If you have a map like you pasted, then DTS like this:

syscon@f0800000 {}
pinctrl@f0800000 {
  gpio@f0010000 {}
}

Is quite weird, don't you think? You have two devices on the same unit
address which is not allowed. You have child of pinctrl with entirely
different unit address, so how is it its child?

Best regards,
Krzysztof
