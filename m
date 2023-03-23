Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5996C715E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCWTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:54:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2AFEC7E;
        Thu, 23 Mar 2023 12:54:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 476D91C0E45; Thu, 23 Mar 2023 20:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679601265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KovE6zmPZKp3jugh8VF+9SoqMmJilIrkDfSLZCsLNOo=;
        b=EsTdhLDkJRY0fdFnsoEREsPVp+UwzwUF7SZiNOBAQurTaF1fs+hZVPRGfHfIE+Opb9+dN2
        AVVgdQsNv45EHRwOYskxIytt2fZAeW7eMpOMTQ5J5bExvS0e3HLlr+bcfZReq+emSQ14Xt
        Fqy+qDH1DL4+wrMI52585whxkgPXJxk=
Date:   Thu, 23 Mar 2023 20:54:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: configure
 flash LED
Message-ID: <ZByucIecBARC/2X2@duo.ucw.cz>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-3-531521eb2a72@fairphone.com>
 <Y5S+6j1yJ62RJU/v@duo.ucw.cz>
 <COZW5FAXA36Z.175ARPIESQSLL@otso>
 <ab314039-2c69-8afa-cfb2-e5876ac6afe2@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/ytfWZ+uTA/p222V"
Content-Disposition: inline
In-Reply-To: <ab314039-2c69-8afa-cfb2-e5876ac6afe2@quicinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/ytfWZ+uTA/p222V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > > I'm pretty sure the flash is not yellow.
> >=20
> > The marketing term is Dual LED flash or Dual-tone flash, one LED is a
> > blue-ish white and one is a yellow-ish white, but from what I can tell,
> > in the original code it's always referred to as white and yellow so I
> > also followed that here.
> >=20
> > Also the LEDs are right next to each other so in practise for torch just
> > both go on, and for camera flash I cannot really tell you but I guess
> > it's doing something there with the camera tuning.
> >=20
> > See also this picture:
> > https://shop.fairphone.com/media/catalog/product/cache/b752d78484639b19=
641a8560800d919d/p/_/p_5b_main_camera_back.jpg
> >=20
> Hi Pavel,
>=20
> Luca is right. It is normally called dual CCT (Correlated Color Temperatu=
re)
> flash LED. It has 2 LEDs, one is with higher CCT (~6000K) so it looks lik=
e a
> white LED, another is with lower CCT (~2000K) and it looks like a yellow
> LED. I am not an expert of this but my understanding is the camera tuning
> process normally adjusts the brightness of the two LEDs and enables them =
to
> get different CCT for different snapshots.

I believe this is normally called "warm white" and "cool white", no?
Yellow would be monochromatic light at cca 575nm, see
https://en.wikipedia.org/wiki/Shades_of_yellow .

If we need to add some defines for that, lets do that.

BR,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/ytfWZ+uTA/p222V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZByucAAKCRAw5/Bqldv6
8oTYAJwNZ0uZ603G90xIYj5gh/jjp/mm7gCfYsqK0F6HunXRkKewzPzLgpN3lgQ=
=nhTM
-----END PGP SIGNATURE-----

--/ytfWZ+uTA/p222V--
