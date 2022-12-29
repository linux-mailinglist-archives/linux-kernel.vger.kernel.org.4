Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92603659140
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiL2Trw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2Tru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:47:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555D165B0;
        Thu, 29 Dec 2022 11:47:41 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.69]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7AAk-1olRgP2OJI-017Qzv; Thu, 29 Dec 2022 20:47:17 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 65DE03C0EF; Thu, 29 Dec 2022 20:47:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1672343235; bh=Ssiaq0UCBUNmKvQggRzr07i09RelaxqQve23Idug6co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXlsgr06qCbo9+gk/suhU5qopL+ga4NwZ81LwMJnPX+wYUfZcbEa5LIybtawNTbgV
         h2/FNwCYMdpA66rtLjs0XvreX9BmZZK/k//eyGXTVe3wsIP9cTLXCUjW3NsAHvNsGs
         ww3cjNmIel1aYIEpu3cCQerjkQfBwBg4gIC1yNr0=
Date:   Thu, 29 Dec 2022 20:47:15 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: unify cmd_dt_S_dtb and cmd_dt_S_dtbo
Message-ID: <Y63uw1HGiL5ZxJkk@fjasle.eu>
References: <20221229184650.1107463-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="guvpMswPTi1NG181"
Content-Disposition: inline
In-Reply-To: <20221229184650.1107463-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:Wa28HNUXKQWMjjrooBQKiPvM26xDjVz/antJMaKuE44Ev5z34pB
 OMc1ndLxOk8UuH0KitG4gPeLRmJDmtxLG/T0AYLPfN0I7hoFJOR9jFQNK2Q1Y6J6+TR8YOE
 XFH/Cewl2ljgVy/roT2vQvqlW3sE4L0Y4NeONoJVn5Hfcg13zGdqVuReTTao2UoYiAXvosT
 6fC3Iak6LGLMHNEcmOX8w==
UI-OutboundReport: notjunk:1;M01:P0:y6YlNRfDplk=;zWkJfjiPHSx0Jh+brLolqFM7she
 kK61b1bZy7auigq/7jQ/rTQWdYzLK3szJNC34koBuw1RKF7heUlgEvYgILapc4eEbFVlVjNh6
 f4JqTojEq1CTb7/USPGqOzRfVIEsyEUfydV8EQX4EZQSAg1rUP9K8afvpcD4RNOoX354xXsQm
 jEQOEa8icwMH/rv2nNtEiTSRNsOhRAxHiTJ3KrAFW8o6kMWtoP5d6KL9sLN4FtJ0g/6UkMhRF
 dAYrCRmc/lBVDyj2JerKEW0+HQXjVkdziGi1zfzYUq27uxljE15gdfv52vEAIxZ3C88BpShcw
 FdOrtJNdYOjI5b0Ug26nJ2dc/dB1ANwkpUra11d6OLWzpcm9iJftddfZG6EFo6MyEsasRWV/Z
 iySoOcYGa/oyjquBuN82CuUTWFgCueanwo85y7yedBHUNIb3UxEO44MdNFrKu45oNdWUf1Ojz
 oPGuJfOGhE0tKkPs3fCPUW5No972EWA1JWowmluYi0CXEnTAHg/fC1n4OQ3TWDTWuZocij2jR
 +RsN3ZEHmoHcQiykN1tY5CjNvrMQq36RdIfC5TZfZfbneRrid9rYrtung/GtKdcVpIE6HHmFH
 ivLhuXJVIo7Y/MwylZVg/vRm+mpBv/zAfs0ajTEfN5mL0X3i77cuzF/5lbbuhPjFz4Wzv7HFy
 E3kDH9ev/QnrILhWTUWq+2NjXJz6Dq8iVqXLS4QPYg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--guvpMswPTi1NG181
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 30, 2022 at 03:46:50AM +0900 Masahiro Yamada wrote:
> cmd_dt_S_dtb and cmd_dt_S_dtbo are almost the same; the only differnce
> is the prefix of the bein/end symbols. (__dtb vs __dtbo)

Two letters got lost: differ_e_nce, be_g_in.

>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.lib | 45 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 30 deletions(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 4a4a5f67c1a6..100a386fcd71 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -368,40 +368,25 @@ DTC_FLAGS +=3D $(DTC_FLAGS_$(basetarget))
>  DTC_FLAGS +=3D $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), =
-@)
> =20
>  # Generate an assembly file to wrap the output of the device tree compil=
er
> -quiet_cmd_dt_S_dtb=3D DTBS    $@
> -cmd_dt_S_dtb=3D						\
> -{							\
> -	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
> -	echo '.section .dtb.init.rodata,"a"';		\
> -	echo '.balign STRUCT_ALIGNMENT';		\
> -	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
> -	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
> -	echo '.incbin "$<" ';				\
> -	echo '__dtb_$(subst -,_,$(*F))_end:';		\
> -	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
> -	echo '.balign STRUCT_ALIGNMENT'; 		\
> -} > $@
> +quiet_cmd_wrap_S_dtb =3D WRAP    $@
> +      cmd_wrap_S_dtb =3D {								\
> +		symbase=3D__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));	\

As long as I know, '$(notdir $*)' should be equivalent to '$(*F)'.  Is it j=
ust
personal preference or is there some other reason for choosing one or the
other?

Nevertheless, with the typos fixed, it looks good to me:
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


--guvpMswPTi1NG181
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOt7sIACgkQB1IKcBYm
Emmvlg//ajMpzoFgEDR/6HTlwxYwKGBbhZkx2O0jz/2xXVW9eItzm1TslT6DWPR1
SV8llpZQUpUEbSu3BcNSbvUuhYLXJbUmzf87+xlB8tzzTLjp1TGWEOd8UZeF0Ieh
tRGeu4nqRE+3xQzf/7rH5K7fWhyMqE56o9JkDTMW1KjxFosAd2K0Qes0tSwwVMoN
FEgcCTVzI4al8sW0n98jb9G/eOtPbHkdpTKD1apUUm2KfLd6YXYZPR86ET0rnRNR
pTVafRInpPzTYqIy+yoBMsKJg1JZAGygmvPYsKrklhjwD4pwNK8vHSP8ckblHrHk
frOG4WApnuejJfayn9HgyEB4tMYzs0q+r9c4KHJQuLLHS0EixTMBHmSyDidX7dlA
jqLQCDJt9cTC4sjbuhCbGNOSgfENI7sPq/hpV0OrwkLCbj1dH3wnHqfC9G4D9aQ+
+qZfsoknJmPpMJx0aQjmkwRLD+u0q11ElG4WQAGhRxyFzPLZCiqgS0Ugsb1HntIC
4IjdhlVahId1+YNAjQqQvI9rHApWyFGLmwJMJsP6tT4WdwL4uh15CWXR/Fu5nIOh
jILTpzaYyfc/AabrEfAFamGSp0gYKaTURkaFPS55cfjZa/wiTMtDYr+s0NZXSyzJ
H3MQ6m9BRXQbuIMHmXsslj69SZh0dcqL9Rn2N9SsDwcoN94f29E=
=OugI
-----END PGP SIGNATURE-----

--guvpMswPTi1NG181--
