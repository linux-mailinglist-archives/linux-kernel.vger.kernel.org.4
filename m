Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0166708378
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjEROEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjEROEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:04:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68242E51
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:04:29 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5619032c026so25492767b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684418668; x=1687010668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb52D43DsqGb204mTo3qspPFJckrgQNCD/FODRqOHJ0=;
        b=muVRHFcr9MubEw7tp2pHvDOpXn2bQK2/6aeFUN0ZSlngg7AyA6QZ/bufXNLw0xx5cp
         /VTMyJx98duxIvHRJFWRAI+KdamaFVC1g/fpnKIPUKKOObHxpUgPGVFyKNJhtTwoH54n
         PWwX+sj6L/zB85O71XzTydtm8dRpKNSbVi2SOdWbp37aGg30xnXGtPy+t59MqeEj2Uhp
         SaSVsOgyQPMCFN48kI4hW8ra7/Yd89BbFLGPQftarIXq9zxu13dnYvuYIJyIrfGbPwp6
         AP++NR44+uynGQqydNLvzSEYY7wrHpz0dAZRbft3sn5QIDhJfZPy0uYFK1H3kSDeh9NK
         GlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418668; x=1687010668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb52D43DsqGb204mTo3qspPFJckrgQNCD/FODRqOHJ0=;
        b=S98g2Clzo3Evc20i7qO33DGftRPKzZheB1iLpFDBKWD4Gyehlg106qh5jwH+mqolft
         u/3sbv2aHxDx6drCFCPEjsj0yJkUgGxHoVii9JfNqHR+nf/CTC+xWKY9WpkDWAanTjWP
         Ao8t8bWKNOwIQHDo0NG+mLTj9IiJu0RFnu4SauA/hUhucG6YaMvetmQqnaNgxj5SLkxU
         pDrxVGVPyztmsNN3+Tp5JvRrgy9BKCEZU/7zqrw0xAB1K6OEkyBCkOx5b32efYvHWTyD
         YuCFp5cHcaGps/M6+X8scAYw5nslHJBllkbqP6beHHr9V7H+nacXY+2cUl3ZsgAwgsmW
         IpqQ==
X-Gm-Message-State: AC+VfDzOWbovLgvExObrWQB0qLk16PDReZ9GDpIZ0sCd5EWMM3uegClJ
        Wei5ym3Z+LoNvjrVy21U2LWOYm89u+kMAfGTKKz+sg==
X-Google-Smtp-Source: ACHHUZ6eFzOQTMDebzeFYmo+3o8okYvjI1voHSR+i5t4PdB8AjoFGI1y4SVGb9LjYHImh8ahQjWgljPPKRCT+gAiFZA=
X-Received: by 2002:a0d:ca58:0:b0:561:c1ae:1dfb with SMTP id
 m85-20020a0dca58000000b00561c1ae1dfbmr1229295ywd.34.1684418668364; Thu, 18
 May 2023 07:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com> <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
In-Reply-To: <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 18 May 2023 19:34:16 +0530
Message-ID: <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sunil V L <sunilvl@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 5:39=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 5/18/23 08:53, Anup Patel wrote:
> > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> >> On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@mic=
rochip.com> wrote:
> >>> Hey Alex,
> >>>
> >>> On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> >>>> On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> >>>>> On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gm=
ail.com> wrote:
> >>>>> I actually removed this flag a few years ago, and I have to admit t=
hat
> >>>>> I need to check if that's necessary: the goal of commit 3335068f872=
1
> >>>>> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expos=
e
> >>>>> the "right" start of DRAM so that we can align virtual and physical
> >>>>> addresses on a 1GB boundary.
> >>>>>
> >>>>> So I have to check if a nomap region is actually added as a
> >>>>> memblock.memory.regions[] or not: if yes, that's perfect, let's add
> >>>>> the nomap attributes to the PMP regions, otherwise, I don't think t=
hat
> >>>>> is a good solution.
> >>>> So here is the current linear mapping without nomap in openSBI:
> >>>>
> >>>> ---[ Linear mapping ]---
> >>>> 0xff60000000000000-0xff60000000200000    0x0000000080000000         =
2M
> >>>> PMD     D A G . . W R V
> >>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        1=
2M
> >>>> PMD     D A G . . . R V
> >>>>
> >>>> And below the linear mapping with nomap in openSBI:
> >>>>
> >>>> ---[ Linear mapping ]---
> >>>> 0xff60000000080000-0xff60000000200000    0x0000000080080000      153=
6K
> >>>> PTE     D A G . . W R V
> >>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        1=
2M
> >>>> PMD     D A G . . . R V
> >>>>
> >>>> So adding nomap does not misalign virtual and physical addresses, it
> >>>> prevents the usage of 1GB page for this area though, so that's a
> >>>> solution, we just lose this 1GB page here.
> >>>>
> >>>> But even though that may be the fix, I think we also need to fix tha=
t
> >>>> in the kernel as it would break compatibility with certain versions =
of
> >>>> openSBI *if* we fix openSBI...So here are a few solutions:
> >>>>
> >>>> 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> >>>> before the linear mapping is established (IIUC, those nodes are adde=
d
> >>>> by openSBI to advertise PMP regions)
> >>>>      -> This amounts to the same fix as opensbi and we lose the 1GB =
hugepage.
> >>> AFAIU, losing the 1 GB hugepage is a regression, which would make thi=
s
> >>> not an option, right?
> >> Not sure this is a real regression, I'd rather avoid it, but as
> >> mentioned in my first answer, Mike Rapoport showed that it was making
> >> no difference performance-wise...
> >>
> >>>> 2. we can tweak pfn_is_nosave function to *not* save pfn correspondi=
ng
> >>>> to PMP regions
> >>>>      -> We don't lose the 1GB hugepage \o/
> >>>> 3. we can use register_nosave_region() to not save the "mmode_resv"
> >>>> regions (x86 does that
> >>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e82=
0.c#L753)
> >>>>      -> We don't lose the 1GB hugepage \o/
> >>>> 4. Given JeeHeng pointer to
> >>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapsh=
ot.c#L1340,
> >>>> we can mark those pages as non-readable and make the hibernation
> >>>> process not save those pages
> >>>>      -> Very late-in-the-day idea, not sure what it's worth, we also
> >>>> lose the 1GB hugepage...
> >>> Ditto here re: introducing another regression.
> >>>
> >>>> To me, the best solution is 3 as it would prepare for other similar
> >>>> issues later, it is similar to x86 and it allows us to keep 1GB
> >>>> hugepages.
> >>>>
> >>>> I have been thinking, and to me nomap does not provide anything sinc=
e
> >>>> the kernel should not address this memory range, so if it does, we
> >>>> must fix the kernel.
> >>>>
> >>>> Let me know what you all think, I'll be preparing a PoC of 3 in the =
meantime!
> >>> #3 would probably get my vote too. It seems like you could use it
> >>> dynamically if there was to be a future other provider of "mmode_resv=
"
> >>> regions, rather than doing something location-specific.
> >>>
> >>> We should probably document these opensbi reserved memory nodes thoug=
h
> >>> in a dt-binding or w/e if we are going to be relying on them to not
> >>> crash!
> > Depending on a particular node name is fragile. If we really need
> > information from DT then I suggest adding "no-save-restore" DT
> > property in reserved memory nodes.
>
>
> I understand your point, the node name is the only thing I found that
> would work with current opensbi: any other idea what we could use instead=
?
>
>
> >> Yes, you're right, let's see what Atish and Anup think!
> > I think we have two possible approaches:
> >
> > 1) Update OpenSBI to set "no-map" DT property for firmware
> >      reserved regions. We were doing this previously but removed
> >      it later for performance reasons mentioned by Alex. It is also
> >      worth mentioning that ARM Trusted Firmware also sets "no-map"
> >      DT property for firmware reserved regions.
> >
> > 2) Add a new "no-save-restore" DT property in the reserved
> >      memory DT bindings. The hibernate support of Linux arch/riscv
> >      will use this DT property to exclude memory regions from
> >      save-restore. The EFI implementation of EDK2 and U-Boot
> >      should do the following:
> >      1) Treat all memory having "no-map" DT property as EFI
> >          reserved memory
> >      2) Treat all memory not having "no-map" DT property and
> >          not having "no-save-restore" DT property as EfiBootServicesDat=
a
> >      3) Treat all memory not having "no-map" DT property and
> >           having "no-save-restore" DT property as EfiRuntimeServiceData
> >           (Refer,
> > https://devicetree-specification.readthedocs.io/en/latest/chapter3-devi=
cenodes.html#reserved-memory-and-uefi)
> >
> > Personally, I am leaning towards approach#1 since approach#2
> > will require changing DeviceTree specification as well.
>
>
> If needed, indeed #1 is the simplest, but I insist, to me it is not
> needed (and we don't have it in the current opensbi), if you have
> another opinion, I'm open to discuss it!

I agree with you, backward compatibility with older firmwares
is important.

Let's go with your proposed change to treat reserved DT nodes
with "mmode_resv*" name as M-mode firmware memory (it could
be any M-mode firmware). We will certainly need to document it
somewhere as an expectation of Linux RISC-V kernel.

@Sunil How about treating "mmode_resv*" as
EfiRuntimeServiceData in EDK2 ? Other reserved memory
nodes can follow the device tree specification.

Regards,
Anup

>
> Thanks for your quick answer Anup,
>
> Alex
>
>
> >
> > Regards,
> > Anup
> >
> >> Thanks for your quick answers Conor and Song, really appreciated!
> >>
> >> Alex
> >>
> >>> Thanks for working on this,
> >>> Conor.
> >>>
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
