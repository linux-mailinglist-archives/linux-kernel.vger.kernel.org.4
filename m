Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB926289F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiKNT5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiKNT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:57:36 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B705F80;
        Mon, 14 Nov 2022 11:57:35 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id s4so7478964qtx.6;
        Mon, 14 Nov 2022 11:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WAy4fGH2qI75XjqU+rmRnjohu2C+vTax0LvWTeL3iw=;
        b=jsCXkGkpndBobqdJSAmZiEnKY8YCyCQaaIipicwXGDEO1WybM7znG4mlCaB8VKs/j0
         IzTmO6a+eZSnzVNAoqADAXBdms2ghO+WGxtEpWICLCp5xK6JD9oiSVSpgFXcWxohs7m+
         gHEAiqt80W5T4n90G20T9V6a4YfoqUg02fbQ1Hl8KhEfkIqXHgAkW8bEpTIrMonseyr3
         wr6WscZdc9EQ+LhYL3O0HwDe8Oz3ZIWlXA7ChK7F+YayLRd0SdbLmbPD+Tj/Fese2qBf
         vvTcFKuabNxaeKghnf2kpy8IvhWCCDN3C0CBSyei9a/FrhaGHQDb7ERH4kcxhz3+/1l2
         rJvw==
X-Gm-Message-State: ANoB5pkFzaTOYMhrcDM1ZDrlyhVTxYNGiBtnSjsbiqEPyXu9sl/JCwHq
        2XL+Ynjirll0O6NP8uhlKu9pZGN3dSk+jg==
X-Google-Smtp-Source: AA0mqf5fQDftUym9nASv3HtQHDak2ki+t2JTUXhMh7xwbEh1et7V/uxEZmBBC8o1HulTuj/4h+OkrA==
X-Received: by 2002:ac8:13ca:0:b0:3a5:9be8:59f2 with SMTP id i10-20020ac813ca000000b003a59be859f2mr13603156qtj.297.1668455854734;
        Mon, 14 Nov 2022 11:57:34 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a258d00b006bb82221013sm7070413qko.0.2022.11.14.11.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 11:57:34 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-369426664f9so117152357b3.12;
        Mon, 14 Nov 2022 11:57:33 -0800 (PST)
X-Received: by 2002:a0d:f6c6:0:b0:373:5c0c:9b37 with SMTP id
 g189-20020a0df6c6000000b003735c0c9b37mr14378960ywf.358.1668455853794; Mon, 14
 Nov 2022 11:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20221114194846.108814-1-detlev.casanova@collabora.com>
In-Reply-To: <20221114194846.108814-1-detlev.casanova@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 20:57:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9dAxJwzD=W1xLN2e_T_BNFk5MfbWh24Btur-o+-n4sg@mail.gmail.com>
Message-ID: <CAMuHMdW9dAxJwzD=W1xLN2e_T_BNFk5MfbWh24Btur-o+-n4sg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77951: Add reserved memory region
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/RENESAS ARCHITECTURE" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Detlev,

On Mon, Nov 14, 2022 at 8:48 PM Detlev Casanova
<detlev.casanova@collabora.com> wrote:
> The 0x3000000 bytes memory region starting at 0x54000000 is
> reserved for the lossy_decompression hardware that will try to
> decompress any data written in the region.
>
> Mark the region as no-map to prevent linux from using it as RAM.
>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> @@ -290,6 +290,18 @@ CPU_SLEEP_1: cpu-sleep-1 {
>                 };
>         };
>
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               /* device specific region for Lossy Decompression */
> +               lossy_decompress: memory-region@54000000 {
> +                       no-map;
> +                       reg = <0x00000000 0x54000000 0x0 0x03000000>;
> +               };
> +       };

This depends on the firmware/boot loader stack.  If it configures a
Lossy Decompression region, it should make sure to pass this
info through the various boot loader components to Linux,
just like is already done with the memory regions, RPC-IF state,
and OpTee configuration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
