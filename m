Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C15EAC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiIZQXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiIZQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:22:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1CFAC6A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:11:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so11317708lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0ResaCRcsUOki8mHX84VLbBbaYO+n6OLrjO1w6TMR/M=;
        b=MKazrO8zStfo7jH6sUqOhcWXlHZ6jGioyPRBckSnMOrSREao2F5mnNbChlk3TKYGlt
         6x1nPv+VF5/OIuP/O7bpXX3uIJA6p6mhP1MqVBtzASCnkOjchLlLtKN/TDXx5iUU4OZ5
         OwmF+FAywLtutF/J0EPsnN58b3SoaPVqrIj92Mo6DLYuYYaZL4ko3zdYTA6oxqgDpqkk
         1JtFOMOkvr+Nx+a6l2JIkNSt3rOeRPHxCczjNzOqrHG60XauSdrJakhYGL8MhgWCrpcX
         nJggzuqE+O3xcr35ooTVXUuqZWXYjasuvev5DlIEnnNOKsndEStIqAvkYEm4Iur4KQss
         pHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0ResaCRcsUOki8mHX84VLbBbaYO+n6OLrjO1w6TMR/M=;
        b=VTEWIWkua7K/1/QnI/jC+hgx1NwPq+MA8cX57LS9CNvtt5Ycp3QFhR3bZdWL4YYS1t
         vrAdd6lA8YyKeS8lFfFZYGGQGeR90TOrQlWdLECeq29wKzvcjrtr1S4flfBmca3F8KLp
         ke6Yxq4B0lx/XFd4VO0AfYdBUzyym8V8O/+drLsP2dpacWi3khCBtWB3wBmoG61NPjjB
         pIcuAnPMdrW8g8P5MHmyEV0s7f4jwc5/v3NjdSoCtOqj3lnMw7Feuu9/S9frlKH1VTdf
         XUS1ovZtxzo9HcFDmMQw2NaLreZG6sfYymjnY/AMXGNhYDaxyG+iEIuRo9+7QcXEosFM
         G0KQ==
X-Gm-Message-State: ACrzQf0DtGVnScDjL5oNCGXG+86RHdMyGy36hAMF/Y1CC2o6uvqdKkA5
        O+RrDHlwF7jvBkn/1gLnaaEyvw==
X-Google-Smtp-Source: AMsMyM5DbWjQ5OcG45qSNXBkGdY9nbJMePM8Uy0a14deDFRDiV8v7kvdmFk2yqZgew9/0hkEjpKUkw==
X-Received: by 2002:a05:6512:3584:b0:49f:517a:19da with SMTP id m4-20020a056512358400b0049f517a19damr8640642lfr.25.1664205098092;
        Mon, 26 Sep 2022 08:11:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b0026c453c51b7sm2330019ljo.68.2022.09.26.08.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:11:37 -0700 (PDT)
Message-ID: <d19ffd93-bbb3-ac61-0ec3-58fd48443eb2@linaro.org>
Date:   Mon, 26 Sep 2022 17:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFoyNWZvT+QPdX4sQuS3DL8mepfnLraHLusMi9K8MOfLgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 12:12, Ulf Hansson wrote:
> On Fri, 23 Sept 2022 at 20:00, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/09/2022 15:49, Ulf Hansson wrote:
>>> On Fri, 9 Sept 2022 at 16:22, Francesco Dolcini
>>> <francesco.dolcini@toradex.com> wrote:
>>>>
>>>> Hello Ulf,
>>>>
>>>> On Fri, Aug 26, 2022 at 03:50:46PM +0200, Ulf Hansson wrote:
>>>>> On Thu, 28 Jul 2022 at 13:21, Francesco Dolcini
>>>>> <francesco.dolcini@toradex.com> wrote:
>>>>>>
>>>>>> On Thu, Jul 28, 2022 at 11:37:07AM +0200, Ulf Hansson wrote:
>>>>>>> On Tue, 26 Jul 2022 at 18:03, Francesco Dolcini
>>>>>>> <francesco.dolcini@toradex.com> wrote:
>>>>>>>>
>>>>>>>> Hello Ulf and everybody,
>>>>>>>>
>>>>>>>> On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
>>>>>>>>> On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
>>>>>>>>>> So our plan is to explicitly handle a (shared) regulator in every
>>>>>>>>>> driver involved, adding that regulator capability for drivers not
>>>>>>>>>> already having one.
>>>>>>>>>
>>>>>>>>> Please don't! I have recently rejected a similar approach for Tegra
>>>>>>>>> platforms, which now have been converted into using the power domain
>>>>>>>>> approach.
>>>>>>>>
>>>>>>>> Just to quickly re-iterate how our hardware design looks like, we do
>>>>>>>> have a single gpio that control the power of a whole board area that is
>>>>>>>> supposed to be powered-off in suspend mode, this area could contains
>>>>>>>> devices that have a proper Linux driver and some passive driver-less
>>>>>>>> components (e.g. level shifter) - the exact mix varies.
>>>>>>>>
>>>>>>>> Our proposal in this series was to model this as a power domain that
>>>>>>>> could be controlled with a regulator. Krzysztof, Robin and others
>>>>>>>> clearly argued against this idea.
>>>>>>>
>>>>>>> Well, historically we haven't modelled these kinds of power-rails
>>>>>>> other than through power-domains. And this is exactly what genpd and
>>>>>>> PM domains in Linux are there to help us with.
>>>>>>>
>>>>>>> Moreover, on another SoC/platform, maybe the power-rails are deployed
>>>>>>> differently and maybe those have the ability to scale performance too.
>>>>>>> Then it doesn't really fit well with the regulator model anymore.
>>>>>>>
>>>>>>> If we want to continue to keep drivers portable, I don't see any
>>>>>>> better option than continuing to model these power-rails as
>>>>>>> power-domains.
>>>>>>>
>>>>>>>>
>>>>>>>> The other approach would be to have a single regulator shared with the
>>>>>>>> multiple devices we have there (still not clear how that would work in
>>>>>>>> case we have only driver-less passive components). This is just a
>>>>>>>> device-tree matter, maybe we would need to add support for a supply to
>>>>>>>> some device drivers.
>>>>>>>>
>>>>>>>> Honestly my conclusion from this discussion is that the only viable
>>>>>>>> option is this second one, do I miss something?
>>>>>>>
>>>>>>> No thanks!
>>>>>>>
>>>>>>> Well, unless you can convince me there are benefits to this approach
>>>>>>> over the power-domain approach.
>>>>>>
>>>>>> I'm fine with our current power-domain proposal here, I do not need to
>>>>>> convince you, I have the other problem to convince someone to merge
>>>>>> it :-)
>>>>>>
>>>>>> Maybe Krzysztof, Robin or Mark can comment again after you explained
>>>>>> your view on this topic.
>>>>>
>>>>> To move things forward, I suggest you re-start with the power domain approach.
>>>>>
>>>>> Moreover, to avoid any churns, just implement it as another new SoC
>>>>> specific genpd provider and let the provider deal with the regulator.
>>>> I'm sorry, but I was not able to understand what you mean, can you
>>>> provide some additional hint on the topic? Some reference driver we can
>>>> look at?
>>>
>>> Typically, "git grep pm_genpd_init" will find genpd providers.
>>>
>>> There are a couple of examples where a regulator (among other things)
>>> is being controlled from the genpd's ->power_on|off() callbacks, such
>>> as:
>>>
>>> drivers/soc/mediatek/mtk-pm-domains.c
>>> drivers/soc/imx/gpc.c
>>>
>>>>
>>>> The driver we implemented and proposed with this patch is just
>>>> connecting a power-domain to a regulator, it's something at the board
>>>> level, not at the SoC one.
>>>> We do not have a (existing) SoC driver were we could add the power
>>>> domain provider as an additional functionality.
>>>
>>> Right, so you need to add a new SoC/platform driver for this.
>>>
>>>>
>>>>> In this way, you don't need to invent any new types of DT bindings,
>>>>> but can re-use existing ones.
>>>> The only new binding would be a new "compatible" to have a place to
>>>> tie the regulator instance used in the device tree, but I do not think
>>>> that this is an issue at all.
>>>
>>> Yes, I agree.
>>>
>>>>
>>>> The main concern that was raised on this topic was that we have to
>>>> somehow link the power-domain to the specific peripherals (the power
>>>> domain consumer) in the device tree.
>>>
>>> Yes, that is needed. Although, I don't see how that is a concern?
>>>
>>> We already have the valid bindings to use for this, see more below.
>>>
>>>>
>>>> Adding the power-domain property there will trigger validation errors
>>>> unless we do explicitly add the power-domains to the schema for each
>>>> peripheral we need this. To me this does not really work, but maybe I'm
>>>> not understanding something.
>>>>
>>>> This is what Rob wrote on the topic [1]:
>>>>   > No. For 'power-domains' bindings have to define how many there are and
>>>>   > what each one is.
>>>>
>>>> Just as an example from patch [2]:
>>>>
>>>>   can1: can@0 {
>>>>     compatible = "microchip,mcp251xfd";
>>>>     power-domains = <&pd_sleep_moci>;
>>>>   };
>>>>
>>>> leads to:
>>>>
>>>>   imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>           From schema: .../bindings/net/can/microchip,mcp251xfd.yaml
>>>
>>> I think it should be fine to just add the below line to the DT
>>> bindings, for each peripheral device to fix the above problem.
>>>
>>> power-domains: true
>>
>> Again, as Rob said, no, because it must be strictly defined. So for
>> example: "maxItems: 1" for simple cases. But what if device is then part
>> of two power domains?
>>
>>>
>>> That should be okay, right?
>>
>> Adding it to each peripheral scales poorly. Especially that literally
>> any device can be part of such power domain.
> 
> Right.
> 
>>
>> If we are going with power domain approach, then it should be applicable
>> basically to every device or to every device of some class (e.g. I2C,
>> SPI). This means it should be added to respective core schema in
>> dtschema repo, in a way it does not interfere with other power-domains
>> properties (existing ones).
> 
> Isn't that already taken care of [1]?

No, because it does not define the items (what are the power domains and
how many). This binding expects that any device has maxItems restricting it.

> 
> If there is more than one power domain per device, perhaps we may need
> to extend it with a more strict binding? But, that doesn't seem to be
> the case here - and if it turns out to be needed later on, we can
> always extend the bindings, no?
> 
> Note also that we already have DT bindings specifying "power-domains:
> true" to deal with the above. Isn't that what we want?

You mentioned it before and both me and Rob already responded - no,
because it does not restrict the number of items.

Best regards,
Krzysztof

