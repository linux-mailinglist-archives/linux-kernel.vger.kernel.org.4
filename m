Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83F26A2FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBZNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZNZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:25:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5F2D48;
        Sun, 26 Feb 2023 05:25:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E7AB80BA9;
        Sun, 26 Feb 2023 13:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D2DC433D2;
        Sun, 26 Feb 2023 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677417898;
        bh=s9joBrvXb6RfpPN3dmpyMQUL2fvd22NrzMWuyPkh4Ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aMK0XrXyp5vh7rBjir4vJW67/iBP0b1VUWRjrMPeecsOwebh+PQW/UBGACkrMlvj/
         2tqh9clNO7phzoRgAklmPk//udyjgrh88T0v6raqnN7jaRFC4NwUCbAp3SHGYHHlCP
         Btu4SkurDC+pI0XQiGa28pizMBiYHdqCTRZ6PtKAst+Thbw7y/6KKdO3CSylhvWQTV
         ZL6mkbkw6wQmXAlAiiShszFKOV/h1FoaiN4Rr0FF5TbICqYqwy9Pyuy7bDtoTHqydw
         NvNiB4b/5pAxdb4Hw3A7ZyLxBIBPbviE0DQE9hCZiZXPZV46q8Z7hmAzUXTJI2rrsO
         G4XmHckuSfPsw==
Date:   Sun, 26 Feb 2023 13:39:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <20230226133922.13ac17b1@jic23-huawei>
In-Reply-To: <33abc8a3-39f7-af7c-9676-723228624b0f@linaro.org>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
        <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
        <e6b2a6f4-d710-7f74-e85d-1cd3f5b96460@linaro.org>
        <101db5e2-e878-b751-9679-6ea45eb24c26@fi.rohmeurope.com>
        <33abc8a3-39f7-af7c-9676-723228624b0f@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 10:26:02 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 23/02/2023 07:20, Vaittinen, Matti wrote:
> > Hi dee Ho Krzysztof,
> > 
> > Thanks for the review! It's nice you had the time to take a look on RFC :)
> > 
> > On 2/22/23 20:57, Krzysztof Kozlowski wrote:  
> >> On 22/02/2023 17:14, Matti Vaittinen wrote:  
> >>> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
> >>> capable of detecting a very wide range of illuminance. Typical application
> >>> is adjusting LCD and backlight power of TVs and mobile phones.
> >>>
> >>> Add initial dt-bindings.  
> >>
> >> Driver can be "initial", but bindings better to be closer to complete,
> >> even if not used by the driver currently.  
> > 
> > Out of the curiosity - why is that? (Please, don't take me wrong, I am 
> > not trying to argue against this - just learn the reason behind). I 
> > can't immediately see the harm caused by adding new properties later 
> > when we learn more of hardware. (and no, I don't expect this simple IC 
> > to gain at least many properties).  
> 
> Linux drivers change, but the hardware does not, thus DTS, which
> describes the hardware, can be complete. It should be written based on
> the hardware, not based on Linux drivers. If you add incomplete
> bindings, this suggests you wrote them to match your driver, not to
> match hardware. This in turn (adjusting bindings to driver) makes them
> less portable, narrowed to one specific driver implementation and more
> ABI-break-prone later.
> 
> Imagine you that clock inputs, which you skipped in the binding, were
> actually needed but on your board they were enabled by bootloader. The
> binding is then used on other systems or by out of tree users. On your
> new system the clocks are not enabled by bootloader anymore, thus you
> add them to the binding. They are actually required for device to work,
> so you make them required. But all these other users cannot be fixed...
> 
> What's more, incomplete binding/DTS is then used together with other
> pieces - DTS and driver, e.g. via some graphs or other
> phandles/supplies/pinctrl. So some other DTS or driver code might rely
> on your particular binding. Imagine you had only vdd-supply regulator,
> but no reset pins, so the only way to power-cycle device was to turn
> off/on regulator supply. Then you figure out that you have reset pins
> and it would be useful to add and use it. But already drivers are
> written to power cycle via regulator... or even someone wrote new driver
> regulator-pwrseq to power cycle your device due to missing reset GPIOs...

To add one wrinkle here, board designers have an annoying habit of not
wiring reset pins up so if there is any easy way to support an alternative
(often there is a software reset command over a bus) then keep the reset
pins as optional and implement that in the driver from day one.
Same is true of interrupts, though that can be harder to deal with so
the binding may say they are optional but the driver fail to load without
them.

Nice reply Krzyzstof, I'll try and remember to point people at this one
as the question comes up pretty often.

Thanks,

Jonathan

> 
> 
> Best regards,
> Krzysztof
> 

