Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA165ABAE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjAAVV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 16:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 16:21:25 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D7241;
        Sun,  1 Jan 2023 13:21:24 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CDCFD1C09F4; Sun,  1 Jan 2023 22:21:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1672608080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aq0v+DYHcUKp6Xj+Ok8b/poNMw5kQJV4suii1vowS2Y=;
        b=hp4FrWfGD9sf/WF/sIKeSJh2cWjkqGkhJgEbwyHMiXN7Xf4KewzwFCmD59UY7hXAraoIOq
        Exgfp8xbd9cPZL8Oy5UZ4IBa+EWGo967xtUlVWDyBC8oAATD5qC0UYN9yAdsWtHijeluIm
        6rGR62jAzP9MiMHQHk22l8L9lRoAu9g=
Date:   Sun, 1 Jan 2023 22:21:20 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org, Ondrej Jirman <megi@xff.cz>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Add PinePhone Pro display support
Message-ID: <Y7H5UJOz/zYuZn7j@duo.ucw.cz>
References: <20221230113155.3430142-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RTMPi14+3aUpRgHm"
Content-Disposition: inline
In-Reply-To: <20221230113155.3430142-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RTMPi14+3aUpRgHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series add support for the display present in the PinePhone Pro.
>=20
> Patch #1 adds a driver for panels using the Himax HX8394 panel controller,
> such as the HSD060BHW4 720x1440 TFT LCD panel present in the PinePhone Pr=
o.
>=20
> Patch #2 adds a devicetree binding schema for this driver and patch #3 ad=
ds
> an entry for the driver in the MAINTAINERS file.
>=20
> Finally patch #4 adds the needed devicetree nodes in the PinePhone Pro DT=
S,
> to enable both the display and the touchscreen. This makes the upstream D=
TS
> much more usable and will allow for example to enable support for the pho=
ne
> in the Fedora distribution.

Thanks for the series. Please cc: phone-devel@vger.kernel.org with
future patches.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--RTMPi14+3aUpRgHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7H5UAAKCRAw5/Bqldv6
8umEAKCiiwwQLTUUm7OHMP64I5tMJAdxgACfQsIjJN7Qg6MhlcLpmicQs5rvGSs=
=0ZNJ
-----END PGP SIGNATURE-----

--RTMPi14+3aUpRgHm--
