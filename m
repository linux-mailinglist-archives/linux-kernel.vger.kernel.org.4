Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4D63A9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiK1Neg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiK1Ne2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:34:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DC1E73F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB6761178
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338E6C433C1;
        Mon, 28 Nov 2022 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642467;
        bh=6ZyoE61TU6oOaDkCB796SpvFg4qPHeIhaVpyfOHlwng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnGFuAvrwQanpdHYFHp1Z8ly5ChADa7N19NtPaqRgL0JXq2wyj2idESDwAVskm7JZ
         xO6M2XGDQtyeZQvJ6kfQ4+G35OpL8xjL0qbzoRaHHefC4aq3pmSixrGSNRfJGM78NE
         h0xoGGry9xCZn3cmOYqcqPR4C4DKph5p63KbH66PyEJdS3xLa2jY0iFRYOAOxslqEN
         I6IfBd5VRrQL55KcYV/ZbwncDmW2Zbe1qibzaObdHznFt3LPNEEKfq9J4tEnVeuxL3
         tx75jYutMgYkkYJU9iqlwT9TpUnKACzMJmc1fy6S2T472PbQQ8kLOO7TTuwRUk0Hy+
         by2DR0Y3BAqHQ==
Date:   Mon, 28 Nov 2022 13:34:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
Message-ID: <Y4S43XjRyrdm4Tha@sirena.org.uk>
References: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
 <a214fe55-fb5e-04b8-348b-895902470b18@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mXbGyhu5lsnY5RXX"
Content-Disposition: inline
In-Reply-To: <a214fe55-fb5e-04b8-348b-895902470b18@collabora.com>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mXbGyhu5lsnY5RXX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 28, 2022 at 02:17:53PM +0100, AngeloGioacchino Del Regno wrote:

> This commit needs a Fixes tag, as this is indeed a fix.... kexec isn't anything
> new, so all kernel versions are affected by this bug.

Fixes tags are a nice to have, they're not 100% a requirement - they're
a lot more useful when they're fixing a bug that was introduced rather
than just something that never worked.

--mXbGyhu5lsnY5RXX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEuN0ACgkQJNaLcl1U
h9BVzwf/W/HVqeLRVgVFl3uE+TfDAXzjIy9TDRW7DrWbkN7i2uH7bVGlYEoAecj8
VJD5KtVKChD32froEJ2N+lbaEjonWwUDQyB8tP9yNe/jXjqwUqROmAoUlLKYaGuL
vZZw8pKHpTo/UXf497QSCSARIrRu6fCZcCbFPrj9QUKsvXjJoLCgqgNcVlz/u0gG
uI14fz9Jw/YZUYuD6ESLnwFQqjgWQ0jBP0R/FeW0B0juWdoo6n83K98EC3Zv5FWW
u0RTdWzRWf/wnMuQE0pdt+Dc9qdygMXbmEO1oz8axtoxac0VlMXVSR85yzZ75Y60
cb2bOJZXHcYZZSz2WkiFVLOLZiCpdg==
=G3Pk
-----END PGP SIGNATURE-----

--mXbGyhu5lsnY5RXX--
