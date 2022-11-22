Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5135D63375C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiKVInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiKVImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:42:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1230A1B8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:42:51 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h12so17138009ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7NY7k+Aa5N9DlhIquG0NmiQoRxU6GJ+N37ltBBWUU4=;
        b=Py0vsaEjCa1ebI9VbLXGCjZoKNk0awz8348fV82HhXMTl+0Up/DS1w2fXqTJo1Fu5h
         7tlGWkQh/CldNpiEJXVVjJCywZCfY8CEhWuQ/rAlwxP3cxTvX8J7pCTaMCMWCkt284N6
         pONkTaqGA1O2GdydkHB1NwZZpjO7wh8aCobZmOrCNSaNe09u+MiYuVk8mH7C+nXNol0T
         pwhslqdw7WYV9l7rEtfcjJ7hXMrc7RG1dauk24VmPBmt+ei9za3s17jwmUWIVAcGiv6X
         KEDDuQYof+4vrTWEX+NtDmwVyxRjLQfgG4y/cB/nNvjpu/nABfehARzgDuPI/qA/f1RO
         6OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7NY7k+Aa5N9DlhIquG0NmiQoRxU6GJ+N37ltBBWUU4=;
        b=RGGO5f7b25z5nm17N5Q3NE6/24xXNk/yOyLPnbcGekaJMhFGmX5X7/mJx6ZJFR8BAg
         y16wU2ZxnaVu04lUavwCNQE3/m221rSA5kAHZhoy2Wswe6Mo3xO2OK0sgXds+3HDxtI7
         NfZyCb4AwkE8OfFC9yVxu9ObBc5eP6jQrYFgAfsTpc5V8WzlRVY7daHsAIhfPqoVrgwL
         IjAmz86o3TwpY/qHpHislStGf3lSm6FL2RdUFIBOzvFdC0ybBY77Z2u/uRxCs7+LMqh+
         mPaBvAi0MH+PuOf97g/zxJdSzTzmNwE18ME8Vs6zaz8ramoY73QCXaovFxduTt8FEZHo
         AMRA==
X-Gm-Message-State: ANoB5pkDX5X5SNYNAMwagVf4I4mhhT2+xOM9HbQBJ+lEyDE2OkD8oP03
        ucRsf1o/u5H96hc//TMVSpjNVw==
X-Google-Smtp-Source: AA0mqf7/UsftI+kuXWw2ZObJffeMs3x/d131N5RP0pQBBjM51jfoAwn6fUl61SAYf6wBK0vyMPAUow==
X-Received: by 2002:a2e:aa9f:0:b0:277:710f:f973 with SMTP id bj31-20020a2eaa9f000000b00277710ff973mr7123921ljb.74.1669106570016;
        Tue, 22 Nov 2022 00:42:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t3-20020a2e8e63000000b0026fbac7468bsm1703702ljk.103.2022.11.22.00.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:42:49 -0800 (PST)
Message-ID: <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
Date:   Tue, 22 Nov 2022 09:42:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
 <20221115150417.513955a7@bootlin.com> <20221118112349.7f09eefb@bootlin.com>
 <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com>
 <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
 <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
 <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 09:25, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 21/11/2022 21:46, Geert Uytterhoeven wrote:
>>>> This does not change anything. Herve wrote:
>>>>
>>>>> probe some devices (USB host and probably others)
>>>>
>>>> Why some can be probed earlier and some not, if there are no
>>>> dependencies? If there are dependencies, it's the same case with sysctrl
>>>> touching the register bit and the USB controller touching it (as well
>>>> via syscon, but that's obvious, I assume).
>>>>
>>>> Where is the synchronization problem?
>>>
>>> The h2mode bit (and probably a few other controls we haven't figured out
>>> yet) in the sysctrl must be set before any of the USB devices is active.
>>> Hence it's safest for the sysctrl to do this before any of the USB drivers
>>> probes.
>>
>> Again, this does not differ from many, many of other devices. All of
>> them must set something in system controller block, before they start
>> operating (or at specific time). It's exactly the same everywhere.
> 
> The issue here is that there are two _different drivers_ (USB host
> and device). When both are modular, and the driver that depends on the
> sysctrl setting is loaded second, you have a problem: the sysctrl change
> must not be done when the first driver is already using the hardware.
> 
> Hence the sysctrl driver should take care of it itself during early
> initialization (it's the main clock controller, so it's a dependency
> for all other I/O device drivers).

I assumed you have there bit for the first device (which can switch
between USB host and USB device) to choose appropriate mode. The
bindings also expressed this - "the USBs are". Never said anything about
dependency between these USBs.

Are you saying that the mode for first device cannot be changed once the
second device (which is only host) is started? IOW, the mode setup must
happen before any of these devices are started?

Anyway with sysctrl approach you will have dependency and you cannot
rely on clock provider-consumer relationship to order that dependency.
What if you make all clocks on and do not take any clocks in USB device?
Broken dependency. What if you want to use this in a different SoC,
where the sysctrl does not provide clocks? Broken dependency.

You have here in such case parent-child dependency, not
provider-consumer. Just like for all serial-protocol engines (I2C/UART/SPI).

Best regards,
Krzysztof

