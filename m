Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E0742917
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjF2PGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjF2PGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F92A30C5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E919661573
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272B9C433C8;
        Thu, 29 Jun 2023 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688051171;
        bh=474x6sMuA4plncvQ6IrECB4qCG3K40O5a/bmnxALyas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyTCu0f5QA4FVNSB65EEfJPxXlmulwlUJtsO2jbv8BLlni96QEeX5EDltLkShm/PJ
         Dd/2N6fgVXAy0GHo3lYMFSpbOAOrp3feuxigkYqZAndvycDVeegiz+O9bL9yKN6PBq
         i4SIAcnevtO7DClmCfpIyv0v/gp6kXA0vDI9a+f0rJ+QiPaz+k1imVqXjMH5MVag86
         LG3r7jEbGyS+U/Ngrdp7QcfR2uzgFIjiJbXDXMkFI7iTPxmdKdJ4j37Fzn8YiBraAP
         Krfzykyro4RR5xPjPS0vrl5kqcAdYzXWlCnnuW4p5o+N3rnzzDe/tccoNlbk7xQae5
         6OiE6XsELxhkQ==
Date:   Thu, 29 Jun 2023 16:06:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8188: add constraints for PCM
Message-ID: <5995e77b-ea8e-4e88-8ca2-f716df9c9579@sirena.org.uk>
References: <20230629075910.21982-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9vDzboGe8Rh5zM2x"
Content-Disposition: inline
In-Reply-To: <20230629075910.21982-1-trevor.wu@mediatek.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9vDzboGe8Rh5zM2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 03:59:10PM +0800, Trevor Wu wrote:

> For certain projects, only a limited number of parameters are necessary.
> Therefore, it may be beneficial to add constraints that restrict the
> capacity of the PCM.

This commit message isn't entirely clear.  The effect of the commit is
to restrict the configurations supported when using a nau8825 but it's
not clear what a nau8825 has to do with this or why we're doing this in
general.  What exactly do you mean when saying that "only a limited
number of parameters are necessary" and what makes this the case?

--9vDzboGe8Rh5zM2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdndsACgkQJNaLcl1U
h9Aj1Af9EDUZJPIpv75r4jnUe38kpi7YWD4SjRP7RAdggjnFr3VblTudJeMsxBfP
Xg9arOq/KEIqU3qGGn0ejdO0SOUF/cCS5ZUyNTcIMr3IWGUlWEn2mSZDP01MbnGg
DrIv5lNYZ+LXxdZD4UPqIcuEp/umRN7mTp3nQxX3AqIo2BWplzSKE9yIYF4CrZvx
XU2ZpGqV3RIR2G8avJlLdC16KL3gOQqLzPkPEctHFP2u24hnnkobgwEvBPlR9Xuy
/TvMv8XRH3FcVqoKf82e23q0hl7W1g6DCy5N7ShqD/lRqlIjGWcUbIiaffP8f+rp
L/kqu8AfVJw33IGr4CscKIVH29kFcA==
=i7Ra
-----END PGP SIGNATURE-----

--9vDzboGe8Rh5zM2x--
