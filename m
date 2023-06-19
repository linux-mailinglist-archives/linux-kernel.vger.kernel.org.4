Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633C735E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjFSUGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C34E0;
        Mon, 19 Jun 2023 13:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA8160EAE;
        Mon, 19 Jun 2023 20:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AE7C433C0;
        Mon, 19 Jun 2023 20:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687205174;
        bh=CTxCMk1gTTUHDIrUKyoalHysRRGv6bTbdPSH/3zbi5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIQTVfeYtBre7rWe8mp0bQlH/s+0b6z1oAmHfdXAyHNEmr7q3Nn69xHczgv/dtMZi
         tuCdsCB0LyQYhSRCMZB5KumypM+b/RkXwiaSmxAuc60kddU+09MBFuC9luPtVc/jos
         JcIW2Sb6ZHrqprYBq7nhZQlD2tQkR+EskgAto9tnZA0mtvZpiq52NkwjznRRmhlS7l
         Ym7UxQfUpiaNNIZycmSGkqetlAGyCYUFiAh1XKlq6uJ5gDlOpj3Ji8QhCyZp21PzER
         /3rP9Mjh5bWePyXn/d/HivSH31jJ8m9AnFWDed6vrvI90tnnUXYS+dZ4CosP/HLv5f
         WexPSroD6RIsw==
Date:   Mon, 19 Jun 2023 21:06:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: micrel,ks8851: allow SPI
 device properties
Message-ID: <20230619-aware-robin-789ada1c6db4@spud>
References: <20230619170134.65395-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nal+MxCjpXktrc4o"
Content-Disposition: inline
In-Reply-To: <20230619170134.65395-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nal+MxCjpXktrc4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 07:01:34PM +0200, Krzysztof Kozlowski wrote:
> The Micrel KS8851 can be attached to SPI or parallel bus and the
> difference is expressed in compatibles.  Allow common SPI properties
> when this is a SPI variant and narrow the parallel memory bus properties
> to the second case.
>=20
> This fixes dtbs_check warning:
>=20
>   qcom-msm8960-cdp.dtb: ethernet@0: Unevaluated properties are not allowe=
d ('spi-max-frequency' was unexpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Cheers,
Conor.

--Nal+MxCjpXktrc4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJC1MQAKCRB4tDGHoIJi
0rWMAQCcFMIt8ItKOlPO3UX2ZtobWQGO+xcS/uHckB0dDYyWIwEA/cUiCww3Nisg
NpZFU/CH5HUAVJOzke4wq4gzE/zngwA=
=0/YM
-----END PGP SIGNATURE-----

--Nal+MxCjpXktrc4o--
