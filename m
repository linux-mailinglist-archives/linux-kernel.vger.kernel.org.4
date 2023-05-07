Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CB6F9BDB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEGVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEGVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB055B4;
        Sun,  7 May 2023 14:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A52E361D14;
        Sun,  7 May 2023 21:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77952C433D2;
        Sun,  7 May 2023 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683494492;
        bh=clnO7AEkW4tSMcED4bSRmePf7YYp7OwuCNoz2foxxKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoJWOWKW7Fdf0O1FX8agKw7fkKTemhNTwr3aG9wWfxm/l16CXgqNTirCQeL/Nrq7S
         izsov4GvAy6nHzgpdWrmvzMTyiQFie/KIg9v7B6bnfn42EZhFBe3AhOYY5EOwiMug1
         xBjIMcEdZt2AErspoo4dWXY2FZ9Pu0D+HW2bQctnij5hyhgJZ/WLyNTIGmN8eAEx5D
         JRRI3uFV8xwrlpaQpdYsGWqpFN6tibBobyJt9k3Yzo0vakCmyu8bLoh7lHNy1jC65d
         LOuCK5FfwcwgfBTGe2KL2pi63kClSEOMferAVn9ain1j2NpkZgSUaz7GjdMEjzh+0P
         KWC1mSDH2rdwg==
Date:   Sun, 7 May 2023 22:21:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Message-ID: <20230507-woof-eldercare-f1323b10bde6@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q5vBHBzSkO7wX8v6"
Content-Disposition: inline
In-Reply-To: <20230507182304.2934-6-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q5vBHBzSkO7wX8v6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Mon, May 08, 2023 at 02:23:04AM +0800, Jisheng Zhang wrote:
> I would like to temporarily maintain the T-HEAD RISC-V SoC support.

What does "temporarily" mean?

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..e1e51accec4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18155,6 +18155,12 @@ T:	git https://git.kernel.org/pub/scm/linux/kern=
el/git/conor/linux.git/
>  F:	Documentation/devicetree/bindings/riscv/
>  F:	arch/riscv/boot/dts/
> =20
> +RISC-V THEAD SoC SUPPORT

Miniscule nit, "T-HEAD"?

Cheers,
Conor.

> +M:	Jisheng Zhang <jszhang@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	arch/riscv/boot/dts/thead/
> +
>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:	Jack Wang <jinpu.wang@ionos.com>
> --=20
> 2.40.0
>=20

--Q5vBHBzSkO7wX8v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgWVgAKCRB4tDGHoIJi
0tCdAP962Sjs0r22MIRXpkuEO+owajWsrPMAC5JdjNIjVoJT2AD+M53WjTZHRFzy
hsq80PfTplWqHa590DogB9gCVUc8Igk=
=KW65
-----END PGP SIGNATURE-----

--Q5vBHBzSkO7wX8v6--
