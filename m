Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B77338B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjFPTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbjFPTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245543C12;
        Fri, 16 Jun 2023 12:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD690625A9;
        Fri, 16 Jun 2023 19:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855ADC433C0;
        Fri, 16 Jun 2023 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686942068;
        bh=k7TL4/bEtYnlDoFIRBngv3fhHMXqUW4iN9W+YmmLUhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aodvJaD58Y+8lUTMXpB+bGwpR4phhlnX+6Oh5PnMDn3MAiV5RYJFIv+KjZLQnAY0Y
         IEW69W3BETBuIJatjMnz/A/Xeb6JidIvdDB2zGceX2LdWxPw5XDyD/HoZiae83A5EA
         rFCGHggp6UO8oX+zbaJM1Pumsr4gBAT2YdfGbHTGf/T/5pVYFvOPZafZYn3PEUbc5w
         Lk8k0PvJbAojM73H786e7KeJk75vSEh9JxatHIJTFPqnDB3RXNIW+DUN7rdHfem7Oi
         68KrV5zWDb13L1BqzBWAplwxLJMFaRY9EMj4ejW3DLmU3QU8IZY8vwz/dexGHxzsQ2
         spuA6P6lAoz9A==
Date:   Fri, 16 Jun 2023 20:01:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v6 23/26] dt-bindings: soc: rockchip: grf: add
 rockchip,rk3588-pmugrf
Message-ID: <20230616-gargle-spotless-9d04000106b0@spud>
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
 <20230616062101.601837-24-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NpVXOp9NH7FQ7UcR"
Content-Disposition: inline
In-Reply-To: <20230616062101.601837-24-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NpVXOp9NH7FQ7UcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 08:20:58AM +0200, Sascha Hauer wrote:
> Add rockchip,rk3588-pmugrf compatible string.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--NpVXOp9NH7FQ7UcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIyxbgAKCRB4tDGHoIJi
0hRCAPwIBYDKio6eKwjALxf7btC6cRpqymJvrXVISsExsJ2rGgD/ZsjJuro0F/cO
PcC1ID8rsPY3eXz6PZ75Cx2uYr3Dogo=
=NrG2
-----END PGP SIGNATURE-----

--NpVXOp9NH7FQ7UcR--
