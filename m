Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092E072EAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjFMSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjFMSRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24F919A;
        Tue, 13 Jun 2023 11:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AABB61ED3;
        Tue, 13 Jun 2023 18:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBA3C433D9;
        Tue, 13 Jun 2023 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680231;
        bh=XTG2klyPf0oT75Kv3XuLzl4bkZFcLP4Om9Y9CJiTxXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/rINJ26xpgNTIWBu2mAqPIfXNTg/865ib3LfIal3P9wIMWz06nB2MmFTDaY+l/ct
         hvgukZzRYlr2g+fhgOMDluOdAoaUvhx9Lf7Cxd/fa8dcUeX73pRmnVlhAFrAiAZNWY
         uViP+XJJC/v0zvgPhdOY6iqxWffqzrpPvGXSWdHV9zJk+/3jbgektHlKFq+KNCgJLI
         bYmRO0Ye+CyxsriYG5OIFej7tXenif3SjZfvYKJZl9GyrA/iuM6vmHMTL0KuTomMTV
         bBAVhWtTpRVbjjKmjVEstjJ2+t6Gr2HlQCElzsExBOQ2WEWOJq3a/8wFighLoGlOAh
         u1JwuoE5cmyPQ==
Date:   Tue, 13 Jun 2023 19:17:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 6/9] drm: atmel_hlcdc: Add support for XLCDC in atmel LCD
 driver
Message-ID: <20230613-recant-citadel-a3d3878ced06@spud>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-7-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qFolLM+MCUnaiMP"
Content-Disposition: inline
In-Reply-To: <20230613070426.467389-7-manikandan.m@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qFolLM+MCUnaiMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:34:23PM +0530, Manikandan Muralidharan wrote:
> - XLCDC in SAM9X7 has different sets of registers and additional
> configuration bits when compared to previous HLCDC IP. Read/write
> operation on the controller registers is now separated using the
> XLCDC status flag.
> 	- HEO scaling, window resampling, Alpha blending, YUV-to-RGB
> conversion in XLCDC is derived and handled using additional
> configuration bits and registers.
> 	- Writing one to the Enable fields of each layer in LCD_ATTRE
> is required to reflect the values set in Configuration, FBA, Enable
> registers of each layer
>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> [Hari.PrasathGE@microchip.com: update the attribute field for each layer]
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> [durai.manickamkr@microchip.com: implement status flag to seprate registe=
r update]

These things inside [] look suspiciously like they should be
co-developed-bys...


--2qFolLM+MCUnaiMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIiyoAAKCRB4tDGHoIJi
0sLzAP0Zkw/eYHzkGeK+6kpdWRLLsfZ8lM2aucgkkRrlw9+AQAD/RMzPg4U7Jd4l
w7bDsBluRxpYOapZPx5QzBXcbWUXHgY=
=QOaw
-----END PGP SIGNATURE-----

--2qFolLM+MCUnaiMP--
