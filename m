Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05EF70F800
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjEXNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEXNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF546A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6578B632DA
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71930C433EF;
        Wed, 24 May 2023 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684936177;
        bh=FUTP1mbfy6I1wRKtWTlWctBObh3m57kq+FA25r2OZK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BikjzReTPHEj0Vt6ScGzym8/ZWPpoYr7dNGmwJofgnsf5nOEnTfdK5U3wBfkw1429
         PXHe3Nm5xXA+EwGmyBBSHFrnkwESJug6W/n5CrrOVSWnbbr9CDSM0uuV0wkYkFTPUX
         93B1wuex8U+/MbbWngX5fQn2Iq2BFWsZWvfkPaLg1psc7jtx3ekFn+tTqpJniKUeB/
         Tyj0Y8J/CWq3u4to0NVaY++sKIJutK1Zq5lIMH6kSwmQ1tAl2JFP5twrTVz51u3lIW
         J0j+JyV+YeJID/Q4xce6bV3FNGld+V39biB+q+MmhTBwwHU1/jEsPisN1hAoVYmEO0
         77Hfs3VO8W3+A==
Date:   Wed, 24 May 2023 14:49:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230524-wasp-charm-fe5c5478957a@spud>
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
 <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JfSOowhxP3xt+heO"
Content-Disposition: inline
In-Reply-To: <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JfSOowhxP3xt+heO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alex, Anup,

On Thu, May 18, 2023 at 07:34:16PM +0530, Anup Patel wrote:
> On Thu, May 18, 2023 at 5:39=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> > On 5/18/23 08:53, Anup Patel wrote:
> > > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > >> On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@m=
icrochip.com> wrote:
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
> > >> mentioned in my first answer, Mike Rapoport showed that it was making
> > >> no difference performance-wise...
> > >>
> > >>>> 2. we can tweak pfn_is_nosave function to *not* save pfn correspon=
ding
> > >>>> to PMP regions
> > >>>>      -> We don't lose the 1GB hugepage \o/
> > >>>> 3. we can use register_nosave_region() to not save the "mmode_resv"
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
> > >>>> To me, the best solution is 3 as it would prepare for other similar
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
>=20
> I agree with you, backward compatibility with older firmwares
> is important.
>=20
> Let's go with your proposed change to treat reserved DT nodes
> with "mmode_resv*" name as M-mode firmware memory (it could
> be any M-mode firmware). We will certainly need to document it
> somewhere as an expectation of Linux RISC-V kernel.

Actually, you two both probably know the answer to this, but was there a
release done of OpenSBI where the reserved memory region was not
specified to be no-map?

>=20
> @Sunil How about treating "mmode_resv*" as
> EfiRuntimeServiceData in EDK2 ? Other reserved memory
> nodes can follow the device tree specification.


--JfSOowhxP3xt+heO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG4V6wAKCRB4tDGHoIJi
0l2fAP9VB11nIqsvVNkavW5WcNBM3RgPlCXyA1ltDlnR+igeOQD+OEGhixkjuJOY
zp+FBKQesQLe4PtD2luSO8SXfFAxcgc=
=Yqlw
-----END PGP SIGNATURE-----

--JfSOowhxP3xt+heO--
