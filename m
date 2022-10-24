Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316F60A8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiJXNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiJXNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:10:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E52A960;
        Mon, 24 Oct 2022 05:24:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j21so5900356qkk.9;
        Mon, 24 Oct 2022 05:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/srQP/bu4WanQeXYrc4ISsILh6SSKMs2u8D7WMV0Rfg=;
        b=0wD1tu12O2w0SufriqBXYgXOMFvZiXe+rHu39rfY0LVqesSGOYwXSMP1r780DNyA/j
         3bo1TgIo6v4dP8QOda38qh6q103WRsN6Dx0vXNjVaLNPVNGWcnId/Ic+KPIKBqC7f6s4
         dohCGZMGW75ruZ3uQ29mL14E9oHjtOBZSwbi+xQLdE74HdvL3IILlZjYnEbl87NIfpf6
         GviCuqrMVSAEYAI2DAlxEH/nxmblR3n4i8QMp8GQFD4Cp5Yc7OpDYL9ibjlrHJXmInnN
         SMGpEpvJnFrEuMo4SCVUWauOlIx2mlh2h8JgSpn+3Ob7pbEx0559BMDFT+7NTzmkMH4M
         H4dw==
X-Gm-Message-State: ACrzQf1B+4BZFH0LgomlNUUD8tQUVxDuZY5B+LwgDdXYGmCIPByx4FTU
        fco3lBGFkgJ46IrPLKkFxyL4okMKpZZ2qQ==
X-Google-Smtp-Source: AMsMyM7/ai9ZUXdyyUlhgsTjjEwbS2TRZblYwpB9qJutXp8DZoXPUBDZC/e840UKMY5DlmiD6mS8bw==
X-Received: by 2002:a05:620a:1725:b0:6ee:e8bc:9594 with SMTP id az37-20020a05620a172500b006eee8bc9594mr23381961qkb.184.1666614059352;
        Mon, 24 Oct 2022 05:20:59 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006cec8001bf4sm15201684qko.26.2022.10.24.05.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:20:58 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id e62so10804702yba.6;
        Mon, 24 Oct 2022 05:20:57 -0700 (PDT)
X-Received: by 2002:a25:26c1:0:b0:6c3:bdae:c6d6 with SMTP id
 m184-20020a2526c1000000b006c3bdaec6d6mr30138696ybm.36.1666614057747; Mon, 24
 Oct 2022 05:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com> <20221023182437.15263-7-afd@ti.com>
In-Reply-To: <20221023182437.15263-7-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 14:20:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6UQ0VGHP1Ta7Q8EK0KiOBqKj9P-g--J63CDs7o1ZGdA@mail.gmail.com>
Message-ID: <CAMuHMdW6UQ0VGHP1Ta7Q8EK0KiOBqKj9P-g--J63CDs7o1ZGdA@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: Rename DTB overlay source files
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

On Sun, Oct 23, 2022 at 8:25 PM Andrew Davis <afd@ti.com> wrote:
>
> DTB Overlays (.dtbo) can now be built from source files with the
> extension (.dtso). This makes it clear the content of the file

... clear what is .. files?

> and differentiates them from base DTB source files.
>
> Convert the DTB overlay source files in the arm64/xilinx directory.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
