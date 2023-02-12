Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87969396A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBLSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:45:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77440DC;
        Sun, 12 Feb 2023 10:45:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 623B8B80C2C;
        Sun, 12 Feb 2023 18:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9054C433D2;
        Sun, 12 Feb 2023 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676227537;
        bh=tnPPngd7rmN7Pd2Bo0dYoAqjVVSybHD1OGhV6WT90xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RM9IOqTjeWw0/KN0HrtxeHjqXD2NWfOZcl1FbykdM0ov+L7jSzNVuXivB0pxBFMdl
         SvY5UyIxpX7L63OFiOLV4FEDR/8jJDWOrWAR3mVEQJGNkyZIbR7QqG1p0MtrjCgR3F
         utGyi3uRel5KKLb6j1kR8aRnYNMBPbuB7HWEG0y4aTDvTazvFSDjJWYsIA9ukt+SUV
         UbJtrHYd0uwiwoN3wR796y5TS+AFiXdkdUnLhkVkTOn8ilNdqt2nAkQVMiBca549lz
         ZUkwLownwlITqHxmjbMOI4cr4neYYWkuPdC9quVnQB2RZiPMBpn4HN+r4QBfqZsQ2s
         olHbyibjmDLIg==
Date:   Sun, 12 Feb 2023 18:45:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v5 00/13] riscv: improve boot time isa extensions handling
Message-ID: <Y+kzy1y3Z3j3Ohs9@spud>
References: <20230128172856.3814-1-jszhang@kernel.org>
 <20230212154333.GA3760469@roeck-us.net>
 <Y+kM//nuDv29Z9qJ@spud>
 <Y+kU9nDBTttZRLLq@spud>
 <Y+kcgcncQO/2DNLo@spud>
 <Y+kqi8bQE+8hLfOF@spud>
 <a059a815-dcb0-c575-b5a4-f9433e268e9b@roeck-us.net>
 <Y+kt04c1iRlzUNLA@spud>
 <48d2ac96-abdd-23bc-b167-08dc2c1a1dbe@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UYsJLzonAkMi3tM1"
Content-Disposition: inline
In-Reply-To: <48d2ac96-abdd-23bc-b167-08dc2c1a1dbe@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UYsJLzonAkMi3tM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2023 at 10:38:26AM -0800, Guenter Roeck wrote:
> On 2/12/23 10:20, Conor Dooley wrote:
> > On Sun, Feb 12, 2023 at 10:14:13AM -0800, Guenter Roeck wrote:
> > > On 2/12/23 10:06, Conor Dooley wrote:
> > > > On Sun, Feb 12, 2023 at 05:06:09PM +0000, Conor Dooley wrote:
> > > > > On Sun, Feb 12, 2023 at 04:33:58PM +0000, Conor Dooley wrote:
> > > > > > On Sun, Feb 12, 2023 at 03:59:59PM +0000, Conor Dooley wrote:
> > > > >=20
> > > > > So as not to lead anyone up the garden path, let me correct mysel=
f:
> > > > >=20
> > > > > > Hmm, so this appears to be us attempting to patch in alternativ=
es where
> > > > > > none actually exists - seemingly F & D.
> > > > >=20
> > > > > And of course that's not true, riscv_has_extension_likely() now u=
ses
> > > > > alternatives as of:
> > > > > bdda5d554e43 ("riscv: introduce riscv_has_extension_[un]likely()")
> > > > >=20
> > > > >   From a quick look, it just happens that the only users are F & =
D.
> > > > >=20
> > > >=20
> > > > Samuel pointed out that this is a lockdep splat on irc.
> > > > There's a patch on the list that removes the lockdep annotation
> > > > entirely:
> > > > https://patchwork.kernel.org/project/linux-riscv/patch/202302021141=
16.3695793-1-changbin.du@huawei.com/
> > > >=20
> > > > So ye, no surprises that it was config based!
> > > >=20
> > > > Palmer posted a "better" fix for that lockdep warning a while ago:
> > > > https://lore.kernel.org/all/20220322022331.32136-1-palmer@rivosinc.=
com/
> > > >=20
> > > > So we'd have to duplicate/reuse that for cpufeature/errata patching.
> > > >=20
> > > >=20
> > >=20
> > > This does not (only) happen in stop_machine().
> >=20
> > Yah, sorry I meant that it's the same lockdep splat as is being
> > addressed there.
> > The first patch deletes the lockdep stuff entirely, so removes the
> > splat. I was thinking that we'd need to take Palmer's (IMO better)
> > patch and do the same thing for patching alternatives, but I figure we
> > can just take the text_mutex itself for alternatives & not have to
> > dance around the lock.
> >=20
> > I'll go do that I suppose!
>=20
> Thanks a lot for the clarification. That sounds like the backtrace
> can be largely ignored.

Yeah, sorry that I phrased that confusingly in the first place.

> However, I still see that the patch series
> results in boot hangs with the sifive_u qemu emulation, where
> the log ends with "Oops - illegal instruction". Is that problem
> being addressed as well ?

Hmm, if it died on the last commit in this series, then I am not sure.
If you meant with riscv/for-next or linux-next that's fixed by a patch
=66rom Samuel:
https://patchwork.kernel.org/project/linux-riscv/patch/20230212021534.59121=
-3-samuel@sholland.org/

Cheers,
Conor.


--UYsJLzonAkMi3tM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+kzywAKCRB4tDGHoIJi
0gBGAP4k1y38xuLeW0feO86J6WPfcRHKXkpqSNJOsp3tA5EFmgD/ZOgAcxE1Wu5k
jMaQUwn6jGt4r3URuDAAXxYfbvNYiwc=
=wpnv
-----END PGP SIGNATURE-----

--UYsJLzonAkMi3tM1--
