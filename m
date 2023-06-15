Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9E732187
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjFOVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFOVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3921B2;
        Thu, 15 Jun 2023 14:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C12E7621CA;
        Thu, 15 Jun 2023 21:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CADC433C8;
        Thu, 15 Jun 2023 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686864103;
        bh=yEJ1sVebWOjpqJF7Ce+024H12ihDLGhFejIzI51dkA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcNKYEcjPsJehqtPbRYFE7N6WFFHDMEvvgaGYe8BzpaM6VEOC3gEI4D6Gu/SwZ+jS
         /BYZOukFZbbSfEbJ83MVuvNp8GX98Hl/VGofHWdrHVJr9vtDH+dEzHz46eCjddmWfv
         b1v4X5qNsw8uDY9Q8atCZChuFzAEpFloEdaWMAe6lZ9maHFlgIEmJW4n5gUCOvgV2T
         VqnKUk0BXJp7LMDvsMgchb5+jte3Z2EprOdxpcAHUXCMhEKKYgDVJFi0tqGOyu+K8o
         ffZ6N0+GwAjpdWYh4Gd3s045VTooAy6DhjGmPEbclSSPt1yDyCBY0Epum6vZocMxd0
         g8pj/Wy5Ir1NQ==
Date:   Thu, 15 Jun 2023 22:21:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 3/3] riscv: dts: allwinner: d1: Add GPADC node
Message-ID: <20230615-overact-lard-9402836697f5@spud>
References: <20230615205540.1803975-1-bigunclemax@gmail.com>
 <20230615205540.1803975-4-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NWC+jNAdJ4jwAH42"
Content-Disposition: inline
In-Reply-To: <20230615205540.1803975-4-bigunclemax@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NWC+jNAdJ4jwAH42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 11:55:22PM +0300, Maksim Kiselev wrote:
> This patch adds declaration of the general purpose ADC for D1
> and T113s SoCs.
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--NWC+jNAdJ4jwAH42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIuA3gAKCRB4tDGHoIJi
0hhUAP9/W2wEpDsdB/Sc22oil+LX2XhuR7HCsY8W1oqAguqBagD/T8gxH24r/hy1
AaVKYORuvL5Bv/c/MlUxLX7izpr1rg8=
=Y/s0
-----END PGP SIGNATURE-----

--NWC+jNAdJ4jwAH42--
