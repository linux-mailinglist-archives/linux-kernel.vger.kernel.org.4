Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B263B0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiK1SP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiK1SPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:15:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE8766A;
        Mon, 28 Nov 2022 09:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1AB061337;
        Mon, 28 Nov 2022 17:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5CC433C1;
        Mon, 28 Nov 2022 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669658263;
        bh=HOm5tlWIniy5T1amAXM6Y8prJ7Kjyr4oEW5FOmYDoic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkZTBD09uxBmtzSZiuor8HjGnbbP1RV/lyx2WAeOihIR7vO4VrljoBY1MtGSNUK3E
         98JP5V9jtxBTF8PDeS1XarMMo5dPw+/rlowPp8unwkO1PMiK6Ru1I65LBMcTSN9y1F
         9GH0y3P0Dz2GPAMi0QFsGEEODDYzzO5cvYMhjnOMpDT/P6DG306vNIg/sGCjE87b9Y
         pGcerHb/jNWALLUDd5Ibi7KJl7j/OtUgs77xojC1MVkaBYnhiZinT7MRSVPqm7rBZv
         UE3nRqjJFcSb7VCYe7VKxKUBmw8jRLpE5LW2EE96f73kUoLNevfSJHiATVXCL4/B96
         OCl7V7suyc6hg==
Date:   Mon, 28 Nov 2022 17:57:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y4T2kowzjQMqxckF@sirena.org.uk>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-2-j.neuschaefer@gmx.net>
 <166950112932.8087.6546134123286782729.robh@kernel.org>
 <Y4SV+5/3Y0dw5QeU@wendy>
 <Y4S+oWz8fNsQj5Gj@probook>
 <Y4TBIah6vJAG3kj2@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8hu38K+e8vZwubEp"
Content-Disposition: inline
In-Reply-To: <Y4TBIah6vJAG3kj2@wendy>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8hu38K+e8vZwubEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 28, 2022 at 02:09:37PM +0000, Conor Dooley wrote:

> Without being a Responsible Adult^TM for either SPI or DT, my preference
> would be for simplifying the binding so that if your clk stuff doesn't
> land for 6.2 the binding checks still work.

Yes, please simplify the example.

--8hu38K+e8vZwubEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOE9pEACgkQJNaLcl1U
h9Bs1wf+OUxEzRc8Sldcia8LNWHm678IKCqgxrejUeJvY8R7o/7LTsHa5JVhnTt3
Ovq4CmMPJ+0bEF5DIDBxGFWNfEA5C1E9eNJOm9HWTpSYfxZTpBRcP+YC0p1bS9pS
IQhoCxI4K+iYfERMqy6QDCiBCXr9y0+7QHQvwJGvjHNwOXrfEeGdP8GACFTYzCno
3fMMk+tuTUHeRiLKCjdDSbEZwYzMwapBi5mXKS7Ocj+S8SIZFe4zQWY2ViO21GtA
SYedntOzggayxP4PyoIdxyoju5UqteP59QHtE28ygxkzZZt9G1dKhbjhzQ8QAviL
5rv8aCuy9lWvUL45v2NzDVf5/IzSwQ==
=bB+P
-----END PGP SIGNATURE-----

--8hu38K+e8vZwubEp--
