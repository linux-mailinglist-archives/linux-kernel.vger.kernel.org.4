Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE661755D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKCEIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKCEIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:08:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A013D2F;
        Wed,  2 Nov 2022 21:07:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so2149910ejc.4;
        Wed, 02 Nov 2022 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UIsWfbCkFTerxLO9Jkep5pwZTiDKcyfBXjgU1iksCT0=;
        b=ElwEESMhEGa2sw4P2gh53qMCeCRPfmgPXbU9M69JbGY880u+E3ik20+IB/sUqw/sYK
         W5IkrCG02DljO77dN4iUv5ziQ4IT22z3CRKxvb3+1KKrwA1Gsd3hL5XkCY4HIcCWPD32
         dN7u350I5+xpoZmJOfrMMhI53eMTetNwJwYajTdKIpw1UGMlIttnDYwg8szgZ2lJtQwf
         nXQ8tKq1mFjCo88jSZoBG2ZoeJ8HS8hkTYQwOydtAStSTGdOTrUrzgYppp8NPtcZUXHc
         uWSOi5PRc38/gmILf1Vdhz8tgmv8+ivSQU7bLoTwBKkHO6CDH4G9JZ0Bo6UM2AyW57zh
         3www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIsWfbCkFTerxLO9Jkep5pwZTiDKcyfBXjgU1iksCT0=;
        b=h3Qp1bvxK0btjzRo4qSVCwCKs7Q4rXjUJveK/U+RiRpY5KjfRDDb0aKAMmmvYMe4xw
         Ci86QSlxeVqMJryDUkUgTqfkQ/xfClgehrNo9IwrTirCJanXstpWhV8iQRaF8/YVT4nE
         +sDbWFnWHFzXDJbmjo5aFOz3dzpF6MZovRNlI0gsFa6r4RRtbWKj2I1YSUSnuNp6y6KI
         mtwvxGHJpL9nlqT8nuzUaiLEZCarFq1WQ5lJJlAXs6CO+SCnJ3BjZfurwGepuNqjs45E
         SOBU3+Y0x+qElzzO7EHsqb5xcck80RREapmLmcWVdAkHGOmlKLqYXl9OVVOb3JGlB+Ai
         KkNg==
X-Gm-Message-State: ACrzQf1L/8KwaxyVZkYqEGDoY1E00BiAIp80mfU1EyAYdz2LEJL5cK6W
        etpc8tH9vShB/hu6v5kQxX9P0a8Q7hjJpT9WJwA=
X-Google-Smtp-Source: AMsMyM7EowHw/EYtUWBQy6Ou2EamJtzjAwCj+H/BxB5HHl8BGO95RvQ24cnciHOsrjoktw7pTSU2r97iFOyBXW8cDFk=
X-Received: by 2002:a17:907:c08:b0:7ad:f758:2899 with SMTP id
 ga8-20020a1709070c0800b007adf7582899mr9247589ejc.671.1667448478023; Wed, 02
 Nov 2022 21:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221101215804.16262-1-afd@ti.com> <20221101215804.16262-8-afd@ti.com>
In-Reply-To: <20221101215804.16262-8-afd@ti.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 2 Nov 2022 21:07:45 -0700
Message-ID: <CAKdAkRTQ2bjQEn1HM=ZMHdC8Goyf1rUDNfMkNK3jMA2CR-t4eg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
To:     Andrew Davis <afd@ti.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi Andrew,

On Tue, Nov 1, 2022 at 2:59 PM Andrew Davis <afd@ti.com> wrote:
>
> This looks better and allows us to see the row and column numbers
> more easily. Switch to this macro here.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/nspire-clp.dts | 90 ++++++++++++++++++++++++--------
>  arch/arm/boot/dts/nspire-cx.dts  | 90 ++++++++++++++++++++++++--------
>  arch/arm/boot/dts/nspire-tp.dts  | 90 ++++++++++++++++++++++++--------
>  3 files changed, 204 insertions(+), 66 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nspire-clp.dts b/arch/arm/boot/dts/nspire-clp.dts
> index f52f38c615886..916ede0c2499c 100644
> --- a/arch/arm/boot/dts/nspire-clp.dts
> +++ b/arch/arm/boot/dts/nspire-clp.dts
> @@ -6,32 +6,78 @@
>   */
>  /dts-v1/;
>
> +#include <dt-bindings/input/input.h>
> +
>  /include/ "nspire-classic.dtsi"
>
>  &keypad {
>         linux,keymap = <
> -       0x0000001c      0x0001001c      0x00020039
> -       0x0004002c      0x00050034      0x00060015
> -       0x0007000b      0x0008002d      0x01000033
> -       0x0101004e      0x01020011      0x01030004
> -       0x0104002f      0x01050003      0x01060016
> -       0x01070002      0x01080014      0x02000062
> -       0x0201000c      0x0202001f      0x02030007
> -       0x02040013      0x02050006      0x02060010
> -       0x02070005      0x02080019      0x03000027
> -       0x03010037      0x03020018      0x0303000a
> -       0x03040031      0x03050009      0x03060032
> -       0x03070008      0x03080026      0x04000028
> -       0x04010035      0x04020025      0x04040024
> -       0x04060017      0x04080023      0x05000028
> -       0x05020022      0x0503001b      0x05040021
> -       0x0505001a      0x05060012      0x0507006f
> -       0x05080020      0x0509002a      0x0601001c
> -       0x0602002e      0x06030068      0x06040030
> -       0x0605006d      0x0606001e      0x06070001
> -       0x0608002b      0x0609000f      0x07000067
> -       0x0702006a      0x0704006c      0x07060069
> -       0x0707000e      0x0708001d      0x070a000d
> +               MATRIX_KEY(0,  0, 0x1c)
> +               MATRIX_KEY(0,  1, 0x1c)
> +               MATRIX_KEY(0,  2, 0x39)

Can this also be switched over to using KEY_* macros to describe the
keycodes emitted?

Thanks.

-- 
Dmitry
