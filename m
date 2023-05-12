Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19996FFF51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjELDbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbjELDak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4E4C20;
        Thu, 11 May 2023 20:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9C464D0F;
        Fri, 12 May 2023 03:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887BAC433D2;
        Fri, 12 May 2023 03:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683862236;
        bh=3wHs1m5GP/R3tyHlMdTHhowVdnHSnCWrWzt8b5NMDXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dY+uogn1+76Wu2PraxhO6Z3mS3VHZDd9NVpSxUuCYXt3aPqmmrzPyQ/Wz7MdjtpaX
         Hxd3w06J/yh9cN4w46sQnv4DbiSlUHPx3YXVHjir+kaa2CDKYCFeoMBxMzEL/fueFr
         n4ccKHVIrudsQoAJREsTv0Z0K9aTSYh3djJjmAuOD/0DbaZfCvdKhbr56muVm0DV08
         l9Rz0BO8pUqvkBStUuan7jKkWF5Axs+oaAReEnyYmQhQCMRd1m85TBvYdA7FHlTGih
         jqKgombIxYS1Wgpr9Qws25YjIOawl4/SHASHvnuTVF/OHmKfETjBCQxX8yuvJ23VVJ
         J4RKOVwxEIXQg==
Date:   Fri, 12 May 2023 12:30:29 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: Introduce spi-mosi-idle-low flag
Message-ID: <ZF2y1YNkSbXzRm4V@finisterre.sirena.org.uk>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-2-bstruempfel@ultratronik.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crcVxhkxf83g7XbZ"
Content-Disposition: inline
In-Reply-To: <20230511231317.158214-2-bstruempfel@ultratronik.de>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--crcVxhkxf83g7XbZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 01:13:14AM +0200, Boerge Struempfel wrote:
> Some spi controller switch the mosi line to high, whenever they are
> idle. This may not be desired in all use cases. For example neopixel
> leds can get confused and flicker due to misinterpreting the idle state.
> Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> can be overwritten on a per device basis.
>=20
> Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++

If this is always required for a given device (which I'd expect to be
the case) why configure it through DT?  I know we've got some legacy
stuff like that but not all legacy DT choices were good and no need to
continue the pattern.

--crcVxhkxf83g7XbZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRdssoACgkQJNaLcl1U
h9C1fAf+OxB7rCOtlPof7FqZqSfBXMUMxSO9PukmbYkdxUV/iKlWoo+TI2D946t/
buUcDGkK2j+ubWF0uwQUuLyCbzsL4O2oRnKi5CJgEZeiCkRAhbddWFSYLCyEaKNq
fp1MiV5/2bdtfD/WIz0CvQD4YIB7mSNj1o1U7/+K8BD9a2oACXnmlW1p2sFafi5a
AOtv1AssMLY8nxnUZD68d7CKqVxRdFpR0NGhhdmOqViDY/Vwt3Hig/zgbegBTHWh
CAsMZz8WWmRXq2dIJIjHOd5QKloNlSsCgtlEQFMX/35ZCXTRKLlimYwBN1wUtaN4
XWLyuvm5QH8uHDoseqY+1dteVb0Csg==
=Cu0M
-----END PGP SIGNATURE-----

--crcVxhkxf83g7XbZ--
