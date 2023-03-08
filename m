Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F106B0FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCHRFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCHRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:05:35 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E293B0C7;
        Wed,  8 Mar 2023 09:05:21 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.228]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M9nlN-1pfhr81LW9-005pvL; Wed, 08 Mar 2023 17:56:39 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 539723C0EE; Wed,  8 Mar 2023 17:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1678294594; bh=7VWMwfXXv0YD8F9Lq169jrl7Zw+rwUp8ZVw3UymO9/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYbiKWo6Y8ak5EvFzXrG1NuTCXhu/a60TJTxgZs9YrPaR1e8c5ZXw5DzK1GbT12Xw
         YM9NbplWU5a7r74Uja4ihpCLdqYMEb8gRCwfH7ekhTfciiG127mIwo1f9G6xQdhePV
         UCuqPErU6ACUenJK676pFd71wl2TaBzPhflyG+4s=
Date:   Wed, 8 Mar 2023 17:56:34 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Andrew Davis <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
Message-ID: <ZAi+Qo1z2OkrqncP@fjasle.eu>
References: <20230306224752.8417-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230306224752.8417-1-afd@ti.com>
X-Provags-ID: V03:K1:8JHUdQfsgXsc3MmQdY06IDbmasMyiee9XYceo3T8y+M0stCLqA8
 aYBVjJbUetgHxd/i2J1+NXGK4EsAkTwKsTgjx7vBfYwEA19b6Y1qn1h5W7GsUszVJUoPdmU
 Gg8yV4wXbP+MlLdvRllTCwmu/rtT9Ge11JenKM4XnWN5H9WfyT79UD6P+Pi5M5jbnWQ8Gro
 0XWYuYCrYoE+a/6Xjo64A==
UI-OutboundReport: notjunk:1;M01:P0:dSGm0YPz3s8=;vb8e7fVSk4bNsFLEMS1MxlVrjtu
 dKMrBQpnbmkYN96hy1WPrebQrmRRorEm/h6LX3Kyu/TBjf2d+rB0ybyJv9+76hcHQXQ4PZmjz
 5k3ZHhhlT+hmOYT56I7f2TNErog8GIhwArJR55EpmG13ER9EIDDjXIKAZYkEnJGhBPqC6Sn6n
 JETssKxWt2xl4kxTcSSjHObHhMqzZOgDUMS9ixE4PkS7Ij99lpZ49EV24qPwP0IA+SyQfO4wW
 Bmof21Gx2Qo4At6+k8WNZqwpq3WeZcsA1KYuhH67F4WwXzoGf41WZeXe1/smo8DYelUKPO92L
 CtBxxe5m0pjHX7E0KmNa+Hg/h88DxzOU+TBD1dcRfd5zejGx4xUJwd7EVJzh8+m52MN6H6ZRU
 sbh7SzP/kcMv8Bo87CMB2bsYZ1T7imdkJ+1HooRIVi+P4ueTvqf9ezBa0TjyijuAF05Vd3pIg
 DKuDESFktiHK4AhsnqUM9obsqSthgRZsPMiSLCMrUuLdvhh8NquEJAECQlZnSeNkPOrMGT/Aj
 b2TM12jrwYBVdvyEdK3GqCoUYgBstlO7HX4FEitgMqe/cSivj8Yg2BJ30b04J2jpJJlYWFk1M
 Cb/y+fftPw9X8Ozwn9XuiNByn8GiLYcYHpGr3RxXUGvn7agZZxgt1ZUOspKS5cX0cM6ETPsld
 hfNSMOWe6GXsaa/iu7OEg35Ag0O1Awp2n8PfBTW5TZXmRcljKKLJMSX2hlgx1DgmmnH4o/ONP
 dkote5MuKaRe9sGm6+D5Yb3Kf2Bqezzvg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 04:47:52PM -0600 Andrew Davis wrote:
> As a follow up to the series allowing DTB overlays to built from .dtso
> files. Now that all overlays have been renamed, remove the ability to
> build from overlays from .dts files to prevent any files with the old
        ^^^^

The first "from" sounds superfluous to me.

Kind regards,
Nicolas
> name from accidental being added.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  scripts/Makefile.lib | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 100a386fcd71..68d0134bdbf9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -418,9 +418,6 @@ endif
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>  	$(call if_changed_dep,dtb)
> =20
> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> -	$(call if_changed_dep,dtc)
> -
>  $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>  	$(call if_changed_dep,dtc)
> =20
> --=20
> 2.39.2

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
