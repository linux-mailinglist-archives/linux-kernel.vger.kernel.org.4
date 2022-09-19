Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604795BD1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiISQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:06:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8892DA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:06:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f14so46752919lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=iE9nxQEFInaL7XSikMpoXTZbHYoCnjZKoSz4CSYOZnA=;
        b=UAOja/FfrymFuV0xvicbL7PMXuUl4mPyof1Okb0o4luFMO529ZM+SZDfwGKYf+HTMf
         a/WaNIKZH+CCwzmVfwGBHNgDh6tyEE/4RCYW3s7Xy7CUDsPExVi8yVgN77oSpkFy1wP0
         EZDoTz0wXXRlHxsk4U6dtvkL2742ktOiuNpmr9RmscpZCU5Du2ez6apYChpa26SOBuxd
         8D5LRWj2h5/EJlkgEmYbAKihkayVc39iPARINK4Y7nQn0Yf6r8U/fwVO+POZ4Tm3kQed
         Czy0pCZbVQwwyLBIv33YaafZbPlkHahN7hk1BWUO99D62XnnMEsRLm6WG1yXMAoUug8l
         tELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iE9nxQEFInaL7XSikMpoXTZbHYoCnjZKoSz4CSYOZnA=;
        b=ysip/PO4ZR0U8fAoz2WWmer4/fFqO16/PXn2scAVbsY+zvDyfm7BVYR1cdYPk80TsA
         yzNjgwzhVQWNCGazfBTrw3jMc6zp4H7O6UsJqf3L6GS3GlPY5l2xFWIaLNtlAXs0qJyQ
         PD5K/ArmgQqaemWACJ3gfojONdIsaqhcbWPfwZ7CbGVHNB4PZOT0dg80qwQ8l4QoMpBk
         1TChWyHPJimDCiXcA05OUs3JyLIU+S8dd3U3J1hUPTbs5B3yOJ3Au4zH/6qyTZQL4vF+
         ydhFnpcwjTyNCyooR2Dz2tCesMs4kJtfDoZvEAKQ3foI2xFPlzyk94JDil3n9JNkBkCL
         dh1g==
X-Gm-Message-State: ACrzQf3EHkS+RToCn1f3Fq0Zp+d7IMeJNsymWd11sFjDyISLviAAgst2
        LVEMSQu2zvpiNpNcFTn6Q7Gkew==
X-Google-Smtp-Source: AMsMyM65h0pq/i+FvwWdh8cUN9HdV6WWDFVY+wFWguOob0zVZcboRCwsVykWpVj97GAsCtp0S9YpTw==
X-Received: by 2002:ac2:4bc7:0:b0:49a:dbf7:73e9 with SMTP id o7-20020ac24bc7000000b0049adbf773e9mr5964150lfq.529.1663603598864;
        Mon, 19 Sep 2022 09:06:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e5356000000b00268b85321eesm3787302ljd.113.2022.09.19.09.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:06:38 -0700 (PDT)
Message-ID: <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org>
Date:   Mon, 19 Sep 2022 18:06:37 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 16:31, Tomer Maimon wrote:
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>>> +
>>>>> +    soc {
>>>>> +      #address-cells = <2>;
>>>>> +      #size-cells = <2>;
>>>>> +
>>>>> +      pinctrl: pinctrl@f0800000 {
>>>>> +        compatible = "nuvoton,npcm845-pinctrl";
>>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <1>;
>>>>> +        nuvoton,sysgcr = <&gcr>;
>>>>> +
>>>>> +        gpio0: gpio@f0010000 {
>>>>
>>>> gpio@0
>>>>
>>>> Is this really a child block of the pinctrl? Doesn't really look like it
>>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
>>>> so, then pinctrl should be a child of it. But that doesn't really work
>>>> too well with gpio child nodes...
>>> the pin controller mux is handled by sysgcr this is why the sysgcr in
>>> the mother node,
>>> and the pin configuration are handled by the GPIO registers.  each
>>> GPIO bank (child) contains 32 GPIO.
>>> this is why the GPIO is the child node.
>>
>> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
> The pin controller using the sysgcr to handle the pinmux, this is why
> the sysgcr is in the mother node, is it problematic?

You said pin-controller mux registers are in sysgcr, so it should not be
used via syscon.

Please provide address map description to convince us that this is
correct HW representation.

Best regards,
Krzysztof
