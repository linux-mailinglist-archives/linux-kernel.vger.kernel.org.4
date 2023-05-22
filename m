Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02E70B70A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjEVHvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjEVHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:51:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07A1FDA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:49:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso36514125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684741665; x=1687333665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiwtxuCvDMv279PaESGTGeWvfl9xpTP38snTPyvkmBg=;
        b=B25mpczTgDcacVp+M6vrs2FgiTGL/wKWpN6AAIB6Gu5dpTHYtKOdT9XNHHa4GuiQfa
         4PGCOx4vZ51Thk+XPM0PHTtN80XzjkfpKm8VOQhHeBWz6M0IuJNhaaPT5WmaScxkHprc
         0ExBWYoZRybJe36CnBhKmzulXCBluuhFrXN+LWdNhxoSB4BBL/tsPfovii4pVagPIwza
         8q+g+4U0sbzNK5l+SwsUDV1iOo7DUEqpo8QI2elc3HZYtx/ooIhAVNJHycoOOhfow9iI
         uBe4F411Ts7KIhcF3QKupAR/hGs14uwO8aYhcCYiBEHodmmdyGSAInJHSxg+mzf4EBOh
         z8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684741665; x=1687333665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiwtxuCvDMv279PaESGTGeWvfl9xpTP38snTPyvkmBg=;
        b=g7cEV980X13dKLdR8OZwN9MecSyWXNSwaKlWu36jP6sReXu4JH7ciMS9Hg/VSsFvaV
         L8gY5vBnpfUoa8BusRrzXoMHtJVQmWYeOS4JkPHhk9pwY914Q3qTC2BmuUXNi6uJznTu
         W/i3hOpq1k8bsFv0tkDgTXhv4k7FtbMUG4OOMB4+2aYtcND//tMoWAW9zl+jpCUJcEZ4
         ogBfb90luSbjgCwzWRMr/PCZzHFguo3Ono+QJcplYpIy+bPmzDM2gO9KXD8Nt8y1ZFKo
         1JYJfXKgqGP69OgJybXE5vRujNGIf5OXVpc7ALDIgJicmyol7LkEW93169OFZkKly7md
         izgA==
X-Gm-Message-State: AC+VfDxeywc5iem/6R5PSweFQd38Udgq1kfzfncVg1hKBxbmdkfJ4T5M
        tsac4NvwSf70lS2ULrVYQvIYXcIAFfpWA/IJrhU=
X-Google-Smtp-Source: ACHHUZ478uL/FKIIQkjSOc9DwlEwYv9wHPlknnkW6XyifiI5UtwdQFU6A6JEmqkTdYI/pNVm+JOY1w==
X-Received: by 2002:a05:600c:b4f:b0:3f4:ec32:6a00 with SMTP id k15-20020a05600c0b4f00b003f4ec326a00mr6264367wmr.6.1684741664711;
        Mon, 22 May 2023 00:47:44 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003f60101074dsm5286380wmg.33.2023.05.22.00.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 00:47:44 -0700 (PDT)
Message-ID: <9fa1a6e8-368a-3e22-aa84-8cad09f72a32@baylibre.com>
Date:   Mon, 22 May 2023 09:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     andy.shevchenko@gmail.com, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
 <ZGiWdQcR6Zq6Aw65@surfacebook>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <ZGiWdQcR6Zq6Aw65@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2023 11:44, andy.shevchenko@gmail.com wrote:
> Mon, May 15, 2023 at 05:36:46PM +0200, Bartosz Golaszewski kirjoitti:
>> On Thu, May 11, 2023 at 4:09 PM Jerome Neanne <jneanne@baylibre.com> wrote:
> 
> ...
> 
>>> +       gpio->gpio_chip = tps65219_gpio_chip;
>>
>> Aren't you getting any warnings here about dropping the 'const' from
>> the global structure?
> 
> But this is a copy of the contents and not the simple pointer.
> 
In many other places where this is done, the struct is declared like:

static const struct gpio_chip template_chip = {

After internal review, I changed this to:

static const struct gpio_chip tps65219_gpio_chip = {

This is because I didn't want to have this "template" that sounds to me 
like "dummy". Maybe I misunderstood and this "template" was used on 
purpose because this const struct is just copied once to initialize
tps65219_gpio->gpio_chip during probe.

Introducing tps65219_gpio_chip name is maybe confusing with 
tps65219_gpio struct.

I think the const should not be a problem here but the naming I used 
might be misleading. If you have a suggestion of what is a good practice 
to make this piece of code clearer. I'll follow your suggestion (use 
template? more_explicit name like ???).

Thanks for your time.
