Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB270D876
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjEWJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEWJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:09:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595B94
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:09:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f50e26b8bso950877866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684832993; x=1687424993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoEso63g+0SKeGzDkD1maNgqaaGX52WJnGRxyXGPsc4=;
        b=FYAUUJhu+cevF0Zg6iafvi/RtW1iniieS1LAaBi9MEVhqlz2zQbYCstnjRu/XTE8Tf
         acH2KyB0IdWo6ugqPyNwIz21e+g2LeWBYqRvA0GOg0lbQzchwHoUQNzoNNAd7QLVWU07
         au1DvBzxTw9kUXKLd2247RVQOQfQHmX9VNs2E56xdNsSNFbNUy4gSKZMclU1/+3cLBAF
         VtMJKIjpxd1kltJ468dOvHZ+pnitvI8oMKRF5I8NcdITJS6SqrFi+DQS62zLPqyvBZjj
         fEjz8degm1IisEbJokZhmTYZ9ScHgDPiSzCLQUMZJFanPMgXE/lf9aSxV3spPupYJzwb
         59qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832993; x=1687424993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoEso63g+0SKeGzDkD1maNgqaaGX52WJnGRxyXGPsc4=;
        b=Lr4GFNDIWMZBCpuy4S+/iGlMmFQ0qoOtnC8/azald0IUY1Gv17uRuLxbe7bthsAeMz
         tdCwtAEwccjUxhHIvMI0LBJmdpFqTKb6FMxGQim2/i1uXS9TQRRS0/CxVpxV7lKvrNbJ
         BKHF4Oc+6t7GQLIdHOdJl0txjx6op4Lmiiqo3eOAJ3cgBTwG1HuVNv75+28lif8wgLsH
         tqAVcDWapAet8Io4KxKb00i62pj/Q+AdfEdeNPYSlQP0f13511EV143hS6vXduJBC++G
         Cx33p0fNdrFRgaASaT96Qmaz8ZBx2MpIS/Ig2dG6KzqE8kza10nHH7rBHa/8e1nkMDvV
         Hvnw==
X-Gm-Message-State: AC+VfDyQWTsHOMW4A5H54g1/jXDdc261ai4IQppj3gwC1czFqfx0lD+Q
        JpkS//RLMm6KzhYJFsUene6UMg==
X-Google-Smtp-Source: ACHHUZ5zYnuYGtxhCBEc6UuB0mA8LCTKfqijjVsWcN9D+xkiJ0rEyMKWdCr9Yd6nvdeUbwg/r/Dqxw==
X-Received: by 2002:a17:907:60cc:b0:96a:580e:bf0f with SMTP id hv12-20020a17090760cc00b0096a580ebf0fmr15054349ejc.14.1684832993139;
        Tue, 23 May 2023 02:09:53 -0700 (PDT)
Received: from [10.2.5.18] (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm4213801ejn.189.2023.05.23.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:09:52 -0700 (PDT)
Message-ID: <0cf870f1-8cdb-df74-79d6-a4004cdfcc2f@baylibre.com>
Date:   Tue, 23 May 2023 11:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
 <ZGiWdQcR6Zq6Aw65@surfacebook>
 <9fa1a6e8-368a-3e22-aa84-8cad09f72a32@baylibre.com>
 <CAHp75Vf0hW6sMXeGSVXRVoW1mxFufWmbJNzt7_10xPj_k5SNkA@mail.gmail.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <CAHp75Vf0hW6sMXeGSVXRVoW1mxFufWmbJNzt7_10xPj_k5SNkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2023 13:18, Andy Shevchenko wrote:
> On Mon, May 22, 2023 at 10:47 AM jerome Neanne <jneanne@baylibre.com> wrote:
>> On 20/05/2023 11:44, andy.shevchenko@gmail.com wrote:
>>> Mon, May 15, 2023 at 05:36:46PM +0200, Bartosz Golaszewski kirjoitti:
>>>> On Thu, May 11, 2023 at 4:09 PM Jerome Neanne <jneanne@baylibre.com> wrote:
> 
> ...
> 
>>>>> +       gpio->gpio_chip = tps65219_gpio_chip;
>>>>
>>>> Aren't you getting any warnings here about dropping the 'const' from
>>>> the global structure?
>>>
>>> But this is a copy of the contents and not the simple pointer.
> 
> I commented on Bart's question.
> 
>> In many other places where this is done, the struct is declared like:
>>
>> static const struct gpio_chip template_chip = {
>>
>> After internal review, I changed this to:
>>
>> static const struct gpio_chip tps65219_gpio_chip = {
>>
>> This is because I didn't want to have this "template" that sounds to me
>> like "dummy". Maybe I misunderstood and this "template" was used on
>> purpose because this const struct is just copied once to initialize
>> tps65219_gpio->gpio_chip during probe.
>>
>> Introducing tps65219_gpio_chip name is maybe confusing with
>> tps65219_gpio struct.
>>
>> I think the const should not be a problem here but the naming I used
>> might be misleading. If you have a suggestion of what is a good practice
>> to make this piece of code clearer. I'll follow your suggestion (use
>> template? more_explicit name like ???).
> 
> It's up to Bart.
> 
Bart, should I keep the code like this or do you suggest a name change 
so that's it's more appealing?
