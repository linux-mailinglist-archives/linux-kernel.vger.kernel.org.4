Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12C3608D05
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJVLxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJVLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:52:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AEE027;
        Sat, 22 Oct 2022 04:52:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so15079895edj.0;
        Sat, 22 Oct 2022 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jrvz3xnxmWMFBldQvzy2ZgmI4h77t/gPKZnFb0toqjg=;
        b=IkNUMBBK3F7G2PHSg4UUbh50Ru31YT5iLaRe+eXiX/kgyEVFRWM+EOsx8fOhmmHZYB
         mpbIbh4q3vvwnGYurdPN4A+6370j/lx2BQ8nIWwsFsKx7Y9z3Heey5CL1lY0jPs9BmQs
         phlDwix2DMjgdaGZx7K06usQjnaAJXxond0AzlVST6lU+BhY3YDU08cxFgsQ/dUXc2c7
         LdYPI7IFyVT/b62MgoKyx+X6xWA8M1MoAde1RLXhSz1IYm4Xjv5RErUgw3uEISZC4QYx
         hjKz433tB6OeY3mXTLp49KN3S9Tg+E2Z2NqOFJVPn3sVHkt0h8isq2wF9OnV5ADNL+8a
         l+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrvz3xnxmWMFBldQvzy2ZgmI4h77t/gPKZnFb0toqjg=;
        b=76DF1DKUd1O9c0pGluAJxetk/BCt+lYOAlNlJfzBPYbnY3Xus5rZszjxqZQq99BBiz
         LRnsRsRbgSxjT39YzI4uLP0zRqbOV2Gy8fCg6UJI5QsAf9CZf3Tp3lWMicD5xi5pjfi+
         PHyFrTUVNcho/BWTWnDC9m4nbtQJUiPxSS7lsjxmMaRvlqcihdDUkgdkwB44bhRGDcea
         cAv/kfJ+YHc2FogtEfCelzF7gvS3gYpIlc8LV/jxyp7J42FZXsPEmejYpaKNd+gwPknS
         R4CH3+ftsZ3Fu0dMdv5HP2HktFYyCelkpMXeC9c9799Rc6IGRyVzP3m2Dno1e2Uy3Ij1
         1NTQ==
X-Gm-Message-State: ACrzQf3FeTBvBHQHJNuThcwUGgecjmkb/5/nbpsb9hF+3VhfZcMsc8et
        BOMdeYQ1LhHbEUBVDCLhavgU37QOc7H+CGNh6lc=
X-Google-Smtp-Source: AMsMyM6muR/RwsipWgBLxIPXio2nN5ILA/phMy0wSCb+hRGOvh2zvm54UfTCsw2MojaPvDmu/D2VNn3FDSPF1kaXgew=
X-Received: by 2002:a17:907:7f92:b0:78d:ed9c:d86f with SMTP id
 qk18-20020a1709077f9200b0078ded9cd86fmr19695128ejc.251.1666439563373; Sat, 22
 Oct 2022 04:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221022084737.1028-1-linux.amoon@gmail.com> <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
 <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com>
In-Reply-To: <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Oct 2022 13:52:32 +0200
Message-ID: <CAFBinCCNJiL-ZKRYesQAwys6bBMpYHJbUDK-Zi_VhGDVSvF7uQ@mail.gmail.com>
Subject: Re: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan
 on Odroid N2/N2+
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Sat, Oct 22, 2022 at 1:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > @@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
> > >                                                 mux {
> > >                                                         groups = "pwm_ao_d_10";
> > >                                                         function = "pwm_ao_d";
> > > -                                                       bias-disable;
> > &pwm_ao_d_10_pins is not referenced anywhere so it seems that this
> > change has no impact on controlling the fan on Odroid-N2(+).
> > How did you test this change?
> >
> Ok I felt these changes affect the behavior of the pinctrl
>
>   * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
>  *  transition from say pull-up to pull-down implies that you disable
>  *  pull-up in the process, this setting disables all biasing.
>
> I mapped this is linked in pinctrl driver, pwm_ao_d_10_pins GPIOAO_10 see below
Yes, I understand this part.
My concern is: &pwm_ao_d_10_pins settings only become active when this
node is actively referenced. You can even see it in your output
below...

[...]
> pin 10 (GPIOAO_10): (MUX UNCLAIMED) aobus-banks:1958
This shows that it's used as a GPIO. If the &pwm_ao_d_10_pins setting
was used then it would show "function pwm_ao_d group pwm_ao_d_10"
(similar to what GPIOE_1 shows in your output)

If you want to know if a pull-up/down is enabled you can look at the output of:
$ cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinconf-pins
(I'm sure this can also be retrieved from some userspace tools, but I
don't know how)


Best regards,
Martin
