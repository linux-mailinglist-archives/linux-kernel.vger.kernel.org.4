Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE316E0BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDMKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDMKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:50:05 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E47EC7;
        Thu, 13 Apr 2023 03:49:42 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E6DA41C0AB3; Thu, 13 Apr 2023 12:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681382954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8W9jtbqN6xKguBZ7APq038DUQHbwahDOenGO1VwnTr8=;
        b=RcUTqGeIixkfZkvr1yDh2531IFYd43KtEPj7Qbv8znxrAvCtVYgEnnZsfUUT0Se2NzBfkH
        xpa5IiBS7pdnKSPoUlQvmzxua3xJwJ8KswTSL2kij/5pCjozvgriT0/H09d07VO0VqqtLi
        qh1EZ2CaOFA8IsBpwoNm5xImBZzW7zk=
Date:   Thu, 13 Apr 2023 12:49:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 0/7] Add support for MT6331 and MT6332 LEDs
Message-ID: <ZDfeKhUvo5a9jd9E@duo.ucw.cz>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/vFl9uYmCyb8SBnI"
Content-Disposition: inline
In-Reply-To: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/vFl9uYmCyb8SBnI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Changes in v2:
>  - Rebase over next-20230412
>=20
> NOTE: Since v1 of this series was sent in Semptember 2022 and got
> ignored for *7 months* with no feedback, I'm retrying the upstreaming
> of this same series.
> There are no changes, if not just a simple rebase and another test
> run on the same hardware.
>=20
>=20
> MT6323 is not the only PMIC that has a LEDs controller IP and it was
> found that the others do have a compatible register layout, except
> for some register offsets.
> The logic contained in this driver can be totally reused for other
> PMICs as well, so I can't see any reason to keep this specific to
> the MT6323 part.
>=20
> This series brings meaningful platform data to this driver, giving
> it flexibility and adding support for LED controllers found in the
> MT6331 and MT6332 PMICs.
>=20
> Tested on MT6795 Sony Xperia M5 smartphone.

Please cc phone-devel with phone related stuff.

Can I get ls /sys/class/leds on that machine?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/vFl9uYmCyb8SBnI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfeKgAKCRAw5/Bqldv6
8m7nAKCkhsGoT6c46SC0+xG2IjFSQVUhGQCcD9A0Yf4QeIcQ0stgUpEYAsAYh5I=
=5q7a
-----END PGP SIGNATURE-----

--/vFl9uYmCyb8SBnI--
