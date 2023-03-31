Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C06D1FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCaMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCaMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:12:17 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1161C1E7;
        Fri, 31 Mar 2023 05:12:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r19so148473ilj.6;
        Fri, 31 Mar 2023 05:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680264735; x=1682856735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOa0WDEClE+kNIsNikxxp7PL+bWJ4DGdBDO+mmYy+aM=;
        b=F1QoNAEfg2cAj7U4wmA8PsIz83ZH1hMOPIj90UszYnqjjAXygAdESm02pWCWaLiN03
         +N26IGPZ6VAcXGOGtkaT3lmgpEPrZ7XYH1kH+HUdZG0zONOdhYJd40NsnSiaRvY+wCwQ
         SF2oSruQD3hw3pY5L2mFY94IuVdZmjRwXqF0fxVoGsTCIA+udLKqJlEuhhVxI/C+CS6j
         bKjm1Os3GsIJuKn+jlib5867fTgj3pMjjPFuCeDpy8SqeuSSgXCX6Kx1gInm/A6cxy2h
         MUkql7GaUJltCFPrGYzIY5a7/kVOl9NmjiG8G8UKkEt1BOS/RSl+EdUjg8kewmnrJPA6
         cLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680264735; x=1682856735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOa0WDEClE+kNIsNikxxp7PL+bWJ4DGdBDO+mmYy+aM=;
        b=NBffPp24eivuD3StwkkIyB1d0MnER3G8zyg41nLHc+2tzg9L/QAxo7GlAIiAWarpmp
         qrRFn+qilANE3HtniZvRf9F7TqeTkLrySWhXjQJiUXJTrnj1lcKEy0bNV4bR5RTz7EP2
         FGWHFq+Cvu1IRZF4i5wq0YKOOWuMYq2hgJvwtiRJNxVSjTxoCZzxwmZPMtdeVEVbADjm
         /dwgw5iMbNc+gXzOeyZqnAaOK25rvi+ZVyGMTkBHqZOw2ZjSX3JYknwswQjLeORcP9K+
         cznB4BYozXFq8ysHyKsCXR8eg0GP7BOhNaNPAs8EDtt0itqYnxwAfiCVJSipEn2DVxXS
         OsWA==
X-Gm-Message-State: AAQBX9ejT+jB867CU+eOlPwgFbuoW42Ymf5vOGpOI6RsLRua3aY5iFqZ
        c5uaP5WKod3+rI/oAMc6wrA64XBThMBWtpehpF4=
X-Google-Smtp-Source: AKy350a6CpiHAw/8PBeQohWWJaeNroiWBab+H6eZzow8rf2zzcfKecGDt6RIbJ/ASWV/e1FauShuiLz6VaQ/PBseZ88=
X-Received: by 2002:a05:6e02:1047:b0:325:dd36:7451 with SMTP id
 p7-20020a056e02104700b00325dd367451mr12904804ilj.1.1680264735446; Fri, 31 Mar
 2023 05:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com> <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
 <1c441d20-951d-407b-90ba-4cda3b0505b2@app.fastmail.com>
In-Reply-To: <1c441d20-951d-407b-90ba-4cda3b0505b2@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 31 Mar 2023 13:11:49 +0100
Message-ID: <CA+V-a8t_kozAobT028-RN39uoXcd7-0oJAhAR24MEzmoLVKX8Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:45=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, Mar 31, 2023, at 12:37, Lad, Prabhakar wrote:
> > On Thu, Mar 30, 2023 at 10:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
> >
> >> It also seems wrong to have the fallback be to do nothing
> >> when the pointer is NULL, since that cannot actually work
> >> when a device is not cache coherent.
> >>
> > If the device is non cache coherent and if it doesn't support ZICBOM
> > ISA extension the device won't work anyway. So non-cache coherent
> > devices until they have their CMO config enabled won't work anyway. So
> > I didn't see any benefit in enabling ZICBOM by default. Please let me
> > know if I am misunderstanding.
>
> Two things:
>
> - Having a broken machine crash with in invalid instruction
>   exception is better than having it run into silent data
>   corruption.
>
> - a correctly predicted branch is typically faster than an
>   indirect function call, so the fallback to zicbom makes the
>   expected (at least in the future) case the fast one.
>
Ok, thank you for the clarification. I'll default to zicbom.

> > @@ -465,7 +466,6 @@ config RISCV_ISA_ZICBOM
> >         depends on MMU
> >         depends on RISCV_ALTERNATIVE
> >         default y
> > -       select RISCV_DMA_NONCOHERENT
> >         help
> >            Adds support to dynamically detect the presence of the ZICBO=
M
> >            extension (Cache Block Management Operations) and enable its
> >
> > But what if the platform doesn't have the ZICBOM ISA extension?
>
> Then it needs to register its cache operations before the first
> DMA, which is something that it should do anyway. With your
> current code, it may work by accident depending on the state of
> the cache, but with the version I suggested, it will either work
> correctly all the time or crash in an obvious way when misconfigured.
>
Okay, agreed.

Cheers,
Prabhakar
