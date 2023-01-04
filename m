Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80665DB05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbjADRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjADRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:16:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835FD64E8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E76B81714
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D10BC433D2;
        Wed,  4 Jan 2023 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672852569;
        bh=XwOijTKRs64E9IkFBMlrNumius7hSHhyVy94XZxMOFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKDHvQ+qPwAoQ/3XivrWZXA6qfjLz7QRcK9K2gl/H7uHPDTWXNPZEfDgXSphczRLM
         4FnptcvjM6EUEsVNzEnweSH3spHn6Hnn1UYku9wgWR0uvXcgU/f3xUUvs/2+N5VkGA
         u98x6PGmHC4neU9pbEVPd8BS3OaZ72/wL4ZQ/fXtYmBqf6JhcrUp2abr+2NaASoqFH
         WN1eRK5YyywXGb7gQzEeBGBI24X9QoffodDNasyLeO6qs9/AaofP3M47BZvDgk66eg
         tmsmxFiFpeeuOn7UNU8MKcX1IREPItqAh0zPRljUJ+fx+5UUiIFNHaM2cpjaEemzmE
         xiy+TxG+aal4Q==
Date:   Wed, 4 Jan 2023 17:16:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-ID: <Y7W0VOJKlMtaIp13@sirena.org.uk>
References: <Y7WtywhUZCTx3akM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DzU3FZTl/qvLfKOs"
Content-Disposition: inline
In-Reply-To: <Y7WtywhUZCTx3akM@smile.fi.intel.com>
X-Cookie: Stay away from hurricanes for a while.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DzU3FZTl/qvLfKOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2023 at 06:48:11PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 04, 2023 at 04:42:28PM +0000, Mark Brown wrote:

> > According to b4 you've only acked the first patch here because Andy
> > doesn't send cover letters :/

> Is b4 capable to spread tags from cover letter to the whole series?
> (Sorry, I'm a bit outdated with all Swiss-knife possibilities that
>  b4 provides)

Yes, it does that.

--DzU3FZTl/qvLfKOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO1tFMACgkQJNaLcl1U
h9CXiwf9EWr+UeDMVySmEBhGp8o+0wnuHvOhwQtbbLZfRNGFujw9NVRQ5CQ6nzzF
GcXZgSV1AZZg4l6BPBTHh1OBKVT4l+xURJjZ32un5r6f/0xmdAtFkx/+pRa2loIf
B6skxnNOBbhyeaOZ9/5XSnnODmSSeRqw55aBvHHfOPFrXIHsFIywVBgD7ILrFL2V
49RATfsii5jzsob/5NH//fJY23hVHWgZMKWW58pail+bKRujcG5hOiqbAFICJo4T
O/hFyzjD/DbkQQGqCZtF/f+bwtBdEQQcxT9PX/GpDkSJ0CEY1EYLuBqOG868oix9
/zEhGqpQQ60lejRHV5rPwtjtoaA7dg==
=JwZ6
-----END PGP SIGNATURE-----

--DzU3FZTl/qvLfKOs--
