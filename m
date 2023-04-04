Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E16D61BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjDDM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDDM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A910C4;
        Tue,  4 Apr 2023 05:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055396336A;
        Tue,  4 Apr 2023 12:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A48C433EF;
        Tue,  4 Apr 2023 12:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680613104;
        bh=lfN5JmYc6qH2G3FL+rOMSqCMigVP0CNtxst6MOpGxTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYHYSHZiam2G5oaFbWuRvjo5X8i2qbRziSSxXrwY9unZDuJatAKn5FoylGjEd5zK/
         uNuxWKjvC+wsItZRwTOPOVbMEMJcR7tLu/CLVlu/uCDEVG/uMsgHGvpEbRetOfTp51
         Y9yZ6wEUbTQtzI8Wp2zLDJOGYyfdboEeXXUEIXL1a4O/uH1+ezJ0SoSRisJoio7Ydo
         5ZyqP1xRV3YgHTgvaRCqv508vFdWlmm6jg6HMduwb7s1o50Wq6MLrdKCt7kX+Y/V8F
         cxkQaj/IhlEOF7pPx5RpciAeUpH83UWCJQIhQ18OUR/PGrRSNjkjdxbMKA3WlFopIE
         v4N4Cca131Lqw==
Date:   Tue, 4 Apr 2023 13:58:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 3/3] spi: s3c64xx: support interrupt based pio mode
Message-ID: <61a67466-3467-4f71-bc27-d660e37c08ac@sirena.org.uk>
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
 <CGME20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040@epcas2p2.samsung.com>
 <20230404060011.108561-4-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FtNVjpVuw+7vGHgr"
Content-Disposition: inline
In-Reply-To: <20230404060011.108561-4-jaewon02.kim@samsung.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FtNVjpVuw+7vGHgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 03:00:11PM +0900, Jaewon Kim wrote:

> This patch adds IRQ based PIO mode instead of cpu polling.
> By using the FIFO trigger level, interrupts are received.
> CPU consumption is reduced in PIO mode because registers are not
> constantly checked.

Is there some lower limit where it's still worth using polling, for
example for just one or two bytes like a register address?  Taking an
interrupt isn't free...

--FtNVjpVuw+7vGHgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsHukACgkQJNaLcl1U
h9CjUQf9EiPCzbc8yrug4XOVx5vLrZjaqSwCUSDbAagu7OyC9xlCHJnwl08s/nyc
fmPzZrCkeg4w28iF5l59gmLVPvwHcU4b5x/Ehops1JPxGwRj1UDTHpIu8ZDkceuL
DcfowqDid6f4oHrpu3u74qeq4R2xjkEXSkERBDLjbE2Vu2qX9NShilxXBEcUpxJb
bP/LX7zmLRPBsuUADOOmUbdtdc6pj32ojCpMUUb3T4GlIkYlE/bCR8Clq+esPBqT
ZQPhF1n0oqyMvnXZhAN8VetYX7TamuBciAqHwDJnhng+HDKD0vmXlVeC9LGowMMo
I3hxrr8dk41jVOYp9hEgFXNVGh0JgQ==
=y4Gu
-----END PGP SIGNATURE-----

--FtNVjpVuw+7vGHgr--
