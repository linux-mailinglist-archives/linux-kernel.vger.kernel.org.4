Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A795BC32D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiISG4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiISG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:56:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4559A13E2F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:56:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w8so45403564lft.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bKbN1I3cs9nIBHXs3yK9lgtbTnTo8V/szSejEq/+Fh8=;
        b=abmE5BPvSBlnQ/1wpJYNvjkXHwjnf4/jKgTtS0LkWH821XELN32YCjHut3FUlPWpqO
         LbKfyXvQQ1rf4qE7EuXL872ArsIK2IJJIZINK9jwftM04Bjk3YywUeHICS0YAuYmYwK5
         f1+9Hyus6T56BP3Hb3VTW/GIWjXxzKsaoDJwy+nFtho23otI6cODCNjsLCo3MWJcTnjF
         nFhq7guNhl4dgHHNbOchlKuImhD/ixbIdsnj1K8bJ+0V8/dJNejOUbjxyF8LIXs9pfCS
         RHpb2SemaG7VIyMOtHoEkk+0OUBahM1/T/iSHgCQGRuoLjIooScvZRxKWtMHkpBL6ZHY
         pwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bKbN1I3cs9nIBHXs3yK9lgtbTnTo8V/szSejEq/+Fh8=;
        b=37GK3Pux8ny5j8uCRKJmIzsDuMn/NJm0iYR0hAHG75ayP4oWLNp68TbitPhAOt6Lm7
         bADX/91WBU1a1phLQstvabtC2nnReti80PhyjFeL+MSUMUEtPbjQWob3sV6QohJZqzKL
         EdE0yFMo8X4QGNg3GrJ7q0oro4QeiiG+k/GQn6hbYyo+PdkS/dQnMgytmDZN9heI7Urh
         1u/EQ3XchnYRP2XZmV6Wfv3ADbWyXlgeHdboakPWEo61Bx/2BBTgvwJCg1twbWZ6rnLU
         vViHqUUEp4jYfY8QTpjdg38IIPNRpGj5yXO/KL3v8BOkiZqtOUIR8OT+WXvTqbME94Ak
         s+Dw==
X-Gm-Message-State: ACrzQf1chcy5riCrswRC69nXiArUS7AjfAg6XWskVHVuOxYSitC+Yzvk
        ke4o1/Vy+xf8Z4MoLZbWHInYmQ==
X-Google-Smtp-Source: AMsMyM7pmT02HbMvT2Z9EbsCYNa431X5QazL/wY5I4IaRn1ay6AOpAdg2MDEBDBbE+AsP8u0MCUl1w==
X-Received: by 2002:a05:6512:10ce:b0:49e:ad1f:3d7 with SMTP id k14-20020a05651210ce00b0049ead1f03d7mr5364814lfg.609.1663570572634;
        Sun, 18 Sep 2022 23:56:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be7-20020a056512250700b00492c463526dsm5066078lfb.186.2022.09.18.23.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 23:56:12 -0700 (PDT)
Message-ID: <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org>
Date:   Mon, 19 Sep 2022 08:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2022 20:28, Tomer Maimon wrote:
> Hi Rob,
> 
> Thanks for your comment and sorry for the late reply.

Two months... we are out of the context and this will not help your
patchset.

> 
> On Tue, 19 Jul 2022 at 00:10, Rob Herring <robh@kernel.org> wrote:
>>

(...)

>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +
>>> +    soc {
>>> +      #address-cells = <2>;
>>> +      #size-cells = <2>;
>>> +
>>> +      pinctrl: pinctrl@f0800000 {
>>> +        compatible = "nuvoton,npcm845-pinctrl";
>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        nuvoton,sysgcr = <&gcr>;
>>> +
>>> +        gpio0: gpio@f0010000 {
>>
>> gpio@0
>>
>> Is this really a child block of the pinctrl? Doesn't really look like it
>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
>> so, then pinctrl should be a child of it. But that doesn't really work
>> too well with gpio child nodes...
> the pin controller mux is handled by sysgcr this is why the sysgcr in
> the mother node,
> and the pin configuration are handled by the GPIO registers.  each
> GPIO bank (child) contains 32 GPIO.
> this is why the GPIO is the child node.

Then maybe pinctrl should be the sysgcr and expose regmap for other devices?


Best regards,
Krzysztof
