Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F269D73C198
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFWU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjFWU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:56:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7801BF2;
        Fri, 23 Jun 2023 13:55:52 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.205]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNbtF-1qS1JM46Dz-00P4i8; Fri, 23 Jun 2023 22:55:12 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F006F3EA3D; Fri, 23 Jun 2023 22:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1687553709; bh=/zs8pKuVXLztJtcOtsm1AgBqJ6bbce3gdJiuX7Qc3AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opQXZo2ktEW/Lu2ISSW6iZtO1fBrMM06STnPzvVkUVmLL06YnLwkiSymhlyL1jWG2
         EC8rc3i6WOtIUw6pmlt3BkNTR6soVW0FJEeD/5yKIDdlFGxdS3IWQetFxL5hycxVjz
         5WR5mrZ6KbfucrnGZ8VzKltEzmh1iEEOvsV8H+4k=
Date:   Fri, 23 Jun 2023 22:55:08 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] kbuild: builddeb: always make modules_install, to
 install modules.builtin*
Message-ID: <ZJYGrC+3l50kcNkl@fjasle.eu>
References: <20230615111743.883891-1-masahiroy@kernel.org>
 <f7e9220aad3d98bd174f7dcbd68031e1e15ea968.1687461492.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eTEBsKav2BLy7Olg"
Content-Disposition: inline
In-Reply-To: <f7e9220aad3d98bd174f7dcbd68031e1e15ea968.1687461492.git.josh@joshtriplett.org>
X-Provags-ID: V03:K1:WrZ7MfH0d46/XjgZv+BwCHXBbU2AcHmiUYZs4bF6vyW19YODJEv
 OcnU/WZ5uUUWaWuylYMZZwAltu23VKq5SOKaI+10L09ys02CPeCIUVqqeJV+Fo1R6n7Fp0V
 x7IbQadZN3R4OrYYQ9Zzhhyoddc+4IkURg/F1vy4fzyWesEfNgvDMZzSeJizm0K1g72tNvw
 GP28NbRcj3gWqNj9S/BXg==
UI-OutboundReport: notjunk:1;M01:P0:Wo85uib8gV4=;bMFL52HzeQnR0BtrNo8OniHR1h5
 Xi/7hIGw8znmM1qv7FnUH4CauBtaohBXwcGX3mrY4xQoU+4zeYZAFMl2snrBv7sYqLmMwdIgn
 z659cZtIs6w6x0WlmNWf3B5OgFBh/wfeAm2Ld0jIW+e/twNtxv0yj7ldHrtDYRGZzM7JFVI+H
 tNMZPk8T/mtGVfy1a1K1Jaql1Hwd8jgG8twPuwZK1wgAp/3ZCPNJXcs2X6iaJwiYWBc+tcfFD
 J3BK4MzqXsMKnFUIkI/bIYVtKxsZyMXsDKFzk1xBmA+y6b/A4/UcCNBF8ImU3LtTX1BJQu1uy
 GtdHwStCTWSnFM1MCedt88BYMrQYeukg/hXsW48xK2/sZlJaOkBuu0uo8wcsGICYl0VxfUcFX
 yzlrfeGHBHDGK8mJ9ThA2DYkLwbLXXdHNMgroYYNs/WDdcXXcygUdkYXOWakFIRCfbIJvIDre
 7NpQhFTTx+2wbL0PZhfgxRToivjvs1L4Fyabe71MSGeukMpk92ywuoZsjpqm1hEPzv/kwUjCB
 /TqA8tYb1d71a2X4nu2HqfxXVO/GN6z0VWJNpA0CUew4hGHCZqi7Cj926IrTHtdzfHdu+dFk5
 yrs7A811f9cFMsgE2AhfgSZycIwm0apEr5PwaTUaQcwXfx3leos6bhqwsZ+EqZC9ZALRv9sYN
 vtvs+ZfXAId3rGYSqFjyVxqj9ctuIRmgHLKnOh2ROg==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eTEBsKav2BLy7Olg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 12:19:53PM -0700 Josh Triplett wrote:
> Even for a non-modular kernel, the kernel builds modules.builtin and
> modules.builtin.modinfo, with information about the built-in modules.
> Tools such as initramfs-tools need these files to build a working
> initramfs on some systems, such as those requiring firmware.
>=20
> Now that `make modules_install` works even in non-modular kernels and
> installs these files, unconditionally invoke it when building a Debian
> package.
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---

thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


> This patch depends on
> https://lore.kernel.org/lkml/20230615111743.883891-1-masahiroy@kernel.org/
>=20
>  scripts/package/builddeb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 252faaa5561c..f500e3910158 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -62,8 +62,8 @@ install_linux_image () {
>  		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH=3D"${pdir}/usr/lib/li=
nux-image-${KERNELRELEASE}" dtbs_install
>  	fi
> =20
> +	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH=3D"${pdir}" modules_ins=
tall
>  	if is_enabled CONFIG_MODULES; then
> -		${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH=3D"${pdir}" modules_in=
stall
>  		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
>  		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
>  		if [ "${SRCARCH}" =3D um ] ; then
> --=20
> 2.40.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--eTEBsKav2BLy7Olg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSWBqwACgkQB1IKcBYm
EmnWfRAAtP85RutI/lZit0ETIZsCYS4olhIri+eUsdAAXiMeRmh4QcDhuyEWgppK
2J0oI1XOQY45GRmID28iGIPjhIG3/bd+TWnIC4tDc3/z+DWpmWIc8O3ICuqs5luJ
MiWgPH6QVvGSl3WE+i48X8kP8AxizXeBP+SSxQuQsEMqfi8fCPm/l2wMReOTaKJ6
3VMeDqvC8IPdTSOgyO4TrdShwsTRBsMUDzkZ8kYk9ElbgdO6DX8Pz4YENn473aaQ
JgYlqgHkXDmUAcud+CA49Lsp+GDIV+SQPmcZTCuSKEvWkPBjOMM1/YoErUKeaTht
DehzO3DqlWN+6yTzHUIE94DTQ/rBJ9qqir9psg/jE6Ud22QlOFc7Wp3FP47qNTkm
lohdvXWQfRvkOAn9zb0IehTwHtW2zJ3I4+B1gN0kFrUyWA8xqHpzBIC17iJhHyJe
XeTwnGAO51su8fqpESiISeGGt+3VTSpJJt39lGlAgsRFf8H1ETUF3vyTncM+vZos
8/mgs7mCgN6kaiJYiTaMNgEctFUG6gG9t0SFJP5spGrz3pvaJwBv2DofQzahFSLk
E5GAtaBuHf1pMVeR8BzwkCfFN7ajF/3xbm3fZbIbnLYFfJ5Sfw29VkUrPI8zyseg
ne8e7LwfsP369WZYp64JMtEFnZfxkwxSaJa6csH4EYHUl1sBtuY=
=xiGO
-----END PGP SIGNATURE-----

--eTEBsKav2BLy7Olg--
