Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6B7305D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjFNRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFNRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35ABA;
        Wed, 14 Jun 2023 10:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8958F644D9;
        Wed, 14 Jun 2023 17:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539F2C433C8;
        Wed, 14 Jun 2023 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686763014;
        bh=NHe088c1o+Jq210BxHdiVxxRFtRSMBshsrQJ+SPLxbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWtgCU+6ufuU6Xdic33eWjkskELBMGTngTkrUEGc2GDt6cLDaNKiK2DCjtdr8rjuz
         qkQ6ZI5OCnHqXWXmefvVWT++3kK5iYtLBPRMtGU2vgWztYuteLXv1C2zGDFYm28QUL
         mKzhiSG4Jr0ve0wpMHL6KU+jSWgUWdJrkWnwpl86SV8lPoBDV7ay4pAzanQuaGXv54
         LrF/JUgxDKJhYUJyYlpWEmLL6PnpykkHdHuLGXxiObMmO3bL55CeqvwXjYLsMOgVhD
         QiiOvZFwOLKzoofqXFj/0a8TrXCSQNFnmqGCjZKC0gy3sYAzNrTFvr6Vjl1rJQc+a3
         /an1uiIrjBY8g==
Date:   Wed, 14 Jun 2023 18:16:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: can: m_can: change from additional-
 to unevaluatedProperties
Message-ID: <20230614-chomp-surfer-6866386bfa9b@spud>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
 <20230614123222.4167460-5-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NyTjScBlhm/mrubF"
Content-Disposition: inline
In-Reply-To: <20230614123222.4167460-5-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NyTjScBlhm/mrubF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 02:32:18PM +0200, Leonard G=F6hrs wrote:
> This allows the usage of properties like termination-gpios and
> termination-ohms, which are specified in can-controller.yaml
> but were previously not usable due to additionalProperties: false.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>
> Suggested-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--NyTjScBlhm/mrubF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIn2AAAKCRB4tDGHoIJi
0oSnAP9t/ky4bUHtrdCYyGTGf+rlOh9PaoIb1M2yCjvlHffP4QEA8GHfeb9pYWCG
B95yVv/Jd4LlGTcac4lxeVqws9djzgw=
=OjL8
-----END PGP SIGNATURE-----

--NyTjScBlhm/mrubF--
