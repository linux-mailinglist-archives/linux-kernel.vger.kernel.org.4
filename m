Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE91744273
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjF3Sj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjF3Sji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:39:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79F4218
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98292617F3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D9C433C9;
        Fri, 30 Jun 2023 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688150369;
        bh=JbGXqFMUL4n0IXDBBVJY0wDuDAmp//TQtfDTWQWC1S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHWU2HJsleIlof4nj8Jezwrh779vlPlDUF/E19/a8nRNhPg0nyO1iycU0B1Vp1w3a
         eOneXB9PV9oAQkCaabaVFi+qWqKe0ASFeB4uKYXQDUU247VO40VWKzIRY4U4gVwgvg
         AEiFHBMkmd23uILQI7joEgd80EDaPtdRf5C7xFYwdK3ZMWCqqrSu6fN2Lg+LDM1iE+
         nn0J5LREsxGsH3T15/rhFJBpOoCDyIfYXmXTK0sDQh/sd7iF4OrquzvHP5HTCj/AFf
         h/LjnNc+0kBnODOcDqdf2puXiQP6TdQn1o8RSF8V8NK0IZcuePfWWchJMETCQfdVjf
         QPtHjSVng1oTA==
Date:   Fri, 30 Jun 2023 19:39:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        ajones@ventanamicro.com, sunilvl@ventanamicro.com,
        heiko.stuebner@vrull.eu, apatel@ventanamicro.com,
        evan@rivosinc.com, greentime.hu@sifive.com,
        leyfoon.tan@starfivetech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] riscv: Add BUG_ON() for no cpu nodes in devicetree
Message-ID: <20230630-blasphemy-tapestry-85755d24cbc3@spud>
References: <20230630105938.1377262-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pEfCFaD3T3JEELWO"
Content-Disposition: inline
In-Reply-To: <20230630105938.1377262-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pEfCFaD3T3JEELWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 06:59:38PM +0800, Song Shuai wrote:
> When only the ACPI tables are passed to kernel, the tiny devictree created
> by EFI Stub doesn't provide cpu nodes.
>=20
> While if append the "acpi=3Doff" to kernel cmdline to disable ACPI for ke=
rnel
> the BUG_ON() in of_parse_and_init_cpus() indicates there's no boot cpu
> found in the devicetree, not there're no cpu nodes in the devicetree.
>=20
> Add BUG_ON() in the first place of of_parse_and_init_cpus() to make it cl=
ear.
>=20
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>

I'm still not really convinced that this is needed - not finding the
boot CPU is a strong a hint as any that your DT is completely broken.
Especially if you intentionally go out of your way to disable ACPI on a
system that requires it to boot.

I'll leave it up to Palmer or whoever to determine whether this is a
valuable change. Code change itself much improved though, thanks - I'd
give an R-b/A-b other than that I question whether there's any value in
adding another BUG_ON(). You could've kept the part of the comment that
explained what the error meant though, but that's not a big deal.

Thanks,
Conor.

> ---
> Changes since V1:
> https://lore.kernel.org/linux-riscv/20230629105839.1160895-1-suagrfillet@=
gmail.com/
> - revise the commit-msg and move the BUG_ON into of_parse_and_init_cpus()=
 as Conor suggests
>=20
> ---
>  arch/riscv/kernel/smpboot.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 6ca2b5309aab..04d33afbdf55 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -147,6 +147,8 @@ static void __init of_parse_and_init_cpus(void)
>  	int cpuid =3D 1;
>  	int rc;
> =20
> +	BUG_ON(!of_get_next_cpu_node(NULL));
> +
>  	cpu_set_ops(0);
> =20
>  	for_each_of_cpu_node(dn) {
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--pEfCFaD3T3JEELWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8hXAAKCRB4tDGHoIJi
0n0fAQDjUvMTHOr4kKEEdu3GUgoPc+gt3psWvOlqlbuqIZRUbgEA/2rTzeDYuN95
qa96Tk5EV4N8Xwu5/juvgz8Ob3nQ5AA=
=Y0wJ
-----END PGP SIGNATURE-----

--pEfCFaD3T3JEELWO--
