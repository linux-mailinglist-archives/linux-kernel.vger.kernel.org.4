Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AE699953
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBPP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:55:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA62BECD;
        Thu, 16 Feb 2023 07:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4076FB828BE;
        Thu, 16 Feb 2023 15:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38100C433D2;
        Thu, 16 Feb 2023 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676562955;
        bh=hV3TgAk/KO+NdNpJKyDzmoNWy91YGJwb/WwPxBrMaqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdIwx35G0MLr8zpqqp47h75H/OZCZVkusZsj7GbFecNMbH7P5oT4icb10MEw6e6Ri
         q5QxF5kBcHp8OKYAJCFukJrcjZOrkJS/g3e2M77Cx5A4l9hdT5YrRNMCXDV45CO8kZ
         xWFDid2csx/LxuLAqu7XN2tBxtyT1p90zhKJ+gb9AIqxPBjNoQeJP8DX/GAvjHHkQQ
         5xCJzllEBLB8ocmVl37gF9KuBdQxVN+dpw3MH0DAOv3Zxi6Pr9Sy9pMQ+LmKPOjW45
         UAQnSU5UcKuQm1IDwtTmfLGl13D0EQb1YkuitXgsNmkT91kEU6wgETLPMDeIZx7bqY
         IQqiNudqyQkOA==
Date:   Thu, 16 Feb 2023 15:55:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Kazuki <kazukih0205@gmail.com>
Subject: Re: [PATCH v2 0/3] SPI core CS delay fixes and additions
Message-ID: <Y+5SCAj4Vk8NLrW9@sirena.org.uk>
References: <20230113102309.18308-1-marcan@marcan.st>
 <167362544665.163457.10878671229075890152.b4-ty@kernel.org>
 <20230214185234.uj63aovylzixs6xa@kazuki-mac>
 <20230216090411.GH17933@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s65+AzCdwLsVrzag"
Content-Disposition: inline
In-Reply-To: <20230216090411.GH17933@jannau.net>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s65+AzCdwLsVrzag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 10:04:11AM +0100, Janne Grunau wrote:

> can we still get "spi: Use a 32-bit DT property for=20
> spi-cs-setup-delay-ns" into 6.2?

I think I sent a pull request for this already.

--s65+AzCdwLsVrzag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuUgcACgkQJNaLcl1U
h9BBigf/dsJ+ETdTLuVQDaiiOGZssz74Zfb/yxvCGBxQPNF/e5096O+ulj4PrJo5
+Hv3TUl4BlbpSZpBU/xMUMvGLlCzAOY84+/5GORTiI3kv5dJPiANbhC74MWQgAip
PQk0CkRzmuTfstt6TJebtz75d1oaQ9IwzzPyJXNQDsf/QsFZ7ESbDNVFinfbUTme
UdLUS93gq7rmJ6Bug1NBn8pIlI+fXFPsX8SbBskh39mgtD3du5vgDoiffi45dLNa
f/Hil41eRHZf4/W0Te1MM7MVf4OCb4eJ0zTNRg8QUrC0LkcwwqLHiXvwgSuvNR41
56c4NZFev9qOAs83U+F1FIx7gJkTEA==
=U6EO
-----END PGP SIGNATURE-----

--s65+AzCdwLsVrzag--
