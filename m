Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50AA709663
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjESLWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjESLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:22:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA51180;
        Fri, 19 May 2023 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684495362; x=1716031362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=70zMPUe0yxRdfFDQaum+Lv5tPUPcm7ABiGrps531AkM=;
  b=oo22wo/1bMR+ergafw5bcz70QI+Y6yn3bN3RzQRMHQymc2ooHF/mwq0g
   nOWqkNGlpujoZYstoz1Y7S4b3ReY4AampbNvtwnqQOqv/NKvlSSxF//Rj
   3xkL3rAyej1FpxJLF863qDaLfgYfT7wn+7R/nczcSbDmZwSFLjyYXOp3K
   VAkoucP8m3tltTxi9aIUrzlvEOi2KYjAV7FonLOJYf0mlWKyiWdgrlso5
   JwJwOMk5HBeS3oSfimP2BcFEDwjAshOw9wynuTHi2PSY1IXJ5bwaWNSCt
   hOf6oycGLLAq2AVqCHmmpQmKVYyVo9D5FKJ1KuM3KSzFrQoZQbqzpzAgo
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="214006166"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 04:22:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 04:22:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 04:22:39 -0700
Date:   Fri, 19 May 2023 12:22:18 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Message-ID: <20230519-starlit-grip-ed152fb318cf@wendy>
References: <20230515141235.0777c631@canb.auug.org.au>
 <54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.org>
 <5d894e71-25ad-8ba0-f632-2eec6e017f46@ghiti.fr>
 <ee3bc2ce-5ebe-927e-5b6d-0b9490ef3875@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zXr/mpVKTRvFI6MJ"
Content-Disposition: inline
In-Reply-To: <ee3bc2ce-5ebe-927e-5b6d-0b9490ef3875@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zXr/mpVKTRvFI6MJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 12:42:55PM +0200, Alexandre Ghiti wrote:

> > > /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld:
> > > section .data LMA [000000000041a000,00000000075bffd7] overlaps
> > > section .text LMA [00000000000f09d4,00000000033562ab]
> > > /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld:
> > > section .init.pi.text LMA [00000000033562ac,0000000003359137]
> > > overlaps section .data LMA [000000000041a000,00000000075bffd7]
> >=20
> >=20
> > I'll check this one too which seems to be related to kernel/pi
> > introduction.
>=20
>=20
> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have
> limited size, hence the overlap, so no fix for this one. Is there a way to
> exclude this config from randconfig?

What exactly is the problem? That the randconfig is too big for the max
XIP kernel size?
We already disable half the world for XIP, is turning off the pi stuff
an option? It's already turned off for 32-bit, right?


--zXr/mpVKTRvFI6MJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGdb6gAKCRB4tDGHoIJi
0vVYAQCuJQDeHvqAW7U7kTId0ub6ZpJPRnn7lZisW1y8nNo8WQEA8DchlX9mBO3w
LTWmWx2BpAoAM7VuXrI5pFiIuZA9qQU=
=kiLz
-----END PGP SIGNATURE-----

--zXr/mpVKTRvFI6MJ--
