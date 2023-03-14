Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894E6B9650
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjCNNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjCNNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C735AB4D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F4861769
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F63C433D2;
        Tue, 14 Mar 2023 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678800544;
        bh=+YB9KE6sf0iyiR5V+tN3GVCoEoKrBJ3DoQtL6YAL7wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaVTRxNS2Qx2vbsg9ClqTv1mr+TRIjo4DIkTeAlfxuPeH8aszhTcUXKcuxSRs9TCG
         r27O3sUcOME//K5tQDdsznuyg5sjjuYNEhEIHQYnbskIiAJ9I2v4rJ98hotfAr8Epk
         73G+UNH0m0HG2818WtFjdT/xlgY+4LJ1jCiX3iRjzav3npGMRAN6usKcEbm1i4wrrR
         1PVp7ZXoJb5xCc+O5Y6SKKfZMYgOmbpaXHm0K4pTyb9LZqJa/Vs0NyH/Tz2v0qCmKJ
         l9KeBS+v5P+Z+sWrhWbQYWOCuQ3kADnXya4Ednw0hkE2XYYgVXG+G6gxx81L893ECD
         193lDR5UKSVWQ==
Date:   Tue, 14 Mar 2023 13:28:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 2/2] regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS
Message-ID: <f76b82ef-bece-4eee-8711-ceb2f77b1c6f@sirena.org.uk>
References: <20230313181820.2482385-1-dianders@chromium.org>
 <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid>
 <89bf362b-6c63-447a-ad4b-91385bf26dab@sirena.org.uk>
 <CAD=FV=XWaWfDy+ZFjwq6hK4ssTtGjxRePzF2DooMAOg3fziZvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ub3Y2Twz+mMMVDnr"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XWaWfDy+ZFjwq6hK4ssTtGjxRePzF2DooMAOg3fziZvw@mail.gmail.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ub3Y2Twz+mMMVDnr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 12:49:37PM -0700, Doug Anderson wrote:
> On Mon, Mar 13, 2023 at 12:05=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > This is going to be true for all regulators...

> Sure, that's true. So what are you suggesting?

That we shouldn't be making this change for just one driver, if you can
write an identical commit log for most if not all drivers but are just
making the change for one random driver then that suggests something is
being missed somewhere.  Either there's something special about this
driver or we should do things consistently.

--ub3Y2Twz+mMMVDnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQQdpoACgkQJNaLcl1U
h9AdGAf/R/330hSIvqTaSlwLfV8OuMiz5vOwRoCbkCO0eYs1vncDV1Bzq79QeGhp
2wN4eoxt1UgnTmjYhBJ46b2HkdowzfhbEof5mUx8YZlI12W/Tww/1kre2N+Fhm04
Cv2ldC6VjiOj1kRpSUOHWiSg4JZGtKDJ49fFPNXxJg+JPI1YxgEFURQo9cKNRR+P
uirIOO2NMPiLnMNhjgcgu1aelCl2ZBcUCSHYPWrbr21ucig7goiM1aMVl+jHgYwt
URfA+NVOd9hmCMnfrftSJfSZL84AF9LgOBzIy1xy62cRtB0M6ZHB4iKgjrCjfVa6
V0XJ/uUawhOuYSz/1Idd2tDYh6gLLQ==
=FEdb
-----END PGP SIGNATURE-----

--ub3Y2Twz+mMMVDnr--
