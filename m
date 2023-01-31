Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4858F682D83
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAaNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjAaNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:14:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD6A5DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:14:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41C1614DE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD60C433EF;
        Tue, 31 Jan 2023 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675170845;
        bh=MvBRUhXs8Mb0cjrqONXBDmQkhlrVlqX5fAH9pVKnyP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bk2XSB6LliekhTckkTnGX2h4Q3EKN4p2737yWZSVKsvN3yn7XTumWApmg6K9wUvM0
         n4Mh+XaZk6JcFHsjCs85sUJ8J1/iKss6izVsde3nagHmWOxHhZNxxLGOHiEzdTgVCZ
         FM+TC+0OhOk3CkuLQP/vW7+YykUiZjdXRPcQkY8rBxnSbfOQwHT+HTVPQWfRmsz0u9
         7lEfEZ89NIUsyQri1qV+D4GG/nBT5cFLo7AVfee/yp2GZBuuoP5YTaCqQnTFSlpGOE
         LfCAxr0p49YhcAF+si8IcEQ2P9k7Gg2NyNj2kYuqXUzbqCs7gV26qJnMtN5M7I92Rj
         NjofA5W49mMbQ==
Date:   Tue, 31 Jan 2023 13:14:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64/signal: Signal handling cleanups
Message-ID: <Y9kUGGYpWvbb1fZC@sirena.org.uk>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
 <Y9kO1egKjKNqE0zg@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pEWZi37D5UvUp+u6"
Content-Disposition: inline
In-Reply-To: <Y9kO1egKjKNqE0zg@arm.com>
X-Cookie: MS-DOS must die!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pEWZi37D5UvUp+u6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2023 at 12:51:33PM +0000, Catalin Marinas wrote:
> On Tue, Jan 03, 2023 at 08:25:15PM +0000, Mark Brown wrote:

> >       arm64/signal: Avoid rereading context frame sizes
> >       arm64/signal: Only read new data when parsing the SVE context
> >       arm64/signal: Only read new data when parsing the ZA context

> I'm not sure these add much to the code readability (and the performance
> improvement I guess is negligible). We avoid some copy_from_user() into
> the context structures but rely on data read previously or some
> get_user() into local variables. Personally I'd make the
> restore_fpsimd_context() also do a copy_from_user() for consistency with
> the current sve and za frames restoring.

> Personal preference, not sure whether Will has the same view.

I don't particularly care about those changs either, Will seemed to be
asking for something like that.

Note that I should at some point today send a version of this series
rebased on for-next/core due to the TPIDR2 and SME2 changes.

--pEWZi37D5UvUp+u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPZFBcACgkQJNaLcl1U
h9CM0Qf/Q4kwXZ5gT5659flGrSzy49DIrxrJyXlQYg6be5W2GMKo+isJeXnSQW72
YZ7ROEKBRMC6Fnv62XGwiSWXtETgEm3xWK49QMnUd2Xd91P6uRdM5hB0EvvBZ+8r
rKTJ4EpDaIP8+kooqrBz0JBFDxfiR5uUo8/Vy1YuFIyDbK39hJnwyS1Dq6rqZd5+
wJewvo8Jef/oqYsB+kGeiv5WIeEUz/CQKAWkpvHFYcOCP1WwTe1W0vsMjF8tmjxi
5tHKzWqFo/O03dyJf+5C03h2ud+1p9V35bKP3OloKSKTPDUXIC44Pem0u3wQ+yH6
rVz3iF8vy7zfylgHM3IgTsCYgyDbYw==
=u87Z
-----END PGP SIGNATURE-----

--pEWZi37D5UvUp+u6--
