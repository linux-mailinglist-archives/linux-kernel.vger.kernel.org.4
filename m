Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5E6DF450
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDLLx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDLLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263A122;
        Wed, 12 Apr 2023 04:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DFEE63395;
        Wed, 12 Apr 2023 11:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EDAC4339C;
        Wed, 12 Apr 2023 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681300412;
        bh=1BnVdA7cg1GKugY79T0L9Xabv3Bh6hrULajUc10fi0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCuwDDl4XNheq4dN7AzCA7tMVQ9IraG0rBNwFbTXEbkJSVl5YFG7gN83MZzQxf458
         fkqgejAfTmOh0l0q0vaaFr0EkXcPvhmti9VCuy9hca9eK9qqmv2F4VIJK/EMRU0ZTN
         JPOSZt5Q1FdnkjcIfTZEy3mw84ZL+mPLJTVHu3BFLFrCm95GA94c/EpJ/Am0CEFetd
         lChKt1daI8KKm1GEnFlREMw5cS+81yM5MPYqo8h3RfEkBgCZgT3lFlx0Cpzwp9C9ex
         adLg9AdSJYrRvIsPcfUqLV+54dFwW6Pajh3pLrOSBb8V1QAZ8uedV1iSp9uJVQewTW
         WWiOGMmrI/ygA==
Date:   Wed, 12 Apr 2023 12:53:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, gcnu.goud@gmail.com
Subject: Re: [PATCH 1/2] spi: spi-cadence: Switch to spi_controller structure
Message-ID: <5c25cdaa-a4e5-44df-8a91-25e636e99cd0@sirena.org.uk>
References: <1680090384-25769-1-git-send-email-srinivas.goud@amd.com>
 <1680090384-25769-2-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t3O8x3Ecp5jUChD7"
Content-Disposition: inline
In-Reply-To: <1680090384-25769-2-git-send-email-srinivas.goud@amd.com>
X-Cookie: Your ignorance cramps my conversation.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3O8x3Ecp5jUChD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29, 2023 at 05:16:23PM +0530, Srinivas Goud wrote:
> Replace spi_master structure with spi_controller structure.
> spi_controller structure provides interface support for
> both SPI master and slave controller.

This doesn't apply against current code, please check and resend.

--t3O8x3Ecp5jUChD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ2m7cACgkQJNaLcl1U
h9DUzgf9F3xyecLHlcbp2BqGwUrGiE0p6nZ8Z1moyCkCM4y2YXmIe5QR8X5LrhRU
4Y3S1LHQW8+I1wQRN6kWv3OfGyiZxX2d0LHajQb+Y6u121vD/4zekCsuW141PYRQ
qtqcw/H8ChNzSOYaBVV9/SqK2ylyVKV5GiBbVuUOoL6YIIsZ04Ox/5Ivn8PFIkzl
WQVownJYOdFqMIKECNO58m5j8neT24e6FJOK8+UhE6D/oROolgA5q+/KzDtGu8IB
5VH9xDKjK5lpJUZeujCKLdkybBHyDeMz+Ba2OQ9a7tmGeIhX8t4xPlLU8y5eEgCg
gFzYBAEc2YXzDeWcgWeTe67GjmOMrA==
=/F1l
-----END PGP SIGNATURE-----

--t3O8x3Ecp5jUChD7--
