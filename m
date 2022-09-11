Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A75B5867
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiILK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiILK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85180371A1;
        Mon, 12 Sep 2022 03:28:41 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D55AD6601FE6;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978518;
        bh=ReP/C2j0Kn0XYRx1xFBqc3HIG8waizhK8qxy6tw9V4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBPkqjZ3g0PgsqyAPXghkf+34aBMhr4Uobp2ML+IbGuUZoCHGTwjg/4tfqbOXs1Xc
         8Rn01F/UUoqwN0O96o1E0yO2EgivpxtKM/M1U2PayHqYcBczks5tXmYXmb4vmbZkrT
         aRH8PilYIQIgOtzHCHwR8bGYbtNUUgImO5hFOLc0rkG9whJPFWKMetont1Y3d7Kxu6
         kYCLWOtbjQ0GKQqiun3Ec20m+ALvtERtkxu/JaXo5cP0fsWGZvvJzVGoxnh3kHaKT2
         4uUoAVwtgQbXwLK81fCkYwhMfq8YV2/63CeFzwyjOet/Z908+JlHiaytr+YzRYyPuZ
         pqa13IsJCHjIw==
Received: by mercury (Postfix, from userid 1000)
        id 294851063357; Sun, 11 Sep 2022 14:19:25 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:19:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/2] power: supply: adp5061: some fixes from device
 mockup test
Message-ID: <20220911121925.k36y2wjh6nn6b6l4@mercury.elektranox.org>
References: <20220827073224.713803-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iosvc4cs6envf56f"
Content-Disposition: inline
In-Reply-To: <20220827073224.713803-1-weiyongjun1@huawei.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iosvc4cs6envf56f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 27, 2022 at 07:32:22AM +0000, Wei Yongjun wrote:
> This series fixes some issues found by device mockup unittest, not
> sure how about the real device.
>=20
> Wei Yongjun (2):
>   power: supply: adp5061: fix out-of-bounds read in
>     adp5061_get_chg_type()
>   power: supply: adp5061: show unknown capacity_level as text
>=20
>  drivers/power/supply/adp5061.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, I queued both patches into power-supply's for-next branch.

-- Sebastian

--iosvc4cs6envf56f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd0kwACgkQ2O7X88g7
+poDRhAAjhd/bP/kPwVIJCeOlSR7y8AOduEO0CzpyuGKUeMTDW59VIxjbu05+kJP
mLeaZLqFISNGJGelMwUToJ/Klz4YTJo6x4ZrSCXUhi8TJ+GWZRziymzadZFYoHwk
n7BNdgp24GwDhH3OrZggMB+Iki91mBd+f5/aaHnRZprzcQnx3Rooe61LH1m4+S8h
vyROvZMv34X1cXDdPfr/tV357OV2Y/AMe8Ua7HaaE7DJcniizbJFWXyppm8uVujh
/mYaA5u0BgrJLgZTTAqZTO66aKCO6oynIy8kq9x/4tgS8ISsv5Ci7PS7RTalD9Fj
K54eFBzI9eImzLw95b6KCm+h9rja/rwXYKRpH58TT8HEXp+XLegqk8706XORbyJM
EvyIkaRBsLIgpjV1MiQ78gqh99VmT4AWOZYixn9Eq3gdQ4ol9y5Td4+0DpuawgOf
xfAxiW9xPIUUc1X3BG/90PM3g9zaf1KFUuh4V0pTedE6P63v33zQJ62k2JNCUpCW
QKs+gqcLGdy2taewGCnd3uLurUW/AuUBPWiLMblJwR/U95cMacDty5l/IsEKTwwt
dumezz6QYKB7Z/BQ7adlLEUHpyWrelWkrCQf1EXBo15oZSlmrWujfnWRu/FGlf2M
fjtZ9F4b3+bCTHF7PkhnubRYURMN74HPmzslNumy7AkmikzV6+I=
=em5t
-----END PGP SIGNATURE-----

--iosvc4cs6envf56f--
