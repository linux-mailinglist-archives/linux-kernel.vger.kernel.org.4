Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3244373E437
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjFZQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjFZQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194DE56;
        Mon, 26 Jun 2023 09:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15E760EE6;
        Mon, 26 Jun 2023 16:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD41C433C8;
        Mon, 26 Jun 2023 16:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687795713;
        bh=YtBxDgCSo52EnCezN1xP/GLTHgcQBQ/UTGIq1c7iU7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0cu9j7LYBWo5mX66CE2FbV41OSFcVyDdRYJkFWjFGvX1J6J8QUyCspssz5N0nwf5
         mslVgIguao52pzHAfLvCU0FkwJlMksclNp7nQcnSN+uoYw3WnslJOZjQ496MkISJrs
         wy/xylfHyjouzqpPt0pOEMR4rsomvo2Z1sY49fZiAPa+3BCMS6sbtiUnKq2OWkYqo8
         dXDZeeLXB1gPenQ5jECRySGGd0u/JdEWoZ3wzbtdu0k1PKDX0F87HG/cAByLK7z/mR
         KcIFOI/5ej+B7rbdlliOhOTLAXlb9TZ4l3yKQhwe8QVSptwIkTzjuELeK+ylxb/bcX
         +r5e2ulfWVpTg==
Date:   Mon, 26 Jun 2023 17:08:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/9] RISC-V: drop a needless check in print_isa_ext()
Message-ID: <20230626-jitters-spiral-68e941d0ad3f@spud>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-skydiver-frown-659b982a43ad@wendy>
 <20230626-67e571e6d9f02c28a09dab33@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UAbBwUXwcEUwpL43"
Content-Disposition: inline
In-Reply-To: <20230626-67e571e6d9f02c28a09dab33@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UAbBwUXwcEUwpL43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 05:19:08PM +0200, Andrew Jones wrote:
> On Mon, Jun 26, 2023 at 12:19:40PM +0100, Conor Dooley wrote:
> > isa_ext_arr cannot be empty, as some of the extensions within it are
> > always built into the kernel.
>=20
> This is only true since commit 07edc32779e3 ("RISC-V: always report
> presence of extensions formerly part of the base ISA"), right? If
> so, it might be nice to call that commit out in this commit message.

Per my last mail, where I commented on the origins of some of this code,
there were no multi-letter extensions when this code was first added.
When the first multi-letter ones did get added, it was Sscofpmf - that
doesn't have a Kconfig symbol to disable it, so I think this has been
redundant for a long time.

Apart from the ones I recently added, there's a fair few others that
are not gated & should always be present.
It's probably not clear from the comment, but this check is for whether
the kernel supports extensions, not whether the system it is running on
does. I guess I should expand on that in my commit message.

Thanks,
Conor.

> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >=20
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 742bb42e7e86..01f7e5c62997 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -233,10 +233,6 @@ static void print_isa_ext(struct seq_file *f)
> > =20
> >  	arr_sz =3D ARRAY_SIZE(isa_ext_arr) - 1;
> > =20
> > -	/* No extension support available */
> > -	if (arr_sz <=3D 0)
> > -		return;
> > -
> >  	for (i =3D 0; i <=3D arr_sz; i++) {
> >  		edata =3D &isa_ext_arr[i];
> >  		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
> > --=20
> > 2.40.1
> >
>=20
> Otherwise,
>=20
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>=20
> Thanks,
> drew

--UAbBwUXwcEUwpL43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJm3/AAKCRB4tDGHoIJi
0lvuAP9Wwmh7CDmYVwCrwm2QnFlvh2auna7EZPvP8MVubcvyMgD+JhXPQyKqs2g1
Myse48aBIwDuIggV5cCfMWtC7cfUJgY=
=KSGS
-----END PGP SIGNATURE-----

--UAbBwUXwcEUwpL43--
