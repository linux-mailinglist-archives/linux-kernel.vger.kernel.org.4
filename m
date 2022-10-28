Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1512610F22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJ1Kz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiJ1Kze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765D36DEF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99ECE62790
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5979C433D6;
        Fri, 28 Oct 2022 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666954532;
        bh=nFjORNVTf+TRMTqeQVeerWjWKXAbrWqpRQns/dwztZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fwykub34Q/MCGz93v7Hwgci6uIPqgu3jabRJeXTGzBxtex5OQtPfDjLhHRr1X27/P
         lOnKyB2yE7kbtXgOJszZR5KUIZQLXkFXHKqVVBMvpUf7dJDJ6esUfUuzKa3n53i5/W
         rV955CvlssvxXpAsQdiU94YmQ4oDxXaSK5uUUVUrFMcm81LXn6WpHi1YgbPdoXfsGq
         olgIBXyzg4fHqqHn9/oyCVbGKA8V+swsd/rnwQeY5q5lJzjpCGIUn/IykFqgfvPniF
         CFKOflsqP5Qmv2MLYqhN9dFIe4DOnvFsPGaU4OI63AF2RLY0LGClA2VrxPMlBRmMON
         8imltCwKdmPdA==
Date:   Fri, 28 Oct 2022 11:55:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Bergin <peter@berginkonsult.se>
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: cs42xx8-i2c.c: add module device table for of
Message-ID: <Y1u1Hl7GaTlS/jeF@sirena.org.uk>
References: <20221027115057.442925-1-peter@berginkonsult.se>
 <20221028075045.493191-1-peter@berginkonsult.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lt61aAraIxElQ1nh"
Content-Disposition: inline
In-Reply-To: <20221028075045.493191-1-peter@berginkonsult.se>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lt61aAraIxElQ1nh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 09:50:44AM +0200, Peter Bergin wrote:
> When trying to connect the device with the driver through
> device-tree it is not working. The of_device_id is defined in
> cs42xx8.c but is not correctly included in cs42xx8-i2c.c.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--lt61aAraIxElQ1nh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNbtR0ACgkQJNaLcl1U
h9AFqQf+K+eRfq9uKu9Z6qplac0kFMuatMLuwnXT2FIu4W4Y7v3RNeJG9wTfzcjj
5uhk1Czmwp7/t3rsKYJM4Yncuwfk+nB723EspO+95glNewFMzwQWFHFTmU199tVI
i+uu+L90LqfcvlmvBa2nWPp1lX2vFFhqd/xRMfnGG0tnX+Ell9GzZW5XTiStKrZX
l7ltevbWMvJ+5g87SKpzZ9AU0Gsazkzx6dBT0vxfUVwBV1u2Oyb9LKo+mqJ7ViGg
lM8ZpVJmCJbMczHyfr+c0/yyo2uTjm4+OLz23ABISSl5YiAXi8roV2k/609AiQqj
F1gvTDJ8FrQXIQwsHHXxMEPiGe93Dg==
=fvxc
-----END PGP SIGNATURE-----

--lt61aAraIxElQ1nh--
