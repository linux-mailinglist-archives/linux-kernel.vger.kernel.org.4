Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4462616282
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKBMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBMPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:15:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE9233B8;
        Wed,  2 Nov 2022 05:14:58 -0700 (PDT)
Received: from mercury (dyndsl-095-033-155-045.ewe-ip-backbone.de [95.33.155.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 554E76602946;
        Wed,  2 Nov 2022 12:14:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667391297;
        bh=DQY6HUX0xjeTCiBzx/CIesZNnO7eX2+GRyxpBBMMVQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLBwGCwt0j5WgmxYpiUrOTl+T4l7hLbh53WtHF+eBTqALkVq7tee2WbijfNd6wKgK
         CMkiV8kHjATe1pfM41hVJkEwBF9TUNNwytxdnpH314VX6cWA/ZdGtczsjH/UvoGIak
         niDNwhUccIZo356WRqJBAlxMFLIBPwIrr8//ULTCyzY4ZrotNX5UJ6elqqbluOCA/B
         jqnsIeorPZV7s9uyrxTJEfZItGHu441JpYrJ63lHaYgv0KuL0FArR1843CTfSIdSYd
         Av4CosQ09r4QOBLctB3+F5copuLXQXa9g80m0sfKjzDC7PEjmAPYj1o6LZqaoHzd6M
         eTwQ99oU85PoQ==
Received: by mercury (Postfix, from userid 1000)
        id 17BB81065D88; Wed,  2 Nov 2022 13:14:54 +0100 (CET)
Date:   Wed, 2 Nov 2022 13:14:54 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] kbuild: Add DTB_FILES variable for dtbs_check
Message-ID: <20221102121454.tp4d5uhkxytibsya@mercury.elektranox.org>
References: <20221101220304.65715-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3gksq3u5hwje4j3"
Content-Disposition: inline
In-Reply-To: <20221101220304.65715-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3gksq3u5hwje4j3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi N=EDcolas,

On Tue, Nov 01, 2022 at 06:03:03PM -0400, N=EDcolas F. R. A. Prado wrote:
> Currently running dtbs_check compiles and runs the DT checker on all
> enabled devicetrees against all dt-bindings. This can take a long time,
> and is an unnecessary burden when just validating a new devicetree or
> changes in an existing one, with the dt-bindings unchanged.
>=20
> Similarly to DT_SCHEMA_FILES for dt_binding_check, add a DTB_FILES
> variable that can be passed to the dtbs_check make command to restrict
> which devicetrees are validated.
>=20
> Signed-off-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
>=20
> ---
> Usage example:
> make dtbs_check DTB_FILES=3D'arch/arm64/boot/dts/mediatek/mt8192-asurada-=
spherion-r0.dtb arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb'

Please add the usage example to the 'Running checks' section in
Documentation/devicetree/bindings/writing-schema.rst

-- Sebastian

>  scripts/Makefile.lib | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ec391c6a2641..f3ac6d3632a2 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -418,9 +418,16 @@ DT_CHECKER_FLAGS ?=3D $(if $(DT_SCHEMA_FILES),-l $(D=
T_SCHEMA_FILES),-m)
>  DT_BINDING_DIR :=3D Documentation/devicetree/bindings
>  DT_TMP_SCHEMA :=3D $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> =20
> +ifeq ($(DTB_FILES),)
>  quiet_cmd_dtb =3D	DTC_CHK $@
>        cmd_dtb =3D	$(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(sr=
ctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
>  else
> +SHOULD_CHECK_DTB =3D $(filter $@,$(DTB_FILES))
> +
> +quiet_cmd_dtb =3D	$(if $(SHOULD_CHECK_DTB),DTC_CHK,DTC) $@
> +      cmd_dtb =3D	$(if $(SHOULD_CHECK_DTB), $(cmd_dtc) ; $(DT_CHECKER) $=
(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ |=
| true , $(cmd_dtc))
> +endif
> +else
>  quiet_cmd_dtb =3D $(quiet_cmd_dtc)
>        cmd_dtb =3D $(cmd_dtc)
>  endif
> --=20
> 2.38.1
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--h3gksq3u5hwje4j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNiXzMACgkQ2O7X88g7
+povlA/1HlNx4+VVtcWgux/1wR8lONh+KWSe/IiEQNHWsJsv43ufnRHGxul4s+yB
UMxLElgqkz/xqhrSazbIyqq+CnFqjKFBcZ5eU8dg4Z3xXPNQlsWfoHdQVPo7Mm5u
kxWHyBZu5tqGnxWni2JLKahITdeWRSv8jV3N0dGpU1IPTUDiqjgK/f6tBzIstCrv
V+XIbr6YrP8GJWL+sfpIqZzsSb4S8ItlcjMZD739HsVXH0dvkVojVozxCfHNunSb
2GteZtZnwuPJeVzNpNrEH7yCkFVjjve0QAkTto2yZJG8KcRdd12rJ2ICRZeOe2eb
ardvm6sj4uxc+BJWVt7sC7lu6buQFiL/GXwYQo6ibCNnl8zzSQe5CwD04wUVgFDl
9RXl0P1wbmXq6MmNO2DtbZuCLHIIOCyGhdEC4k+L2/mGoMaqbcKPB8nwJkP71LoT
Ov73w8TWQPrfu/8RiBV/3BvYfAnel5+y39j3eoqSSaEE10XwqmzLxLw8EcQHHA7R
zACXJHzqfyeRScvqxCT34+NYAdQcQ9aiZLxdpYM2Y6C2rgXiU9QV7a+QihxfW5Sr
98zxNcj32y51hI4vf67AwAhiKn1Bp/2Mdqce2IuZ72/xW8fVTMdv9RMBgKnRG140
UQZI6+5SQHnzxxUt17+sIrvIp5KTCgyZqrF7nUJn7730PVLQMQ==
=/hNc
-----END PGP SIGNATURE-----

--h3gksq3u5hwje4j3--
