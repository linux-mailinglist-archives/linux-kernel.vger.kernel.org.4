Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4167390E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjASM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjASM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:57:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191838B47;
        Thu, 19 Jan 2023 04:57:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C1360EEC;
        Thu, 19 Jan 2023 12:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7298BC433F0;
        Thu, 19 Jan 2023 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674133069;
        bh=rhavputJ017eS44fDBAjIKmqhA8MGnBkVgBQfgF1Wq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo4tlIZksqs8y0QjfN03K7khBibYDE7X3dJX3W7PWas5X0LDDz7TtJMronclaG/Dg
         vT14zzYVr2rZVYX6+wbO9miw1WAwTmzmNP/EuWRbcvLWvMgRMLM0kcIIHH++Qgylcy
         3Fo/LPgBvOpnPaMn+gttVDXJPc4WChkO7w9Pp18su4ZXe1rwKN4Et8L3Jt1aPdOmG/
         /TGpHIrbhHbJDHypSAglO1EJBTcboxq0J4BB4By/BctwyMF1xatMkPLaeO72RzaxVU
         Ku3ApiqMmy2Ld38fNPzRWYh9uduM0Bqa99VfkpkLclmeh/9NUSpD3+BazrN1rWneqp
         ScqrUhZUYYiaA==
Date:   Thu, 19 Jan 2023 12:57:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 00/15] Support AMD Pensando Elba SoC
Message-ID: <Y8k+SXQ5YtjDbKMG@sirena.org.uk>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="duu0q9TD4wNe08AR"
Content-Disposition: inline
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duu0q9TD4wNe08AR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2023 at 07:51:21PM -0800, Brad Larson wrote:
> This series enables support for AMD Pensando Elba SoC based platforms.

> The Elba SoC has the following features:
> - Sixteen ARM64 A72 cores
> - Dual DDR 4/5 memory controllers
> - 32 lanes of PCIe Gen3/4 to the Host
> - Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
>   also a single 1GE management port.
> - Storage/crypto offloads and 144 programmable P4 cores.
> - QSPI and EMMC for SoC storage
> - Two SPI interfaces for peripheral management
> - I2C bus for platform management

Are there any interdependencies between the different leaf
drivers here?  Generally it's better to make the series doing
baseline enablement for the SoC as small as possible and submit
other things separately to simplify issues with dependences.

--duu0q9TD4wNe08AR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJPkYACgkQJNaLcl1U
h9B+8gf+O9EFbrK1+BmyGN1sU7gIT3V9CwdRRLQo2RsEid331miI+CKveOmwnd74
B47SAVhfZy9ydlw7dkSC6pQPF6LJ4cs3E2RR+lOSrLUjxAXey9fAEPq3caKxIDx2
50wshkCNbkUQ0PBdaX9gN3xxH9lgfBoksoSCrMXsRV6HLMD4l7eqzDii+xCWoGVx
b1SZEivvDEdOPEMpAS7YX9KHKmo4XWe9ckpOMBrEYk1T+LZU8VtO8s8yFZKAMGA1
t4NwUClDk7MKm3PN3SolBsL87FEUCJ2YfGDYqVwIciTGNOPhbbWAVTmrIMGHkr32
k8MPkLG61N9FfqbjAs2kERVWHA0oYg==
=ZAqK
-----END PGP SIGNATURE-----

--duu0q9TD4wNe08AR--
