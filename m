Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F3716AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjE3R1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjE3R0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21BAA3;
        Tue, 30 May 2023 10:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F0961403;
        Tue, 30 May 2023 17:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C9DC4339B;
        Tue, 30 May 2023 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467540;
        bh=NOcoyxFR4vwKOMvoF94j9sG6honGQkXkQuK+B+qcPfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOeYJe09x1NUFUNb0syYwOgfFjHqms1EHdwUGKwXhgEMIgQ65PiaXSLyM39oZe6DZ
         BplgA+P2uPCx1OtoKe00+Q63mpTRpgWotn85LoI1b7668B4N2jP28NEMC5sMHSrlXX
         zsc9fF/MUyao/1pIU3vZ2PjeYpw8eviYt0sRtTTYpE19jIKzuSWCTCdG9J2yImV6nk
         ZFBwkQdKCQJaP7pjbQ3NhZsnkukMp+MgMeeya8jCWkNv1LaEQ5MpXr9id6Agg8K4FU
         9bCj2vkkiuW+Yt9WndLt56kz3UDB4Dtq1Jspchf9uISY+RyGU8s7pB+/0S+IaVWHaK
         T9AAofnPcSI8g==
Date:   Tue, 30 May 2023 18:25:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 03/17] dt-bindings: clk: g12a-clkc: add VCLK2_SEL and
 CTS_ENCL clock ids
Message-ID: <20230530-outfit-stifling-f5ba6dfbc47b@spud>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-3-56eb7a4d5b8e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fpY+fROroRfh6jEX"
Content-Disposition: inline
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-3-56eb7a4d5b8e@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpY+fROroRfh6jEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 09:38:04AM +0200, Neil Armstrong wrote:
> Add new CLK ids for the VCLK2_SEL, CTS_ENCL and CTS_ENCL_SEL clocks
> on G12A compatible SoCs.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--fpY+fROroRfh6jEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHYxjQAKCRB4tDGHoIJi
0mb1AP4yTzCwn7nVWyhFGK+s0DVp1sxicllf/G5S0d1/5MB4kAEA6Il4QAMrzg7h
VyBrvc9UPsHwiJaLjqMpz4nthWyUNQQ=
=veg3
-----END PGP SIGNATURE-----

--fpY+fROroRfh6jEX--
