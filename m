Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E7970669D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjEQL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEQL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:28:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7370830F6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684322886; x=1715858886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=USREqE8lRmbgXvnU/8dLwkbI7tqJwD1a8ZDS5Hs3u8I=;
  b=AdXZR13xDjplgXzxzsvkytI82nNuOK9LtLFkoge26ylBmHXhKZXphyY2
   l98SGGY/prYKluWeiRiHYOV1IOLBLAaZcyvT4Ih36rSbIS9/J5UK4OWqC
   MxIYwWf9V5Fgkw14o726+VttAcI0sciV4gdFSpKf++SSINSqRHiRMGGOo
   3dYt5az+wLlSXgwesK4Y8NP49/7cIaMZraKYRV4hiPRokMnXyBZ9Q6/AJ
   meyLP78oUpuDhEytlV+NnFMCJHKdrYZDkqoyGc7lUTSSWo7ONdYc8U17M
   kABSmCWyEZnduQyRt5aPBIOp//dgJeIx2hCYnhocrQXbcs5QxFg4W2yO2
   A==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="asc'?scan'208";a="214265850"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 04:27:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 04:27:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 04:27:51 -0700
Date:   Wed, 17 May 2023 12:27:30 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Song Shuai <suagrfillet@gmail.com>, <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, <anup@brainfault.org>,
        <palmer@rivosinc.com>, <jeeheng.sia@starfivetech.com>,
        <leyfoon.tan@starfivetech.com>, <mason.huo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230517-preacher-primer-f41020b3376a@wendy>
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6w54c5FuSo5Xd9WG"
Content-Disposition: inline
In-Reply-To: <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6w54c5FuSo5Xd9WG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:

> > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gmail.=
com> wrote:
> > I actually removed this flag a few years ago, and I have to admit that
> > I need to check if that's necessary: the goal of commit 3335068f8721
> > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
> > the "right" start of DRAM so that we can align virtual and physical
> > addresses on a 1GB boundary.
> >
> > So I have to check if a nomap region is actually added as a
> > memblock.memory.regions[] or not: if yes, that's perfect, let's add
> > the nomap attributes to the PMP regions, otherwise, I don't think that
> > is a good solution.
>=20
> So here is the current linear mapping without nomap in openSBI:
>=20
> ---[ Linear mapping ]---
> 0xff60000000000000-0xff60000000200000    0x0000000080000000         2M
> PMD     D A G . . W R V
> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> PMD     D A G . . . R V
>=20
> And below the linear mapping with nomap in openSBI:
>=20
> ---[ Linear mapping ]---
> 0xff60000000080000-0xff60000000200000    0x0000000080080000      1536K
> PTE     D A G . . W R V
> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> PMD     D A G . . . R V
>=20
> So adding nomap does not misalign virtual and physical addresses, it
> prevents the usage of 1GB page for this area though, so that's a
> solution, we just lose this 1GB page here.
>=20
> But even though that may be the fix, I think we also need to fix that
> in the kernel as it would break compatibility with certain versions of
> openSBI *if* we fix openSBI...So here are a few solutions:
>=20
> 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> before the linear mapping is established (IIUC, those nodes are added
> by openSBI to advertise PMP regions)
>     -> This amounts to the same fix as opensbi and we lose the 1GB hugepa=
ge.

AFAIU, losing the 1 GB hugepage is a regression, which would make this
not an option, right?

> 2. we can tweak pfn_is_nosave function to *not* save pfn corresponding
> to PMP regions
>     -> We don't lose the 1GB hugepage \o/
> 3. we can use register_nosave_region() to not save the "mmode_resv"
> regions (x86 does that
> https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820.c#L=
753)
>     -> We don't lose the 1GB hugepage \o/
> 4. Given JeeHeng pointer to
> https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapshot.c#=
L1340,
> we can mark those pages as non-readable and make the hibernation
> process not save those pages
>     -> Very late-in-the-day idea, not sure what it's worth, we also
> lose the 1GB hugepage...

Ditto here re: introducing another regression.

> To me, the best solution is 3 as it would prepare for other similar
> issues later, it is similar to x86 and it allows us to keep 1GB
> hugepages.
>=20
> I have been thinking, and to me nomap does not provide anything since
> the kernel should not address this memory range, so if it does, we
> must fix the kernel.
>=20
> Let me know what you all think, I'll be preparing a PoC of 3 in the meant=
ime!

#3 would probably get my vote too. It seems like you could use it
dynamically if there was to be a future other provider of "mmode_resv"
regions, rather than doing something location-specific.

We should probably document these opensbi reserved memory nodes though
in a dt-binding or w/e if we are going to be relying on them to not
crash!

Thanks for working on this,
Conor.


--6w54c5FuSo5Xd9WG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGS6IgAKCRB4tDGHoIJi
0qsIAQCtlGg/uMm4zz/vWITkgyLV+LGXakABee0MyRtoPfADJgEAhWfiM9TB46v4
4k0/ko1bu+Hxn6d2KvY+53/VT6P1DQk=
=YttE
-----END PGP SIGNATURE-----

--6w54c5FuSo5Xd9WG--
