Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D87267D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjFGRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjFGRyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA61FC2;
        Wed,  7 Jun 2023 10:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227256101E;
        Wed,  7 Jun 2023 17:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E93C433D2;
        Wed,  7 Jun 2023 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686160477;
        bh=t9VMLHpwDUMRX+sjzy9JXqecsOwAcppqiOl5uvHgkwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7lwImtQWmfcsD3AaKRkzMR6LsIKj+bZ3d7pRI2oiE5mHGFq6wSkteK7sbA3aU+jd
         sRfA6M5mXyKGf1b8k3jKG6kKYqmbeVnCQ6g2sbGFXbLkP5M71eKKxDx0Z06e/CNck3
         GwaKRpe1gpqSh1F6Yc3VPSvVlMEBqyQqlE+kg8pFEAtPAOCDMuyyhW8fky3+1f4Yui
         dSb3eHN2COqCnronx9tl85n34dcYhgxgmnXW8OKO5az1FEhI6dRFZ/BAKmFLcWWcj+
         UOYCNMKGDIwzB40MVU+85Zvocx+Ccq8Kp5FGkscGn3v1SpB2iB4QNHgu9bdwI8vJuc
         r08HOiyyafqkg==
Date:   Wed, 7 Jun 2023 18:54:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/8] dt-bindings: display: panel: mipi-dbi-spi: add
 spi-3wire property
Message-ID: <20230607-talcum-purging-92caedf423f1@spud>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-2-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KRHE2d73KvjNQ2FN"
Content-Disposition: inline
In-Reply-To: <20230607115508.2964574-2-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KRHE2d73KvjNQ2FN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 01:55:01PM +0200, Leonard G=F6hrs wrote:
> Some MIPI DBI panels support a three wire mode (clock, chip select,
> bidirectional data) that can be used to ask the panel if it is already set
> up by e.g. the bootloader and can thus skip the initialization.
> This enables a flicker-free boot.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--KRHE2d73KvjNQ2FN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDEWAAKCRB4tDGHoIJi
0p1gAP0cKhUNjF0VGGTzVmkkas++loSoMeqKZSPC/dWXhVwfFgEAhRkljA73KAnQ
I4TX62PntZEAHLMlF/0QvgeC6Q88eg0=
=42vw
-----END PGP SIGNATURE-----

--KRHE2d73KvjNQ2FN--
