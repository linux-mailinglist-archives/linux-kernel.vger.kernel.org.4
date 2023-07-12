Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2E750C58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjGLPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjGLPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D8310CB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B600A6184D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F56CC433C7;
        Wed, 12 Jul 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689175396;
        bh=CBAv5KX7B1FxLIzBzn77XTf0tZXAhjcehlFhJ5nOPUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsjDkFJB9zFmE7Ay55YaI48lZA52jOWabEH5yn0JedxtOJzs1afI845CQv2+MVRAv
         +f1KY/IdnIivEpeJS5MvksIYH0aDkiIHaqTxXoHske/JJXyM9hUNzcY/7IEvlQzGHu
         xr825FWBtEmgLPLVnNlTxLsyRbFBp6BLg0+bJZrkH+geZXGGjxI7FGha7g2KfJAQbK
         agrGZRFxwpoANR6jCu9WY+kLX7YRBYYWf4xb9JFD8VbLo1hEJH4J09v+se3tbVzDtG
         ABRcMLwQUDkDIk3ACD3GUKISPwCXJcJdaTSwM2RMMGWPr2A4lvxQsz9/cKwpdd85Vx
         pHSlu9sLbhqFQ==
Date:   Wed, 12 Jul 2023 16:23:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use
 device_get_match_data()
Message-ID: <d5cac1ef-1d44-4ab7-a933-b381108b1eaa@sirena.org.uk>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
 <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
 <ZK6xI8l7Vdp35yJG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Ui5GpKY7zYS59Df"
Content-Disposition: inline
In-Reply-To: <ZK6xI8l7Vdp35yJG@smile.fi.intel.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Ui5GpKY7zYS59Df
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2023 at 04:56:51PM +0300, Andy Shevchenko wrote:

> JFYI: You might need to amend your scripts (?) as in the merge commit
>       the Subject is cut (I believe that your scripts doesn't handle
>       RFC2822 long lines in the email headers).

Report that to Konstantin, this is just b4.

--0Ui5GpKY7zYS59Df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSuxV4ACgkQJNaLcl1U
h9BuQwf8C/mc0vg28M9xPMJZIMtURgHn6o5uk8aXPYVLajseTotKqn28i/r12tYF
aGSiMs8rAfxH56wyH65D+t/veFTg+B3+ZzttqhxU26p9JCRNLWBLpb/JeuTx8KUW
tD9cUr1koNQWtV6sCHRYs9hLOrzDElFGFARO9OCA5PeXgOZ+yQmC2JXNesPZob1L
GbVe7uOenBI2A+oBa8I6Z9xaIkSiMMf8qQlL79zZTIDQ2As6SPmzXNY9PoBitb/F
Xfwo1ckGRE/JWEB5AtUDXIKq7OjpULiGsNGK38Br4OFkPsDqe8UfvekqoSnZLnXY
qEZTl5YWzGY16cGbDhJsBrhRpUEniQ==
=Lske
-----END PGP SIGNATURE-----

--0Ui5GpKY7zYS59Df--
