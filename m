Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDD6161CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKBLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F224966
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CC92B82191
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11EC433C1;
        Wed,  2 Nov 2022 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667388768;
        bh=yoHsM6tzdVUYkSoFF8KSjoXXJcut+N1ohrZ0gOth29Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmSYfK+Uxc8Af0fr9SSp1F2vFXBAAiNMWRKCQsYuYy1waaPZCBtnUFINCX7N3SM4W
         s13tuFdamtC6JI4h3QBVAqdxWZrQPJfB8CVyG1XTgKfIfYMA55jI/oXhGvlMPPMEXF
         B6TcVEnxrF900DtBvHOfSn6JMuqjvOoP+qd20yU2qEFmalPHp6h8dd26vEQHB9hKXE
         H+rNXTtKpSRZeNKTWEvimkPYEZe+vpc5qop5CQtfVbgwG0GfK/+RokTZYxTJ79fVQh
         SJiOnMArcxS6O5OsTgtDqtt8ss+/ovo0r5ongKtQ612I6Q3WROm26opwe4bKWmXdwl
         UwwPsJEWDKkJQ==
Date:   Wed, 2 Nov 2022 11:32:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Message-ID: <Y2JVWmJsprt0xnKH@sirena.org.uk>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
 <Y2EttkwUvMReQcqg@sirena.org.uk>
 <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6S2eJXa8E4+Y1UCq"
Content-Disposition: inline
In-Reply-To: <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6S2eJXa8E4+Y1UCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 02, 2022 at 10:59:07AM +0530, Venkata Prasad Potturu wrote:
> On 11/1/22 20:01, Mark Brown wrote:
> > On Tue, Nov 01, 2022 at 03:15:08PM +0530, Venkata Prasad Potturu wrote:

> > Right, that's what the code does but why is this something that should
> > be controlled in this fashion?

> This machine driver is common for TDM mode and I2S mode, user can select TDM
> mode or I2S mode.

Why would the user choose one value or the other, and why would this
choice be something that only changes at module load time?  If this is
user controllable I'd really expect it to be runtime controllable.
You're not explaining why this is a module parameter.

--6S2eJXa8E4+Y1UCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNiVVkACgkQJNaLcl1U
h9BonQf/WOzgZDEZv8RNQ4jP23/wuknKo8guxsWKck2+1KjS6H71fYA8QQov0Ram
ctytaYT07gWmnwqOU7rNk8dOsMLeqSi4fRaOrX9P5D2QJ8Q6HF7IgBHN4b9QMqLe
/SuNdWvkY+rgkiaZOuMzXAw4xVXao0B1TG3feHqgeYeO3h4Gkozy6n2tQOn/ETBg
N6szVTLGRqzGQeb12XBkpJmeQwUrA3VagVeV6CQquMUdnf4Q9xAsPi9LWYVpS73U
lh4digzscLLrlU/yZxbqz4gJqrZ+iGbQRBa2cD16pDueAIuDBtSh9Dx+k95Y0MvS
VY5i0Qe/maNcCPV4537jKuwcMxlkLA==
=DdXj
-----END PGP SIGNATURE-----

--6S2eJXa8E4+Y1UCq--
