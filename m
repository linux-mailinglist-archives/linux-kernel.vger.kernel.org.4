Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC64A707A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjERGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjERGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:54:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79822105
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:54:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so260936466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1684392852; x=1686984852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZMbvGRBSSGMaxz0Ghtb36uIgcR+JrOIXpj+Zni7fqo=;
        b=3L4pvmOEEs2FgzUIm6H/6fQNVBImOK5ubFHPOSw0n3vR6leMEjiYFcXh5XSsVR9Maq
         TXmlvVzOP/xi7cooFahpE4iKSwyjTnAQGQ35FHzVreg2OjvK5pGt8UMbzgcbDiG2xYnk
         pndW/bxeUi45jdmmVlC3Gjj6o80lqZDE+Z+RGvtjXqZ2q8vUrI4Z+B5fcg00KFKiOlrj
         USqaJxXNihWYCoZeR41H26l7DXYqRC1k4rZ/5+g3LI6gXblP+f661m6Ek78Jbws3g+Ir
         qrSD++DAdJaLABMqvC0M7z74b2hMVXttiDeAcEYirU4PwWoGwOGQfAJd6mjq8+dqInuI
         7tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684392852; x=1686984852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZMbvGRBSSGMaxz0Ghtb36uIgcR+JrOIXpj+Zni7fqo=;
        b=AlSGsPaLJNqo/+9126z6RPGi9N7pcRYQyzzcPmXbvDOKOErJhhlxeMV2OKuWKnVfPJ
         iP245CS6+Ulr9P7QVJUKTjLSs+wvDHXufSQFWEvvIcaGou/PQDffb5v0aHHy42M1BbSs
         oR3EhADX9gYdJGsD0pZEbqdAfqv0K7sHJZWs1J3CzwuXbh/OjdUOi4gLWPJKIWQ6q4G9
         NId7A4UwaoSNCyiZOhNBa2PMN7ryDCWt7jQ2m94aIjJGLy/Gww8qO9ZMwdHs7H1yFxUL
         WhZ/UO7CosCalALcZ+7jDpJHdpOAl1W2BCnD5cttu7Rv+Yfu+j4ylRkC7CjzEVYTldok
         po1Q==
X-Gm-Message-State: AC+VfDxaobnpPocpF2Wxw7gRP2n6XED2P9xEG7pr5SImeKiTV1aB0+fb
        YFvsFVII7lY7P2V0Kv0A76S+vAy7GBCuGDjW8ITpnQ==
X-Google-Smtp-Source: ACHHUZ5uWmYXNgFp+u3x+RXg6LSOgTAIVd4YLNPiugpvW7aS+PfPMwwDj04xk9VognXxFCoCji2yesKhXdgH9zReuHs=
X-Received: by 2002:a17:907:8694:b0:96a:1c2a:5a38 with SMTP id
 qa20-20020a170907869400b0096a1c2a5a38mr28043720ejc.11.1684392852058; Wed, 17
 May 2023 23:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
In-Reply-To: <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 18 May 2023 12:23:59 +0530
Message-ID: <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > Hey Alex,
> >
> > On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> > > On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> >
> > > > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gm=
ail.com> wrote:
> > > > I actually removed this flag a few years ago, and I have to admit t=
hat
> > > > I need to check if that's necessary: the goal of commit 3335068f872=
1
> > > > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expos=
e
> > > > the "right" start of DRAM so that we can align virtual and physical
> > > > addresses on a 1GB boundary.
> > > >
> > > > So I have to check if a nomap region is actually added as a
> > > > memblock.memory.regions[] or not: if yes, that's perfect, let's add
> > > > the nomap attributes to the PMP regions, otherwise, I don't think t=
hat
> > > > is a good solution.
> > >
> > > So here is the current linear mapping without nomap in openSBI:
> > >
> > > ---[ Linear mapping ]---
> > > 0xff60000000000000-0xff60000000200000    0x0000000080000000         2=
M
> > > PMD     D A G . . W R V
> > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12=
M
> > > PMD     D A G . . . R V
> > >
> > > And below the linear mapping with nomap in openSBI:
> > >
> > > ---[ Linear mapping ]---
> > > 0xff60000000080000-0xff60000000200000    0x0000000080080000      1536=
K
> > > PTE     D A G . . W R V
> > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12=
M
> > > PMD     D A G . . . R V
> > >
> > > So adding nomap does not misalign virtual and physical addresses, it
> > > prevents the usage of 1GB page for this area though, so that's a
> > > solution, we just lose this 1GB page here.
> > >
> > > But even though that may be the fix, I think we also need to fix that
> > > in the kernel as it would break compatibility with certain versions o=
f
> > > openSBI *if* we fix openSBI...So here are a few solutions:
> > >
> > > 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> > > before the linear mapping is established (IIUC, those nodes are added
> > > by openSBI to advertise PMP regions)
> > >     -> This amounts to the same fix as opensbi and we lose the 1GB hu=
gepage.
> >
> > AFAIU, losing the 1 GB hugepage is a regression, which would make this
> > not an option, right?
>
> Not sure this is a real regression, I'd rather avoid it, but as
> mentioned in my first answer, Mike Rapoport showed that it was making
> no difference performance-wise...
>
> >
> > > 2. we can tweak pfn_is_nosave function to *not* save pfn correspondin=
g
> > > to PMP regions
> > >     -> We don't lose the 1GB hugepage \o/
> > > 3. we can use register_nosave_region() to not save the "mmode_resv"
> > > regions (x86 does that
> > > https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820=
.c#L753)
> > >     -> We don't lose the 1GB hugepage \o/
> > > 4. Given JeeHeng pointer to
> > > https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapsho=
t.c#L1340,
> > > we can mark those pages as non-readable and make the hibernation
> > > process not save those pages
> > >     -> Very late-in-the-day idea, not sure what it's worth, we also
> > > lose the 1GB hugepage...
> >
> > Ditto here re: introducing another regression.
> >
> > > To me, the best solution is 3 as it would prepare for other similar
> > > issues later, it is similar to x86 and it allows us to keep 1GB
> > > hugepages.
> > >
> > > I have been thinking, and to me nomap does not provide anything since
> > > the kernel should not address this memory range, so if it does, we
> > > must fix the kernel.
> > >
> > > Let me know what you all think, I'll be preparing a PoC of 3 in the m=
eantime!
> >
> > #3 would probably get my vote too. It seems like you could use it
> > dynamically if there was to be a future other provider of "mmode_resv"
> > regions, rather than doing something location-specific.
> >
> > We should probably document these opensbi reserved memory nodes though
> > in a dt-binding or w/e if we are going to be relying on them to not
> > crash!

Depending on a particular node name is fragile. If we really need
information from DT then I suggest adding "no-save-restore" DT
property in reserved memory nodes.

>
> Yes, you're right, let's see what Atish and Anup think!

I think we have two possible approaches:

1) Update OpenSBI to set "no-map" DT property for firmware
    reserved regions. We were doing this previously but removed
    it later for performance reasons mentioned by Alex. It is also
    worth mentioning that ARM Trusted Firmware also sets "no-map"
    DT property for firmware reserved regions.

2) Add a new "no-save-restore" DT property in the reserved
    memory DT bindings. The hibernate support of Linux arch/riscv
    will use this DT property to exclude memory regions from
    save-restore. The EFI implementation of EDK2 and U-Boot
    should do the following:
    1) Treat all memory having "no-map" DT property as EFI
        reserved memory
    2) Treat all memory not having "no-map" DT property and
        not having "no-save-restore" DT property as EfiBootServicesData
    3) Treat all memory not having "no-map" DT property and
         having "no-save-restore" DT property as EfiRuntimeServiceData
         (Refer,
https://devicetree-specification.readthedocs.io/en/latest/chapter3-deviceno=
des.html#reserved-memory-and-uefi)

Personally, I am leaning towards approach#1 since approach#2
will require changing DeviceTree specification as well.

Regards,
Anup

>
> Thanks for your quick answers Conor and Song, really appreciated!
>
> Alex
>
> >
> > Thanks for working on this,
> > Conor.
> >
