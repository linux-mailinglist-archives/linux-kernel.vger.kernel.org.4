Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51A06EAC33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDUOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjDUOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:00:40 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974DE55;
        Fri, 21 Apr 2023 07:00:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230421140035euoutp01aeab63ae47400b17d720d3ab377eadc2~X9-lHZIlH3268932689euoutp01S;
        Fri, 21 Apr 2023 14:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230421140035euoutp01aeab63ae47400b17d720d3ab377eadc2~X9-lHZIlH3268932689euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682085635;
        bh=OhoPMFQws91DiLhcXZx4Il6r6awi0qFvS5Nqb4RJzmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=go7ZOA0Z8TeSPltOwSzM5kMpWJD+Ir19zgnicqisB6VRJt330DVlOtvO/tKfX6n0q
         kmNHmKoyXgxQHz0ASXWmWLKujgf8xNE9BIZ2NC57SNYXEted023FOpO4z5EA9zFkAD
         fAxPkPCLDiL53DF/qtYmVyJ3UvTQ4BQTj752fJ30=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230421140035eucas1p21abdc35a7265a76ca865b237e819c859~X9-kmPjXu1534415344eucas1p2Y;
        Fri, 21 Apr 2023 14:00:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.3F.10014.30792446; Fri, 21
        Apr 2023 15:00:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230421140034eucas1p1f74c5d5dc69eea89ca520660b250d824~X9-kKRPBA2419324193eucas1p1i;
        Fri, 21 Apr 2023 14:00:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230421140034eusmtrp1f0e220e0ced47668de8b166c6bc3e7e0~X9-kJkwZH3172231722eusmtrp1K;
        Fri, 21 Apr 2023 14:00:34 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-cf-64429703a4c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.94.22108.20792446; Fri, 21
        Apr 2023 15:00:34 +0100 (BST)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230421140034eusmtip123d7a4f33c68f189c232735aa229d00c~X9-j7cZE22497524975eusmtip1G;
        Fri, 21 Apr 2023 14:00:34 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH] hwrng: Kconfig - Add HAS_IOMEM dependencies for
 exynos/meson/mtk/npcm
Date:   Fri, 21 Apr 2023 16:00:30 +0200
In-Reply-To: <ZD+oZ9DWiTxeo3RY@gondor.apana.org.au> (Herbert Xu's message of
        "Wed, 19 Apr 2023 16:37:59 +0800")
Message-ID: <oypijdv8hp49oh.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRTG895723vbUXIpc5zUfRiyGQeuw6DhojAdEHMXjeL8xyxmrsKV
        sUE721WZibohlGbARoYLLfsoBVPoFgplBKVCIQ2CzdDyFVbmBNaxMSoOSNdgAYfU2yX773ee
        5zzve86bl8KleqGMylee5NRKRUG8UEx09Ic8e/CajNwkl4NiQjXnMMbQPY0z5f6tzLyvD2dC
        Ze0YU3dpEzM1GcKYUcdlIWPwODHG/51PyPTXuwlmofM2YlzWMYwZvNIqYBy9Z0hmpd2PmO5e
        O8HoVizCt6TsgreUZDtr/yTZjt5dbF2blr1fVU2yDV1zGHtnvEvI3vjhW/bhDSNiS9w9BBto
        25696ZA4LZcryP+CU+/dd0R81DR4iTgR3FHkuFhJnEZ3ZWeRiAL6VTAM6MizSExJ6SYEU84R
        nC8eI/j5brmALwIIgo5V4dOI1WKOGI0IJkJDBF88RHDBfG/DoSghLYfm5o/Cgc30y2Cda/g/
        gNN2AbTMmrCwEUt/DFNBPRnuJ+hdcMYsCcsi+nOw/NonCLOETgGDdYoM83N0Kqw9WCJ5PQbc
        xhkizDhdCEbPPAqfD7RfBBPj65FJsyDw5FGEY8E/0E7yvBVuVlcQfKAMQfEYvw7QVQgC+mKM
        73oD7vy+Eknvhx63BQ9PCnQ0eP+O4W+OhgsdNRFZAnqdlO/eCbbzXQTPMqj0NyGeWbCt2iLv
        q0NQOliGV6EXap9ZqPaZhWo3jsXp3dDi2MvLiWAx/4XznA422wJRhwTXUByn1RTmcZpkJfel
        XKMo1GiVefIcVWEb2vigN58MBH9CTf4luQthFHKhnRthX+v1ISQjlColF79ZwmozcqWSXMWp
        rzi16hO1toDTuNDzFBEfJ0lMd+dI6TzFSe44x53g1E9djBLJTmMVr68k9bY057y0252WVu8Z
        P5flHA7mJ2xP+qbErFkWpWQ23zsVKzdS0bf2rA51pm6x12cFz6exF/vVk4dv7T84O/+m94PD
        P/auDy++m2j6Z7Aicy0Q59uSt7Y6udjYl+G8/l7PTJQpe7S67rM46cxtaZS35JelKPERe2Ax
        +oBKt/z2WAM9n/laf9GOD0t0oz3W8uoR77VU54ip1dlFCxJmj/mGWMcyOVfWWtme/XX6vrYK
        8v1i7diDbdrjszpb8nSy59D9xu7R8qvrsqt/xGCXf+O+nxhWkQc/TdfXo23L7/yLHQvFLDof
        O5VsQpGl5sqjmWnyRaXAZHAak1NKpfbYeEJzVPFKAq7WKP4Df0RUWBsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7pM051SDM6e0Lb4Ob2PyWLG3gfM
        Ft2vZCzePDrCbPGzfQuTxYLZ3Bb37/1ksri8aw6bxYzz+5gsXjU/YrM4tugki8X7nbcYLQ6t
        vMJkcWbuBlaLXQca2S1+bXnFaLH3wEYWi7Zfy9gchDze32hl99g56y67x7YDqh4LNpV6PJ0w
        md1j8Z6XTB53ru1h89i8pN7jxeaZjB4tJ/ezeHzeJBfAHaVnU5RfWpKqkJFfXGKrFG1oYaRn
        aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMf/MbJaCr/IVu6b2sjQwPpTqYuTkkBAw
        kVi5bCFrFyMXh5DAUkaJm+cWMXUxcgAlpCRWzk2HqBGW+HOtiw3EFhJ4xiixr7EWpIRNQE9i
        7doIkLCIgI7EypeLwcYwC2xnlZgyeSsLSEJYIEbi/tcOdoheI4njX6eygvSyCKhKNC7kBQlz
        ChRKLDtxhBXE5hUwl5ix8j5YuaiApcSfZx/ZIeKCEidnPgEbySyQLfF19XPmCYwCs5CkZiFJ
        zQLawCygKbF+lz5EWFti2cLXzBC2rcS6de9ZFjCyrmIUSS0tzk3PLTbUK07MLS7NS9dLzs/d
        xAiM+m3Hfm7ewTjv1Ue9Q4xMHIyHGFWAOh9tWH2BUYolLz8vVUmE16PUKUWINyWxsiq1KD++
        qDQntfgQoynQZxOZpUST84HpKK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUI
        po+Jg1OqgSll4svoeLdm3lWepwx1zn5uYtiS96Wfs9bU6W/d1GUODQWnJjsFzLVbe/TFx5Uh
        L+9mBpvfEzH986iLS1To7x+tM0dk9U9V8ZsIXa7rk+hjOv5vtW3Ps6O2QpmX4nqWJ5Z+O2po
        kaox8Uj3s5XBnTq3tpzYMcvUWMBYX4vzS8din7lxe3NLbhYHatz482Zr+EPx3CWObyNms6Yu
        M+k4+JWt0oK3jrc6fL+YlFTrlyBBOTOXrw7HmCNmLDH4nBRdrWx7++lPiy3XDZz2CMxOYlSQ
        a/155/reqLlfH+x1Cil0XMXGZWzmO83knJry9KdGdUX1WrOW+9x0mbT+Bo8FU9KPPx+2f1h8
        1ZLt0ueguUosxRmJhlrMRcWJAO5g292PAwAA
X-CMS-MailID: 20230421140034eucas1p1f74c5d5dc69eea89ca520660b250d824
X-Msg-Generator: CA
X-RootMTR: 20230421140034eucas1p1f74c5d5dc69eea89ca520660b250d824
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230421140034eucas1p1f74c5d5dc69eea89ca520660b250d824
References: <ZD+oZ9DWiTxeo3RY@gondor.apana.org.au>
        <CGME20230421140034eucas1p1f74c5d5dc69eea89ca520660b250d824@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2023-04-19 =C5=9Bro 16:37>, when Herbert Xu wrote:
> On Wed, Apr 19, 2023 at 11:43:42AM +0800, kernel test robot wrote:
>>
>>    s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exy=
nos_trng_probe':
>>    exynos-trng.c:(.text+0x39e): undefined reference to `devm_platform_io=
remap_resource'
>>    s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson=
_rng_probe':
>>    meson-rng.c:(.text+0x10a): undefined reference to `devm_platform_iore=
map_resource'
>>    s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng=
_probe':
>>    mtk-rng.c:(.text+0x40e): undefined reference to `devm_platform_iorema=
p_resource'
>>    s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_r=
ng_probe':
>>    npcm-rng.c:(.text+0x2ca): undefined reference to `devm_platform_iorem=
ap_resource'
>
> OK, this patch should fix these ones at least:
>
> ---8<---
> Add missing dependencies on HAS_IOMEM as otherwise they will trigger
> failed builds with COMPILE_TEST enabled.
>
> Also add dependencies on OF where appropriate.
>
> Change the default so that these drivers are not enabled just because
> COMPILE_TEST is turned on.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304191106.swKbBeDh-lkp@int=
el.com/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>

Acked-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kcon=
fig
> index ae508e96cfc2..f3146470ce88 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -400,9 +400,9 @@ config HW_RANDOM_POLARFIRE_SOC
>=20=20
>  config HW_RANDOM_MESON
>  	tristate "Amlogic Meson Random Number Generator support"
> -	depends on HW_RANDOM
>  	depends on ARCH_MESON || COMPILE_TEST
> -	default y
> +	depends on HAS_IOMEM && OF
> +	default HW_RANDOM if ARCH_MESON
>  	help
>  	  This driver provides kernel-side support for the Random Number
>  	  Generator hardware found on Amlogic Meson SoCs.
> @@ -427,9 +427,9 @@ config HW_RANDOM_CAVIUM
>=20=20
>  config HW_RANDOM_MTK
>  	tristate "Mediatek Random Number Generator support"
> -	depends on HW_RANDOM
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	default y
> +	depends on HAS_IOMEM && OF
> +	default HW_RANDOM if ARCH_MEDIATEK
>  	help
>  	  This driver provides kernel-side support for the Random Number
>  	  Generator hardware found on Mediatek SoCs.
> @@ -456,7 +456,8 @@ config HW_RANDOM_S390
>  config HW_RANDOM_EXYNOS
>  	tristate "Samsung Exynos True Random Number Generator support"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
> -	default HW_RANDOM
> +	depends on HAS_IOMEM
> +	default HW_RANDOM if ARCH_EXYNOS
>  	help
>  	  This driver provides support for the True Random Number
>  	  Generator available in Exynos SoCs.
> @@ -483,7 +484,8 @@ config HW_RANDOM_OPTEE
>  config HW_RANDOM_NPCM
>  	tristate "NPCM Random Number Generator support"
>  	depends on ARCH_NPCM || COMPILE_TEST
> -	default HW_RANDOM
> +	depends on HAS_IOMEM
> +	default HW_RANDOM if ARCH_NPCM
>  	help
>  	  This driver provides support for the Random Number
>  	  Generator hardware available in Nuvoton NPCM SoCs.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmRClv4ACgkQsK4enJil
gBDEswf7BMFGz7sr6Hns4MWdMpjlwix4EMNruEIgZGpf/j0cw5+SZJoHq9jbZf3v
qsHL0KO35EJKwGDg/1IeGvhmDVs2H3JaoqrWFcVefd818IyYdYL2J0xJuj5vrkHV
mQxneDpdsLj/L0UHizakKVTAHmR6LvMFU9U+jvgTFTGIRyURJoZaXIrtDJCcu10I
2KCLqggMBlkNp1Pqqc+OhDVlL1lHeOwS9dCt9XkvFANKYDdGoDTIbWb5ripx4zrJ
7CI2ML8j0leEwNwaporniHAtIRyU81UQtdTKILr/GUfmtP340WGqgvt+TwqcGZ38
mnj8IDtWJNNo5MIuDJR5XiDJJMTnww==
=F7gO
-----END PGP SIGNATURE-----
--=-=-=--
