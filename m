Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8360D2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiJYSGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:06:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCACEE3B;
        Tue, 25 Oct 2022 11:06:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 13so14763597ejn.3;
        Tue, 25 Oct 2022 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vE3MZf2Ly6I21HYX2Enssb0FvxhWUpQUt/rjYLZA2c=;
        b=AIoycIk6UAxZOhKS4FkwFGdRh7jyHE0kEWC2WMRQaL1p/6dGWAxFrMa9ffs5MRa/bH
         7GAaU3+9jvLiHfNpkmPfiLX/idkC/AlesrGXrnqIKxyGIpXKUkf/mAZyQnw21GYaGym+
         I/OrK7p7hf7RnzTmqSZkBqpy0onqhqd3qrFVINLUSMIOlfunsb2fenm9FTi4aVTgJ+PL
         /a2uMVEl+/Y1r6wMwmQnDOe51BKKG3pu68z2F9BgiXi6GfCVZvI8AD4fG9D3bbVswqLx
         vcwqKxqmgfJwRHwaekhxJAbgsxni9RDM5CHOKwwXoHq6NerLI35xDNb8s5nTUN36kn6M
         sisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vE3MZf2Ly6I21HYX2Enssb0FvxhWUpQUt/rjYLZA2c=;
        b=tiGC9+MktLUML4j6Fs4PMjYM5lRHfFRVBGs9hg8Kpp7hVEMAW9QBuDfUjsgbFYrR4v
         XGpXrrZf2xcQmNywx7yLEqFQ5O8171CAfVP8HIb5nmIaIk2X7kH6QqJKh7t0bYVdic/L
         smqCPZelN5NJBQ/lShV+5WO1IhaOFg8wOOFytpAXvcST6yYISsvA0Cd3lSuyJckjZNlV
         /7p8uaYZ0+iXfWwM4Btc7hrObhjabgmrRrxAlI79WrFTNIGD9R34HLbHnx3Mut7+S/EW
         YBle1DuzFiHLJ7sQFWp9EV7GtxPulg2kVFGXDXXoPB/fNm98Weht+EP8JxZhal+GlxmO
         fGng==
X-Gm-Message-State: ACrzQf1pOBEQ2QPVuN+c+wNMo9+8ur7sKOiWOWmOdhc0SC3TSgpA3v2U
        0H7Nsa4Y1gyJH7xvT8tPf4umCGHMTEuBqZ6lblQ=
X-Google-Smtp-Source: AMsMyM6POggN5PNl2ALYtzdpl/lqeMzGcPPZij8P5gVQpfSkcBzGMMo2TQ+tMAjHM4dwayRQGSBct5iqZcMbuNshgoc=
X-Received: by 2002:a17:906:8a6c:b0:7a8:2f09:d88d with SMTP id
 hy12-20020a1709068a6c00b007a82f09d88dmr10214197ejc.49.1666721185888; Tue, 25
 Oct 2022 11:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221022084737.1028-1-linux.amoon@gmail.com> <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
 <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com> <CAFBinCCNJiL-ZKRYesQAwys6bBMpYHJbUDK-Zi_VhGDVSvF7uQ@mail.gmail.com>
In-Reply-To: <CAFBinCCNJiL-ZKRYesQAwys6bBMpYHJbUDK-Zi_VhGDVSvF7uQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 25 Oct 2022 23:36:09 +0530
Message-ID: <CANAwSgTLTCA9=WvWXcR-40baauN3kAk2qx9k4FQOPCa1+_O0Yw@mail.gmail.com>
Subject: Re: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan
 on Odroid N2/N2+
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sat, 22 Oct 2022 at 17:22, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sat, Oct 22, 2022 at 1:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > @@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
> > > >                                                 mux {
> > > >                                                         groups = "pwm_ao_d_10";
> > > >                                                         function = "pwm_ao_d";
> > > > -                                                       bias-disable;
> > > &pwm_ao_d_10_pins is not referenced anywhere so it seems that this
> > > change has no impact on controlling the fan on Odroid-N2(+).
> > > How did you test this change?
> > >
> > Ok I felt these changes affect the behavior of the pinctrl
> >
> >   * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
> >  *  transition from say pull-up to pull-down implies that you disable
> >  *  pull-up in the process, this setting disables all biasing.
> >
> > I mapped this is linked in pinctrl driver, pwm_ao_d_10_pins GPIOAO_10 see below
> Yes, I understand this part.
> My concern is: &pwm_ao_d_10_pins settings only become active when this
> node is actively referenced. You can even see it in your output
> below...
>
> [...]
> > pin 10 (GPIOAO_10): (MUX UNCLAIMED) aobus-banks:1958
> This shows that it's used as a GPIO. If the &pwm_ao_d_10_pins setting
> was used then it would show "function pwm_ao_d group pwm_ao_d_10"
> (similar to what GPIOE_1 shows in your output)
>
> If you want to know if a pull-up/down is enabled you can look at the output of:
> $ cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinconf-pins
> (I'm sure this can also be retrieved from some userspace tools, but I
> don't know how)
>

I now switch using pwm-fan with the local changes I am able to link
pwm_ao_d_10_pins
but now the issue is fan keeps on spinning on boot-up and stays on.

I can manually turn on off by using
$ sudo gpioset gpiochip1 10=1   // fan on
$ sudo gpioset gpiochip1 10=0   // fan off

It is not controlled by the thermal tip as expected.
I feel some configuration is missing in pwm-meson driver.
Any input for me?

$ sudo cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinmux-pins
[sudo] password for alarm:
Pinmux settings per pin
Format: pin (name): mux_owner gpio_owner hog?
pin 0 (GPIOAO_0): ff803000.serial (GPIO UNCLAIMED) function uart_ao_a
group uart_ao_a_tx
pin 1 (GPIOAO_1): ff803000.serial (GPIO UNCLAIMED) function uart_ao_a
group uart_ao_a_rx
pin 2 (GPIOAO_2): (MUX UNCLAIMED) aobus-banks:1950
pin 3 (GPIOAO_3): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 4 (GPIOAO_4): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 5 (GPIOAO_5): ff808000.ir (GPIO UNCLAIMED) function
remote_ao_input group remote_ao_input
pin 6 (GPIOAO_6): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 7 (GPIOAO_7): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 8 (GPIOAO_8): (MUX UNCLAIMED) aobus-banks:1956
pin 9 (GPIOAO_9): (MUX UNCLAIMED) aobus-banks:1957
pin 10 (GPIOAO_10): ff807000.pwm (GPIO UNCLAIMED) function pwm_ao_d
group pwm_ao_d_10
pin 11 (GPIOAO_11): (MUX UNCLAIMED) aobus-banks:1959
pin 12 (GPIOE_0): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 13 (GPIOE_1): ff802000.pwm (GPIO UNCLAIMED) function pwm_ao_d
group pwm_ao_d_e
pin 14 (GPIOE_2): ffd1b000.pwm (GPIO UNCLAIMED) function pwm_a_e group pwm_a_e

$ sudo cat /sys/kernel/debug/pwm
platform/ffd1b000.pwm, 2 PWM devices
 pwm-0   (regulator-vddcpu-a  ): requested enabled period: 1250 ns
duty: 838 ns polarity: normal
 pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

platform/ff807000.pwm, 2 PWM devices
 pwm-0   (pwm-fan             ): requested period: 1250 ns duty: 0 ns
polarity: normal
 pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

platform/ff802000.pwm, 2 PWM devices
 pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
 pwm-1   (regulator-vddcpu-b  ): requested enabled period: 1250 ns
duty: 1213 ns polarity: normal

I could observe a change in duty when we have stress testing the CPU.

Thanks

-Anand
