Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4541E6511A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLSSQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:16:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561EC2605;
        Mon, 19 Dec 2022 10:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E86DB6108D;
        Mon, 19 Dec 2022 18:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66441C433D2;
        Mon, 19 Dec 2022 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671473776;
        bh=xf8iFCzl9zuXuIZoZeKbqKyIeX7Ltc9DNWcGsUf9asw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0xO+GTMM6RneQprCz7daszheO8/h/FCWFvLmanljzzDwzmHLyArI8bqC8kK21RSX
         W0iHknaZ1nn2s5z9j7r7942rbYfSViWb5HeZcSVr70lnGpL9qQg/uHX2gcqXT3HBGd
         uypxF8yMN2KyH+ra4LwyIBkEoTQBWuKyYj1nwA9YucsaXqeI+wciVhAf6BvX7OfFIZ
         FgjS1yw6hxLqxWicC3zaGQYORtEs53LlRZe7KYJ4jMFuGVqyRJ6jHwteZR7HOKrjXh
         qwbRV2XwihEpuqPRSmO1KYW6dsYXsx+EIdj6YB/Oilk1oLyvl3Sjj1Hhfz2bbMQcIT
         1wOqe3l8OQBvA==
Date:   Mon, 19 Dec 2022 18:16:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Witold Sadowski <wsadowski@marvell.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
Subject: Re: [PATCH 5/7] spi: cadence: Add read access size switch
Message-ID: <Y6Cqavt/wT2sQfRU@sirena.org.uk>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-6-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUY/ItggUwzxJAnk"
Content-Disposition: inline
In-Reply-To: <20221219144254.20883-6-wsadowski@marvell.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUY/ItggUwzxJAnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2022 at 06:42:52AM -0800, Witold Sadowski wrote:
> Allow to use different SDMA read size.
> In Marvell implementation of that IP each SDMA
> access will read 8 bytes at once, and is not
> configurable.

If this isn't configurable then shouldn't we just key off the compatible
rather than having a separate property?

--fUY/ItggUwzxJAnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgqmoACgkQJNaLcl1U
h9DQwwgAgdo84Nf5Ics4LK4oxae6TizIsBnruqnm3WPEvcjnNlSWq1bejox99uH5
3hPpyBH8pxhAJIwkUHukxVTsZmjdd7x7ZeNUWqi0nV+EFbEWZkpPsR2wb4vEuZY0
KtB9mufJFdBmPmseqLGuSObzLtJoh9ERjrY/GtQil77IO5Zd/8NsFFId4PibehAQ
2oK0xezwLv7N9Jd82b/Ai6RmE35sg50Rf0UlP7v7NnNTnbOyvpyTkD7SYzEFeWQu
jO2B3dorzTljzIkAmnvuq5yMkPVBeO85mK60+gNaJvAg4WeuC4R5IgrwqJGLxSmJ
Bwx1geciQym3FAbIb7kJjLQIRKv9nw==
=Sai/
-----END PGP SIGNATURE-----

--fUY/ItggUwzxJAnk--
