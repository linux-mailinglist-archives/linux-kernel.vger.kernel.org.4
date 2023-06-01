Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACEB71F343
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFATyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFATyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880FF199;
        Thu,  1 Jun 2023 12:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1445864943;
        Thu,  1 Jun 2023 19:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE231C433A0;
        Thu,  1 Jun 2023 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685649244;
        bh=WIvsyNlQ2uif/TVWGVhpNPIcaskEDpRpcFq93Z5mjDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iElvsq9+OM8xGA6LbHjVK0hzhFmSt8qxp7PEeQ7uaPp3EuwGQYjZSuEcyog2s9M9n
         vsb2B0d1xD+kO4duraPDA0t8ZBwSl+rlOizY0Efg6xZ9ASaE5nvMRvMXMItSAYLfPw
         ce2xHtoHcu2SJm3J6Qten8WSfj/Pg1G4E+5CwhMs2wvZ52tMUE59yw2bMvikdsg5QV
         lI43YW0IU7mNPenEZfJcEKXTuRM7XJ/rCsKxt6ssacZd/scN6KpCUhiEeM3w09I99r
         +KyB/oiyQ2h+DaUUQyTpzjQvRTDGRt81VXcWnZO5RBNXGeQWa5Y0fRkEOyfGoNGNaE
         v6uvt8BWzAr2g==
Date:   Thu, 1 Jun 2023 20:53:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: allwinner: simplify with
 unevaluatedProperties
Message-ID: <20230601-unelected-grafted-8333e9984ebf@spud>
References: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nHOltvHEp6P8plXF"
Content-Disposition: inline
In-Reply-To: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nHOltvHEp6P8plXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 11:59:06AM +0200, Krzysztof Kozlowski wrote:
> Remove properties already mentioned by common spi-controller.yaml and
> switch to unevaluatedProperties:false to achieve same functional effect.
> This makes the binding a bit smaller.  Similarly there is no need to
> allow additionalProperties for children, because spi-controller.yaml
> already does it.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--nHOltvHEp6P8plXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHj3VgAKCRB4tDGHoIJi
0hmkAP9c4/+xjSLZz6d94Dw8OGxLW8UccXJR3DDidXgsKcnPOQEAuhQukAIZ5FJQ
JZTLwAPq7pe2aZLkiWUiElym64rkLgs=
=qRki
-----END PGP SIGNATURE-----

--nHOltvHEp6P8plXF--
