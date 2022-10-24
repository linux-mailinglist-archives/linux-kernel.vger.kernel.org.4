Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2A60A8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiJXNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiJXNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:10:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24029A2229;
        Mon, 24 Oct 2022 05:23:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a18so5956704qko.0;
        Mon, 24 Oct 2022 05:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJJRBYG1+d5KpGh/2jmIV9Sl5iQP2xw0J4yEZ82n6eQ=;
        b=IkA+5sbIKfcxmG8tFlaHyvfi1M+6wZDyB+s+X+OQ9XeSShB5MqhEF/C8TGKRQNgJKF
         MJ2il1ejvUHA4lXys1QIIrmWJgexRFMZC6hqFoMsx/JTTt26VctGyHKAwbCJWSbjEXuv
         W1COSBzHvxDImlliG7RdAMuRxdl9UWAVcHoicHSwNPha1LLyxrel+PcDRFIppbipWHSK
         CLOEhBpJ6U1dmWHWHVxBaLD11dnrHAnlBRp9PwGp5NrDwdo8CMZdgSHTJdUlOzK7VJAP
         +Ct1ICRUNOpMysf4ODAqT7ty5PJ5CxPrbEWkcLwnkJye77QT9cd9ug60Advv9MAWbw2H
         LfgQ==
X-Gm-Message-State: ACrzQf3UwlqYRUvdZTUbaF4oR0AkO4IjYacdqOZ1TmSZuVRQM6vg2MJc
        No01QU5Ht/OHVUVoenb1WuYfy16iwkZljw==
X-Google-Smtp-Source: AMsMyM5pOaKQzlHRlHc92M8yTTzkNeBekva8dPbqBgmvo8zkbWeRR0adeazdwAqzf7FAvjYYaz7TkQ==
X-Received: by 2002:a05:620a:12fb:b0:6ee:79f2:3716 with SMTP id f27-20020a05620a12fb00b006ee79f23716mr22442202qkl.348.1666614028294;
        Mon, 24 Oct 2022 05:20:28 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id hf8-20020a05622a608800b0039cbbcc7da8sm12481924qtb.7.2022.10.24.05.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:20:27 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-35befab86a4so83762417b3.8;
        Mon, 24 Oct 2022 05:20:27 -0700 (PDT)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr28558715ywa.384.1666614027033;
 Mon, 24 Oct 2022 05:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com> <20221023182437.15263-6-afd@ti.com>
In-Reply-To: <20221023182437.15263-6-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 14:20:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTdxQeRXjdDYGEW7EW4j+H64rgSeo58OMmgfOYZjEiaw@mail.gmail.com>
Message-ID: <CAMuHMdUTdxQeRXjdDYGEW7EW4j+H64rgSeo58OMmgfOYZjEiaw@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: Rename DTB overlay source files
 from .dts to .dtso
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your patch!

On Sun, Oct 23, 2022 at 8:24 PM Andrew Davis <afd@ti.com> wrote:
> DTB Overlays (.dtbo) can now be built from source files with the
> extension (.dtso). This makes it clear the content of the file

... clear what is .. files?

> and differentiates them from base DTB source files.
>
> Convert the DTB overlay source files in the arm64/renesas directory.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
