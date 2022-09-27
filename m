Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9735EC5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiI0O1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiI0O1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:27:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF6E62E9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:27:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so16016758lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Oxh+GrGgW5Md/ssq5B/P1uixYEHvWSD7HAtKuTrp8ws=;
        b=kwWYQBcJQDPMoCbe5L0ONOgX7dAaz/hzZIE73gFP53KUL8HJlLM5ns5ztbYPjP2MY6
         1EG0A8RBurq0SvWYG8cmIXOpjy53hFEZvurDE7P07tPBd3are6N9PdUmGyzf7hClCNy/
         rPj6wm9tK6HEFxEVbHMhQuS/wmSe4P/wyT9RtQis23sORgLfKVxpRGGU0FD3+Wwj6EUi
         tCQdFw039Fve2WC2G6OGgl0zackViCXno781D9n75HdkgufEY+l0IVpK/CIG5Lhv4/mP
         VabJx2dbsrHfR11+DYdX1tlY4ytdYUTHXzcUW3yKVCTVXzRWl/0omoWC8Kk03PIXTfnV
         SHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Oxh+GrGgW5Md/ssq5B/P1uixYEHvWSD7HAtKuTrp8ws=;
        b=ok5c5fNAtPte7zB3bIUfzJBAxA3H/LZG8o6jFEssjIRZ/9Tfcb3zHhXmcyXx8UKD6c
         cCrO3+q7bIr/D3ZBcgw1JNF3W/nrB48mlcijhI3UGFpXshI5prax67lAKAusxXle7eBw
         AumHwhnFRloFtVUGBRnVtWGDef/yCyunKQcO/Hn0bxq0CffvdmTJD7aaNVPevZlz6IUg
         tv5KNsKMQJz+/BZctzlaCoxuhBqNDl0Fu8khDh/0CnVlEaFOwj0aq00QjFCWtD8/aLIz
         3Do4543LYtHEi6nTuHEcVNJVriM/8iJRkR2ft8jWd3nvTtsYorbgnm2F3d5AV14/JkUR
         j0jQ==
X-Gm-Message-State: ACrzQf1KCnxWqXTZSP73rzXEeK09zP+hMXOKRYEIst82i7DfjwkKGvg2
        NeqQ1xfZ/vyD20BZJ6F29oLr7w==
X-Google-Smtp-Source: AMsMyM5bFbLGFxGNSahMhk0VwJDZDb1OhGvbPdW4UtUtIYJI7u5azAjXn0QJGAS62JDqCDDZz9mtmg==
X-Received: by 2002:ac2:5584:0:b0:497:815c:d854 with SMTP id v4-20020ac25584000000b00497815cd854mr11214397lfg.532.1664288821907;
        Tue, 27 Sep 2022 07:27:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f25-20020a2e3819000000b0026c47426cd0sm170134lja.140.2022.09.27.07.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:26:59 -0700 (PDT)
Message-ID: <a88274ce-279e-3a36-d929-1901d6b760cf@linaro.org>
Date:   Tue, 27 Sep 2022 16:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com>
 <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com>
 <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
 <20220909142247.GA238001@francesco-nb.int.toradex.com>
 <CAPDyKFrwpz=gi3iY5YsO6k4o33eLQRp-wXvBx3nQ0q=G9YrqHA@mail.gmail.com>
 <70ee4f8e-7529-307e-656c-2a65d0187af6@linaro.org>
 <CAPDyKFoyNWZvT+QPdX4sQuS3DL8mepfnLraHLusMi9K8MOfLgg@mail.gmail.com>
 <d19ffd93-bbb3-ac61-0ec3-58fd48443eb2@linaro.org>
 <CAPDyKFrDFAif3DnvPoLrgJ2+fv+aB9GyOoG_O3q-1m=2Y5eT5w@mail.gmail.com>
 <CAMuHMdVteS1va320fAAx445eFQ75XnapQbeGWEkg2aagnjN6Jg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVteS1va320fAAx445eFQ75XnapQbeGWEkg2aagnjN6Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 14:49, Geert Uytterhoeven wrote:
> Hi Ulf,
> 
> On Tue, Sep 27, 2022 at 11:49 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>>> The main concern that was raised on this topic was that we have to
>>>>>>> somehow link the power-domain to the specific peripherals (the power
>>>>>>> domain consumer) in the device tree.
>>>>>>
>>>>>> Yes, that is needed. Although, I don't see how that is a concern?
>>>>>>
>>>>>> We already have the valid bindings to use for this, see more below.
>>>>>>
>>>>>>>
>>>>>>> Adding the power-domain property there will trigger validation errors
>>>>>>> unless we do explicitly add the power-domains to the schema for each
>>>>>>> peripheral we need this. To me this does not really work, but maybe I'm
>>>>>>> not understanding something.
>>>>>>>
>>>>>>> This is what Rob wrote on the topic [1]:
>>>>>>>   > No. For 'power-domains' bindings have to define how many there are and
>>>>>>>   > what each one is.
>>>>>>>
>>>>>>> Just as an example from patch [2]:
>>>>>>>
>>>>>>>   can1: can@0 {
>>>>>>>     compatible = "microchip,mcp251xfd";
>>>>>>>     power-domains = <&pd_sleep_moci>;
>>>>>>>   };
>>>>>>>
>>>>>>> leads to:
>>>>>>>
>>>>>>>   imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>>>>           From schema: .../bindings/net/can/microchip,mcp251xfd.yaml
>>>>>>
>>>>>> I think it should be fine to just add the below line to the DT
>>>>>> bindings, for each peripheral device to fix the above problem.
>>>>>>
>>>>>> power-domains: true
>>>>>
>>>>> Again, as Rob said, no, because it must be strictly defined. So for
>>>>> example: "maxItems: 1" for simple cases. But what if device is then part
>>>>> of two power domains?
>>>>>
>>>>>>
>>>>>> That should be okay, right?
>>>>>
>>>>> Adding it to each peripheral scales poorly. Especially that literally
>>>>> any device can be part of such power domain.
>>>>
>>>> Right.
>>>>
>>>>>
>>>>> If we are going with power domain approach, then it should be applicable
>>>>> basically to every device or to every device of some class (e.g. I2C,
>>>>> SPI). This means it should be added to respective core schema in
>>>>> dtschema repo, in a way it does not interfere with other power-domains
>>>>> properties (existing ones).
>>>>
>>>> Isn't that already taken care of [1]?
>>>
>>> No, because it does not define the items (what are the power domains and
>>> how many). This binding expects that any device has maxItems restricting it.
>>
>> Right, apologize for my ignorance.
>>
>>>
>>>>
>>>> If there is more than one power domain per device, perhaps we may need
>>>> to extend it with a more strict binding? But, that doesn't seem to be
>>>> the case here - and if it turns out to be needed later on, we can
>>>> always extend the bindings, no?
>>>>
>>>> Note also that we already have DT bindings specifying "power-domains:
>>>> true" to deal with the above. Isn't that what we want?
>>>
>>> You mentioned it before and both me and Rob already responded - no,
>>> because it does not restrict the number of items.
>>
>> Okay, so maxItems need to be specified for each peripheral. It's not a
>> big deal, right?

It's a bit of effort to add it manually to each device binding. It just
does not scale well.

>>
>> Of course, it would be even easier if the core schema would use a
>> default "maxItems: 1" for power domain consumers, which of course must
>> be possible to be overridden for those consumers that need something
>> else. But perhaps it's not that simple. :-)

I think this would be the way to do it properly.

> 
> It's not that simple: being part of a PM Domain is not a property of the
> device being described, but a property of the integration into the SoC.

I agree.

This concept of power domains for every device does not look like really
describing the hardware. The hardware itself, e.g. some camera sensor or
I2C device, might have power supply and reset pin. It does not have
something like power-domain.

Although one could also argue that it is the same case with SoC blocks -
being part of power domain is a property of a SoC and its power domain
controller.


> All synchronous hardware needs power (single/multiple), clock(s), and
> reset(s).  But the granularity of control over power(s), clocks, and resets
> depends on the integration.  So the related properties can appear
> anywhere.

Best regards,
Krzysztof

