Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F7650C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiLSMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLSMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:44:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F60E032;
        Mon, 19 Dec 2022 04:44:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so21273461ejh.0;
        Mon, 19 Dec 2022 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxV7u7RRZGTufLc/md9pxkp/T9u0Ezh5oQMEVPe6YoE=;
        b=NXZBQcYCFN6W7FZJnt2A0RGQ67TR1ahrG9Il9h7nLhG41ek3IlOG5ncHGcpvDsgYYi
         wGPBvRPnhbbsdeGYPZSE6kp8mwDpreWGjVAv2C/2OwGnYkkVJKGOdp8SZb+vbL/qtyFU
         Nt6SF2tW0efcm36MpHVmZWcsI6rrkzPPtLEUsdQnn4+6IcLMWnEWtmt1mT8MTjRAPsYZ
         v3TFOMh8gs/NcWWIZxoHgSKd/vhauHrCBqIG4kzFA2hwG2H0oE29kqpilZR2Pf9qdP9R
         TXho41ZtENKaJhpNTjGnSoqu2cb70bvgvUqcgB6DEn09XGgHSd0ekPM/TMeT2hJZ5YXe
         SqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxV7u7RRZGTufLc/md9pxkp/T9u0Ezh5oQMEVPe6YoE=;
        b=RzOmVQr2ZBXCxL7g8t+OQXHf7456/j5MY2XAkh5A864kxjukItANP60XQKKbqULHUR
         zQQOk7cKeRCvNi+0kn0myy9a+xFIlD+N3TRT3k3RTPDNTkmIVnAmIAfBLNtG4LUfQ137
         bsqhlgcvB0UH4smEcvx/5SJjoK9e0t50We7z1xrLeqmlKFb8ZrJmx5nBlH1SEvqEjyhT
         GBsiHC527pmh/xgI87qaGbNviMrw05zeDPrF+EKq/Eu3lOJwFASV1gf3P6OsvnCVxVEQ
         1pSZd/bT9lOimFBSiqa5LM9C8w2rCZnWnwiby8fxYQBiwDDC6VjNRU5L/mlxk77X9Hj5
         Qwtw==
X-Gm-Message-State: ANoB5plkOCycajBhjcev+UXp5sK6hg4HSOo8Ny4feNW3qoNe0vH3SBJS
        0WeEx3xEJH/8Qr7HcsRh2CtLt3/JoXkACaWMX7Y=
X-Google-Smtp-Source: AA0mqf5uBgvc3EA96bzK5dHrHzFiUTyMSkm7/ctkGB9XyGfleg5xEJDmeYdEobBRDxbJ6jWt4l6SYB5GKW3s9lK5HRk=
X-Received: by 2002:a17:906:3e41:b0:78d:bc9f:33da with SMTP id
 t1-20020a1709063e4100b0078dbc9f33damr80689032eji.80.1671453850556; Mon, 19
 Dec 2022 04:44:10 -0800 (PST)
MIME-Version: 1.0
References: <mhng-8b05b6cd-d8a1-4302-af24-2f64a4bf7c32@palmer-ri-x1c9a>
 <32cf0901-a4a0-48a7-bf42-f2cdb34d1ee7@app.fastmail.com> <Y55IQIxXw/twcxFx@spud>
In-Reply-To: <Y55IQIxXw/twcxFx@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Dec 2022 12:43:44 +0000
Message-ID: <CA+V-a8utcKKp81UTxQSvD6WsHgjO_7gSz33eedaE0+VxrR3f4w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>, soc@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        guoren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@infradead.org>
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

Hi Conor,

On Sat, Dec 17, 2022 at 10:52 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Dec 16, 2022 at 09:04:20PM +0100, Arnd Bergmann wrote:
> > On Fri, Dec 16, 2022, at 17:32, Palmer Dabbelt wrote:
> > > On Thu, 15 Dec 2022 23:02:58 PST (-0800), Christoph Hellwig wrote:
> > >> On Thu, Dec 15, 2022 at 01:40:30PM -0800, Palmer Dabbelt wrote:
> > >>> Given that we already moved the SiFive one out it seems sane to just start
> > >>> with the rest in drivers/soc/$VENDOR.  Looks like it was Christoph's idea to
> > >>> do the move, so I'm adding him in case he's got an opinion (and also the SOC
> > >>> alias, as that seems generally relevant).
> > >>
> > >> Well, it isn't an integral architecture feature, so it doesn't really
> > >> beloing into arch.  Even the irqchip and timer drivers that are more
> > >> less architectural are in drivers/ as they aren't really core
> > >> architecture code.
> > >
> > > That makes sense to me, it just looks like the SiFive ccache is the only
> > > one that's in drivers/soc/$VENDOR, the rest are in arch.  It looks like
> > > mostly older ports that have vendor-specific cache files in arch (ie,
> > > arm has it but arm64 doesn't).  Maybe that's just because the newer
> > > architectures sorted out standard ISA interfaces for these and thus
> > > don't need the vendor-specific bits?  I think we're likely to end up
> > > with quite a few of these vendor-specific cache management schemes on
> > > RISC-V.
> > >
> > > I'm always happy to keep stuff out of arch/riscv, though.  So maybe we
> > > just buck the trend here and stick to drivers/soc/$VENDOR like we did
> > > for the first one?
> >
> > I don't particularly like drivers/soc/ to become more of a dumping
> > ground for random drivers. If there are several SoCs that have the
> > same requirement to do a particular thing, the logical step would
> > be to put them into a proper subsystem, with a well-defined interface
> > to dma-mapping and virtualization frameworks.
> >
> > The other things we have in drivers/soc/ are usually either
> > soc_device drivers for identifying the system, or they export
> > interfaces used by soc specific drivers.
>
> Sounds like that's two "not in my back yard" votes from the maintainers
> in question..
> Doing drivers/cache would allow us to co-locate the RISC-V cache
> management bits since it is not just going to be the ax45mp l2 driver
> that will need to have them.
>
> Would it be okay to put this driver in soc/andestech for now & then move
> it, and the SiFive one, once we've got patches posted for cache
> management with that?
>
I think to start with it would be better if we place the Andes cache
driver in the proposed "drivers/cache" folder. We would avoid
unnecessary movement of code?

Cheers,
Prabhakar
