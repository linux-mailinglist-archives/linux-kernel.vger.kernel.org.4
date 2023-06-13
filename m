Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34572EAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjFMSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbjFMSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EAE57;
        Tue, 13 Jun 2023 11:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C923663892;
        Tue, 13 Jun 2023 18:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A444BC433F0;
        Tue, 13 Jun 2023 18:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680492;
        bh=JbA/OIPZczrs6+hrFo3waVWa5we5btG8RcPcykOUAAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdR1amv9ArUBADECJrhV1TrtcpF7JIExxEbZjZVWWGBw95umvWUa4OKPe5tSXICx6
         /VoV9VrkbVD51MFKSV71HOtePjpV1bNvrO4amZX+E6U0bTz1KDA9ca7rBK7QhOmisp
         ZFzsc6BIK7SVahDUd4FIXJ4xE1FU+4LXZFj9jqrPn1KXE506lzdHN6yCN6wCZdwhFW
         ygRTg7NIaPREKbelKUkC6b4BPV5SoDV8W3giMk+bVatF5OUHMCPsMrjhIncsaF6/K5
         SX7+ACXEsAx3IY1SfvGrL1Bo+MGKB7nWdpWS8D0yPYRayv3uwpaXsqAqOvQNOe2tok
         TisDqghK9DYSQ==
Date:   Tue, 13 Jun 2023 19:21:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Message-ID: <20230613-slider-coherent-d508d67afc91@spud>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
 <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iQJwmfp/Oz6KiCqX"
Content-Disposition: inline
In-Reply-To: <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iQJwmfp/Oz6KiCqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 08:17:13PM +0200, Krzysztof Kozlowski wrote:
> On 13/06/2023 09:04, Manikandan Muralidharan wrote:
> > Add new compatible string for the XLCD controller on SAM9X7 SoC.
> >=20
> > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Do=
cumentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> > index 5f8880cc757e..7c77b6bf4adb 100644
> > --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> > +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >     "atmel,sama5d3-hlcdc"
> >     "atmel,sama5d4-hlcdc"
> >     "microchip,sam9x60-hlcdc"
> > +   "microchip,sam9x7-xlcdc"
>=20
> Google says sam9x7 is a series, not a SoC. Please add compatibles for
> specific SoCs, not for series.

We had this one a few weeks ago, see
https://lore.kernel.org/all/add5e49e-8416-ba9f-819a-da944938c05f@microchip.=
com/
and its parents. Outcome of that seemed to be that using "sam9x7" was fine.

--iQJwmfp/Oz6KiCqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIizpQAKCRB4tDGHoIJi
0taPAP9mfEFbmWZH97Xic24LzvzkZr/xL3arGzQUX+b5NcVxXwEA49L2IEZg8BGI
oZKsWMxtmZW0Ilm5EKx0KsafXgngkQ8=
=gUpc
-----END PGP SIGNATURE-----

--iQJwmfp/Oz6KiCqX--
