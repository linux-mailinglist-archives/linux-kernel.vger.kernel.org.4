Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE44706FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjEQRvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjEQRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB381BE;
        Wed, 17 May 2023 10:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8384F649A4;
        Wed, 17 May 2023 17:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41460C433D2;
        Wed, 17 May 2023 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684345856;
        bh=Nj3X4eb32bJvjIobk6DnVqeRKQCfep3jBPFcL9HRAGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekOGNtS+hKr/Lrs4H+eqixvbP8ce/1VXpcwsOX9IXwd9nOfh2FKX9LuOdX2+uZi2G
         b6X2xMu3XGRFmST2C0ef/DgOsKAgvv5H5B8lqgMrqgceWj8vMeeCoCEwrIy2VMPdM2
         Kqu91bCe99yvjJgrVZwFV/hqbejVPsj3akyi6SyU5uDue0QkHa0msQ1OzQXie30g9b
         7NF4Bqq1R0EQPbCDPkrstaMRYM6a/OzSvYPw0aU2sjMQ8O/yxKO9e3DJOV84ESnJBJ
         p3b/4LqRC4DHiuW0NDwQRsgysTpfZVPF8ft7O6oHea00u9mpEEAiJOhsge4ndO+Ng6
         QrcFmi6LCUDfg==
Date:   Wed, 17 May 2023 18:50:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ryan.Wanner@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linus.walleij@linaro.org, ludovic.desroches@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: at91-pio4: Add push-pull
 support
Message-ID: <20230517-retaliate-sway-af7e15f8e80f@spud>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <048a41d1dcb3da0e845986a73eaac61a54c69269.1684313910.git.Ryan.Wanner@microchip.com>
 <20230517-arrogance-unroll-5e6770618364@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zCeDp95tAXyEvGVE"
Content-Disposition: inline
In-Reply-To: <20230517-arrogance-unroll-5e6770618364@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCeDp95tAXyEvGVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 06:38:28PM +0100, Conor Dooley wrote:
> On Wed, May 17, 2023 at 01:54:05PM +0200, Ryan.Wanner@microchip.com wrote:
> > From: Ryan Wanner <Ryan.Wanner@microchip.com>
> >=20
> > Add generic push-pull support for pio4 driver.
> >=20
> > Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Whoops, incorrect vim macro, should have been:
Acked-by: Conor Dooley <conor.dooley@microchip.com>


--zCeDp95tAXyEvGVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGUT+wAKCRB4tDGHoIJi
0iG6AQCYV9PvL5v/9KFf9yQnP4XLLrQuOsEwZn7ZL2HsmonBQgEAoBxWUxdrtXdj
Ch1/FHMciUANAZbmgX6+cbSyEeDhzAY=
=m2A7
-----END PGP SIGNATURE-----

--zCeDp95tAXyEvGVE--
