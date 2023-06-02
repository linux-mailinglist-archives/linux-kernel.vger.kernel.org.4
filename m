Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9D7201FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjFBMXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjFBMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726D1E45;
        Fri,  2 Jun 2023 05:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF9864FD4;
        Fri,  2 Jun 2023 12:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D26C433EF;
        Fri,  2 Jun 2023 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708562;
        bh=shNWx6PFTlZH3l3m3BnGPmtrxXFRFCsjkB9++JCK98M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=el95joKQmeHIrPzPxwzjZ6qgl0W4VWbIztz33qjwDs5PNcAqt9GHZj1DMCTz+SM7l
         xF3m6LHnFputavM2+e8nrZIVLi5zq6YsKwNeLiIfQKU43zuTX58KR66OnHA+a2+Tdv
         iwGBOUc1IlTI5evUTyA/9RRLL8n2APTDXzxfBzYvRioGkerCGtBRylnOLVI06lwBMg
         HfzQoIbVfX1S20pFUzd34/vMyrUei+pEWvmZ3LvmYMtvytHnjqUm6up+iIhcwTUYgk
         omwxAu+WUyib1tkhkR+55dEIebp7+HAh4T1+UU/DwxPuF7eta0Thy/lhhL4JeYIw7k
         4lTEEQv0q6iZw==
Date:   Fri, 2 Jun 2023 13:22:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Message-ID: <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="46S1Pyf2fGJjRDRn"
Content-Disposition: inline
In-Reply-To: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--46S1Pyf2fGJjRDRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 01:52:00PM +0200, Matthias Schiffer wrote:
> We have seen a number of downstream patches that allow enabling the
> realtime feature of the SPI subsystem to reduce latency. These were
> usually implemented for a specific SPI driver, even though the actual
> handling of the rt flag is happening in the generic SPI controller code.
>=20
> Introduce a generic linux,use-rt-queue flag that can be used with any
> controller driver. The now redundant driver-specific pl022,rt flag is
> marked as deprecated.

This is clearly OS specific tuning so out of scope for DT...

--46S1Pyf2fGJjRDRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR53wwACgkQJNaLcl1U
h9ATnwf8DeqEMGZX6YWquv4DiwGh9r4pUYflsXOy0mAeVMTZzGlUg4S65jr1G/lK
Pky2kCDuOXO3NhC4sZF+l7OStNmj8JEhMdEYic3dUv5ypPKBYqDQ9RVbHTtBO6bK
KsEjSA+xOJz0MV9P7jRQrS0UbiY2PiwZ+EuHr+FFxy8aTJ4ZUSFZlgwf6dMXnhHw
jrkq/h9Gfey75Bn0g0WfVpXhap6CoMpkwcykfWtjxss+6GYjGJnO5iOgSoK1/hlD
O5YLIrB6dP1uI1WnTtwoQLy5il6+k3egJ2cxHPu/IAIADtYhwly4yyTV5V8FiZV5
+vP8P2wCBCY03hZlP+WPGi4fHFfqhQ==
=qcmR
-----END PGP SIGNATURE-----

--46S1Pyf2fGJjRDRn--
