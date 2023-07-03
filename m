Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3D74617E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGCRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGCRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F8CE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA3960FEF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3945DC433C7;
        Mon,  3 Jul 2023 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688405989;
        bh=OntLpPnFpu6a5AZn6p9k4IDUTa9DeesaKC3dsarBEQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmrFmh5lmxYbn4ure2V67iG4eEuApA+cAlmqBLLlcm22Zr08WKxQHX28dD2UKLsjd
         DP+rbcQDXn3UG4NI77qkloLUuYM7fnmFG7citty9W43xTWEfujhRokN0XnVCTrEGSl
         +s+hFLWXSRReOk0GYeB4H1sfXuFS5SYtVcdj2dFDXj+FWNkYQAkaih8GJVBwHN+U/e
         BRv5FkW5UqRxzuussLA9sDCiLF7Q29Q5GHLyox7pAPttgayI8CuAD6RLZWMTswWaSy
         yLFcxHVZT0QRlQpWQL/hSfB4BGXEx15i67N+6yqO0ZNIdEbFUTISuT79ubCc2ybOzL
         R8pY7TlcX5mkA==
Date:   Mon, 3 Jul 2023 18:39:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230703-mangle-panning-75909ebbe30c@spud>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
 <ZJwE5wRVkoND3Z6P@vermeer>
 <20230628-unfeeling-tavern-edd4f58396fa@wendy>
 <CALs-HstZe+bw_fY--4FQXfFoA67tvMSaEjKhZ2pRstNT07xBxA@mail.gmail.com>
 <20230628-dragonish-lullaby-b44d2df09d66@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JgFm48JGbULM0hnk"
Content-Disposition: inline
In-Reply-To: <20230628-dragonish-lullaby-b44d2df09d66@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JgFm48JGbULM0hnk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 06:24:40PM +0100, Conor Dooley wrote:
> On Wed, Jun 28, 2023 at 10:18:34AM -0700, Evan Green wrote:
> > On Wed, Jun 28, 2023 at 4:10=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 12:01:11PM +0200, Samuel Ortiz wrote:
> > > > On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > > > > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > > > > On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@riv=
osinc.com> wrote:
> > >
> > > > > > It would be nice to consolidate the ones together that search f=
or a
> > > > > > single string and set multiple bits, though I don't have any su=
per
> > > > > > elegant ideas for how off the top of my head.
> > > > >
> > > > > I've got a refactor of this code in progress, dropping all of the=
se
> > > > > copy-paste in place of a loop. It certainly looks more elegant th=
an
> > > > > this, but it will fall over a bit for these "one string matches m=
any
> > > > > extensions" cases. See here:
> > > > > https://patchwork.kernel.org/project/linux-riscv/patch/20230626-t=
hieving-jockstrap-d35d20b535c5@wendy/
> > > > > My immediate thought is to add another element to riscv_isa_ext_d=
ata,
> > > > > that contains "parent" extensions to check for. Should be fairly =
doable,
> > > > > I'll whip something up on top of that...
> > > >
> > > > Nice, and thanks for the review.
> > >
> > > > Should I wait for your refactor to be merged before pushing this on=
e?
> > >
> > > I don't know. I think that you should continue on with your series he=
re,
> > > and whichever goes in second gets rebased on top of the other.
> > > I don't think it makes material difference to review of this patchset=
 as
> > > to whether you rebase on top of what I'm working on, so I wouldn't
> > > bother until it gets merged.
> > >
> > > Rather hacky, had less time than expected this morning:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commi=
t/?h=3Driscv-extensions-strings-supersets
> > > Clearly there's issues with looping to RISCV_ISA_MAX_SUPERSETS & I ju=
st
> > > repurposed Zicsr for the sake of testing something in the time I had.
> > >
> > > Evan, at a high level, does that look more elegant to you, or have I =
made
> > > things worse?
> > >
> >=20
> > I see what you're going for at least. It's unfortunate that when
> > someone bumps up RISCV_ISA_MAX_SUPERSETS it squares the whole array.
> > Another way to go might be to define the elements in a separate array,
> > like:
> >=20
> > unsigned int riscv_zks_exts[] =3D {
> >        RISCV_ISA_EXT_ZBKB,
> >        RISCV_ISA_EXT_ZBKC,
> >        ....
> > };
> >=20
> > then the macro entry looks like:
> >=20
> > SET_ISA_EXT_MAP_MULTI("zks", riscv_zks_exts),
> >=20
> > where the SET_ISA_EXT_MAP_MULTI() could use ARRAY_SIZE() to stash both
> > the pointer to the array and the number of elements.
>=20
> Yup, I like the sound of that. I like the variadic stuff as it'd not
> require defining a bunch of sub-arrays of supersets. I guess if it grows
> too badly, we can just dump it off into another file or w/e.

Also, I realised the other day that I had a bug in my series - I was using
"name" to read the property, not "property", which is what required the
extra "supersets" property.
The simplest thing to do actually seems to be to expand the "property"
member to an array of strings named "properties", rather than
introducing a "supersets" or similar.

Perhaps I am forgetting a good reason for why I had it split, but I'll
give it a whirl and see what I think...

Cheers,
Conor.


--JgFm48JGbULM0hnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKMH3wAKCRB4tDGHoIJi
0t+YAQCaAdQcKzF/7Wkkp8B3/aBhZXO+q4AFQeKrzR3oAw54bwD9G6x/Upc4snIB
z7KVmZAXIYejb0tOCXe33BZlBfBWUAg=
=UEKI
-----END PGP SIGNATURE-----

--JgFm48JGbULM0hnk--
