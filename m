Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D0E7101D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjEXXyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjEXXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:54:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996FE135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:54:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f380cd1019so1717748e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1684972451; x=1687564451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcCRp0LFpuo7QMm9DbnFC3rTU4rCkAGrzLjZTJ0uzE8=;
        b=olo9C9Afn/8GOsefTuP72OGjJi6ie7FbKR+ZnS7ru/Vhe+pSMd0/sHLufsMmLJ5lFI
         P3f2akUlsv85cPvcXbCoKVkZw4q8RVVWbElo5l0JJn5a6CPiufXdCCx54ULcG7mO59/x
         jndhe5kliqTcSH/uN1iYvLfwIbHiHIaNAHrvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684972451; x=1687564451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcCRp0LFpuo7QMm9DbnFC3rTU4rCkAGrzLjZTJ0uzE8=;
        b=RdI0JHo9WD4q4C2N5DT/jje7CnwT5eT/uRg0coEEuE7RlTg/FJ8blRKKHFO/6ay3Oc
         SLZoAQTZ/vyG1hzHdjXh29/JRsufolUHHjzZZFkPOMncwdOEa3f5bWralBVlEAvvYYvh
         tL06UBPKIFB6i+OVXOXvGgJzoWhnpWl6Tqoi2cbqo+7dJC1cFUoZ1YapFdMPnl01pzBQ
         9A+NVLcLrFsNZFcPkeuuczgsm1v2AF0q8nv40L8mtZjHFhH4VdQ/K4pleIMZ66ai1RWa
         gBa+xWO5wHD7hM5XNYOKRAFGNlaKNUHX1AX0/U8o1CX3YBXiMnndjnJp8v/6LOoNhCFK
         FoOQ==
X-Gm-Message-State: AC+VfDzpL5UNquCQpEiQwba0LDjr8gej/c437EwBQ4eiIXZ43IfRxPxv
        fjEURPCHLP85PTFVaO3IKLu+SX6RkiPg7bnzTyH1
X-Google-Smtp-Source: ACHHUZ47iGouzM2FGhVHEI6ee+wnH4Y1E+n76IvuE59H7vpD5VRNIQLGj2c4VcpoQV8Q93ttd1zHStqfsqaHuqOYHwI=
X-Received: by 2002:ac2:5936:0:b0:4f3:c774:1923 with SMTP id
 v22-20020ac25936000000b004f3c7741923mr4331438lfi.11.1684972450771; Wed, 24
 May 2023 16:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <20230518-mobilize-dipper-051dfbc41971@wendy> <CAHVXubhpkkC_1sYkHJvjuHB24YhmHJJ_ZvjRhzaqvygCvfbRnw@mail.gmail.com>
 <20230518-cauterize-game-636a6aac4871@wendy> <CAHVXubgsHKfNaRgvXT0A=7cnnCMrZMrpvxEGrGobcytuFCsLKQ@mail.gmail.com>
In-Reply-To: <CAHVXubgsHKfNaRgvXT0A=7cnnCMrZMrpvxEGrGobcytuFCsLKQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 24 May 2023 16:53:59 -0700
Message-ID: <CAOnJCUJQdZZ3kT099Z6gcj+A4fP7ste3dC9QZ8G-2XH7x8DL7A@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
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

On Thu, May 18, 2023 at 4:58=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Thu, May 18, 2023 at 12:35=E2=80=AFPM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > On Thu, May 18, 2023 at 10:41:19AM +0200, Alexandre Ghiti wrote:
> > > On Thu, May 18, 2023 at 10:00=E2=80=AFAM Conor Dooley
> > > <conor.dooley@microchip.com> wrote:
> > > > On Thu, May 18, 2023 at 12:23:59PM +0530, Anup Patel wrote:
> > > > > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > > > On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.doo=
ley@microchip.com> wrote:
> > > > > > > On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wro=
te:
> > > > > > > > On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <al=
exghiti@rivosinc.com> wrote:
> > > > > > >
> > > > > > > > > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suag=
rfillet@gmail.com> wrote:
> > > > > > > > > I actually removed this flag a few years ago, and I have =
to admit that
> > > > > > > > > I need to check if that's necessary: the goal of commit 3=
335068f8721
> > > > > > > > > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") i=
s to expose
> > > > > > > > > the "right" start of DRAM so that we can align virtual an=
d physical
> > > > > > > > > addresses on a 1GB boundary.
> > > > > > > > >
> > > > > > > > > So I have to check if a nomap region is actually added as=
 a
> > > > > > > > > memblock.memory.regions[] or not: if yes, that's perfect,=
 let's add
> > > > > > > > > the nomap attributes to the PMP regions, otherwise, I don=
't think that
> > > > > > > > > is a good solution.
> > > > > > > >
> > > > > > > > So here is the current linear mapping without nomap in open=
SBI:
> > > > > > > >
> > > > > > > > ---[ Linear mapping ]---
> > > > > > > > 0xff60000000000000-0xff60000000200000    0x0000000080000000=
         2M
> > > > > > > > PMD     D A G . . W R V
> > > > > > > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000=
        12M
> > > > > > > > PMD     D A G . . . R V
> > > > > > > >
> > > > > > > > And below the linear mapping with nomap in openSBI:
> > > > > > > >
> > > > > > > > ---[ Linear mapping ]---
> > > > > > > > 0xff60000000080000-0xff60000000200000    0x0000000080080000=
      1536K
> > > > > > > > PTE     D A G . . W R V
> > > > > > > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000=
        12M
> > > > > > > > PMD     D A G . . . R V
> > > > > > > >
> > > > > > > > So adding nomap does not misalign virtual and physical addr=
esses, it
> > > > > > > > prevents the usage of 1GB page for this area though, so tha=
t's a
> > > > > > > > solution, we just lose this 1GB page here.
> > > > > > > >
> > > > > > > > But even though that may be the fix, I think we also need t=
o fix that
> > > > > > > > in the kernel as it would break compatibility with certain =
versions of
> > > > > > > > openSBI *if* we fix openSBI...So here are a few solutions:
> > > > > > > >
> > > > > > > > 1. we can mark all "mmode_resv" nodes in the device tree as=
 nomap,
> > > > > > > > before the linear mapping is established (IIUC, those nodes=
 are added
> > > > > > > > by openSBI to advertise PMP regions)
> > > > > > > >     -> This amounts to the same fix as opensbi and we lose =
the 1GB hugepage.
> > > > > > >
> > > > > > > AFAIU, losing the 1 GB hugepage is a regression, which would =
make this
> > > > > > > not an option, right?
> > > > > >
> > > > > > Not sure this is a real regression, I'd rather avoid it, but as
> > > > > > mentioned in my first answer, Mike Rapoport showed that it was =
making
> > > > > > no difference performance-wise...
> > > >
> > > > My point was that if someone has hugepages enabled & we handle this=
 in a
> > > > way that causes the first hugepage to be unusable, is that not a
> > > > regression? Whether hugepages provide a performance benefit is not
> > > > really related to that question AFAICT.
> > >
> > > Not being able to map certain regions of the linear mapping with a 1G=
B
> > > hugepage will happen, for example the kernel mapping is protected in
> > > the linear mapping so that it can't be written: so we can only map
> > > this region with 2MB hugepages. A firmware could mark a region as
> > > "no-map" and there again we would not be able to use a 1GB hugepage. =
I
> > > don't see that as a regression as the intention is not to *always* us=
e
> > > 1GB hugepages, but rather to use them when possible. Does that make
> > > sense?
> >
> > Ah, so it was as I expected - I don't/didn't properly understand
> > hugepages. Thanks.
> >
> > > > Were you suggesting reverting hugepage support entirely in your ori=
ginal
> > > > message? If we entirely remove hugepage support, then I guess the f=
irst
> > > > hugepage cannot be lost..
> > >
> > > Given Mike Rapoport's recent talk, I think that's an option, yes.
> > >
> > > >
> > > > > > > > 2. we can tweak pfn_is_nosave function to *not* save pfn co=
rresponding
> > > > > > > > to PMP regions
> > > > > > > >     -> We don't lose the 1GB hugepage \o/
> > > > > > > > 3. we can use register_nosave_region() to not save the "mmo=
de_resv"
> > > > > > > > regions (x86 does that
> > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/k=
ernel/e820.c#L753)
> > > > > > > >     -> We don't lose the 1GB hugepage \o/
> > > > > > > > 4. Given JeeHeng pointer to
> > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/pow=
er/snapshot.c#L1340,
> > > > > > > > we can mark those pages as non-readable and make the hibern=
ation
> > > > > > > > process not save those pages
> > > > > > > >     -> Very late-in-the-day idea, not sure what it's worth,=
 we also
> > > > > > > > lose the 1GB hugepage...
> > > > > > >
> > > > > > > Ditto here re: introducing another regression.
> > > > > > >
> > > > > > > > To me, the best solution is 3 as it would prepare for other=
 similar
> > > > > > > > issues later, it is similar to x86 and it allows us to keep=
 1GB
> > > > > > > > hugepages.
> > > > > > > >
> > > > > > > > I have been thinking, and to me nomap does not provide anyt=
hing since
> > > > > > > > the kernel should not address this memory range, so if it d=
oes, we
> > > > > > > > must fix the kernel.
> > > > > > > >
> > > > > > > > Let me know what you all think, I'll be preparing a PoC of =
3 in the meantime!
> > > > > > >
> > > > > > > #3 would probably get my vote too. It seems like you could us=
e it
> > > > > > > dynamically if there was to be a future other provider of "mm=
ode_resv"
> > > > > > > regions, rather than doing something location-specific.
> > > > > > >
> > > > > > > We should probably document these opensbi reserved memory nod=
es though
> > > > > > > in a dt-binding or w/e if we are going to be relying on them =
to not
> > > > > > > crash!
> > > > >
> > > > > Depending on a particular node name is fragile. If we really need
> > > > > information from DT then I suggest adding "no-save-restore" DT
> > > > > property in reserved memory nodes.
> > > >
> > > > We can add whatever properties we like, but where does that leave u=
s for
> > > > the systems in the wild where their reserved memory nodes do not co=
ntain
> > > > a "no-save-restore" property or "no-map"?
> > > >
> > > > Ideally, yes, we do not depend on the node name and instead use exp=
licit
> > > > properties - but I think we may be "forced" to fall back to checkin=
g the
> > > > node-name to cover the opensbi versions that do not contain one.
> > > > LMK if I have missed something there!
> > >
> > > Yes I agree with you, we can implement Anup's solution #1, but we nee=
d
> > > to fix the kernel anyway since if we don't, that would make the kerne=
l
> > > hibernation support depend on a certain version of openSBI.
> >
> > It's not unreasonable to have things depend on versions of the SBI
> > implementation, but it is if they're not things that can be probed usin=
g
> > the standard interfaces!
> >
> > > > > > Yes, you're right, let's see what Atish and Anup think!
> > > > >
> > > > > I think we have two possible approaches:
> > > > >
> > > > > 1) Update OpenSBI to set "no-map" DT property for firmware
> > > > >     reserved regions. We were doing this previously but removed
> > > > >     it later for performance reasons mentioned by Alex. It is als=
o
> > > > >     worth mentioning that ARM Trusted Firmware also sets "no-map"
> > > > >     DT property for firmware reserved regions.
> > > > >
> > > > > 2) Add a new "no-save-restore" DT property in the reserved
> > > > >     memory DT bindings. The hibernate support of Linux arch/riscv
> > > > >     will use this DT property to exclude memory regions from
> > > > >     save-restore. The EFI implementation of EDK2 and U-Boot
> > > > >     should do the following:
> > > > >     1) Treat all memory having "no-map" DT property as EFI
> > > > >         reserved memory
> > > > >     2) Treat all memory not having "no-map" DT property and
> > > > >         not having "no-save-restore" DT property as EfiBootServic=
esData
> > > > >     3) Treat all memory not having "no-map" DT property and
> > > > >          having "no-save-restore" DT property as EfiRuntimeServic=
eData
> > > > >          (Refer,
> > > > > https://devicetree-specification.readthedocs.io/en/latest/chapter=
3-devicenodes.html#reserved-memory-and-uefi)
> > > > >
> > > > > Personally, I am leaning towards approach#1 since approach#2
> > > > > will require changing DeviceTree specification as well.
> > > >
> > > > #1 is by far the simpler option of the two, if the consensus is tha=
t the
> > > > loss of the first hugepage is not a problem (or if it is a problem =
that
> > > > realistically is unavoidable).
> > >
> > > The "no-map" property does not provide much security anyway: the
> > > kernel should not touch a page that is reserved (this is where I may
> > > be wrong), so the real fix to this issue is to make the hibernation
> > > process not save those pages.
> >
> > Right, the kernel clearly needs to be able to handle the regions. I, at
> > least, was commenting on re-using no-map versus creating new properties
> > for this situation.
> > I was advocating for re-using the property & changing the kernel so as
> > not to touch the regions during hibernation.
> >
> > > > There's something else I think I might be missing here, given the
> > > > scattered nature of the reporting. This is not a problem for a syst=
em
> > > > that does not implement hibernation, which was only added in v6.4-r=
c1?
> > > >
> > > > That would make it not a regression after all. I think I misunderst=
ood
> > > > the report on sw-dev to mean that this was a problem generally afte=
r
> > > > v6.4-rc1, which would have been one. Could someone please confirm t=
hat?
> > >
> > > The problem is only present since v6.4-rc1, that's not a regression,
> > > it's just that both patches landed at the same time and gave rise to
> > > this issue.
> >
> > Sick. Glad to be wrong here!
> >
> > #regzbot resolve: not a regression, feature introduced this cycle
> >
> > > > If it only affects hibernation, and is not a regression, should we =
make
> > > > ARCH_HIBERNATION_POSSIBLE def_bool n in Kconfig until we have agree=
d on
> > > > a solution for the problem?
> >
> > Any thoughts on this one?
>
> Ahah, I don't know, I tried to dodge the question :) But if we don't
> fix this issue, hibernation won't work so is it enough?
>

We can also just revert the commit
3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
until a proper solution is available.

IIRC, Alex also suggested the same as there is no measured benefit
with this patch.
It is good to have 1GB huge page mappings but it can be delayed until
we have the fix
for the hibernation issue.

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
