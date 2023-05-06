Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3056F9144
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjEFKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjEFKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED43A85;
        Sat,  6 May 2023 03:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8438161A0A;
        Sat,  6 May 2023 10:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DA7C433D2;
        Sat,  6 May 2023 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683369994;
        bh=ZlRWQ95zd+5sTAIL7gAqnoDe9APBh7ECq48G+NXjqBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqcwzGWNSOiBOx2a9oADjHiDrb00JicUT9jRND2AmVJZdpWiXnNRpmNhGENf/7/xV
         Mo1atovpgajhmYn216HVE5rZHVPJtJJlJGYKaE64qeFRF+dM5/2/Jk8sQv5Hrt8gaz
         QR/KMRMHn7kbzwNgtQJ4vuPN0fkWq+WIIL/xcQBDMvWgTysNKZPYzvAiJhW/EfzjTC
         SUOKofzPtaQE1UoP4sL14B0wCTJQ8TRp2ti8vQoFPCqZe2xTtIoPd3wiDNqAGEtS0E
         6cojbUC7BL86T0iiM1Ha7cFNXG2Pj0Eg3YY6/E1vRocFfKYKiVQ+/gsrfE66k45dpU
         ijQCMyedaZVuA==
Date:   Sat, 6 May 2023 11:46:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add SPI0 controller
 node
Message-ID: <20230506-synapse-shelving-cc61b168d7c2@spud>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
 <20230506073018.1411583-7-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SEplYM9AlrXlDGun"
Content-Disposition: inline
In-Reply-To: <20230506073018.1411583-7-bigunclemax@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SEplYM9AlrXlDGun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 10:30:14AM +0300, Maksim Kiselev wrote:
> Some boards form the MangoPi family (MQ\MQ-Dual\MQ-R) may have
> an optional SPI flash that connects to the SPI0 controller.
>=20
> This controller is the same for R329/D1/R528/T113s SoCs and
> should be supported by the sun50i-r329-spi driver.
>=20
> So let's add its DT node.
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--SEplYM9AlrXlDGun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFYwBAAKCRB4tDGHoIJi
0gugAPsFaNmurMn1m04GZaPBTMtKIju4z0TINH9oqp4Bn2TkJQD/QsCEt441QKoQ
fvXJ1d3lQBaor6kkuScmKeu7JcdV4QI=
=KWaz
-----END PGP SIGNATURE-----

--SEplYM9AlrXlDGun--
