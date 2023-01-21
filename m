Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC616766FA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjAUPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAUPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:00:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783541F91D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FC860A24
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 15:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BBEC433D2;
        Sat, 21 Jan 2023 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674313249;
        bh=xw2Z/7VGgf6MRizE7aJiA1LL99jH3my9WFA793dqn9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgzGqOv038rBIyhf+03U/zbPgYEf5M/2qfzuF7XpKSnCGXy/OGJ4WC5wEcUmAoDEW
         pV4Tus09/AATTuLzuSAxFeYjeIhaHOs8ZuVyw0jalt8uUilJJxoWpRbiiQALeMbqWT
         3kNXzEoxsxC9Pbl0I1jZbyJk2XVPwCcrkbojYopxetw+h9kK9Q8pJn5+9a95jukbBm
         pDeBtWqHAEYuRiqd7Wv2AIEtVPOaBW7NAX+lOo2aa1etDjs47DFVsQeKDgh/xTsCyJ
         KLCCsdcQBquFq5Z0bD3l43OhHIC4JJ6GNwL18Lcfi77CHWCMmqOCEqIAvL6D2v/gE0
         mA5kY9WLUNk/A==
Date:   Sat, 21 Jan 2023 15:00:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Message-ID: <Y8v+HOkrT5RF0Ysn@spud>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
 <Y8pJ4y7FyBDQPqIT@wendy>
 <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com>
 <Y8r9GuyUAfJWYY5Z@spud>
 <Y8r+B3TZpeI32iTz@spud>
 <31646cc6-0ed7-89b8-06f9-aaa584ef8047@gmail.com>
 <Y8sAQqOo4DX7GwHN@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fRlkre/rkur7aMjh"
Content-Disposition: inline
In-Reply-To: <Y8sAQqOo4DX7GwHN@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fRlkre/rkur7aMjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 08:57:38PM +0000, Conor Dooley wrote:
> > > > diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> > > > index 67a7cb3503c3..17c5bfb384ad 100644
> > > > --- a/drivers/clk/clk-k210.c
> > > > +++ b/drivers/clk/clk-k210.c
> > > > @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct c=
lk_hw *hw,
> > > >   	f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
> > > >   	od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> > > > -	return (u64)parent_rate * f / (r * od);
> > > > +	return div_u64(parent_rate * f, r * od);
> > >=20
> > > Nope, that's wrong. I omitted the cast...
> > >=20
> > > 	return div_u64((u64)parent_rate * f, r * od);
>=20
>=20
> > Ah that's a much better fix, shall I prepend this to the set and author=
 you?
>=20
> Uh, I'd rather check that it is a functional fix first!
> I have the board, so I'll give it a go tomorrow and let you know.

Gave it a go, board still works with revised version of this change in
place.

Thanks,
Conor.


--fRlkre/rkur7aMjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8v+HAAKCRB4tDGHoIJi
0m6AAQCZuIQY4wCVK265zGzoLEP15W5Ue5T/PLw4PH1FspFktQEAsy6GmdgtX5pe
US6Z4LVXtfXIev97q8Yz8HvU6BeFKwM=
=YZ5v
-----END PGP SIGNATURE-----

--fRlkre/rkur7aMjh--
