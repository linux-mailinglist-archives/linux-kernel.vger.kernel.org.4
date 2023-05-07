Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5C6F9BB8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjEGVMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjEGVMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82C1BD;
        Sun,  7 May 2023 14:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C53E861C11;
        Sun,  7 May 2023 21:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2357AC433EF;
        Sun,  7 May 2023 21:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683493919;
        bh=uB1YV5e0TwjlCZdNCyk4txuy5nrf5p+7tv0Q3h3jj9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoWsSgNFjTGLSZfqQO1t7BqZwz15rno9RiSEUDDLKRMC6S658wOyImAhejMNJi2gI
         JrwhJjI2a4rUIdraFpCIn5xbPiWWGLk7U+Izuk2pkNThF5adxdT33sPwiYpE08U8w+
         FcEnaaeg4RDBhPHZE1wanY9lVLX6ezZXpieiSzYOcJt/CfNaTbZyXaPEwmCWgr1BCM
         fpQCB3OdQv2lOrU0blTw+D5XVvTg5XKbYcGJPUp/Gf/gRIWye261Rbqa0H0gCIW2SR
         8nhhL45IKBPy8ndCaL1Vqgn1YNdnAQ6DE3IL0S0qSP5poyL/PnLmOpibbE4Piwt/+q
         nEVZhcsPSjqDA==
Date:   Sun, 7 May 2023 22:11:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: google,sc7180-trogdor: allow up to
 four codec DAIs
Message-ID: <20230507-traffic-gravity-6120b5413006@spud>
References: <20230507174543.264987-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zt/fYW6iUhOMSVfq"
Content-Disposition: inline
In-Reply-To: <20230507174543.264987-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zt/fYW6iUhOMSVfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2023 at 07:45:43PM +0200, Krzysztof Kozlowski wrote:
> SC7180 Trogdor sound cards come with multiple audio amplifiers, so allow
> up to four of them to fix dtbs_check warnings like:
>=20
>   sc7180-trogdor-homestar-r3.dtb: sound: dai-link@1:codec:sound-dai: [[27=
5], [276], [277], [278]] is too long
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Given Rob is on leave & the sender of this patch...
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/sound/google,sc7180-trogdor.yaml       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdo=
r.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> index 67ccddd44489..666a95ac22c8 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> @@ -74,7 +74,8 @@ patternProperties:
> =20
>          properties:
>            sound-dai:
> -            maxItems: 1
> +            minItems: 1
> +            maxItems: 4
> =20
>      required:
>        - link-name
> --=20
> 2.34.1
>=20

--Zt/fYW6iUhOMSVfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgUGgAKCRB4tDGHoIJi
0uMUAP43pG/k+CSvRLwMJoAKa1mMnlV48KhkscnFgz3qVAHAiwEAk1xoWFrAS8vt
ohIKQBrAKiqvBNbeUwcervAogC01pgE=
=pMFN
-----END PGP SIGNATURE-----

--Zt/fYW6iUhOMSVfq--
