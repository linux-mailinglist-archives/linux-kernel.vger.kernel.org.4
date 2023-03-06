Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE176AC1B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCFNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCFNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:43:20 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30D23873
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:43:18 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t4so8085455ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678110198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JJkVYaR6k4y/YwEKjFCoaiSSS5E0lC7DyrGlhsXf5w=;
        b=LOz7FoweylZgi9J6lwrdz6tiy8AS1nZ7HN40BnYhblypkghOkEBKFBr+jlAqBpJNb7
         4GX60HwmND/rfdFczU9lOL0+8O2ZIcIrfexnmQEzHOOXlhuKQGCanKDZmwvu32Yp+Fai
         L7xrpgnnchYQweepB3wyfcZ48YRGNXsftoZAISo+b7h3u114MgufTVwYYvHVSr7WhugT
         qnNFHWJHnH4n8+1lOp2cVBXMT1ixUlb9SNBX6ze0kWkNFMjkLSk3H7TWJM4/hlH8a9He
         v63npSxGzFUEN2/d8CgGxXpWCJT1g8GjAXrmA8+k5bBc+642oEwRdb2nZ/2ukKZQl8bC
         dcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JJkVYaR6k4y/YwEKjFCoaiSSS5E0lC7DyrGlhsXf5w=;
        b=01LuqvOVOWO/KAP7vGky9KkoKtoHqkmI9LxdLeIWBk7DJau3UQPz93AnmIPK+OMA5d
         jSqiPG8yj+AlyrcJPkrojf5H2IQsUi80z23zi4FKtgiQoLvVsoEgj+yvY4ZO6/IddOlN
         ck0gu6zPz+z+YDnErEBOF3hGLcj6bS6LV6g1j28ff7feCQOvoPdc/f+Q0Tb+lKAJK29P
         38V+sw9OCIA65vamMkA/zoBx23sNoDAEJHH36LN6qyqDBpgFzk5HgGLRzpC/jz0SU80C
         24Yupx/WEAJAhs1CzYnSyy8ZF/RfYCfLpPBJcuiER5lKgJEDeTs7YA58TgDWY1PFvorr
         MbDg==
X-Gm-Message-State: AO0yUKV48mef9Z27x/Uuhn0+8HWarvEpYxJTs0YpD+X+sAphaDwJYn08
        fWHTcrU1KN6nCPgTH4FNNY6hgQaSPcM1tunFCbNotA==
X-Google-Smtp-Source: AK7set8YCn4Jsg6jPH4qYG0BJbp6vWpxECdQH2wjw+INvQEWWcKTR4Gyu0b6jwpzUsU4ixquh/OWea0HjiSteilI90o=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr6489593ybq.5.1678110197962; Mon, 06 Mar
 2023 05:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20230209143702.44408-1-hal.feng@starfivetech.com>
 <CACRpkdbao9M5dMHFO_QE8z4_E6DZLZsMUW1OnUNjKSfQc59=ew@mail.gmail.com>
 <4211d93d-702c-6759-6f25-f86160c0be5d@starfivetech.com> <CAJM55Z-+Cxdebcn4MLXfQdOVhx4c2SQ+zMH8cjn-Yq35xO8g0A@mail.gmail.com>
In-Reply-To: <CAJM55Z-+Cxdebcn4MLXfQdOVhx4c2SQ+zMH8cjn-Yq35xO8g0A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 14:43:06 +0100
Message-ID: <CACRpkdYvzbK-ZJVzh6mGY3Sf5fT3u9LQYkW52BBtiFd2REgwNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Basic pinctrl support for StarFive JH7110 RISC-V SoC
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andreas Schwab <schwab@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:16 AM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> Hi Hal and Linus
>
> I'm curious if there is a plan to address Icenowy's concerns here:
> https://lore.kernel.org/linux-gpio/52dcbe48dbf5f2561713a9642943353216fef15a.camel@icenowy.me/
>
> The problem is that input from "GPIO" pins is configured a little
> differently on the StarFive SoCs. Instead of having a register pr.
> pin(grroup) there is a register pr. control line to the peripherals,
> and into these you write the pin number + 2 of the pin you want the
> peripheral to react to. Why +2? That's because 0 is a special "always
> low" signal and similarly 1 is a special "always high" signal.
>
> With the current bindings one hacky way to solve this is to treat
> those two special values as kind of "virtual pins" that will always be
> high or low. So that would be something like
>
> pinmux = <GPIOMUX(GPIO_ALWAYS_LOW, GPOUT_IGNORED, GPOEN_DISABLE,
> GPI_SYS_USB_OVERCURRENT)>;
>
> ..but this means we might need to mux these two virtual pins to
> multiple peripherals. I'm not sure the pinmux framework is prepared
> for that.

I am not a fan of the magic numbers approach to pin muxing at all and I
often point out that I prefer that you use strings and connect groups with
functions using strings.

The above mentioned problems is one of the reasons.

As maintainer I have been repeatedly hammered down by maintainers
who think magic numbers is good for them, usually because it saves
space in the DTS file and is easier to code a driver for. So this alternative
approach is acceptable, as a compromise.

My apologies if I didn't point this out as sternly as I often do for
StarFive. Really sorry. I guess I have just started to give up on insisting,
as so many people like their magic numbers.

If you switch to stop using the "pinmux" property and instead use
string arrays function and groups as defined in
Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
this should fix it, the old pinmux device trees can be supported
as fallback, if pinmux is present but function and groups are
missing.

So that is my suggestion.

Usually people don't like this suggestion, so I suspect you might
not like it either and come up with something else to work around
it.

Yours,
Linus Walleij
