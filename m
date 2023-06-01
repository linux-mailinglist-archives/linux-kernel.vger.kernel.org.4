Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8671F34C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjFATz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFATz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BDD1;
        Thu,  1 Jun 2023 12:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0912664944;
        Thu,  1 Jun 2023 19:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15B3C433EF;
        Thu,  1 Jun 2023 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685649325;
        bh=pEiUMwDdZiLE4fzh8x63srng8LjrjyaJOInarv+WMGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNHPLIZNLcCbn6k7oM1B1E1s6o9CxWqMVDoSI4EbHed0tgzQUvt/qOWgn5BOz6+YZ
         KEMsyZ2tr/aFqnQrZFxf+iK73cAWFLNeKdzmxdh3NUVPg1zXSBCqgn9XwTrE5oPWMW
         hxmC20+yr49uiLR/9IaXO1DG/ju15J8GbaedqmfKNRZdPeJX7xFIR4YW/So+oAPUjN
         YHBfPvcCKDBZVNvqUmCS8a9qbNrT3YSRw2t2jqW27ndIr060srtvtFbQu0KptJJMtT
         bqEfBWfTT1RCkKtqFxaXFs6jEEuzMoOUuUimcbo7v1Hz5AzvIQaaw65vd7RoOj038c
         62wRqT9tUgAdw==
Date:   Thu, 1 Jun 2023 20:55:19 +0100
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
Subject: Re: [PATCH 3/3] spi: dt-bindings: socionext,uniphier: drop
 address/size-cells
Message-ID: <20230601-granular-landlord-bca8066a89eb@spud>
References: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
 <20230601095908.563865-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9R4EOge1AfRw8lj9"
Content-Disposition: inline
In-Reply-To: <20230601095908.563865-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9R4EOge1AfRw8lj9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 11:59:08AM +0200, Krzysztof Kozlowski wrote:
> Remove address/size-cells because they are already mentioned by common
> spi-controller.yaml.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--9R4EOge1AfRw8lj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHj3pwAKCRB4tDGHoIJi
0tFGAQDZ+7BBBCl6MW6Po9YPoEAqs1z0qgs5UQWFDZcLr6zJPwD/ZpJcRU3ZmzLN
ViI+5IImvOuMsfgz5HAGCiueWtSn1gA=
=19EK
-----END PGP SIGNATURE-----

--9R4EOge1AfRw8lj9--
