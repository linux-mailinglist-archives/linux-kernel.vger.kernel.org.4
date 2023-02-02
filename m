Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46818687C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjBBLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBBLmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:42:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08A8C414
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:42:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53121B825B9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AD7C433EF;
        Thu,  2 Feb 2023 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675338134;
        bh=8AzNixb4xVs4owedtSG8sTCOfFb8S5iNQAR8r+NfxZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQwfYR2NPvHwDjeYm403lPhEhb9ha0tflaAzLW3vKknWfhRsVbHBjdjbI+KKCyzhj
         yowzrYBOEB8JS7tabwYrzR9jXZCDu271i9G6UC53JdknMMkz6qQf48OAKALKiIPZnk
         8/gYLpRkA8aUqXTqgVgfJsq9LYVKuDu0f8+137JNd+w5CRDyYacC2eiXf+9wRk49Il
         ODfB+fUmnz7wFG2Qi4SPgYJ3vXVqezF8VITynpsWgmHDFXOEh+iOGhNL5cyJ4ghx/f
         HHYQd3XMGPQfGrOr7AiP0Ze3nCmMgnhRBVy8597FQqyLS0tC64CvlfMeLrriGF+9FG
         l1d8HyTxfBFNA==
Date:   Thu, 2 Feb 2023 11:42:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        linux-kernel@vger.kernel.org,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Message-ID: <Y9uhkEo9INU0IPEr@sirena.org.uk>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
 <20230131184653.10216-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mBPl7DRMq9TEhSTH"
Content-Disposition: inline
In-Reply-To: <20230131184653.10216-2-mario.limonciello@amd.com>
X-Cookie: Swim at your own risk.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mBPl7DRMq9TEhSTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2023 at 12:46:47PM -0600, Mario Limonciello wrote:
> A number of users for Lenovo Rembrandt based laptops are
> reporting that the microphone is too quiet relative to
> Windows with a dual boot.

If you're sending a cover letter for a series you should send it to the
maintainers as well, not just the patches.

--mBPl7DRMq9TEhSTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPboY8ACgkQJNaLcl1U
h9CdGAf/dKm9kij8B6NkqCtz4OXZSs3ntNhPZrdHOJRAqAbAYxfOSUW7vn7JxKL4
uj+mDVczOvS88KTVDMyzlLE4wG7aTJbYTITOnapi4DkApEs0h6JwuUIZSLTyljB6
mis7Q8iuG/+jIbEiI5c7AsRZ+d7PcmVpTWT5coMeHgWpb8YoHIVsoUqHVzpBDo8+
1gwr1oIGG5pcf+UbgChgafDjt+SOt7ak2znfZ+bav/UDKz9r93k80F0CUcZhsMg8
KWu2mqzQO5cwMrjA9Y7ghkP+HLRL/6LlqRpOdWyYJVTX281KmwZlwiWbOpHORlqu
AWae882bIQonj9D/ASxEyfx/euaplg==
=4g9a
-----END PGP SIGNATURE-----

--mBPl7DRMq9TEhSTH--
