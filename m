Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D474C855
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGIVOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGIVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E97118;
        Sun,  9 Jul 2023 14:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C969B60C4F;
        Sun,  9 Jul 2023 21:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4D8C433C8;
        Sun,  9 Jul 2023 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688937248;
        bh=djyTuseLBeA/Gg1w7QGVbC0L8UjHiviHHPC+JTv+QFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGW3Rrobh4cpmkwae04EinmulxFvrNVqwMYvVBpWeXAaj+C3QsT/GM9yZaZgRCN9K
         1ZiV06ncKleNveVvZ2niBS+q/Q9G49V3bqqWUwc6EQCuEO8Z4NGrjj0Wt4TXsioe0x
         aLbzDW6a2NWQcTzq4WwWCQiLOdd2Tuqs0ig/0XaEINeaKaKxhu7AEYzyuS8pQBPq+2
         WYvPE58NJOHi8dkjeLzkgHRmGvL+lepEWaq5BXo3WYZqUAQVcXi+m9u+Lic6nfXDLA
         6zQLFXdG0uefYnZ8Zj8gCBlNgBP5E0UCelE94V2ctFr+uSXJSIBVjiYbQSHC8i3TwW
         5vYINae9gAqyw==
Date:   Sun, 9 Jul 2023 22:14:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>, andi.shyti@kernel.org,
        krzysztof.kozlowski@linaro.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 04/26] spi: s3c64xx: change polling mode to
 optional
Message-ID: <ZKsjHAaH41V8J+Dc@finisterre.sirena.org.uk>
References: <20230709151255.512931-1-sashal@kernel.org>
 <20230709151255.512931-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gSG3AG9Mzt2Vuaqg"
Content-Disposition: inline
In-Reply-To: <20230709151255.512931-4-sashal@kernel.org>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gSG3AG9Mzt2Vuaqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2023 at 11:12:33AM -0400, Sasha Levin wrote:
> From: Jaewon Kim <jaewon02.kim@samsung.com>
>=20
> [ Upstream commit d1a7718ee8dbcc488d3243d52e19c755123e0024 ]
>=20
> Previously, Polling mode was supported as quirk for SOC without DMA.
> To provide more flexible support for polling mode, it changed to polling
> mode when the 'dmas' property is not present in the devicetree, rather th=
an
> using a quirk.

This is a new feature/performance improvement, not a fix.

--gSG3AG9Mzt2Vuaqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSrIxwACgkQJNaLcl1U
h9BQFQf8CKzKdu0m0tAVJQpSKAYVP/C+mC0FyYeSoywlsnn8mLEcj7hs5ISAoj4K
0vgSSirVRBuVdqaPIT/nMihQFDOgMP6PCIxZKsirh87f3kztnL7H0XWIyj3PD2ZB
X8+TVi0+M95hrkzXkQEp0fybPglb+OkOagEiWVKrwWgF8Qb+HzdHjJ2kmr/5opes
DjMEj1HuCV2t2in/ghB7dSiHm1XfJdATOO9BLpqiHVE5mMinaJyZBK3cIl+0K9jr
0vMRbTGaIujAW7FOc4In1WP+zqBi99Z8JeUQW9bfOrGx+BwKJIP2mj01a6H43JKK
tbyu6gRM9jaoEff+HrZWnL8ukPTlvQ==
=7XeE
-----END PGP SIGNATURE-----

--gSG3AG9Mzt2Vuaqg--
