Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F651610F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJ1K62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiJ1K6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA901A9921
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F29AE627A4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E6BC433C1;
        Fri, 28 Oct 2022 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666954692;
        bh=wSbXFh7ARUVjIFut7VmSHqRrzlhIsC2f690NqWfFock=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiIMsceH4+Du864QrRSonSkMOTqw2po4qsVpIb1OCgXs6nl+9E7S6NIYbWmI1bXtq
         8lsz9+zbuarRxHpCvsGEv9dfX6Eo5e8pyrLT4pBf1QHe8hqTeRe+OY7bW1M69PsZtq
         0UIYYgkdGAFh9hjbP5lCiZrijGe48Nd0MzOfcfpqqam5u2eMqWygCrDH6qW11Zpgxv
         +Sh9T5fLa6MgJsRjahyzW2aSEsFn2JBQKYcia+U34S+kEdjq2CagRqXl0B798196Fd
         Zd96twoAIO0HrlyTR0RkIrsDkfBdVVkA1z08LPk+DiO+zW+tjhFEMByWrJrtsWhcS1
         hvEuKEnRLHF2g==
Date:   Fri, 28 Oct 2022 11:58:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Message-ID: <Y1u1vj0K3m33wCTd@sirena.org.uk>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JMQDwmQnkQx5pq8/"
Content-Disposition: inline
In-Reply-To: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JMQDwmQnkQx5pq8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 04:04:41PM +0530, Venkata Prasad Potturu wrote:

> +static int tdm_mode = 0;
> +module_param_named(tdm_mode, tdm_mode, int, 0444);
> +MODULE_PARM_DESC(tdm_mode, "Set 1 for tdm mode, set 0 for i2s mode");

Why is this a module parameter - how would a user decide to set this?
Is it something that someone might want to change at runtime?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--JMQDwmQnkQx5pq8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNbtb0ACgkQJNaLcl1U
h9D8Dwf/QiIzLylr1xgVaq4dbxjUm9R5UJN5je/Jb3kVw4bwasSnkiqtTnmrbaSS
yLIy1FBYm0pw5SRhaPlG6vWSBqJ9LrAOxEeJj/w1aw8E5djxn/AWHGC2/RVNN7K4
CN7GBQUNEMXnejeFjhza/cwZjD3wqBOYOWlg0ymmbEil2Og9YCnvxRzwYg15fUPh
eEl5hqHt0fpuSLFKKeIzdVAVNfo1XpUc6NnIjb8ns2lCMdLK6oqfZla9UMzOvzsO
EpmeAp5ziXp2v1ggIHx0jP4bGhVcx1lpyQv6D6v8VNMbNbI2LUZlhUQa2altyglK
7oI3JoiKBazvBZP5bRzp390vCGe/yg==
=f1zx
-----END PGP SIGNATURE-----

--JMQDwmQnkQx5pq8/--
