Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFDD706BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEQO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjEQO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:56:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425716186
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:56:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so65402455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684335364; x=1686927364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy01pDU5gpvvu40QdwUDSi9Rn8BJ+AlfGupuASEwzFs=;
        b=jaU0MTMcpsi5e11qScCf/2APvXYvWwIWHm5HZITAA/TYgvG+TzWJjw1k9KkADFndAl
         hGog+rgFaQ6At23WsARj/362a3S0xlbQkZQsvjRnc11X4h1HUeDg5CdotjmZoIAuqJmR
         /mpGK2vT0D9xt4tdnsNet9liylvPFg5KI6l+v6OgfkVl6IFoJXVsHhhUZVdoOjN0TsNS
         0l7+1u5NRev4Ky5IwSHIV2yfOI4lwuQ99UD0OVY6ifa1QaXiQ76VTsiB2hiS2Wr9kJur
         W+58TcD/EI3VxnCU77BXtx8wIHmn1c8cnGJzuF2/8eV9ZoOXltrVxeg61GmtC0asAWz8
         BtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335364; x=1686927364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy01pDU5gpvvu40QdwUDSi9Rn8BJ+AlfGupuASEwzFs=;
        b=LjyxXVia4VXhTTtbUoQDGhVXmsIXI0UXgeurY2BOdVfGXlcV+aoErrUfawHfce602q
         ISzEJc45/it7cYBegXJAuidY5xFozBTqPjskMrO6oW90WCeC8tTtz4dUqgJ0ApGlOR1v
         M6ygmOY620w6sz7Ff9hsjFq7tEOuJCq3gNIpTpIJpaBhqYnHtTi/Q92OqhlhgMw2HHur
         dvbPuPZgOC7ZJt43nx7gM25RjtO/eVzTm+gYIKX3SkICOvWJ2Dit/yc0FZB0rg1DeOct
         mFZComBNxMwM8RdonB3d17D+YkfnoAdFEptNTyJrv3Z0Qmhx9Ba0FteoGS8Bzsndn1RB
         8YYw==
X-Gm-Message-State: AC+VfDysMdmNa7o9RG+REfMEZaai+ok3TaL2sa1rhHEd+GxjNeLYfTdq
        6bye8hT0Xr22tq/GUj2VWDFPfMIstjoqIKn6bPWCdg==
X-Google-Smtp-Source: ACHHUZ5AL12iNPyGhfApc5Ia9Kgnuj/3cquvZ8Z2EKmlj5mtSIfji76qS3UA0nS1hCYb3SYhjSn2nKXlugh0ZzWWuYY=
X-Received: by 2002:a1c:f613:0:b0:3f3:3cba:2f2d with SMTP id
 w19-20020a1cf613000000b003f33cba2f2dmr2096949wmc.7.1684335364254; Wed, 17 May
 2023 07:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com> <20230517-preacher-primer-f41020b3376a@wendy>
In-Reply-To: <20230517-preacher-primer-f41020b3376a@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 17 May 2023 16:55:53 +0200
Message-ID: <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, anup@brainfault.org,
        palmer@rivosinc.com, jeeheng.sia@starfivetech.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Alex,
>
> On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> > On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
>
> > > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gmai=
l.com> wrote:
> > > I actually removed this flag a few years ago, and I have to admit tha=
t
> > > I need to check if that's necessary: the goal of commit 3335068f8721
> > > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
> > > the "right" start of DRAM so that we can align virtual and physical
> > > addresses on a 1GB boundary.
> > >
> > > So I have to check if a nomap region is actually added as a
> > > memblock.memory.regions[] or not: if yes, that's perfect, let's add
> > > the nomap attributes to the PMP regions, otherwise, I don't think tha=
t
> > > is a good solution.
> >
> > So here is the current linear mapping without nomap in openSBI:
> >
> > ---[ Linear mapping ]---
> > 0xff60000000000000-0xff60000000200000    0x0000000080000000         2M
> > PMD     D A G . . W R V
> > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> > PMD     D A G . . . R V
> >
> > And below the linear mapping with nomap in openSBI:
> >
> > ---[ Linear mapping ]---
> > 0xff60000000080000-0xff60000000200000    0x0000000080080000      1536K
> > PTE     D A G . . W R V
> > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> > PMD     D A G . . . R V
> >
> > So adding nomap does not misalign virtual and physical addresses, it
> > prevents the usage of 1GB page for this area though, so that's a
> > solution, we just lose this 1GB page here.
> >
> > But even though that may be the fix, I think we also need to fix that
> > in the kernel as it would break compatibility with certain versions of
> > openSBI *if* we fix openSBI...So here are a few solutions:
> >
> > 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> > before the linear mapping is established (IIUC, those nodes are added
> > by openSBI to advertise PMP regions)
> >     -> This amounts to the same fix as opensbi and we lose the 1GB huge=
page.
>
> AFAIU, losing the 1 GB hugepage is a regression, which would make this
> not an option, right?

Not sure this is a real regression, I'd rather avoid it, but as
mentioned in my first answer, Mike Rapoport showed that it was making
no difference performance-wise...

>
> > 2. we can tweak pfn_is_nosave function to *not* save pfn corresponding
> > to PMP regions
> >     -> We don't lose the 1GB hugepage \o/
> > 3. we can use register_nosave_region() to not save the "mmode_resv"
> > regions (x86 does that
> > https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820.c=
#L753)
> >     -> We don't lose the 1GB hugepage \o/
> > 4. Given JeeHeng pointer to
> > https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapshot.=
c#L1340,
> > we can mark those pages as non-readable and make the hibernation
> > process not save those pages
> >     -> Very late-in-the-day idea, not sure what it's worth, we also
> > lose the 1GB hugepage...
>
> Ditto here re: introducing another regression.
>
> > To me, the best solution is 3 as it would prepare for other similar
> > issues later, it is similar to x86 and it allows us to keep 1GB
> > hugepages.
> >
> > I have been thinking, and to me nomap does not provide anything since
> > the kernel should not address this memory range, so if it does, we
> > must fix the kernel.
> >
> > Let me know what you all think, I'll be preparing a PoC of 3 in the mea=
ntime!
>
> #3 would probably get my vote too. It seems like you could use it
> dynamically if there was to be a future other provider of "mmode_resv"
> regions, rather than doing something location-specific.
>
> We should probably document these opensbi reserved memory nodes though
> in a dt-binding or w/e if we are going to be relying on them to not
> crash!

Yes, you're right, let's see what Atish and Anup think!

Thanks for your quick answers Conor and Song, really appreciated!

Alex

>
> Thanks for working on this,
> Conor.
>
