Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688A3716BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjE3SEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjE3SEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:04:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83018A3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:04:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30aef0b8837so1704676f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685469869; x=1688061869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uURBJv3g3ArZjasZD7kZVLWPQS4crCRORUOeGLZEc5w=;
        b=rCUYS0XDeitzk6/vdzhfmQ41b+Q/9ZjTuImmhA13YTNiQ+DUzem67lU9gOA71a9mzs
         cp3bCFVuUTHqp1tmYAjVf4v5ysdDLuzNC1kOoGdYJnRYZKx1iy93cEb2xJULiwdjq0MP
         XuWqfhxnPio9zYN+9Id+54Ut4jFCNzbPQsHtM/XlzyyrAS9W7TKQiZpr3YGwmIMz2bzY
         4npL2miIWklD5rqGaTc0+jsImOSJKWb33VFo39vhdET1GpKEf+LFF3JOd+0Pcl/cKnXN
         wkSFchuNlT2muLwsruVnQe/T6c60AcuxQg3PhFNBvizGDbckiWDUQAIdFHYmYCTDr9x4
         GKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469869; x=1688061869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uURBJv3g3ArZjasZD7kZVLWPQS4crCRORUOeGLZEc5w=;
        b=SwIRCc18BXvIzL2bTkDrL5063G2OgKmtVig1Ge5RK12ThIOse9qDF82lRoinVhKNwD
         0M91SmIkr1KjoYyZvjo+PSfzSW+ZcOWjGAzTLK6O8ar6HbheQoyf7sNWMDPnBmEXav4u
         FQ/UEqYN0CTgTfsFtolR1L4Dx/wNB4YpFzLH9y27puQYrg9LNIOzl/Q4oojLYc/ntyMm
         PXhAUIdHsPxBNxKinXcfgSjT7qxe6766MuW5PAVHielgcs0I6HGAypqbtGk0RMYaF/Ud
         ZWRSjlH2eSmA4EbtnXf5fAkSAI/7cJ+x11lGE/V/lpHnVAif+wVbujFPONU1hG4K0K6k
         JYpQ==
X-Gm-Message-State: AC+VfDyL+f/n6M3UUvyTwlndWlk8+1ZLv4KR8dgtikAisIe5C0rJvCaA
        tPJxLmhArEOqzYlIO7PwTivomUaXGjKL7qOryX4X7g==
X-Google-Smtp-Source: ACHHUZ4TTBov4Ybg5E9FJ1qhnxNQ7HpfJ7GUFJKCEGWtauoRcccHns1I61grv9X0MCvQWxeUv5Og1A6WRUn6K8+U8Y4=
X-Received: by 2002:adf:e84d:0:b0:2f2:9198:f0f with SMTP id
 d13-20020adfe84d000000b002f291980f0fmr2308885wrn.10.1685469868973; Tue, 30
 May 2023 11:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud> <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud> <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud> <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
 <20230530-polka-trifle-7ccd7a093099@wendy> <92d4aaa8-a1ed-74e1-3a22-df9be1ca1e4a@ghiti.fr>
 <20230530-hatchery-unifier-64d7a2ffe0d0@spud>
In-Reply-To: <20230530-hatchery-unifier-64d7a2ffe0d0@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 30 May 2023 20:04:17 +0200
Message-ID: <CAHVXubgG31moSNOe3fRqFzUSJK9tRWKH1KPP_BO7wRNC4WzxTQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
To:     Conor Dooley <conor@kernel.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 7:47=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, May 30, 2023 at 04:33:45PM +0200, Alexandre Ghiti wrote:
> >
> > On 30/05/2023 13:27, Conor Dooley wrote:
> > > On Mon, May 29, 2023 at 09:37:28PM +0200, Alexandre Ghiti wrote:
> > > > On 29/05/2023 21:06, Conor Dooley wrote:
> > > > > On Mon, May 29, 2023 at 08:51:57PM +0200, Alexandre Ghiti wrote:
> > > > > > On 28/05/2023 15:56, Conor Dooley wrote:
> > > > > > > On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wro=
te:
> > > > > > > > Hmmm, it still works for me with both clang and gcc-9.
> > > > > > > gcc-9 is a bit of a relic, do you have more recent compilers =
lying
> > > > > > > around? If not, I can try some older compilers at some point.
> > > > > > >
> > > > > > > > You don't have to do that now but is there a way I could ge=
t your compiled
> > > > > > > > image? With the sha1 used to build it? Sorry, I don't see w=
hat happens, I
> > > > > > > > need to get my hands dirty in some debug!
> > > > > > > What do you mean by "sha1"? It falls with v6.4-rc1 which is a=
 stable
> > > > > > > hash, if that's what you're looking for.
> > > > > > >
> > > > > > > Otherwise,
> > > > > > > https://github.com/ConchuOD/riscv-env/releases/download/v2022=
.03/vmlinux.bin
> > > > > > > (ignore the release crap haha, too lazy to find a proper host=
ing
> > > > > > > mechanism)
> > > > > > Ok, I don't get much info without the symbols, can you also pro=
vide the
> > > > > > vmlinux please? But at least your image does not boot, not duri=
ng the early
> > > > > > boot though because the mmu is enabled.
> > > > > Do you see anything print when you try it? Cos I do not. Iff I ha=
ve time
> > > > > tomorrow, I'll go poking with gdb. I'm sorry I have not really do=
ne any
> > > > > investigating, I have been really busy this last week or so with
> > > > > dt-binding stuff but I should be freer again from tomorrow.
> > > > >
> > > > > https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/=
vmlinux
> > > >
> > > > Better, the trap happens in kasan_early_init() when it tries to acc=
ess a
> > > > global symbol using the GOT but ends up with a NULL pointer, which =
is weird.
> > > > So to me, this is not related to kasan, it happens that kasan_early=
_init()
> > > > is the first function called after enabling the mmu, I think you ma=
y have an
> > > > issue with the filling of the relocations.
> > > Yeah, it reproduces without KASAN.
> > >
> > > > Sorry to bother you again, but if
> > > > at some point you can recompile with DEBUG_INFO enabled, that would=
 be
> > > > perfect! And also provide the vmlinux.relocs file. Sorry for all th=
at, too
> > > > bad I can't reproduce it.
> > > New vmlinux & vmlinux.relocs here:
> > > https://microchiptechnology-my.sharepoint.com/:u:/g/personal/conor_do=
oley_microchip_com/EZpFNxYYrnNAh5Z3c-rf0pUBBpdPGTLafqdtfcXRUUBkXw?e=3D7KKMH=
X
> > > They're pretty massive unfortunately & hopefully that is not some
> > > garbage internal-only link.
> > > .config is a wee bit different, cos different build machine, but the
> > > problem still manifests on a icicle. I've added it to the tarball jus=
t
> > > in case.
> >
> >
> > Ok so I had to recreate the Image from the files you gave me and it boo=
ts
> > fine using qemu: is that expected? Because you only mention the icicle
> > above.
>
> Unfortunately you sent this one right as I left work..
> I ssh'ed in though and ran the vmlinux.bin & had the same issues.
> Silly question perhaps - is it just not possible to boot something that
> has been hit with `objcopy -O binary vmlinux vmlinux.bin` with
> CONFIG_RELOCATABLE? At this point that's the main thing that sticks out
> to me as being different. You couldn't boot the vmlinux.bin that I sent
> you either.

Ahah, I think we found the culprit!

With CONFIG_RELOCATABLE, vmlinux is actually stripped from all the
relocations (so that it can be shipped) and vmlinux.relocs is what you
should use instead, since it is just a copy of vmlinux before the
removal of the relocations!

>
> Cheers,
> Conor.
