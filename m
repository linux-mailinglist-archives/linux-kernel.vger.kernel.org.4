Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C66F3B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEAX6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAX6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA451FEE;
        Mon,  1 May 2023 16:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E9E61516;
        Mon,  1 May 2023 23:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B200C433EF;
        Mon,  1 May 2023 23:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682985517;
        bh=e0u9aucvc9SvcADXuJZwmwIjMBpsHUxk0ihHfAuXSOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blvVEd9iOPU7KtBcxpUSR7ih0WluBS6gEZUPgeveBmgWwJKOYkK4xNHvtOBoUkA/U
         Sd14335qJ/xxVyz3YCKNsZTJQXdjQy/UjfTNj89UyhmB/tsP/ETTMQKEulUBeS0sCk
         /hvbmuVxwjL1dFzW0AZPIKganJUW0ebEeNVqmPfD9oLA3Gz4CrTj+vtK/7h9IM+ymL
         eDdn60LBWfXVpP8UeVDw5Ocz7vvb9w4Z5PZLjhM6CXisAYPqMFMwlau8ZsjQt2ezie
         nWYOvGQ+06LzoZs7ARwDqqaOKOLXPwWyH++BQc+8UeEpDypeY0utTHB406XhsRagXZ
         H9XgviUCwdB1g==
Date:   Tue, 2 May 2023 08:58:33 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v9 0/5] spi: dw: DW SPI DMA Driver updates
Message-ID: <ZFBSKd1Z5nUg60s8@finisterre.sirena.org.uk>
References: <20230427123314.1997152-1-joychakr@google.com>
 <20230501171409.syub4ro3kb3r6ho2@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isplOYeQgWbnqOfJ"
Content-Disposition: inline
In-Reply-To: <20230501171409.syub4ro3kb3r6ho2@mobilestation>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--isplOYeQgWbnqOfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 01, 2023 at 08:14:09PM +0300, Serge Semin wrote:
> @Mark, @Andy

Just as a note please don't add random characters to the start of the
name, for whatever reason it really annoys me.

> I've done with reviewing and testing the series. My tags are already
> added to the patch logs. @Andy do you still have any comments about
> the updated patchset? If none, @Mark please merge it in if you are ok
> with the changes.

We're still in the merge window right now.

--isplOYeQgWbnqOfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRQUikACgkQJNaLcl1U
h9DMFAf/Qmm1wMq4k2HE1ORG589Uzn3A4T0GtjOaKpSI6O49fcN2iYmrI3whE3rp
GQm0MUXv38TeDEkCQju+pTzckV4H+TjH5LmSjnILj+geOGmEfdthW1/p51Df7yTh
1wGd7VMDB2qzH5zHVLyGuze8Sf8u8shUHOdpUhnec35+RcqchRoiKSAJG6xuflnE
zX6xSn52jJwd/1+I9Ux7mImzvbM5cuEe/Jfe63rLWpjXvndzIluKxis/3hYd3YxQ
rtXOkdK5DsfZUlHGNlqeqXzEQVS6iCiAC7eMNdj2YrYzGWHeuJPZy3FvlKREBlJ7
SJSnRePFD5weair9qD5PrMb0g0b9gg==
=W4Ak
-----END PGP SIGNATURE-----

--isplOYeQgWbnqOfJ--
