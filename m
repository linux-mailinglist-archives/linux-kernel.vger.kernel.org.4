Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79F62F94E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiKRPau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiKRPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:30:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86B81659C;
        Fri, 18 Nov 2022 07:30:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C399B8244C;
        Fri, 18 Nov 2022 15:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF1EC433D6;
        Fri, 18 Nov 2022 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668785445;
        bh=LfiiqbQVgBizYCizUCNHg2IaL0Mi+yMeJ7xdaR4buUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElI+i2r3kma/IUDyxlSnThJkl8QTnLeIACfF3w8dM+Px8545hceggGH/r/6fvER2O
         PqopVu3Q96iNH1klO2wNODhFGrNZsZ9YyZyOAJlg9fokdPVB0Jd8QzZsojTOflQs8F
         HKURLqFqS/sK3foKVBQTj5IoslV3U1yvZKoXVB03w87lqeA5m4Ch5qiQhrxCsAnfGa
         5zo06a2+QMoERl2xcfa3cN5XW1YANTTTyfVbbsLccT3+xh4t/BzNURCThgzj3t9BbI
         kVKaKEfE5sU3Lr2gDyLfoFqfAxrsokTjKQqJ7qETTrTjFT340BSgmuEg4jrHLyqk6D
         G3t2KN3upPGhA==
Date:   Fri, 18 Nov 2022 15:30:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     tudor.ambarus@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
Message-ID: <Y3elIdM3Xz1H4kKk@sirena.org.uk>
References: <20221117105249.115649-2-tudor.ambarus@microchip.com>
 <20221118141458.954646-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kDV9Vhdp/jBbKORP"
Content-Disposition: inline
In-Reply-To: <20221118141458.954646-1-michael@walle.cc>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kDV9Vhdp/jBbKORP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 18, 2022 at 03:14:58PM +0100, Michael Walle wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>

> > +  spi-cs-setup-ns:
> > +    description:
> > +      Delay in nanosecods to be introduced by the controller after CS is
> > +      asserted.

> Does this need a type as the spi-cs-setup-ns is apparently just 16bit? At
> least the driver uses it that way.

> But IMHO this should just be a normal uint32 value to be consistent with
> all the other properties. Also the max value with 16bit will be 'just'
> 65us.

Making it 32 bit does seem safer.  I've applied the series
already, mainly for the reintroduction of spi_set_cs_timing()
since there was another driver that needed it, but we can still
fix things up until the merge window.

--kDV9Vhdp/jBbKORP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3pSEACgkQJNaLcl1U
h9AP/wf+OU7ftgSU8x32UiIvVxfKAhXCTN6YUUpN5wJ5rcR6Y/u5C9U4Hz5OvhXt
iFa2V0T2jjqbu23NzY1vE+1JHj9RDdajNIL6EmY+L/mWhg2zJ9ps6NzDFLKWTP8O
jq8nKUKOtaaQEqjkf1JEohloqNWFiCeS+ClNGIKEE7mXIijbl40YWZ5+b6pu6Dyh
RgAFSFvIvZWg4PcHaEipU9uHlkakTTnCFLdyx9IZYsVb/QxmaVtWHdvutod55qyK
I8ma7ORrkz7xrlS77LyXeNira/4qBuln0QeOf1VRh2pNxOq7MFaiW8TMnSB2pbvp
iPKEIzUny8D0A1zg1QWzhxfru8Jvcg==
=PlCP
-----END PGP SIGNATURE-----

--kDV9Vhdp/jBbKORP--
