Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE129646237
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLGUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLGUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:14:20 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A44442E0;
        Wed,  7 Dec 2022 12:14:19 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C72351C09FA; Wed,  7 Dec 2022 21:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670444058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPU7AcGoXQuq9EnnDg+2o2KomajND47TAO4axs8c6pI=;
        b=Udej0jIP2Ew0NXHb4DnXUiwF7NI7ymNiZTu8hj555qc95m/ZvFMtjkjHjfiRgtJTZ68pch
        e84r990p9ucsMOuqWro+TowJRh1KK1Np5bCoq8ix0T3Fc5Vme68x11wYUeO1rzNhtXcFuv
        2VZ6EJsFL+Zj1umUnOPb+egzkptPdOI=
Date:   Wed, 7 Dec 2022 21:14:18 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] leds: MAINTAINERS: include dt-bindings headers
Message-ID: <Y5D0Gg86i3eQkC1n@duo.ucw.cz>
References: <20220830083625.281462-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MfhJ2rgMibF+m8Lp"
Content-Disposition: inline
In-Reply-To: <20220830083625.281462-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfhJ2rgMibF+m8Lp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-08-30 11:36:25, Krzysztof Kozlowski wrote:
> Include the Devicetree binding headers in LED SUBSYSTEM entry.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you, applied.

BR,							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--MfhJ2rgMibF+m8Lp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5D0GgAKCRAw5/Bqldv6
8gFkAJ9c58DkuXe75sVLM+Md2FE6LrnmewCgptwNcXGdK71mBwK+iNPlW8s7O+w=
=GjZ6
-----END PGP SIGNATURE-----

--MfhJ2rgMibF+m8Lp--
