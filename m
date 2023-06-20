Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78987736896
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjFTKAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjFTJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:59:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B601FD4;
        Tue, 20 Jun 2023 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687255070; x=1718791070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4oXu7FJQwjSx64LQSoiKpv9H6LNtuO8vmXzyXeUjBE8=;
  b=BEdYxwC38DgLvNyYOeNsjJmdq31VOhlI1Kl2MqWAJftS/FHYehwrCctA
   s4hstB+InU5cNYTGDTc6/4upU8Me2kyfKKfkzHbBnZEcfGp+q4hLpN6Dq
   zipxaHKZxoH7hjMC+rJyzOCsc2VGn2ldhORnRlt/Hdr0im9WQgC81Ro5o
   3WFuELz5GF+AKMVNVKyvYEmG/FBuO6oOPDzbifR3Wk5O1ycAxqGGaa9WP
   x2d2GVzHIn23a+3plm1ZY2pamEYa+ZhpSbo5tPqhnSoUYU0dMxmyI0RPW
   eQgj9Hv354sMLDFyzw32Akdouhi5lnEb0o15q1TWL2VgaeIcMLI167qKR
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="asc'?scan'208";a="221063445"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2023 02:57:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 20 Jun 2023 02:57:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 20 Jun 2023 02:57:46 -0700
Date:   Tue, 20 Jun 2023 10:57:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
Message-ID: <20230620-slot-bobtail-4f41b59f4cf9@wendy>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
 <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
 <20230619-sponge-armful-6beeaf4a8624@spud>
 <87r0q7v1o9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HyYzIEwuf18tdy7k"
Content-Disposition: inline
In-Reply-To: <87r0q7v1o9.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HyYzIEwuf18tdy7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 10:48:06AM -0600, Jonathan Corbet wrote:
> Conor Dooley <conor@kernel.org> writes:
>=20
> > On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
> >> On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@mic=
rochip.com> wrote:
> >> > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
> >
> >> > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/bo=
ot.rst
> >> > > new file mode 100644
> >> > > index 000000000000..b02230818b79
> >> > > --- /dev/null
> >> > > +++ b/Documentation/riscv/boot.rst
> >> > > @@ -0,0 +1,181 @@
> >> > > +.. SPDX-License-Identifier: GPL-2.0
> >> > > +
> >> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > > +Early boot requirements/constraints on RISC-V
> >> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >
> >> > Please use "title case", here and elsewhere in the doc.
> >>=20
> >> You mean using "title: " instead of "=3D=3D=3D=3D"? Or using uppercase=
 for the
> >> first letter of each word? FYI I followed
> >> https://docs.kernel.org/doc-guide/sphinx.html?highlight=3Dtitle#specif=
ic-guidelines-for-the-kernel-documentation
> >
> > The latter. That's weird, I guess it would be nice to see what Jon
> > thinks about that.
>=20
> I have Never Been Fond of Excessive Use of Capital Letters, so my
> preference would be capitalization as in a normal sentence.
>=20
> That said, I don't really feel that something like this is important
> enough that we need to define and enforce a policy around it.  If the
> maintainers for specific subsystems feel differently, then I guess
> that's up to them.

Okay, thanks.

--HyYzIEwuf18tdy7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJF3/wAKCRB4tDGHoIJi
0gG8AP9nAmYRkCd6aA3KqwDS5VO/mXdodl6DpCx3vgU2BjkDYgEAu1/lkHz2Ig9k
R2kxyNWLJ055DoTuTXnCUGXDO043/Qs=
=plo2
-----END PGP SIGNATURE-----

--HyYzIEwuf18tdy7k--
