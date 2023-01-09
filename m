Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C05662DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjAISEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbjAISEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:04:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C7B70;
        Mon,  9 Jan 2023 10:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 639F6B80EBB;
        Mon,  9 Jan 2023 18:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA426C433EF;
        Mon,  9 Jan 2023 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673287353;
        bh=yf5mr/XUHMGP26V3S8whUabC4LgE+gULhklh2fekhqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiKWcPvN2EP9szwQsYz8wiktbRFB/Vvb73jkesKsu/8tsSCKdOBPIdAzDuujQtsW3
         qWxpR1JnsqQSlsveciFG6w6eRqIjuoINTlKiAQaWslGgzSKYhFcdqsrk3ge8JB72IU
         LbM51uM+GdmIaJGCmYJFjZTirYfdv21Pw7TfddEMK3tR5E2PzJ9ZhL2+s1pB/iZgYW
         W9mISuZ8B783dusHCq2VfeGxmhr/ZCyJ8yM2+Y4WJsbgDUsao+E3P2sXRI0ZNlkQn3
         ElHr5mQMgNs4dw0VsjuCwKLv28kSl+Q5rIp7Q/0AZE9SVPWCFHkumYINasEetSqL2Z
         XSKMJkdlsT5Lg==
Date:   Mon, 9 Jan 2023 18:02:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for
 VisionFive 2
Message-ID: <Y7xWtFZO/Y7GaYRQ@spud>
References: <20230109165249.110279-1-jiajie.ho@starfivetech.com>
 <20230109165249.110279-4-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JVAKPLOcMe7iVNga"
Content-Disposition: inline
In-Reply-To: <20230109165249.110279-4-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JVAKPLOcMe7iVNga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

On Tue, Jan 10, 2023 at 12:52:49AM +0800, Jia Jie Ho wrote:
> Adding StarFive TRNG controller node to VisionFive 2 SoC.
>=20
> Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 4ac159d79d66..3c29e0bc6246 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -455,5 +455,15 @@ uart5: serial@12020000 {
>  			reg-shift =3D <2>;
>  			status =3D "disabled";
>  		};
> +
> +		rng: rng@1600c000 {
> +			compatible =3D "starfive,jh7110-trng";
> +			reg =3D <0x0 0x1600C000 0x0 0x4000>;
> +			clocks =3D <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;

Which clock source is this? I see syscrg and aoncrg in the v3
devicetree:
https://lore.kernel.org/linux-riscv/20221220011247.35560-7-hal.feng@starfiv=
etech.com/

Have a missed a patchset which adds support for this particular clock
controller? At the very least, I don't think one has reached the
linux-riscv mailing list.
The clock driver patchset only has aoncrg & syscrg:
https://lore.kernel.org/linux-riscv/20221220005054.34518-1-hal.feng@starfiv=
etech.com/


> +			clock-names =3D "hclk", "ahb";
> +			resets =3D <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> +			interrupts =3D <30>;
> +		};
>  	};
>  };

Thanks,
Conor.


--JVAKPLOcMe7iVNga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7xWtAAKCRB4tDGHoIJi
0uNDAP9jdeHkVB4dTr5svGhfs6/VBx1ob6hYWtNCnd0OmytrFQEA/69ADWZjFeQG
DA1v1P6YpTm6kYvzkrt0UNumEQ3suAo=
=V4up
-----END PGP SIGNATURE-----

--JVAKPLOcMe7iVNga--
