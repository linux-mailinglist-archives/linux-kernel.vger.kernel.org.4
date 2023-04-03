Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F16D4E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjDCRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjDCRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:00:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192B19B7;
        Mon,  3 Apr 2023 10:00:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id bl9so13127298iob.8;
        Mon, 03 Apr 2023 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680541231; x=1683133231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nf1Z/1629BSjtPERMC0xegxmYOylmoUX4r5kQI3Zb4=;
        b=afZSs2OWGE0NO12jOYZZiTTElaK97bfx4375BKXFjikdA8n0hir3GyRGXNuXs1UnzL
         5lg2tgzlu/ihguK+7ws1V4VP+Ka/6E+KU4xzIGpJmSb3wVON495DEAv0vWks7ObDMy0B
         QeN2khJBAeNmAYfBLjn/xfcGpDlC+jhTxnD3qH+o8D4xdkBt2Tt8tws9PK3V3TU7DoYg
         Ub7icz4RPADSd1ONMIXOz3/ZZoK9OBeDmv8mJhSioQmNb3a47+nWiZsG8DR3zS1X4IoF
         wz3YoMCBH6X9N2Sm8lpmJnI8G0EwYsYAf7foI5TI7Ph7SQ3uZHPejgFzF9MMjC+4xI/V
         pwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541231; x=1683133231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nf1Z/1629BSjtPERMC0xegxmYOylmoUX4r5kQI3Zb4=;
        b=l6g67eDjttfCXbZEzvh4Z2yNPmnkZ3V6nWhcbuiLe0UIpGX9uJwLPBn+o3LE7tzHy7
         K0jmY6rOIJwLq3zWHQSmYN7TTAIaeObAoNq/lTFdntPa+NW7fO4pLxvOfw2bTq3IrY7f
         +YbIVMQNYxJsaIBJzv4czrnKvmVjwZ+Lf6dg/33cs2faRKjeTXdXbT2BlRj67h0abcsu
         /L1BNWj0GsvVb7FihKwlv42N+dGWE+wHMYdN1NNqLDWOlBYhOMmFC+c8h6zmU7YWeaJA
         X3PJ3ss5Q+S351CfkrmycHzznNJV73JazDcydxvsSmtshzmRTOIH5zi8oStylKbth8S8
         0Krw==
X-Gm-Message-State: AAQBX9cVPpaS+oC1VCfgp06+aMd85/2jmwCkrvI3EMCpn4R/8ULiZDd2
        mHcZwZukb1B7s8+OIoONKZh2+m0+30nsm9OQBQw=
X-Google-Smtp-Source: AKy350Y/yLdfzY2ZvtkWGRk2SOZ/N5p31WZSenKJhc7loZKG0LwU+ujjt2tYneg/fN/rDMA3AWrQzzlpaYBPirIuotA=
X-Received: by 2002:a02:7359:0:b0:3a7:e46e:ab64 with SMTP id
 a25-20020a027359000000b003a7e46eab64mr17031jae.1.1680541231305; Mon, 03 Apr
 2023 10:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com> <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
 <1c441d20-951d-407b-90ba-4cda3b0505b2@app.fastmail.com>
In-Reply-To: <1c441d20-951d-407b-90ba-4cda3b0505b2@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 3 Apr 2023 18:00:04 +0100
Message-ID: <CA+V-a8t-j6DRpcv5oGREHVUaQpafcHiW8M_mRWAK4dC6PAsbcg@mail.gmail.com>
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

Hi Arnd,

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
You were right, defaulting to ZICBOM is giving me a crash. So I need
to switch to something else rather than using arch_initcall().

I tried early_initcall() but this doesn't let me register a platform
driver. I should be able to access the resources and DT from init
callback and then register CMO callbacks (I havent tried this yet) but
it wont be a platform driver. Should this be OK?

Cheers,
Prabhakar
