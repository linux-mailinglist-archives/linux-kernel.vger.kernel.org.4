Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FAD738FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFUTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjFUTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161D19AC;
        Wed, 21 Jun 2023 12:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65AD3616A1;
        Wed, 21 Jun 2023 19:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB1BC433C8;
        Wed, 21 Jun 2023 19:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687374790;
        bh=5OJ7PjnlmhDlV9hG0fI5rCj/uuaQFZRsYGwvFMGaNM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFzVam4xfeCFvgQDEQznaCebTKZ3nPTBCYbYMXvRLSV77FRpOpakatq8LCKg74Lmz
         DvBaRoY4R6n1mecKBSGKQ5SNlrwq+U1RbecDdD+XFxhm3znt0T9Ydx3lYFl6zUQseF
         bI1HydeXmY3fi1WDA+mrd5AVOUy6KpfwzqAGn5qYIqU91AlecTc6RvP7Ef8bkP3lBF
         jB3GMPzr2RnsCEwU9zvWIxXIshleCyIvlYm9XrFrRHkl3iD+HPAqzY5AbE55zJUfZD
         dkmwuq8yf6Ko/7w11cFXNuzLsRIr5zWpq3l6mCVmZkbhs4kZTmw/L20kWhO0j63h+p
         YdJnGp/A5A3Pg==
Date:   Wed, 21 Jun 2023 20:13:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: crypto: drop unneeded quotes
Message-ID: <20230621-mongoose-trance-2d0b2bc7c8b2@spud>
References: <20230621064403.9221-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kMX+ppCtr/sMbNir"
Content-Disposition: inline
In-Reply-To: <20230621064403.9221-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kMX+ppCtr/sMbNir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 08:44:03AM +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--kMX+ppCtr/sMbNir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNLwgAKCRB4tDGHoIJi
0nT0AP45U0MfyYBuBPROCFXmA1qKilOd/vpoavf+9UeUW+2mfwEA3h4J95HX9zJk
n94VGpFRzO8GMY8MxF4qeY8esYgfDww=
=v52S
-----END PGP SIGNATURE-----

--kMX+ppCtr/sMbNir--
