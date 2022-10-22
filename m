Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41372608CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJVLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJVLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:38:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163A1CD680;
        Sat, 22 Oct 2022 04:27:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x16so435263ilm.5;
        Sat, 22 Oct 2022 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HY5GO8di75U1CCASt41qiLyc6F6QvdKPrg08NoOHj/w=;
        b=UNFQHvpbqLns18T7KH5EwVBhZQGXV2kNOC3gM6qxcMbeiHBIf0NngUXUEdPXXg1H/o
         G1tZ6diuM3NyqXBkvNlA/14Afwu8CoEZTyOLe6s19s52fBs16eXMjwqo1QLUrqEic/7G
         VI7ciHJrusXudYvzVwEgMMJ5Qs0XaVlglYFC/kpN9MW6C9V9cYEXodlvHiDvkFpAwiif
         kNwqcDFUEbJCWyGRAUIHc+9fEkZapYNRiJs+t1g0BYKLRnkWcaL/JJswVy5kXmA5kiag
         J05uoj0zSAQOV+uVm1AsQXVDHYrdlk4CwWbibpqLwLa6bqzWqfl+WHFktRjkYhOAS2yL
         rwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY5GO8di75U1CCASt41qiLyc6F6QvdKPrg08NoOHj/w=;
        b=sZb97VnlU9TxDHykqHMDn/m41BXQaPh7WDPA2eceGO9mW0qbW3WJYcUzU+6xU6+kBy
         xyXj1N4v6aB+iPJwGXSDNgQdKL6BNRBbbdqdNfPcJIQmwRz5iOf6wwMlyufYupEYwdG8
         TDksxVol2cE0cbXWIxj+Bhc0XbSvU+rz1F4Wk+pbMV7sLGgtmLWIruLOqdebY9WqzqbE
         KggrYVJxIrNKk5Y4ssox7y8020EyFqTivYrAmcQYU7vqQb9ThTvF6DvLHSAYv0QCfSRA
         eKobniO4/nHuWn3N4a/vk0Cs0wTAgQx3T2DOeGjKMRuRt26jGgzlQoxjMmyN5BRU97Vl
         msNQ==
X-Gm-Message-State: ACrzQf0iMCm5LQSjqNgYdZvpAwqXNaAcJFnJuESBC4BlrwbMfu6lylfD
        HPNVIdtjl1D5i1P1dQO9EYlQUWIDvO2vNEcnCgc/kiXQ0ZE=
X-Google-Smtp-Source: AMsMyM6e9lch0ampIcrmMSSo6HI4nFbDoCNZk74CpXEmGNLqAOT70PmJZTsxlDOknphx0BLulVXPQB1tvGcDuVdHicA=
X-Received: by 2002:a92:da4a:0:b0:2f8:fa94:9dae with SMTP id
 p10-20020a92da4a000000b002f8fa949daemr16162088ilq.80.1666438043011; Sat, 22
 Oct 2022 04:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221022084737.1028-1-linux.amoon@gmail.com> <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
In-Reply-To: <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 22 Oct 2022 16:57:07 +0530
Message-ID: <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for your review comments..

On Sat, 22 Oct 2022 at 15:47, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sat, Oct 22, 2022 at 10:48 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Odroid N2/N2+ support active cooling via gpio-fan controller.
> > Add fan controls and tip point for cpu and ddr thermal sensor
> > on this boards. Drop bias-disable from set pwm_ao_d_10 the pin
> either use "on these boards" or "on this board"
>
> [...]
> > @@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
> >                                                 mux {
> >                                                         groups = "pwm_ao_d_10";
> >                                                         function = "pwm_ao_d";
> > -                                                       bias-disable;
> &pwm_ao_d_10_pins is not referenced anywhere so it seems that this
> change has no impact on controlling the fan on Odroid-N2(+).
> How did you test this change?
>
Ok I felt these changes affect the behavior of the pinctrl

  * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
 *  transition from say pull-up to pull-down implies that you disable
 *  pull-up in the process, this setting disables all biasing.

I mapped this is linked in pinctrl driver, pwm_ao_d_10_pins GPIOAO_10 see below

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/meson/pinctrl-meson-g12a.c?h=v6.1-rc1#n825

For testing, I tried to libgpio command to verify shown below, with
this patch applied.
$ gpioinfo
....
gpiochip1 - 15 lines:
        line   0:      unnamed       unused   input  active-high
        line   1:      unnamed       unused   input  active-high
        line   2:      unnamed     "enable"  output  active-high [used]
        line   3:      unnamed       unused   input  active-high
        line   4:      unnamed       unused  output  active-high
        line   5:      unnamed       unused   input  active-high
        line   6:      unnamed       unused   input  active-high
        line   7:      unnamed       unused   input  active-high
        line   8:      unnamed "regulator-tflash_vdd" output active-high [used]
        line   9:      unnamed      "TF_IO"  output  active-high [used]
        line  10:      unnamed   "gpio-fan"  output  active-high [used]
        line  11:      unnamed    "n2:blue"  output  active-high [used]
        line  12:      unnamed       unused   input  active-high
        line  13:      unnamed       unused   input  active-high
        line  14:      unnamed       unused   input  active-high

$ cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinmux-pins
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
pin 10 (GPIOAO_10): (MUX UNCLAIMED) aobus-banks:1958
pin 11 (GPIOAO_11): (MUX UNCLAIMED) aobus-banks:1959
pin 12 (GPIOE_0): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 13 (GPIOE_1): ff802000.pwm (GPIO UNCLAIMED) function pwm_ao_d
group pwm_ao_d_e
pin 14 (GPIOE_2): ffd1b000.pwm (GPIO UNCLAIMED) function pwm_a_e group pwm_a_e

$ sudo gpiomon  gpiochip1 10
gpiomon: error waiting for events: Device or resource busy

$ sudo gpioget  gpiochip1 10
gpioget: error reading GPIO values: Device or resource busy

If I am wrong I have previously sent it with a typo correction below.

[1] https://lore.kernel.org/all/20221021050906.1158-1-linux.amoon@gmail.com/

Thanks
-Anand
>
> Best regards,
> Martin
