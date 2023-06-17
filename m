Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E97340E3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbjFQMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346115AbjFQMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675A2D48
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 05:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BA061069
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 12:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CB0C433C8;
        Sat, 17 Jun 2023 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687004045;
        bh=0QzwYLQw/VibfYDrU+z6ZNdSa773MjHj/ojJU/BgfM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lM/HlfcrAzSLg4vuQuMQlgh9hsTgrJXi7i9InK/QcbZhwqTM7vSaCuERKaGtU8g2q
         uMqzxdN/ryfiwLhuBvQF0HJkBGBNnmozbXLZIhSYfOJQmBeWcwOZ0g1+h1t1OSFKWl
         oRd6EJ9pCHopOlK+TpmwaaQ9JsaJsHXzh32nk9mcty/6PN+Jh4bnoTEpYaMkREnH58
         oz3VWO3vzz1Fv7FpoGxDjEcwhECQSEhoq/UdjqsqaZCYgj6Z2+kHOSwFdUBSsH2Sy5
         YZK3DFU9Gl3OFfZaBcpzqLULDHV7gCi57B1MzbEi2aH2hHVxLH6NmGfy7SIRAE/eEy
         mG7o3mgS07xNQ==
Date:   Sat, 17 Jun 2023 13:13:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Wylder <jwylder@google.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] _regmap_raw_write() - divide-by-zero
Message-ID: <ZI2jhXUMv9QYmL94@finisterre.sirena.org.uk>
References: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
 <648e22d2-d455-4439-a00d-4042077a8571@sirena.org.uk>
 <CAEP57O9c2Ano4qU5V4EK3ePoBHz+N1xFDo8ULEvidPFnBX+0cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2YT1i4EsH5zHBnD"
Content-Disposition: inline
In-Reply-To: <CAEP57O9c2Ano4qU5V4EK3ePoBHz+N1xFDo8ULEvidPFnBX+0cw@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r2YT1i4EsH5zHBnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 05:39:05PM -0500, Jim Wylder wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Sorry for causing the grief.
>=20
> For the description would it be something like "Max transfer size
> supported on a write"?
> Or does that still not describe it correctly?

I'd probably specifically say it's the physical size but otherwise yes,
something like that.

--r2YT1i4EsH5zHBnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSNo4IACgkQJNaLcl1U
h9BD6Qf+LQL3VUaUhXjliRKQr4zcYixSu7aIVv3vFmX/0fHBpMHqusixJOXhjD3N
hv38ZilNHDNR1Bc3AXg1soNh3H56dwoy2OLS3f7uxfPzyBlP7YV33soIcmiB5U7j
LodtR/XUYgj1DPeT977N/olDrERUkt4MsTFUaB+J/IcOTHCdkwCnDJwOHtUzi7WC
dFHs+qo5Ntr9lJLPKf8q40fQIluoeMAmGlrjU1SlWX3wzR1cScpbPnUSNIjvsEie
e/6SbAydFErH0xp17YsgTynmSBSdkR3Z0bJr8wjBEbfgQiB/IFBqeLGzXSbkJa35
9wwkZYi5ThTb9WLiQVAkBq71LM3CrQ==
=bNlS
-----END PGP SIGNATURE-----

--r2YT1i4EsH5zHBnD--
