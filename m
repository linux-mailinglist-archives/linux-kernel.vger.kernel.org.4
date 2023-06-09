Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08D7295C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbjFIJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbjFIJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E994228
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FA26562F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CD6C4339B;
        Fri,  9 Jun 2023 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686303571;
        bh=2RqJTUusjbxWp6JJrQrKAubtiwiOkGgS0OIMXhczqdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bioFzmiax2w20nUH5t8K3WmPTjuTEYjWc+pOmXdEKvCYBMb2G6PElrCfIJ7O/PN8N
         I2VIQFynxR44Yr8U2Spm9r+s/vWPA8nNidCtQ1K1Y8VrUWe3doiODxwvIFEZjYCwUZ
         pY8II5CPyyjpUGgDMxEw05A5O+Har0+CWh9ws0LLofFGfVgG6UIny/xRVZ2ECBJfwD
         q3c8IE4pfYsv/go7Hf7OnKLelbndA30iYvDVHo7BPprfwi7cSECAunXZiVh28x9PZ4
         6yze7jJllH+gIvLVWJL5qs9A8gsPe90o6SzdkN3LYP9u+HT15sllyeszWlJ0iExyeN
         nJJZp73+B9/Tg==
Date:   Fri, 9 Jun 2023 10:39:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack"
 from Headphone pin name"
Message-ID: <abe6e5f5-7373-44fc-90b6-2c01b1f1e96e@sirena.org.uk>
References: <20230608221050.217968-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vb2jlj/7oqDgwj74"
Content-Disposition: inline
In-Reply-To: <20230608221050.217968-1-nfraprado@collabora.com>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vb2jlj/7oqDgwj74
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 06:10:48PM -0400, N=EDcolas F. R. A. Prado wrote:
> This reverts commit cbbc0ec6dea09c815f1d1ef0abaf3f2ec89ff11f. That
> commit removed the " Jack" suffix with the reasoning that it is
> automatically added to the name of the kcontrol created, which is true,

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--Vb2jlj/7oqDgwj74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSC80wACgkQJNaLcl1U
h9BJWwf/a4nq9jEGhBCy1pyCmPzoBI5oa1mVa3qi2EmesjaoCpgBYGoN2BT3fZ8m
h0nrfOqJrpjCvv0zoVX6F6rMzFyGZxhEWmNa2DiLkXWEZcOB92i3sj6QQZX0RFoD
HxqIGjNg44pfd7MkrTnqAtb09a8aOgdjVZmrNQIHS2Gq/XYrqL5je+pYKiyjs//D
mKU455/DRQpzNZfmcdKeiSAmCkxJsqPV/COcMv25yWmmnzZB967MIF7As97Rcby3
nQMMW4fJkrF2Qr6hyFlqirABm5OY/3ILTUprg5xPZHqSpShCG3sTB6j1vLHg6yYo
H35FHE1W2vBzR0u/ECy3AmPSiCr3gg==
=hy/b
-----END PGP SIGNATURE-----

--Vb2jlj/7oqDgwj74--
