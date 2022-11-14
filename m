Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4D6277E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiKNIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbiKNIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:38:20 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D17B1C421;
        Mon, 14 Nov 2022 00:38:18 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z1so6949275qkl.9;
        Mon, 14 Nov 2022 00:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rl0S7SZImNPA7fsarWyNdeE6Xw1pskJEOYN6VZ4/w6c=;
        b=JWXBYlbE4IZKFyU7cw1JN3toiIDiM1j+J3ieeSimAiGQ4kd12a937qiszUalLrQfPS
         YvanZzk1s4u+vk1tnUQHTjtm31F5Er6hkj8b/o003eo/EfY2mLlFXFqM3GtXhw1v5y+w
         Fisdq0lXuBINRAuLETi3i8S7sZn8voF1wloajCIP7wDqM5pp0QU+BU1TlPNSJu4aJJsC
         vIFCU2OY5uixYSPYcoDcwPBXWXImlFg6kSITqvg8YlJ8GWRbgDX57EI32Otp6uWPmkX2
         owluFVRM5m8w6L9ARkMtn/dHpHVwLgGYvGHTmrD1ayzsOKASDREBksWU9EZSVdvDWaLQ
         zZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rl0S7SZImNPA7fsarWyNdeE6Xw1pskJEOYN6VZ4/w6c=;
        b=MIXusZISYlqWC25iZf2kjDiE10ZleRSHCnJMHyjkBCrTuEMdpuC28xhgk3XX63q3T3
         I8QVvuUM7XOjjsgJAVc7DWQ13DkUvBalYVjLhk/magOO9Q6fAZUwqD7QBjxCx7h8wAee
         O+L8o3FWQAjzSurqIcfZ/s2XFI9h2ACzNJqH0Fup13xJKrCZZWsiwP3r/v8UP1IvfwkS
         M+QxSWlxZbC/IW2qrZbM3msL84NIfBqi6F4H65vWRpd/L8Dc6tTUFxWsthGNJVuReeBd
         9kiKOG0HC163VA85/tGN+TYS2c0ApQc83mlhoCAdhE6tOH7a8xLJqBd9PH5OFSk53QjQ
         12SA==
X-Gm-Message-State: ANoB5pkdk6amLfDhdZwQEE0fToOFzSAJXL4xKzFZ2B0BCrCHeCARKYTc
        81xxK4eVBX+CvNuUeCf4aNVC2SNNDeaLSbXMM7o=
X-Google-Smtp-Source: AA0mqf7cf8gdzo9nrxZ91+TyMP8G5BnW5MpjVlq6lMOFmBqbhSn3NamN9nkudtDhBrmQeYl4pyZ46hsJmmpXLKshPm8=
X-Received: by 2002:a05:620a:1094:b0:6fb:4a84:cef2 with SMTP id
 g20-20020a05620a109400b006fb4a84cef2mr9923232qkk.158.1668415097229; Mon, 14
 Nov 2022 00:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20221108092840.14945-1-JJLIU0@nuvoton.com> <20221108092840.14945-4-JJLIU0@nuvoton.com>
 <CACRpkdb+Bkwa8yCKGtRcsJ6KnJh+RUuz_gOrQV63pcYQLaHCaw@mail.gmail.com>
 <CAKUZ0+GCf_Zv=VhnY5Z=yYAfR1=_ha98BVVxRGVy8ui6so_Yrg@mail.gmail.com> <CACRpkdYW0P8gqtGdiRX_frP32WF2W=NVg1JTu1fVMBXxEL0-WA@mail.gmail.com>
In-Reply-To: <CACRpkdYW0P8gqtGdiRX_frP32WF2W=NVg1JTu1fVMBXxEL0-WA@mail.gmail.com>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Mon, 14 Nov 2022 16:38:06 +0800
Message-ID: <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Thanks for your reply.

let me explain the gpio pin as below:

Our sgpio module has 64 pins output and 64 pins input.
Soc have 8 reg to control 64 output pins
and  8 reg to control 64 input pins.
so the pin is only for gpi or gpo.

The common property ngpio can be out or in.
so i need to create d_out and d_in to control it.
customers can set the number of output or input pins to use.
the driver will open the ports to use.
ex: if  i set d_out=9   and d_in=20
driver will open two output ports and three input ports.

Another method  is the driver default opens all ports , in this
situation the driver doesn't need d_out and d_in.


Best regards,
Jim



On Fri, Nov 11, 2022 at 10:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Nov 11, 2022 at 10:30 AM Jim Liu <jim.t90615@gmail.com> wrote:
>
> > -D_out:
> > the output data is the serial data needed to connect to hc595 and the
> > data will output to hc595 parallel pins.
> > you can use dts nout_gpios to create the number of pins.
> >
> > -D_in
> > this pin need to connect to hc165 and get the serial data from hc165.
> > you can use dts nin_gpios to create the number of pins.
>
> In the example it seems you enable d_out and d_in for *all* 64
> pins, correct? So they are all either input or output.
>
> That in effect turns them into GPIOs, so I don't see the problem
> with simply always doing this?
>
> Just that things are configurable doesn't mean we always need
> to provide means to configure them.
>
> If you have a use case where the user wants to control this, then
> that is another thing. Otherwise just make all pins input and output
> and wait for a usecase that needs more control, maybe it will
> never appear.
>
> Yours,
> Linus Walleij
