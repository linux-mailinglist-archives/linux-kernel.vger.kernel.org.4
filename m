Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA434707B83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjERIA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjERIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:00:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400BA1FE8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684396824; x=1715932824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+MtaUXemXdsDFsjup9gIZdwYkFuFfMKgmgCjvx7N5w=;
  b=F+Ph0mnpnnHF3pPLTZnYjpABOHQZeHh6Exvg8aW43+Khip9xYGf3TWQs
   /vXp0Q2am7sotOLvy3xLhzU8GcTYqFGWUnvYKtxD33HxgQ+wL0mETB930
   M54Nalgn6CU2hTjJq5YrolZ6CqNAHKvfzW1aI0IzTtIRHTWEgEG6G+FDo
   GGuS95CRw0ZmG8m1R12yF2VyZkwSRm0SZm4wbZKn9/3JVz+LPATNCDogT
   pB5+NY5L+ks0P1UcfV7uG/Yc6JXZDrUItF9ZIgLliDn6H0IiPplcoxZZz
   t9FTNsUIADjsJEG8Wbgyxa7IC7h5p4lwCSesNEJZs+bCHq7HCclzv3E1a
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="asc'?scan'208";a="216054306"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 01:00:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 01:00:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 01:00:20 -0700
Date:   Thu, 18 May 2023 08:59:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>, <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, <palmer@rivosinc.com>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230518-mobilize-dipper-051dfbc41971@wendy>
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TrXvLTZCoUzVI2ZA"
Content-Disposition: inline
In-Reply-To: <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--TrXvLTZCoUzVI2ZA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex, Anup,

On Thu, May 18, 2023 at 12:23:59PM +0530, Anup Patel wrote:
> On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> > On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > > On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> > > > On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@=
rivosinc.com> wrote:
> > >
> > > > > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@=
gmail.com> wrote:
> > > > > I actually removed this flag a few years ago, and I have to admit=
 that
> > > > > I need to check if that's necessary: the goal of commit 3335068f8=
721
> > > > > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to exp=
ose
> > > > > the "right" start of DRAM so that we can align virtual and physic=
al
> > > > > addresses on a 1GB boundary.
> > > > >
> > > > > So I have to check if a nomap region is actually added as a
> > > > > memblock.memory.regions[] or not: if yes, that's perfect, let's a=
dd
> > > > > the nomap attributes to the PMP regions, otherwise, I don't think=
 that
> > > > > is a good solution.
> > > >
> > > > So here is the current linear mapping without nomap in openSBI:
> > > >
> > > > ---[ Linear mapping ]---
> > > > 0xff60000000000000-0xff60000000200000    0x0000000080000000        =
 2M
> > > > PMD     D A G . . W R V
> > > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        =
12M
> > > > PMD     D A G . . . R V
> > > >
> > > > And below the linear mapping with nomap in openSBI:
> > > >
> > > > ---[ Linear mapping ]---
> > > > 0xff60000000080000-0xff60000000200000    0x0000000080080000      15=
36K
> > > > PTE     D A G . . W R V
> > > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        =
12M
> > > > PMD     D A G . . . R V
> > > >
> > > > So adding nomap does not misalign virtual and physical addresses, it
> > > > prevents the usage of 1GB page for this area though, so that's a
> > > > solution, we just lose this 1GB page here.
> > > >
> > > > But even though that may be the fix, I think we also need to fix th=
at
> > > > in the kernel as it would break compatibility with certain versions=
 of
> > > > openSBI *if* we fix openSBI...So here are a few solutions:
> > > >
> > > > 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> > > > before the linear mapping is established (IIUC, those nodes are add=
ed
> > > > by openSBI to advertise PMP regions)
> > > >     -> This amounts to the same fix as opensbi and we lose the 1GB =
hugepage.
> > >
> > > AFAIU, losing the 1 GB hugepage is a regression, which would make this
> > > not an option, right?
> >
> > Not sure this is a real regression, I'd rather avoid it, but as
> > mentioned in my first answer, Mike Rapoport showed that it was making
> > no difference performance-wise...

My point was that if someone has hugepages enabled & we handle this in a
way that causes the first hugepage to be unusable, is that not a
regression? Whether hugepages provide a performance benefit is not
really related to that question AFAICT.

Were you suggesting reverting hugepage support entirely in your original
message? If we entirely remove hugepage support, then I guess the first
hugepage cannot be lost..

> > > > 2. we can tweak pfn_is_nosave function to *not* save pfn correspond=
ing
> > > > to PMP regions
> > > >     -> We don't lose the 1GB hugepage \o/
> > > > 3. we can use register_nosave_region() to not save the "mmode_resv"
> > > > regions (x86 does that
> > > > https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e8=
20.c#L753)
> > > >     -> We don't lose the 1GB hugepage \o/
> > > > 4. Given JeeHeng pointer to
> > > > https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snaps=
hot.c#L1340,
> > > > we can mark those pages as non-readable and make the hibernation
> > > > process not save those pages
> > > >     -> Very late-in-the-day idea, not sure what it's worth, we also
> > > > lose the 1GB hugepage...
> > >
> > > Ditto here re: introducing another regression.
> > >
> > > > To me, the best solution is 3 as it would prepare for other similar
> > > > issues later, it is similar to x86 and it allows us to keep 1GB
> > > > hugepages.
> > > >
> > > > I have been thinking, and to me nomap does not provide anything sin=
ce
> > > > the kernel should not address this memory range, so if it does, we
> > > > must fix the kernel.
> > > >
> > > > Let me know what you all think, I'll be preparing a PoC of 3 in the=
 meantime!
> > >
> > > #3 would probably get my vote too. It seems like you could use it
> > > dynamically if there was to be a future other provider of "mmode_resv"
> > > regions, rather than doing something location-specific.
> > >
> > > We should probably document these opensbi reserved memory nodes though
> > > in a dt-binding or w/e if we are going to be relying on them to not
> > > crash!
>=20
> Depending on a particular node name is fragile. If we really need
> information from DT then I suggest adding "no-save-restore" DT
> property in reserved memory nodes.

We can add whatever properties we like, but where does that leave us for
the systems in the wild where their reserved memory nodes do not contain
a "no-save-restore" property or "no-map"?

Ideally, yes, we do not depend on the node name and instead use explicit
properties - but I think we may be "forced" to fall back to checking the
node-name to cover the opensbi versions that do not contain one.
LMK if I have missed something there!

> > Yes, you're right, let's see what Atish and Anup think!
>=20
> I think we have two possible approaches:
>=20
> 1) Update OpenSBI to set "no-map" DT property for firmware
>     reserved regions. We were doing this previously but removed
>     it later for performance reasons mentioned by Alex. It is also
>     worth mentioning that ARM Trusted Firmware also sets "no-map"
>     DT property for firmware reserved regions.
>=20
> 2) Add a new "no-save-restore" DT property in the reserved
>     memory DT bindings. The hibernate support of Linux arch/riscv
>     will use this DT property to exclude memory regions from
>     save-restore. The EFI implementation of EDK2 and U-Boot
>     should do the following:
>     1) Treat all memory having "no-map" DT property as EFI
>         reserved memory
>     2) Treat all memory not having "no-map" DT property and
>         not having "no-save-restore" DT property as EfiBootServicesData
>     3) Treat all memory not having "no-map" DT property and
>          having "no-save-restore" DT property as EfiRuntimeServiceData
>          (Refer,
> https://devicetree-specification.readthedocs.io/en/latest/chapter3-device=
nodes.html#reserved-memory-and-uefi)
>=20
> Personally, I am leaning towards approach#1 since approach#2
> will require changing DeviceTree specification as well.

#1 is by far the simpler option of the two, if the consensus is that the
loss of the first hugepage is not a problem (or if it is a problem that
realistically is unavoidable).

There's something else I think I might be missing here, given the
scattered nature of the reporting. This is not a problem for a system
that does not implement hibernation, which was only added in v6.4-rc1?

That would make it not a regression after all. I think I misunderstood
the report on sw-dev to mean that this was a problem generally after
v6.4-rc1, which would have been one. Could someone please confirm that?

If it only affects hibernation, and is not a regression, should we make
ARCH_HIBERNATION_POSSIBLE def_bool n in Kconfig until we have agreed on
a solution for the problem?

Thanks,
Conor.

--TrXvLTZCoUzVI2ZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGXa8AAKCRB4tDGHoIJi
0l98AP0dE5EosZsI0Rn2zUaiwLP1QhfXAtw0VBDqfyBOggNDGwEAkw/r5ui8ZjMf
3x9hVSJT8j/4N8xYq4MqBRWxUDz7ygQ=
=pmTn
-----END PGP SIGNATURE-----

--TrXvLTZCoUzVI2ZA--
