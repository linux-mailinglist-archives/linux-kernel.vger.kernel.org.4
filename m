Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65BF6CD388
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjC2HqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjC2HqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:46:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6DF3C00;
        Wed, 29 Mar 2023 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680075974; x=1711611974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXE11WAjq7Mq1gQbnjVpv6i2MWcnuFssWTa5BCBjDx8=;
  b=1DC6efx5OdF3goSGN06HUHKZuKXIPiQhqTznboqxXjBdMZ6tlyjAtCJg
   cJ1wqPbiWo7DGixzzWN/jR64WkKDF/NGepOuDakLMt4CX4nX5IcDmTUJx
   ZbjwJyLPc/hYtxCUY82I6SfXlmcV801z2FMNTs9Sidj9HkKEsw8zk2zMN
   bVxb7EE5/H0GPR6Ps7fQTvQ2dLzIGZiKu4D9HDuWJdpTHHCabmzXPm1k+
   ErMkB+EaPgWmDExBpHhcAcesmtSIkNFLhVskRrGFftywi3fgeO2niU/kY
   I2MUEstxaYPszBor3yfSoUovFvwU6n6T2tVj4mAx/AdEmZNm1Thpka0Nq
   A==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673938800"; 
   d="asc'?scan'208";a="203958215"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 00:46:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 00:46:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Mar 2023 00:46:09 -0700
Date:   Wed, 29 Mar 2023 08:45:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes 1/2] riscv: Move early dtb mapping into the fixmap
 region
Message-ID: <3fbfd976-6a24-44cf-91f2-89cc050b4256@spud>
References: <20230323163347.182895-1-alexghiti@rivosinc.com>
 <20230323163347.182895-2-alexghiti@rivosinc.com>
 <292617ac-b63b-473d-8d4e-2817d17233a1@spud>
 <b9097be8-b842-5e53-f728-a8cb6251316d@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mHQtHzilC6ByhlZn"
Content-Disposition: inline
In-Reply-To: <b9097be8-b842-5e53-f728-a8cb6251316d@ghiti.fr>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mHQtHzilC6ByhlZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 09:36:00AM +0200, Alexandre Ghiti wrote:
> On 3/27/23 12:37, Conor Dooley wrote:
> > On Thu, Mar 23, 2023 at 05:33:46PM +0100, Alexandre Ghiti wrote:

> The fix is not wrong, it is just incomplete: it fixes the issue with the
> not-existing-anymore address but introduces the problem with the possible
> allocations in the reserved regions (which you explained clearly below,
> thanks).

Which to me, makes it wrong ;) It's my own patch I'm dumping on so I
think I am best qualified to do that!

> > It would be good to mention that specifically I think, say:
> >=20
> > 	riscv establishes 2 virtual mappings:
> >=20
> > 	- early_pg_dir maps the kernel which allows to discover the system
> > 	  memory
> > 	- swapper_pg_dir installs the final mapping (linear mapping included)
> >=20
> > 	We used to map the dtb in early_pg_dir using DTB_EARLY_BASE_VA, and th=
is
> > 	mapping was not carried over in swapper_pg_dir. This caused problems
> > 	for reserved memory, as early_init_fdt_scan_reserved_mem() initialised
> > 	reserved_mem variables with addresses that lie in the early_pg_dir dtb
> > 	mapping. When those addresses are reused with swapper_pg_dir, this
> > 	mapping does not exist and then we trap.
> > 	The previous "fix" was incorrect as early_init_fdt_scan_reserved_mem()
> > 	must be called before swapper_pg_dir is set up otherwise we could
> > 	allocate in reserved memory defined in the dtb.
> >=20
> > 	Move the dtb mapping in the fixmap region which is established in
> > 	early_pg_dir and handed over to swapper_pg_dir.
> >=20
> > You need this one too:
> > Fixes: 922b0375fc93 ("riscv: Fix memblock reservation for device tree b=
lob")
>=20
> Not sure this commit is related to this fix and it's hard to find *one*
> culprit: TBH I only mentioned this one as otherwise I think the right com=
mit
> is commit 8f3a2b4a96dc ("RISC-V: Move DT mapping outof fixmap") but that'=
s a
> long time ago and the patch won't apply easily, not sure what to do here.

Yeah, it's hard to say.. I think the one I mentioned above should be
mentioned though, because that's what (I think) introduced the bug that
I was fixing in my commit, so if this patch is replacing my fix (which
it is) then I think it should have a super-set of the Fixes: tags in my
one.

> > Thanks for working on this,
>=20
>=20
> You're welcome, that was fun!

Sounds like masochism to me! ;)


--mHQtHzilC6ByhlZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCPspwAKCRB4tDGHoIJi
0n4CAQDthtD9EQ0oVsSXbJlZB5gXxT0oxDzOxUW/Gy6acDiNewD/Qdy18eeHVLCP
ZtZm+663INT/3mXFda24f6EIu8spDAk=
=7bOX
-----END PGP SIGNATURE-----

--mHQtHzilC6ByhlZn--
