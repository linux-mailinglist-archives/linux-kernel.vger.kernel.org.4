Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB37101C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjEXXpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEXXpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:45:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935E399
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:45:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3a873476bso1606739e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1684971948; x=1687563948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGJFiLjtW/P7m7j/sqcQEdAsAmCjjpAnxAKjgnhOmU8=;
        b=hxnQNFg+AMLu53FZh7cKuZV9I7zVF1ldNnVmV4RntW22l3qhHpI/nEHkZi0w6DQxn0
         ngXU+fc6UjEpbJ1GtDBANn9g/yFi2UX7w/5EDFlFLTYlXKMLLiPtevY5Q5dWCerhtixx
         8T5cuckVWblziiJVuHj7/jKt0YXTAtBZ8XIug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684971948; x=1687563948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGJFiLjtW/P7m7j/sqcQEdAsAmCjjpAnxAKjgnhOmU8=;
        b=F1jFkHkGGkg0xYSPHQTO6xlo49dHYHwlPc9IWj1dFb5aoKtSjbWdnk05Q6mUoDJIgR
         lfrm5kptbI/XiA9CnJORC8w/gzKRzmSqT3kJv+51Q0xpB2csjenmAJ1jFK3YK9uVu8MI
         wr8urxyleo1YNcbzH79ZeQeRHKJGbb8o9rEFBmq38UrUY8AT091NOefJ9RpVf4nR1aoL
         R6lWE5aIWDQ1LTV1X/YgfMy0jOexl7ETwLKbrsCP34VpOnRsHtzLQIB5hVU2wXBuvjJK
         UHI6xe0h7jGK3K3djQbGcSNEuTtZPmt+dO0XqlODL4IB4PFtnExXlzAl76hiO9tW+tkb
         T77Q==
X-Gm-Message-State: AC+VfDyRFpV+5Wmof8PG+8xBiOU/h3izYwejVuNeKdAcAydmj8rnIiHC
        2XDoU7EcxNUPR8jA7APg970a6oTFvgW4OpyoyQtk
X-Google-Smtp-Source: ACHHUZ7MP/aaM807PCkU8ee4O5WXTP/wgKx7qC7YMix3ZDmtSLCnBNt7Ft/9PI3OyVRbIwC+BL/mRWitsz59xjjz5hY=
X-Received: by 2002:a2e:b0d4:0:b0:2a8:a5b7:6057 with SMTP id
 g20-20020a2eb0d4000000b002a8a5b76057mr341377ljl.50.1684971947752; Wed, 24 May
 2023 16:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr> <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
In-Reply-To: <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 24 May 2023 16:45:36 -0700
Message-ID: <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, Anup Patel <anup@brainfault.org>,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        leyfoon.tan@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
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

On Thu, May 18, 2023 at 7:04=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Thu, May 18, 2023 at 5:39=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > On 5/18/23 08:53, Anup Patel wrote:
> > > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > >> On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@m=
icrochip.com> wrote:
> > >>> Hey Alex,
> > >>>
> > >>> On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> > >>>> On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti=
@rivosinc.com> wrote:
> > >>>>> On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@=
gmail.com> wrote:
> > >>>>> I actually removed this flag a few years ago, and I have to admit=
 that
> > >>>>> I need to check if that's necessary: the goal of commit 3335068f8=
721
> > >>>>> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to exp=
ose
> > >>>>> the "right" start of DRAM so that we can align virtual and physic=
al
> > >>>>> addresses on a 1GB boundary.
> > >>>>>
> > >>>>> So I have to check if a nomap region is actually added as a
> > >>>>> memblock.memory.regions[] or not: if yes, that's perfect, let's a=
dd
> > >>>>> the nomap attributes to the PMP regions, otherwise, I don't think=
 that
> > >>>>> is a good solution.
> > >>>> So here is the current linear mapping without nomap in openSBI:
> > >>>>
> > >>>> ---[ Linear mapping ]---
> > >>>> 0xff60000000000000-0xff60000000200000    0x0000000080000000       =
  2M
> > >>>> PMD     D A G . . W R V
> > >>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000       =
 12M
> > >>>> PMD     D A G . . . R V
> > >>>>
> > >>>> And below the linear mapping with nomap in openSBI:
> > >>>>
> > >>>> ---[ Linear mapping ]---
> > >>>> 0xff60000000080000-0xff60000000200000    0x0000000080080000      1=
536K
> > >>>> PTE     D A G . . W R V
> > >>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000       =
 12M
> > >>>> PMD     D A G . . . R V
> > >>>>
> > >>>> So adding nomap does not misalign virtual and physical addresses, =
it
> > >>>> prevents the usage of 1GB page for this area though, so that's a
> > >>>> solution, we just lose this 1GB page here.
> > >>>>
> > >>>> But even though that may be the fix, I think we also need to fix t=
hat
> > >>>> in the kernel as it would break compatibility with certain version=
s of
> > >>>> openSBI *if* we fix openSBI...So here are a few solutions:
> > >>>>
> > >>>> 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> > >>>> before the linear mapping is established (IIUC, those nodes are ad=
ded
> > >>>> by openSBI to advertise PMP regions)
> > >>>>      -> This amounts to the same fix as opensbi and we lose the 1G=
B hugepage.
> > >>> AFAIU, losing the 1 GB hugepage is a regression, which would make t=
his
> > >>> not an option, right?
> > >> Not sure this is a real regression, I'd rather avoid it, but as
> > >> mentioned in my first answer, Mike Rapoport showed that it was makin=
g
> > >> no difference performance-wise...
> > >>
> > >>>> 2. we can tweak pfn_is_nosave function to *not* save pfn correspon=
ding
> > >>>> to PMP regions
> > >>>>      -> We don't lose the 1GB hugepage \o/
> > >>>> 3. we can use register_nosave_region() to not save the "mmode_resv=
"
> > >>>> regions (x86 does that
> > >>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e=
820.c#L753)
> > >>>>      -> We don't lose the 1GB hugepage \o/
> > >>>> 4. Given JeeHeng pointer to
> > >>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snap=
shot.c#L1340,
> > >>>> we can mark those pages as non-readable and make the hibernation
> > >>>> process not save those pages
> > >>>>      -> Very late-in-the-day idea, not sure what it's worth, we al=
so
> > >>>> lose the 1GB hugepage...
> > >>> Ditto here re: introducing another regression.
> > >>>
> > >>>> To me, the best solution is 3 as it would prepare for other simila=
r
> > >>>> issues later, it is similar to x86 and it allows us to keep 1GB
> > >>>> hugepages.
> > >>>>
> > >>>> I have been thinking, and to me nomap does not provide anything si=
nce
> > >>>> the kernel should not address this memory range, so if it does, we
> > >>>> must fix the kernel.
> > >>>>
> > >>>> Let me know what you all think, I'll be preparing a PoC of 3 in th=
e meantime!
> > >>> #3 would probably get my vote too. It seems like you could use it
> > >>> dynamically if there was to be a future other provider of "mmode_re=
sv"
> > >>> regions, rather than doing something location-specific.
> > >>>
> > >>> We should probably document these opensbi reserved memory nodes tho=
ugh
> > >>> in a dt-binding or w/e if we are going to be relying on them to not
> > >>> crash!
> > > Depending on a particular node name is fragile. If we really need
> > > information from DT then I suggest adding "no-save-restore" DT
> > > property in reserved memory nodes.
> >
> >
> > I understand your point, the node name is the only thing I found that
> > would work with current opensbi: any other idea what we could use inste=
ad?
> >
> >
> > >> Yes, you're right, let's see what Atish and Anup think!
> > > I think we have two possible approaches:
> > >
> > > 1) Update OpenSBI to set "no-map" DT property for firmware
> > >      reserved regions. We were doing this previously but removed
> > >      it later for performance reasons mentioned by Alex. It is also
> > >      worth mentioning that ARM Trusted Firmware also sets "no-map"
> > >      DT property for firmware reserved regions.
> > >
> > > 2) Add a new "no-save-restore" DT property in the reserved
> > >      memory DT bindings. The hibernate support of Linux arch/riscv
> > >      will use this DT property to exclude memory regions from
> > >      save-restore. The EFI implementation of EDK2 and U-Boot
> > >      should do the following:
> > >      1) Treat all memory having "no-map" DT property as EFI
> > >          reserved memory
> > >      2) Treat all memory not having "no-map" DT property and
> > >          not having "no-save-restore" DT property as EfiBootServicesD=
ata
> > >      3) Treat all memory not having "no-map" DT property and
> > >           having "no-save-restore" DT property as EfiRuntimeServiceDa=
ta
> > >           (Refer,
> > > https://devicetree-specification.readthedocs.io/en/latest/chapter3-de=
vicenodes.html#reserved-memory-and-uefi)
> > >
> > > Personally, I am leaning towards approach#1 since approach#2
> > > will require changing DeviceTree specification as well.
> >
> >
> > If needed, indeed #1 is the simplest, but I insist, to me it is not
> > needed (and we don't have it in the current opensbi), if you have
> > another opinion, I'm open to discuss it!
>

The problem with relying on the "mmode_resv" name is that there will be
other use cases where a portion of the memory must be reserved and accessin=
g
that from the kernel will result in fault. CoVE is such a use case where
TSM will probably run from a memory region with confidential memory
which the kernel
must not access.

We have to name it "mmode_resv" as well or mark it as "no-map" which will
present a hole in mappings. We will end up in same 1GB hugepage issue
if we choose
"no-map".

Another option is to use compatible string or label property to indicate
that this memory region is not to be saved/restored during hibernation.
This can be documented in RISC-V DT bindings as well as the booting guide
doc that alex was talking about.


> I agree with you, backward compatibility with older firmwares
> is important.
>
This does break the compatibility with the older firmware w.r.to hibernatio=
n
feature. However

It is specific to hibernation only. So hibernation will fail to work
if an user is running kernel > 6.4 but 0.8 < OpenSBI < 1.2

The same problem lies if users use other firmware that don't have
no-map property today. IMO, this can be documented as a known problem.


> Let's go with your proposed change to treat reserved DT nodes
> with "mmode_resv*" name as M-mode firmware memory (it could
> be any M-mode firmware). We will certainly need to document it
> somewhere as an expectation of Linux RISC-V kernel.
>
> @Sunil How about treating "mmode_resv*" as
> EfiRuntimeServiceData in EDK2 ? Other reserved memory
> nodes can follow the device tree specification.
>

Either way, we also need to fix U-Boot to match the behavior.  Currently,
it treats any reserved memory without no-map property as EFI_BOOT_SERVICES_=
DATA.

> Regards,
> Anup
>
> >
> > Thanks for your quick answer Anup,
> >
> > Alex
> >
> >
> > >
> > > Regards,
> > > Anup
> > >
> > >> Thanks for your quick answers Conor and Song, really appreciated!
> > >>
> > >> Alex
> > >>
> > >>> Thanks for working on this,
> > >>> Conor.
> > >>>
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
