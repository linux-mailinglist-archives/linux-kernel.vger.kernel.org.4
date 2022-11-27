Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E39639E36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK0XWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0XWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:22:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700CFAEC;
        Sun, 27 Nov 2022 15:22:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL4Pd4dw9z4xG9;
        Mon, 28 Nov 2022 10:22:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669591334;
        bh=58e7Vvb/DCVs4QdqMoDmb9rL+9qi5haPdfe0RSo2QSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=crfenZuD7AMjFRbQIrdRwn6/ghJSNpPUAxMgDLH1qaM+OjcXEqorKQrz9GD31hJKU
         dVCwJN8Dmxzykr7umqSw2lO/GDZfpqNfvUQyHL6UW/Ap/p2QTCt5nBidYG7bVWEAZe
         mQW1NmDqtLMnyadKhWFieKRWLVjDZ5RnM4I663O4XDlV0FxzbWrBUL9OmhKr60nKoM
         H3HmAVuLGVHQkAQH9PJu8Yuh0TxEsB5BAfGCB3yJsRaVpilSjvvUKAw0eNrK/k41DQ
         TfqY+9O9JDf19d4C2ybttJTt/gw/vfm1wugLEYJ5qbTmL4/BiZDP1Nv7TGHXoxOimr
         ZZ/Ytb7/hh5Hw==
Date:   Mon, 28 Nov 2022 10:22:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20221128102212.39f90b0c@canb.auug.org.au>
In-Reply-To: <20221117122904.6759427e@canb.auug.org.au>
References: <20221117122904.6759427e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eXpd8rww./1Tda9N1IgNeCd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eXpd8rww./1Tda9N1IgNeCd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 17 Nov 2022 12:29:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the thermal tree got a conflict in:
>=20
>   drivers/thermal/thermal_sysfs.c
>=20
> between commit:
>=20
>   05eeee2b51b4 ("thermal/core: Protect sysfs accesses to thermal operatio=
ns with thermal zone mutex")
>=20
> from the pm tree and commits:
>=20
>   dca20ad5acb7 ("thermal/core: Add a generic thermal_zone_get_trip() func=
tion")
>   aed8b46d141c ("thermal/core: Add a generic thermal_zone_set_trip() func=
tion")
>=20
> from the thermal tree.
>=20
> This was just too painful to fix up, so please fix it yourselves or
> supply me with a resolution.
>=20
> I have dropped the thermal tree for today.

I am still not merging the thermal tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/eXpd8rww./1Tda9N1IgNeCd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOD8SQACgkQAVBC80lX
0GxhWAf1F4D35kB8Gvdfj5VYObNQppnbs6Y/VMZEIgqTaY4Iwe2SMqFfJFQBOYzY
eS9pp3PfZXd59r8jsHojzbxmhr7/gKKTgynFdOI0lYuiR6fgjN4uM71z5YbvTDB5
3G5le3T8029ntqNUrvvgbTI+S1De7PQaovBs14Am4zNwokJRqh3LMBBU+tlWNTww
xgXRj2b8n7utvKNR0NHZ6nRuyibw2CzPteUptkP/nYKLCmKmLbdn3X8t7G+DcqHa
CcbVBG4HsB+sOsXAeSmcgcp3Dli1F+bXfz0pL1wDq73NuvyeI+6Awc9O0+7kxT48
qsITUJCLlaxopU66/oFtOLeXWnyh
=8U97
-----END PGP SIGNATURE-----

--Sig_/eXpd8rww./1Tda9N1IgNeCd--
