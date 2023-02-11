Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A994693373
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBKUET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:04:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BF18B0E;
        Sat, 11 Feb 2023 12:04:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hx15so23277861ejc.11;
        Sat, 11 Feb 2023 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjjXpGu22f36zsopOwOahgOOSD3GNRdJelEClXp6KLk=;
        b=Wr/lthu3WnMgjFa7C+MuY/PMvXJmIl8jlIQRh3di2Xtzo+LSDs3VOzcUyvNiPi0Rhk
         EQWlR6ZMvZ0Cx7F00jj1sZNWmGfS8TPHGdiSKx1U9swrW7UNpUfhesfSt84OElTM+/+e
         +uwd6WPKOeEqiwBhV4TZE7YhXU64LjNCMQy8ML1ElVrdRlshXmxDTr25DHZBauS82Dr/
         vGuXh8w20KXnw36RfoDpR4hZ6HMc45nfF8N68frpumroLKtX+oYw82SWYNLB4KzqG6zx
         smROF9p7EeTORa9aCY86RFaeruoURD8rb+1XB5eUOtGmNK4p9/1C6XUQeDTYmfhQD8XY
         l4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjjXpGu22f36zsopOwOahgOOSD3GNRdJelEClXp6KLk=;
        b=jqTdJ9FgiSrsXipaLxgZolf1psyNAnhXSI68hx/RndlDtNIco9pku3EnZ5Df6jaSB6
         7+VrCO8L0gxQ9IKJ3wohve3HHytYiTKDPM5KmbRB7667V0UreC1MCOM9wBSUUNBp4Vvc
         wv5QrENcTp9j2u5BFYxXtnXSdFILiFcPg+PfIVrnp5eeA13UKt1I6g+2BGUbugtrih3u
         L8ZgnH8xsCX6AyHrZHYgb4oBQ6cFQwLCH6+T6Bzo8Rt6QXxfjhQ5iWaQUgHNAjCbY1hr
         vtHSaqtQBm6++cc6GKyV63WvvtadYCeKGNWzu4cJEKdT4v1uJSBhJd8iZo5QOPgEPbAr
         Y7rg==
X-Gm-Message-State: AO0yUKX38SZTOyLKA7J151MJVKB5fLl2yD9P9cUMGT1YcOger9pPMoAC
        DjYOB67gSMsqYs90hawyOOXNrl/V1PdhcDbR/eE=
X-Google-Smtp-Source: AK7set9gfXJ0lTgAC1WCpg7g6zQJ4VvoZQDgnULywOlp0nN6xiARxZfB98oEHqpDAMroivI76f6QHrHYDJD9MsOuSNU=
X-Received: by 2002:a17:906:f9cb:b0:879:e721:9d33 with SMTP id
 lj11-20020a170906f9cb00b00879e7219d33mr2729879ejb.4.1676145855971; Sat, 11
 Feb 2023 12:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-5-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-5-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:04:05 +0100
Message-ID: <CAFBinCC1O52eraLJ=GoZVM0fM0zVyqdDrkP3RCjNQ=KaqhByLQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: amlogic: meson-g12b-odroid-go-ultra:
 rename keypad-gpio pinctrl node
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
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

On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Fixes the following bindings check error:
> pinctrl@40: keypad-gpio: {...} is not of type 'array'
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
>  &periphs_pinctrl {
> -       keypad_gpio_pins: keypad-gpio {
> +       keypad_gpio_pins: keypad-gpio-state {
>                 mux {
>                         groups = "GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3",
>                                  "GPIOX_4", "GPIOX_5", "GPIOX_6", "GPIOX_7",
I'm wondering whether we make the keys work without having to specify
a pinmux configuration for them separately.
Our pinctrl driver already sets:
   pc->chip.set_config = gpiochip_generic_config;
So you should be able to use the GPIO_PULL_UP flag for these GPIOs in
device-tree instead of specifying bias-pull-up here, for example:
   gpios = <&gpio GPIOX_0 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;

output-disable is managed by the direction of the GPIO anyways.
pinmux_ops.gpio_request_enable is also implemented by our pinctrl driver.

This is not urgent - I am just curious as always :-)


Best regards,
Martin
