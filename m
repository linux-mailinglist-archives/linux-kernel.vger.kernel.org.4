Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6961143B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJ1OOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJ1OO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:14:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3DF39;
        Fri, 28 Oct 2022 07:14:27 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 279386602925;
        Fri, 28 Oct 2022 15:14:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666966466;
        bh=eBiw1DQEjFf2dEuqwrvW3KKB9648bBPpwmqSPSVAKIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXkzI29z86w4GOXZXMHvLn0TISt6OPvDxN/Cqle1jcQdUzXanA8e0eg3qIU65kAMc
         SZOa32lAhzYEEiL27lNb8oFvMX9XxpiDL1fJTDUT/d/oeigAfjbGLLw1p5y2zq7BD5
         OjZqA1P676nUV6CMHhwobRTLGV74k/zp44kayM1gHxd8cvjqIyUeCSK6ru2ti2BNYr
         qupyiLBhfZsNtxwZoto13kmuriHDFQJQmvcINoNCEg16UYuNpHq+xwlnxoO2LOQ4Zg
         662HfoY6ybdkfd2kOcr0yd4Wu26JkCUqtrcptMFZev3cssaPEqHnxlYnglT/dyDm8Q
         UyHXSetP4bmow==
Received: by mercury (Postfix, from userid 1000)
        id 608C910607E8; Fri, 28 Oct 2022 16:14:24 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:14:24 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: power: reset: restart-handler: add
 common schema
Message-ID: <20221028141424.nzx3xbpswpvue7iy@mercury.elektranox.org>
References: <20220923203603.515714-1-krzysztof.kozlowski@linaro.org>
 <0b2b3ee9-1d5a-4849-a20d-486c3897fb0c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fumpg2gf52miwsop"
Content-Disposition: inline
In-Reply-To: <0b2b3ee9-1d5a-4849-a20d-486c3897fb0c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fumpg2gf52miwsop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 26, 2022 at 12:44:22PM -0400, Krzysztof Kozlowski wrote:
> On 23/09/2022 16:36, Krzysztof Kozlowski wrote:
> > Add common schema for restart and shutdown handlers, so they all use
> > same meaning of "priority" field.  The Linux drivers already have this
> > property and some systems want to customize it per-board in DTS.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
>=20
> Sebastian,
>=20
> This is still pending. Any comments from your side? Can you pick it up?

Done.

-- Sebastian

--fumpg2gf52miwsop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb48AACgkQ2O7X88g7
+ppBhw//e4km+aI0/WbdM/CI76nbO/u8OCFmoB0wh23SRFlRJTfT2AKbT7IzYDbC
rGFrK5PJpSQU9P/3iBGJaGEpaiwy9Ld+YQblPNSEm5SAxzF7jVgp4XYvaDF7v5t1
LEo2Ma6ZsCIUSsSNPDWaThbdmoDQv4h5pjb+cEDE6G9z94nWHjZx76H69P7+ts0l
8J2d6rxXafjOsbUAXGZ5MB+5bhD8mUpQIRfr860htn6+Pwe98StrwzQjge4P5p/Q
8wscFF8Y8D5G5JFgAFO/CqdtGaZcuZsLMuQmG5w/2Ihxiza45tzbhprG78kgvr/Y
fkjhT5naIEwpS2DbJ1D5b//GHF0LL1Mjg8cHfCWzkwAJVfonTRK7UuvN2SODZaP2
vWMpZkisdGLnlDFKw63uuwvBbAb1TsC9bjPI28C4dsKzExG20XjIfSBs9qeV7i2d
sL+JsZHgDx6miWjyQeV0YUNM5StFqZztyu/uRdNL6DITX1QIwlPxHWtf4xlsd7kZ
eaI/vqbg2D10P/hdClH5j1/MO8Va0rHdE5aHWxQoD6XdgbcMCx+S/pILa+i1mPHr
0LqlCaomp21LegnzSw8NNyVs22fYeqtjoV2THYtAd/tNrT4bM1/D0/y3OMcWbkNa
kQuRfcLPogOQy/tH59wl94B/xXKb1u9vYUJb7cgZ42ceYC5NkF4=
=XI8z
-----END PGP SIGNATURE-----

--fumpg2gf52miwsop--
