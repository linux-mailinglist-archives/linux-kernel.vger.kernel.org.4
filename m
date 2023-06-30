Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3C7441E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjF3SIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3SID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74AE5C;
        Fri, 30 Jun 2023 11:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0642616D7;
        Fri, 30 Jun 2023 18:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7925C433C0;
        Fri, 30 Jun 2023 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688148481;
        bh=0Or+SFZ0SHOUTDSagR5mJ/56XhzgF/qhUAA6D6CG8t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHpnGiVlZmskeHYt7wuTO34HaXpPdQdYTc3PeOuRC3/odSA4wD3u4gPgw82PneuRF
         05A2PuS8P+Wsldhi+0EvtI4jk1+WfkA9h5lnUUknpUFZJ+3OjhRWgw4MGDdDeiQ9Xy
         m20Pcz8w92UJJ6XIYL0FtvKkZ+EKHzww2+h5cp+jkxtqUzF9MojybXxyYl7iMJPNfp
         TfteMeJrHfpzlaTzjg2HJid9XRBWvFUCeqfJKlo6TRZ7rso3JlqlcAz9EcNy100JNW
         UibqojsSB5X3Rvw3aB9fLrz+i+aBqUME4GHlHYQNedppf1u6zlVVZ5bgRtlYFFB34f
         vjgaEXC7phnhg==
Date:   Fri, 30 Jun 2023 19:07:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 8/9] dt-bindings: arm: amlogic: Document the MNT
 Reform 2 CM4 adapter with a BPI-CM4 Module
Message-ID: <20230630-serve-annuity-1ee92993e42e@spud>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-8-fd2ac9845472@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PIC40N/CDnE3uSF8"
Content-Disposition: inline
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-8-fd2ac9845472@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PIC40N/CDnE3uSF8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 06:29:15PM +0200, Neil Armstrong wrote:
> The MNT Reform 2 CM4 adapter can be populated with any Raspberry Pi CM4
> compatible module such as a BPI-CM4 Module, document that.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--PIC40N/CDnE3uSF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8Z+wAKCRB4tDGHoIJi
0qDcAQCqzCa/eZq9IhbI1ejK8z9NQ/ZJ2bRUJdMcmMQ+wg4wpgEAsbauVpLse9T4
0BGhgecOD97mZqVrA2Sltk3hQBSIGQk=
=4s+I
-----END PGP SIGNATURE-----

--PIC40N/CDnE3uSF8--
