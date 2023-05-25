Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D3710F40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbjEYPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEYPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2C197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C513618AC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C2DC433D2;
        Thu, 25 May 2023 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685027645;
        bh=DOzvr9e5uK6lrz/mfIuCZuW8BbAmyTO6HzleGT/iWwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=keIM/Ttn9errtDpHITF6we1CF8Te3YW+ROg1/Lowl1DCBbHkZloMqOKIHKRUfNGjX
         GJiHSa7KYtOZnygF8pzpvYl+CZp/zaA8AYESm4F6sbqZr2CKDuNwxXUqUGz1gscQyf
         P7Lx16cLfT2LfbL8YxurKinZL56Uolxgn7TFikbAe8xv18rwQT2fkC6pxtoiZq6K0f
         8xDCWZculAhUKpe88M5ibDSGLBqaS1oqiNU6Mis7TVzAW/kqpBTgiEI2J8uitcWUp7
         X+m304a26z/gfc5+zzO8e+d310767e3WY1CIx4m8W3cwLEEPaRrU+Nzy20Vq/WwoGE
         4wRn0zdPitx+g==
Date:   Thu, 25 May 2023 16:14:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 08/13] ASoC: cs35l56: Pass correct pointer to
 cs35l56_irq()
Message-ID: <b95b2364-c190-4c4f-8136-a75988be8ce3@sirena.org.uk>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
 <20230525150659.25409-9-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YUNpvwja1CqAaEEL"
Content-Disposition: inline
In-Reply-To: <20230525150659.25409-9-rf@opensource.cirrus.com>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YUNpvwja1CqAaEEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 04:06:54PM +0100, Richard Fitzgerald wrote:
> cs35l56_irq() was changed to take a cs35l56_base* but the code
> in cs35l56-sdw was still passing it a cs35l56_private*.

For bisection this should be squashed into the change it's fixing.

--YUNpvwja1CqAaEEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvezcACgkQJNaLcl1U
h9CtCAf+IEpYinky0Ea5PSxZLDp/W7ev8IhIif7QIHXfD5F2xWjMCpw6lROWndWb
Fwc1GMiR/M5S3N+aejyZ3rrlqxUoPI/ks6IiLVU9IRgZrVO6zUUuq6ndfGWNYzUp
rt2Y+D7FyZ4DY8Brp5TFWww9ohuxR0+Y1GKUES/pyPQIMxBIJqYxHZc15JaK9bxz
mUKFmnM58GD5Ia7gIJFJol2aNMk9LM8K33bV806HLY7qBy+gbdHiUU8vv/tZxHTF
L+KKGdi3/xvx47kDk7moHGGNJden1h2wT41SaVW4BHTsgHqowPkAuF4d9vauVvI1
km99GXyiyzvfV0qiuYkQ9glyb01Hog==
=XYvf
-----END PGP SIGNATURE-----

--YUNpvwja1CqAaEEL--
