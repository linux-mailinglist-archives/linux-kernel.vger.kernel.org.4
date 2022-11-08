Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C66211A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiKHM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiKHM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:59:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E31144B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:59:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m22so1153763eji.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMYYNsg0Fd1lbIlymnFj9xbwbr0Q9XGXqF2lkb6r5vo=;
        b=D0MB9l3SuLohSIy6XuTeWJN/UkCRPC4j9T5V2d4qNTDcoHVetCsF/ahRpMl6HP8cfs
         neczcXs959bMdeWHVbsy4CijF3RYG7XlF0/dz4v2Z3G4gqplfVuCffm3LmzWEES13yLg
         Sp/KEn2VS7yGrYdqtzzRm0CoKQsnY4tvbIlpDDgzDSvTlVdCxjAZZSPkrxid8XmcCNZP
         TGXqsboBRvpw9flB3iG5JkY1uJXsblNWe70qFR0oBb/b+V4vzSCgxXwvVY4hFhPJcsju
         PHo5MwbmloqxjAWIDDsJ7FDJJ+2qW5OhbgiffbByZwrBVMMOdblQGJJV6ibGCOf9UlLE
         G9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMYYNsg0Fd1lbIlymnFj9xbwbr0Q9XGXqF2lkb6r5vo=;
        b=D8z+WWCxtYG0Dvq04x7kE3wkgHjRcgCKNxtoHBXWem2PSWODOMgF7A9ezh6kCWUy0I
         dTtWR/ZeLjmsF3tubfFsp7oGYotoVYOozZvipCY6ZwoFNsA2fPi4HT6Kurfx87o2gdTx
         7d8NqwMqmoRFY4aCe+CSknpABpTVXHSqWtfVLeLpDqNX/DSUrpKNkB10Zp+TOn3eo3uC
         b4my6VQaFEAgszpSkJpW+29lrshfH0cwngRhABzV/mMwvReBu5BVK5/vEKzFMTqeeEbQ
         DDkJNp6T26fCR6Ck4UHT+G26tGXO5BhH3yXE8i73roOFRaDJmBiBJhGEdx1qzpjJS6Ne
         UmgA==
X-Gm-Message-State: ANoB5pnmMrxkki2wh5TR12Z3XN9GA0aRv9Da6NA6zdlxfKSO0UIoeZks
        1/qMqHv3Br0VqMvd2n8xTV74p3nerzCrv10hLZdikA==
X-Google-Smtp-Source: AA0mqf6ANmUnYiYdo2x4UFuu2t3zI2/P/e7ukIEC+BUNZec2Z8td6z1gbnX7j+6fQ7HJlb2YQ6VecwBo00lb4mFY7E8=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr11060672ejs.190.1667912359878; Tue, 08
 Nov 2022 04:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20221108092840.14945-1-JJLIU0@nuvoton.com> <20221108092840.14945-4-JJLIU0@nuvoton.com>
In-Reply-To: <20221108092840.14945-4-JJLIU0@nuvoton.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:59:08 +0100
Message-ID: <CACRpkdYjVsHn1LuniEA2mB9Y5+hL3dP2kzVOLWYOcmAQk95sCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

thanks for your patch!

On Tue, Nov 8, 2022 at 10:29 AM Jim Liu <jim.t90615@gmail.com> wrote:
>
> NPCM750 include two SGPIO modules.
> Each module supports up to 64 input and 64 output pins.
> the output pin must be serial to parallel device(such as the hc595)
> the input in must be parallel to serial device(such as the hc165)
>
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v2:
>    - modify description
(...)

This:

> +  GPIO pins can be programmed to support the following options
> +  - Support interrupt option for each input port and various interrupt
> +    sensitivity option (level-high, level-low, edge-high, edge-low)
> +  - Directly connected to APB bus and its shift clock is from APB bus clock
> +    divided by a programmable value.
> +  - nin_gpios is number of input GPIO lines
> +  - nout_gpios is number of output GPIO lines
> +  - ngpios is number of nin_gpios GPIO lines and nout_gpios GPIO lines.

Why does input/output have to be configured uniquely/static per system?

What is wrong with just using direction_input() and direction_output()
at runtime like everybody else?

> +        nin_gpios = <64>;
> +        nout_gpios = <64>;

Especially since in the example you just set them all to be both input
and output so they all depend on runtime direction configuration
anyway.

Yours,
Linus Walleij
