Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88445B351E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiIIKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIIKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:21:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A900A2236;
        Fri,  9 Sep 2022 03:21:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b136so2004749yba.2;
        Fri, 09 Sep 2022 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ZZA4Pj7Rkl+UbvtPPo3Um407kw5Y4PHFemhSOd9ipTA=;
        b=hcutMNzon3W8d0FfJ0yocaM6+40tWA5yA73lZ3gTKLzvbKIom0/A+pdeJ0MkbDArqb
         shctxDqIISISrLv/P4bvYBKdZTU7XbZoDX3d/do49qIhzcjoyCpoDt1TbmEjaSejb+CZ
         wU5aM4eP8yYI1O5rfyViH7w6w/OGs6Hl8ZBlzaTgyzkOVLHy2b2NPOaCo28D1N/ijK/3
         07iFbQOpzBi6osAvXK2Go8vbSd91OCjjUUA5D4l0QkO7kj91TQsfUt2yCO5Bwst60jfm
         7AJVHTMaSx2GFscAoks+YsQgquMY6XWMfDZfuRlRlVhl7omwZ/ijFqOiVSrATqKq4YsV
         Mf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZZA4Pj7Rkl+UbvtPPo3Um407kw5Y4PHFemhSOd9ipTA=;
        b=ClsRskNhf5GJnbDNgUk7pUS0jw/91MEwRB28QZpvyplIt19/wWcYioU/HjJ2ja1ftA
         LroqHjTHrQmNWcJ1zz8ond6RIt98heAz9y7Er2UfAQL8v71n+EYciRIRiBZfi15zmZNr
         cnHEw5Vo0/WXx7rOETpXZZ+ddTXwVips3tEnQ74bsrDYBSoGwgwBHBjMRP3PZC+iQYST
         jv9F5ioyGJVncsZA00Kt+IQ8vM5eYmkyDuCFQ0TbxNfTfDHZ6SQK7FkzrQFJ1BNkclsq
         fPKgcExxTrBKo49+blS5bDABFuSPcct/IKiBnqpJj4fAMjsVuQC2yFShJWbURYIzRFuG
         HPzA==
X-Gm-Message-State: ACgBeo05ObtnYy9QdaIIRwXcIaiwvtgiQ/avvESOptaHigy2bjW5BgaI
        mkZeRfafVh/nFcsQr83fyUOql1vZQqPAnZA56Eo=
X-Google-Smtp-Source: AA6agR7UQInaJ0exjQWl3faIYj89SXcwGKavULQT0HnWP4/3OjUGbu/HMmIYB3hwlm7IuZrtjVADAqjQQnxcuRh1C28=
X-Received: by 2002:a25:99c5:0:b0:6a9:6c30:a67d with SMTP id
 q5-20020a2599c5000000b006a96c30a67dmr11076808ybo.117.1662718906162; Fri, 09
 Sep 2022 03:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <67f0651e-3c6e-5ff6-0913-6b193b581764@microchip.com>
In-Reply-To: <67f0651e-3c6e-5ff6-0913-6b193b581764@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 9 Sep 2022 11:21:19 +0100
Message-ID: <CA+V-a8uZpdUmCwDLrWfN0DSd00Oyt5eV8LnE0LuoUZa6fDN0+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] AX45MP: Add support to non-coherent DMA
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, atishp@rivosinc.com,
        apatel@ventanamicro.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Sep 8, 2022 at 10:44 PM <Conor.Dooley@microchip.com> wrote:
>
> Hey,
>
> I had a quick run through this today so if there's discussion
> about this next week I at least will have some idea of what I
> am talking about...
>
Thanks for going through this!

> (I ended up not doing a quick run...)
>
:)

> On 06/09/2022 11:21, Lad Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > Hi All,
> >
> > On the Andes AX45MP core, cache coherency is a specification option so =
it
> > may not be supported. In this case DMA will fail. To get around with th=
is
> > issue this patch series  does the below:
>
> You say "may not be supported" - is it or is it not supported by the
> core on your SoC? Do some of the cheaper SKUs not support it?
>
Yep, it's not supported by the core on the RZ/Five SoC.

> From what Biju has said, you need non-coherent DMA for your eMMC, USB
> and ethernet controllers to work? To me, that seems like something that
> would be quite important to point out here..
>
Agreed!

>
> > Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtim=
e.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest. PM=
A
> > regions are passed from the cpu core node which are configured as
> > non-cacheable and non-bufferable with the SBI call.
> >
> >         ax45mp: cpu@0 {
> >                 compatible =3D "andestech,ax45mp", "riscv";
> >                 device_type =3D "cpu";
> >                 ....
> >                 pma-regions =3D <0x0 0x00000000 0x0 0x14000000>,
> >                               <0x0 0x20000000 0x0 0x10000000>,
> >                               <0x0 0x58000000 0x0 0x08000000>;
> >                 ....
> >         };
> >
> > We provide callbacks to synchronize specific content between memory and
> > cache. We allocate a global DMA coherent pool (which is marked as
> > non-cached using PMA) so that DMA memory allocations happens from this
> > pool and we implement the below callbacks:
> >
> > - arch_sync_dma_for_device()
> > - arch_sync_dma_for_cpu()
>
> These two already exist in arch/riscv/mm/dma-noncoherent.c using the
> alternatives mechanism.
>
I need to investigate if this can be re-used.

> > - arch_dma_alloc()
> > - arch_dma_free()
> >
> > Below are the configs that are enabled:
> >
> > - DMA_GLOBAL_POOL
> > - ARCH_HAS_SYNC_DMA_FOR_CPU
> > - ARCH_HAS_SYNC_DMA_FOR_DEVICE
>
> For these two see:
> arch/riscv/Kconfig & RISCV_DMA_NONCOHERENT
>
Thanks for the pointers, SoCs requiring this would just select
RISCV_DMA_NONCOHERENT

> >
> >         l2cache: cache-controller@13400000 {
> >                 compatible =3D "andestech,ax45mp-cache", "cache";
> >                 cache-size =3D <0x40000>;
> >                 cache-line-size =3D <64>;
> >                 cache-sets =3D <1024>;
> >                 cache-unified;
> >                 reg =3D <0x0 0x13400000 0x0 0x100000>;
> >         };
> >
> > Due to the above approach custom SBI calls have been implemented. The
> > above implementation is in preparation for adding support for Renesas
> > RZ/Five SoC which uses the AX45MP core. As with the above approach the
> > kernel image might not be generic so that it can be used on other
> > platforms, so sending it as an RFC (without DT binding patches).
> >
> > OpenSBI implementation isn't upstreamed yet, public repo for access is
> > available at [0].
>
> When you say "isn't upstreamed yet", what is the actual status? Where in
> the process are you or have you not started that yet? Does openSBI even
> allow custom extensions to be upstreamed?
>
TBH we haven't started yet. I'm really new to OpenSBI stuff, not sure
if custom extensions are allowed. I didn't find anything mentioned in
[0]

[0] https://github.com/riscv-software-src/opensbi/blob/master/docs/contribu=
ting.md

> >
> > [0] https://github.com/renesas-rz/rz_opensbi/tree/work/OpenSBI-PMA
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (2):
> >   riscv: vendors: andes: Add support to configure the PMA regions
> >   riscv: vendors: andes: Add support for non-cohernet dma
> >
>
> Anyway, a couple of drive-by comments, having made the wild assumption
> that this can be accepted upstream.
>
:)

> >  arch/riscv/Kbuild                             |   2 +
> >  arch/riscv/include/asm/sbi.h                  |   1 +
> >  arch/riscv/vendors/Makefile                   |   3 +
> >  arch/riscv/vendors/andes/Makefile             |   4 +
> >  arch/riscv/vendors/andes/ax45mp_cache.c       | 296 ++++++++++++++++++
>
> Surely this should be in drivers/soc/andestech, just like the SiFive L2
> controller is in drivers/soc/sifive rather in a subdirectory of the
> arch?
>
Agreed, I will move this to soc dir. maybe instead of andestech,
drivers/soc/renesas/rzfive maybe?

> >  arch/riscv/vendors/andes/ax45mp_nocache_dma.c |  65 ++++
>
> This looks like it should be implemented as errata/alternatives just
> like the non-coherent stuff on the D1 is done.
>
Agreed (I need to do more reading).

> >  arch/riscv/vendors/andes/include/proc.h       |   9 +
>
> And I think this would fall away if implemented as errata/alternatives.
>
I need to investigate it.

> >  arch/riscv/vendors/andes/include/sbi.h        |  27 ++
> >  arch/riscv/vendors/andes/ax45mp.c             |  93 ++++++
>
> idk where this would go though, if it is even something that is
> acceptable, given the policy I linked the other day from:
> https://www.kernel.org/doc/html/latest/riscv/patch-acceptance.html#submit=
-checklist-addendum
>
In the worst case we could move this to the lower layer to set up the
PMA regions and can drop this from the kernel.

> There is SiFive specific errata but it is implemented using mimpid etc
> rather than compatible/dt. As I said in my initial mails, I am quite
> interested in vendor SBI extensions in the kernel. If you did check out
> the link I sent, our stuff is a world away from yours - it's isolated to
> a driver where we are using SBI ECALLs to communicate with other harts
> which are running something other than Linux in AMP configurations.
> Pretty much we can do everything we want to do without touching a
> single line of code in arch/riscv, so although the statement in that doc
> applies to both of us here it does not apply evenly :s
>
I agree, as your code doesn't touch the core and just can be
implemented as a standalone driver with ecalls.

> It's all a bit unclear to me what the story is here, because obviously
> you are doing things that Zicbo* is meant to do (just like the D1), but
> your hardware's design and initial tapeout predates the existance of
> Zicbom. Makes me start to wonder, what happens for <insert idea> that
> eventually becomes an extension? Where does the line get draw for "you
> did something that is not a ratified extension, therefore you are not
> permitted upstream"? A line obviously does have to be drawn *somewhere*
> and the easiest place to draw that line is "non ratified extensions are
> a no-go". But then again, why allow the D1 but not you?
>
Yes, with a brief look we are doing something similar to things that
have been done for Zicbo*.

> Obviously this is not a runner for someone not using an FPGA or similar,
> but the InterHart Communication IP that we are using the SBI ECALLs for
> is a fabric core, so we (in theory) could re-write it so that instead of
> using an ECALL which routes communication via the e51 "monitor" core we
> _could_ write directly to the registers of the IHC block. There's clear
> security/isolation benefits for doing things via an ECALL which is why
> that method was chosen but if we opened for the direct writes/reads the
> driver would be upstream acceptable...
>
> Don't get me wrong, I completely understand why a policy of not allowing
> extensions that have not been ratified makes sense - *but* at the same
> time if touching arch code is not required it does not feel very much
> different to me than adding a driver for a fabric core in the first
> place. I mentioned this sort of thing a while back on IRC and Jess made
> the point that similar sorts of things are done by some of the Qualcomm
> for their remoteproc as we would be doing for ours with the IHC. In your
> case, if all of your ECALLs are in drivers/soc - the maintainership
> burden for any churn would be on you/Geert etc rather than on the RISC-V
> maintainer.
>
Agreed a policy as such would keep the core code clean for
non-ratified extensions. I was wondering if we could make use of
staging directory for non-ratified extensions as lots of vendors might
want to have their SoCs upstreamed but are waiting for the extensions
to be ratified. And whenever the extensions are ratified we can always
move it to the core?

> TL;DR of that is maybe a more nuanced policy of "no non-ratified
> extensions that touch arch/riscv" could be a possibility but I would
> completely understand if a "what's sauce for the goose is sauce for the
> gander" approach was taken here and a blanket ban remains in place.
>
> As I have said a bunch of times, this is all just my 2 cents etc and I
> am as much of a punter here as you are... but maybe since I am in the
> same sort of boat I at least have a fleshed out opinion. =C2=AF\_()_/=C2=
=AF
>
Thanks for weighing in.

> Hopefully either Palmer can weigh in here or we do get a BoF & the
> chance to have a chat about this sort of thing & maybe have a more
> nuanced policy - or at the very least something that makes it clearer
> that vendor extensions are a complete no-go upstream.
>
Fingers crossed.

Cheers,
Prabhakar
