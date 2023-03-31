Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68036D18E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCaHqF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjCaHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:00 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA4A1A964;
        Fri, 31 Mar 2023 00:45:59 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-53d277c1834so400425117b3.10;
        Fri, 31 Mar 2023 00:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tPu3wpNf5OOm3sambBzAkZeluIlHnIKjl7VjT4mTMc=;
        b=5L6tqhmlAWcc3FC+GmnUfHpNd5O2ps7N0VKGXL0P8E6H83IekTUfswyzYsdCdP7euD
         SJYGpIMN90piCOYJA6APICpGO5C/Xtms05+Khtm4/fLTAzNGJvrATqEh3cR8XeO+MaZO
         63mQkGoTJINjiFJlXmHmOus7xL/jGMG0PgizEgAGey0WRnFz2S9TRFq8qFkluksAorcB
         X3f29RB3RhQelF2VwRpOazP+ZsLtzrlGdYpoC6g6N/WNgCqZ5cB94hWiOagKs1WI4MFJ
         VxnA7a4hZX4BgNQNUVTQtWic7lo5jrRu81BwK+O3wmryU6H9t4Y3wzjg9RJYyGM5+YFt
         Yvvw==
X-Gm-Message-State: AAQBX9cGaEK25hE2MJeuu2qyKFAOIdofzymzVOIdfRjo2XCj4fhu/vz6
        mi0Rqu+obg6+g3tVamvVfVsKf6ZDFUDB5Nbz
X-Google-Smtp-Source: AKy350YhjfRFAcULl1R+J0IjdANVOjnskecR/+j2GBPCwTzFN1tmzcTeTl5/L03/kiUvUH4H/K1UVA==
X-Received: by 2002:a0d:db49:0:b0:541:85ea:588b with SMTP id d70-20020a0ddb49000000b0054185ea588bmr26252328ywe.26.1680248758206;
        Fri, 31 Mar 2023 00:45:58 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05690c068d00b00545a0818483sm381655ywb.19.2023.03.31.00.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 00:45:57 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-545e907790fso284729697b3.3;
        Fri, 31 Mar 2023 00:45:57 -0700 (PDT)
X-Received: by 2002:a81:b3c6:0:b0:541:7f69:aa9b with SMTP id
 r189-20020a81b3c6000000b005417f69aa9bmr12427975ywh.4.1680248282389; Fri, 31
 Mar 2023 00:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWz=Vf1svs3TJrCSq8ED0rEy-NURQ++bUspo73zfct50A@mail.gmail.com>
In-Reply-To: <CAMuHMdWz=Vf1svs3TJrCSq8ED0rEy-NURQ++bUspo73zfct50A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Mar 2023 09:37:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqK7HYEyL3oTbvD-ebOfp7Nd6REpzOTB=26J7g5C1Pqg@mail.gmail.com>
Message-ID: <CAMuHMdXqK7HYEyL3oTbvD-ebOfp7Nd6REpzOTB=26J7g5C1Pqg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] soc: renesas: Kconfig: Select the required configs
 for RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 9:37 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Mar 30, 2023 at 10:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Explicitly select the required Cache management and Errata configs
> > required for the RZ/Five SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
