Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD51675F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjATU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATU5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:57:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F0881E1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B3DAB82A5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C9AC433D2;
        Fri, 20 Jan 2023 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674248262;
        bh=C/8n3R+rZQQb5j8MVi2jA+BbWjXT+dLd0rYVZPeipcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJVf4GMV3FEH+3FCWKviYjp9aqp4vjRp/WCvFOI4pZ4avotIRyNz91jSBYslri+o+
         vIkyFXeR9NpcXMOpjido+0fsgA/+8vJqJ0fjkN8dzB/KD8yz6n8MisthnzSffY72gV
         YtRks9E4xOuqSnYN+7MPNunDrgC9/Xet/NHnygpQjv67GfxT3LfJfAVzVsRT4SvIwh
         ANRmIFqALLPzhDhHb+yfUvvvLAJ7UjrVcRNVpxV+sKozLYYszKdLNt97IhgxERpU7V
         7aVYth5Su36+i5Y9eEh1fhYDC9rSRixI/KE8G66HQC/iSMsVWd/TIX+RIrpvacNO1l
         IMpTjFR8tzX1Q==
Date:   Fri, 20 Jan 2023 20:57:38 +0000
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
Message-ID: <Y8sAQqOo4DX7GwHN@spud>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
 <Y8pJ4y7FyBDQPqIT@wendy>
 <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com>
 <Y8r9GuyUAfJWYY5Z@spud>
 <Y8r+B3TZpeI32iTz@spud>
 <31646cc6-0ed7-89b8-06f9-aaa584ef8047@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="07XLlRV5jn2qywcu"
Content-Disposition: inline
In-Reply-To: <31646cc6-0ed7-89b8-06f9-aaa584ef8047@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--07XLlRV5jn2qywcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> > > index 67a7cb3503c3..17c5bfb384ad 100644
> > > --- a/drivers/clk/clk-k210.c
> > > +++ b/drivers/clk/clk-k210.c
> > > @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk=
_hw *hw,
> > >   	f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
> > >   	od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> > > -	return (u64)parent_rate * f / (r * od);
> > > +	return div_u64(parent_rate * f, r * od);
> >=20
> > Nope, that's wrong. I omitted the cast...
> >=20
> > 	return div_u64((u64)parent_rate * f, r * od);


> Ah that's a much better fix, shall I prepend this to the set and author y=
ou?

Uh, I'd rather check that it is a functional fix first!
I have the board, so I'll give it a go tomorrow and let you know.

Thanks,
Conor.


--07XLlRV5jn2qywcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8sAQgAKCRB4tDGHoIJi
0vhbAP0fMqrocwAcaEoLC5D7/DL60mv/eigNGPqrlfaLH6nDPgEAuDLfYrTXU6yJ
e6+P5rt6mKGagWq9oUkp+ecqsMSQCg0=
=gCFN
-----END PGP SIGNATURE-----

--07XLlRV5jn2qywcu--
