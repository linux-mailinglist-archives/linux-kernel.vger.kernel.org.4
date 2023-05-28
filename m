Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE75713980
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjE1NBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1NBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:01:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0690
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:01:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2276714f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685278868; x=1687870868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmSD/mMKdh/z5N+sCe3c2tpdqKCT7mWgSBl+i6i1id0=;
        b=NtaqX3glS//gpzcZ9RWLeaPh2+1IMGg5/S/qZ3Nt/o1C5eH6GAIfb7gxnd4/OZj7pI
         dBUkcgdl4rheF+IZ30vnYN6TxkgxssOVArqJpruF2K+fe9NFj9kLjybZRHxrlbXxwbZ2
         0mDAhbDRt2TcgwOm+79LQiutKOF8I61BM7ZvI5BLrEQbMXYgSBktw4S42NWJ1JV9afJJ
         nc8VAlOgvGIl+rY94763GRpYlp1Pu5Jpe2htuuJZk9e5ysgJWXSNq0FSQR9aZpebQzei
         SamvVmzb2VD+M3WkifzcoVtYHmAW4fbVp5LdMO1a5II2e7JLl+TwrA/ZOEapqrHFCzXq
         TgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685278868; x=1687870868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmSD/mMKdh/z5N+sCe3c2tpdqKCT7mWgSBl+i6i1id0=;
        b=Rmy1ra5hdO6SmvjM7AdwKv3s4QWgb9E6w4YBHk62ekpV+cjTd5Bn7JimzxdDA4Q3T+
         mQ5lb6I3t0FcN3gpJDfF+iLau5d9KRbWDItQEnlZu14dz+Xt1fCwexIx6ZZ6iF1Co6FF
         ZgweQmdYij/x6WvK7/S+5zz/SmARMJIbLLrihiH2A5f/OeCHF4GD9Go0R0lYQ8Lklu+J
         FJnMixdfmnwxFrXR91Bvd3yuTUypVpbtiy4U9Do4yjAd08C4mRp86+scLPpQOqM7nLB+
         J34gPAZGsk4QO4lrMfj99QbnvMFfLJXxa6cTYuddOtUri/Rkhg9sezrR4XKKG8kysl3/
         JYLw==
X-Gm-Message-State: AC+VfDzcr+jSWwcnLiZdYfIxrjGzFsl/1BF4QfDQ4WUldydj0+EjYkJQ
        Ow507GzS8X750b3pCQ/PakRSMP2yK8CwcWDV0C/jjw==
X-Google-Smtp-Source: ACHHUZ7+17dKZkWBx2usLAcAjzua73N800snDWC4IqZPOvC1tsLLqyUxWCEdEkWPnzYIK7Q7fHOMIwMUAOV4FIwkjwM=
X-Received: by 2002:a5d:65c3:0:b0:30a:e69d:721e with SMTP id
 e3-20020a5d65c3000000b0030ae69d721emr2344793wrw.55.1685278868682; Sun, 28 May
 2023 06:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud> <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr> <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
In-Reply-To: <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Sun, 28 May 2023 15:00:57 +0200
Message-ID: <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
To:     Conor Dooley <conor@kernel.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sat, May 27, 2023 at 12:02=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, May 27, 2023 at 11:13:18AM +0200, Alexandre Ghiti wrote:
> >
> > On 26/05/2023 18:35, Conor Dooley wrote:
> > > On Fri, May 26, 2023 at 05:24:41PM +0100, Conor Dooley wrote:
> > > > On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
> > > > > Early alternatives are called with the mmu disabled, and then sho=
uld not
> > > > > access any global symbols through the GOT since it requires reloc=
ations,
> > > > > relocations that we do before but *virtually*. So only use medany=
 code
> > > > > model for this early code.
> > > > >
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > ---
> > > > >
> > > > > Note that I'm not very happy with this fix, I think we need to pu=
t more
> > > > > effort into "harmonizing" this very early code (ie before the mmu=
 is
> > > > > enabled) as it is spread between different locations and compiled
> > > > > differently.
> > > > Totally & I'll happily spend the time trying to review that work.
> > > >
> > > > > I'll work on that later, but for now, this fix does what is
> > > > > needed to work (from my testing at least). Any Tested-by on the U=
nmatched
> > > > > and T-head boards is welcome!
> > > > On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added t=
o my
> > > > config, my Nezha fails to boot. There is no output whatsoever from =
the
> > > > kernel. Turning off CONFIG_RELOCATABLE boots again.
> > > I don't know if this is better or worse news, but same thing happens =
on
> > > an icicle kit. What systems, other than QEMU, has the relocatable
> > > eries been tested with, btw?
> >
> >
> > I tested it on the Unmatched (Andreas did too).
>
> Cool. I cracked out my unmatched and it has the same issue as the
> icicle. Ditto my Visionfive v2. Here's my config.
> https://raw.githubusercontent.com/ConchuOD/riscv-env/dev/conf/defconfig
>
> A ~default qemu virt doesn't work either. (-m 2G -smp 5)

I can boot with this config using:

$ sudo ~/qemu/build/qemu-system-riscv64 -machine virt -cpu
rv64,sv48=3Doff -nographic -m 2G -smp 5 -kernel
build_conor/arch/riscv/boot/Image -s

I noticed when trying to add this to our internal CI that I had local
failures that did not happen in the CI because the CI was not using
the same toolchain: can you give me the full .config? So that I can
see if the compiler added stack guards or some other things I did not
think of.

Thanks!

>
> > Very weird it does not work on the icicle kit, there is no errata for t=
his
> > soc, so what gets executed this early for this soc? Do you know where i=
t
> > fails to boot? If you can debug, you should break on the address of the
> > entry point (usually 0x8020_0000) since this is the stvec address, so w=
hen
> > you get a trap, you will branch there, and then could you dump $sepc, $=
ra
> > and $stval when you get there?
>
> > Regarding the thead issue, I think the following should fix it:
>
> It did not :/
>
> Cheers,
> Conor.
>
