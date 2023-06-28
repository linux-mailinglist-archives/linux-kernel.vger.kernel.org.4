Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E770740FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjF1LKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:10:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41143 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjF1LKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687950643; x=1719486643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPS8EgVmsuYKLwB/yZyqAD3qQxEAVrUEUVm4/Bk6ZlA=;
  b=f45a2Vvg/1SqoCWNNeIkz+r8cjxjgWIMLkTKxWYwiUV2yjN7+2VqFxaE
   XJ8XlwYINPRCclNKIgNtS08A4P7lUbUDIR/ARJT2iCA9VCHv8gXtHzv4s
   k/mMBc1fUAIbCYfMSPIy9BH0YO7Ult2+EeGPS8jPrRWkNhcrgPJp4ujhY
   a4ShgZrAoB4WvfnnsVmytASiw96d+3eBuBbvL6cLXB+u8sCB+QyEQ6SDe
   bzGNYi2Ytlxl+dj6l3wGaiZ+lvKCxyJM1R7eMpEWKtPML/f7mJclbe3Ti
   87JEe7TQ0/dg60k3G5/jD6faJnhRk/0msNA+pZxT8nkMiaix814tUk4XW
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="asc'?scan'208";a="220273292"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2023 04:10:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 28 Jun 2023 04:10:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 28 Jun 2023 04:10:39 -0700
Date:   Wed, 28 Jun 2023 12:10:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, <linux@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230628-unfeeling-tavern-edd4f58396fa@wendy>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
 <ZJwE5wRVkoND3Z6P@vermeer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YhMMrLi4maVY432h"
Content-Disposition: inline
In-Reply-To: <ZJwE5wRVkoND3Z6P@vermeer>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--YhMMrLi4maVY432h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 12:01:11PM +0200, Samuel Ortiz wrote:
> On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.=
com> wrote:

> > > It would be nice to consolidate the ones together that search for a
> > > single string and set multiple bits, though I don't have any super
> > > elegant ideas for how off the top of my head.
> >=20
> > I've got a refactor of this code in progress, dropping all of these
> > copy-paste in place of a loop. It certainly looks more elegant than
> > this, but it will fall over a bit for these "one string matches many
> > extensions" cases. See here:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20230626-thievin=
g-jockstrap-d35d20b535c5@wendy/
> > My immediate thought is to add another element to riscv_isa_ext_data,
> > that contains "parent" extensions to check for. Should be fairly doable,
> > I'll whip something up on top of that...
>=20
> Nice, and thanks for the review.

> Should I wait for your refactor to be merged before pushing this one?

I don't know. I think that you should continue on with your series here,
and whichever goes in second gets rebased on top of the other.
I don't think it makes material difference to review of this patchset as
to whether you rebase on top of what I'm working on, so I wouldn't
bother until it gets merged.

Rather hacky, had less time than expected this morning:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Driscv-extensions-strings-supersets
Clearly there's issues with looping to RISCV_ISA_MAX_SUPERSETS & I just
repurposed Zicsr for the sake of testing something in the time I had.

Evan, at a high level, does that look more elegant to you, or have I made
things worse?


--YhMMrLi4maVY432h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJwVEwAKCRB4tDGHoIJi
0odBAQCGhQC04g5NX1UwATx7PJIFcjSsuRX6bdBayXqjTHuUqwEA1YlIzLiAh68e
R4OeRtEOFZOGNesu9GAsfbgm0Zx4DgE=
=iWeD
-----END PGP SIGNATURE-----

--YhMMrLi4maVY432h--
