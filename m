Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34B741779
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF1Rvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjF1Rve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:51:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE042123
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:51:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a675743dso1211381fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687974691; x=1690566691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIfoyCpUUajyFpMhMqY2mJy3ksaLY6ORUfahwyFeKps=;
        b=PZhSyKn0rBq8tzcP5Bek1yLJg+XNjZNPiL4LicVXac8ZOnPsWOnWA/9I80VfEM4619
         g5ay6vTG1iOzQj4ZH+Ab5XNGun/Iazle8Ji9pUkAGLMi2e0llijrwn+V/yw5k+v/9Luh
         RzJbb8msOTGWs80BMmcTGN4oLQohW5sbBQId13ax1T8cACnTMXSM57HORJikYJABP05Y
         2AX9yXWr89Mwke4BESf25avuAOE7dLikndEcqN49udXL2cEUvH21ZM8j0MuNZ9J6gnou
         jI1RYyDbtxgC9SexfytFdTs6FJo2prck5CqbvHYZFhbG0bmUDr6FmBp4iMJnL9/K/rYm
         7JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974691; x=1690566691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIfoyCpUUajyFpMhMqY2mJy3ksaLY6ORUfahwyFeKps=;
        b=BMjkqhCrx/nN8bOYjoEIjntF4oFm4DKJwGtCCzs6brtaHMAcn3I430JmFhJ5yxZDXk
         l/mvtWD9RESKLyQPVqeHH1uUsxIH7T5BG4qlhVCYxJ9Vy/ToMpHRUlzsidiZz2Ff75qG
         K83zu6WHbRMEaFYunJ7ijVPvk8ddHvAqph7XeBQiyiA+BKdjZyDPv4otso06+BV4/xc3
         SwuxFvRIBBNuGyzpHBQ/VS7BfpbSydgAvlU471r+tvoExRr4Wuo45ZRVC8UufPKQ9MpR
         O5oo3JOYvxAbBJe9vxvTuEMyWlsF0KUXxQcqcatIe+HmeiiiU6HO1dOMZPdku7OG55QY
         voxA==
X-Gm-Message-State: AC+VfDwxUjLK+VzH7groyjBoH7FWMnVkkBE26yeJz6JcFqcHZGQbaliG
        YXwVGNWvLpp7htVZ7GwnX2gzD8EgBsKgsjpwEP97Hw==
X-Google-Smtp-Source: ACHHUZ5owY13ULc/O32xrPfk+xUrhF3ccAD9wXq9jBAmvoET+2nZVQozOcdx0DwQxDw2S4OBcBUVCT2CQpLzucnAlkE=
X-Received: by 2002:a2e:3e08:0:b0:2b6:9ed0:46f4 with SMTP id
 l8-20020a2e3e08000000b002b69ed046f4mr8648646lja.23.1687974691162; Wed, 28 Jun
 2023 10:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230626-provable-angrily-81760e8c3cc6@wendy> <20230626-sensuous-clothing-124f7ae0aedf@wendy>
 <CALs-HstDV3PjBk_8WDecwuvVK9rno1CKFzT1+8ohoUXE7X0GwA@mail.gmail.com> <20230628-gizzard-trading-a5f9785128b5@spud>
In-Reply-To: <20230628-gizzard-trading-a5f9785128b5@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 28 Jun 2023 10:50:55 -0700
Message-ID: <CALs-HsvdXu+Ag50FpdCRthZamP+pzsqhxr2rnA+=Ko_sZ98z9A@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] RISC-V: add single letter extensions to riscv_isa_ext
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:43=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Jun 28, 2023 at 10:33:20AM -0700, Evan Green wrote:
> > On Mon, Jun 26, 2023 at 4:21=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > So that riscv_fill_hwcap() can use riscv_isa_ext to probe for single
> > > letter extensions, add them to it. riscv_isa_ext_data grows a new
> > > member, signifying whether an extension is multi-letter & thus requir=
ing
> > > special handling.
> > > As a result, what gets spat out in /proc/cpuinfo will become borked, =
as
> > > single letter extensions will be printed as part of the base extensio=
ns
> > > and while printing from riscv_isa_arr. Take the opportunity to unify =
the
> > > printing of the isa string, using the new member of riscv_isa_ext_dat=
a
> > > in the process.
> > >
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/include/asm/hwcap.h |  1 +
> > >  arch/riscv/kernel/cpu.c        | 36 ++++++----------------
> > >  arch/riscv/kernel/cpufeature.c | 56 +++++++++++++++++++++-----------=
--
> > >  3 files changed, 46 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/=
hwcap.h
> > > index a35bee219dd7..6ad896dc4342 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -77,6 +77,7 @@ unsigned long riscv_get_elf_hwcap(void);
> > >  struct riscv_isa_ext_data {
> > >         const unsigned int id;
> > >         const char *name;
> > > +       const bool multi_letter;
> >
> > Instead of defining a new member, could we just infer this by making a
> > macro like #define MULTI_LETTER(name) (name[0] && name[1])?
>
> Or don't even try to be clever like this and just call strnlen on the
> name & check if it is 1? It's only used in 2 places.

Sounds good to me!
