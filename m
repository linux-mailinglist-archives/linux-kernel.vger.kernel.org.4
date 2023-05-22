Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEE70B96A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjEVJw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEVJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5BB91;
        Mon, 22 May 2023 02:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48B84612AE;
        Mon, 22 May 2023 09:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7011DC433D2;
        Mon, 22 May 2023 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684749142;
        bh=cCuzYUASC9wTSBycAfEJWLo1T1vjoKLVJEIQ28zyt2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/I+/XyDerF5SYOUZPqvIIcBlUXCHiT1OfqS2Cdxo7HR2jEuNU/PEdnOaGwMJ29NX
         NBDe9h1VYyyCNO+5N6FJfeN5pENxoIG5zX0m7H25NokDDzfMb69x46AKtQvWtH+j3T
         A80X2yzRfF3RmFd7DNv36XKEdTagtkhB9wOBJoF/zRoziY1iPlOTbaclr6ix0B12vC
         bbB8rtftcFix0hx13GQ6DsejQwTVTAxgOQ5SHpn7qITClVHJphgy7By+ngh9tEorLX
         vWjJBjkPrh6nB2MLgEhDf3DtNrKLE+PisnKypbcFP+nGTH8dmFh8kgHbkNiYftPbS/
         HLdgO3BiVWmXA==
Date:   Mon, 22 May 2023 10:52:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     srinivas.goud@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] spi: spi-cadence: Add missing kernel doc for
 clk_rate in cdns_spi
Message-ID: <649d68c4-cd2b-4ec1-ad06-ff42ac5653b4@sirena.org.uk>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
 <20230518093927.711358-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KKYYSrtsy6LhuReG"
Content-Disposition: inline
In-Reply-To: <20230518093927.711358-2-ckeepax@opensource.cirrus.com>
X-Cookie: Close cover before striking.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KKYYSrtsy6LhuReG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:39:27AM +0100, Charles Keepax wrote:
> Add the missing kernel documentation to silence the build warning.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>=20
> New since v1 of the series, but might as well fix this build warning
> too.

Sending this without the "v2" breaks threading and makes it hard to
handle with tooling, versioning applies to the patch series, not to
individual patches.

--KKYYSrtsy6LhuReG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRrO1EACgkQJNaLcl1U
h9CD6gf/fQmJ1NmAWonYtfObIJoLl1OPZYOXNnt4p4PsjRm+Usk5yCdz9+b9yMWr
UdRT57FJ/CvaOyLiNxmHWL2s+CtyiuBLF+dCJdA0/vdWh1M6tfLStXEn5vOgnl1y
3zZbWVUnF6xCcYwDMRws4Yo8QhEFvRXBcjOBr9NgxSweGF9p/EqyzN+CRjtYGm2I
/8tJGQi1IqFkYt2NGWOY4s2BMusxjYETd0JFVXIP2BUAl3AMoNwBkPLfU+Agrd4L
gngx9qrDQkLBtB/qmxsgZ68vwE4JkEKSfp5Eu7ciYw8ttG6Ym+YbebSpJ3LGLhLX
QOyU5cY4ev0iYhvL/cwIZH2Uj+hhlA==
=3TAR
-----END PGP SIGNATURE-----

--KKYYSrtsy6LhuReG--
