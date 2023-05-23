Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A43970E557
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbjEWT2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEWT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0CF11D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF95633FC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA5EC433EF;
        Tue, 23 May 2023 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870111;
        bh=9570lVFvsab3sHmAwYsy5Py+ie11vRvjp4TrSWAcHOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hn/XpaiWgJB1341Kul8AmNnuMLemxuYYiLj/dkCLRlKo4sWLCmiHtkgZllmoN6NRW
         8WOZJTmLK7Pzb1kx8f6PIU0cYU+8SQRZqM6c6iW1764eiV37/CQjfW3Xobo3VOxCN7
         npk0amvCb3CLIvNrfQCEm2feRSjz58RZS1KrLoW/vcDl36+mZe2e8XORsWPytpux9M
         bNZnhL2VAsue7Cw2VunzBNYMqNg/nVe49dyyibqnlpaiJ8Z1sxs0U84wdMX1WKf9yY
         18wkF2RRRwjquBXxYoChA/dpv1fCKOINm84zbnuiFg7k941ub838KqyZ1M0OiHdFjc
         nBPs1KLjAiTYg==
Date:   Tue, 23 May 2023 20:28:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5682: Use a maple tree based register cache
Message-ID: <73925372-33dc-46ac-9d01-a43f10988d28@sirena.org.uk>
References: <20230419-asoc-rt5682-maple-v1-1-ed40369c9099@kernel.org>
 <1ce6bb84-3140-3953-e995-00eb7b16f386@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7GEEcFt0ec12B4U5"
Content-Disposition: inline
In-Reply-To: <1ce6bb84-3140-3953-e995-00eb7b16f386@linux.intel.com>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7GEEcFt0ec12B4U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 02:24:53PM -0500, Pierre-Louis Bossart wrote:

> Wondering if this is the root cause of the regression we're seeing in
> [1] on a Chromebook with rt5682 in SoundWire mode?

> I don't see any other changes to this codec driver and the first problem
> detected seemed to happen when we did an upstream merge last week.
> Unfortunately the last merge was on April 24 (sof-dev-rebase-20230424)
> which is just the day before this commit was added...

Try a revert?

--7GEEcFt0ec12B4U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRtE9kACgkQJNaLcl1U
h9DMXQf+MOlb6P/vm6s61dsrFcCJjZL3nsqRyomvvwZvv0Cuybf06OdSw56IDX35
HIC0p5lcmUqZvPocsp47VhHsdKmjgXcOZlTmJ4Cgv547WTDYJ7J/mBW0UEmuw60K
PSxDlc+baG3nwwRBMID2kPvR3tMbZfg2uWuMdibKONgxXZCq8oXLAlcnU3SSNK0h
nzb1BaI37CrmXI86piOPbfKs38K86LjXwHiP8PICite6lqgDnD1dAL0H0Ua6LOnR
+Wv0114uO7OQkfI3qsGKfjLKK/Vg3I0s4PAc59u0jjQrIz515oOY6ASwasmxZcOZ
y9G71AGSmWmxJyM4rxQywNsl75Rr4A==
=29Ur
-----END PGP SIGNATURE-----

--7GEEcFt0ec12B4U5--
