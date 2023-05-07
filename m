Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E786F9CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjEGXiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF091BD8;
        Sun,  7 May 2023 16:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 631DA6115A;
        Sun,  7 May 2023 23:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A744C433EF;
        Sun,  7 May 2023 23:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683502697;
        bh=hF4mlKMlmMVNKZO62c7NA6hnJlzvS6iWMHHTpIElN7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQOWjd+syz5RhKdo7VbAJZBTQdfSyojBI+X86DPYncJQm4WVoji/SDAcydCEotyAI
         fUaNCfGnzR+kzfcv7rxFPUHxOLIiF2VrPkzAh/A0TwjNeJzilbUKo8wRMrN+uJVQri
         x31lVR2ZrxOtbqJii0X2lDKoCmWr5pF7j4fdvDxzAkK2GEPS2PLlv1cmot8IshI0wJ
         EbJqfK2OuGWIhm1tYXwACsTfwsmNnb6CqHmfvLE6jekjOl49HynrKaXTh77GKDTOVn
         Kn2YMc8KRkxccEwALPm6ugb60Sedy0eCiyyRnPo+oirqdwEQ3LuQoFzZYUihrPDsqZ
         BZGG9SqIrKV9A==
Date:   Mon, 8 May 2023 08:38:13 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Svyatoslav Ryhel <clamor95@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.3 01/24] ASoC: jack: allow multiple interrupt
 per gpio
Message-ID: <ZFg2ZWqEBkPsJk+Y@finisterre.sirena.org.uk>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tbAMK+HB7r9NrqN0"
Content-Disposition: inline
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tbAMK+HB7r9NrqN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 08:29:57PM -0400, Sasha Levin wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> [ Upstream commit a2d4051b0bd6dffcd736888ae89a550d6f60b060 ]
>=20
> This feature is required for coupled hp-mic quirk used
> by some Nvidia Tegra 3 based devices work properly.

This is a new feature, why is it being backported to stable?

--tbAMK+HB7r9NrqN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRYNmQACgkQJNaLcl1U
h9D06wf/RQ36tbWP2zfR8KTbtG1xEapzGfQXR0iXraOH5jidrnt7NY8YygQqG/ps
ZAIr/BJRryQaar1+hT95dwMZ+aDPuHPF/+uXTxvzKvg68yaJf/K98zAIx2nIVksX
A2M0DcCRHf3uwNWEE8Cp/Ho0zfrn5SsKCkYQr1nB9/6Dj/MDHx6lkk4yCyVvcbVs
sSXY8LSzXWJYeir/xiEEcFvpUhywo9dFr9vSjYmvbNljOdt62pPBhuf/gg8v3X1t
i5mNXXjhZ2+awaaDlJBgQhbxD8kEnJ8hpSkhB2BIgiBXnE8+2BN0W6HTKcoNw3jl
XxBwmSkhhXgoadmCQxa5ZDlqsvmjRQ==
=QChS
-----END PGP SIGNATURE-----

--tbAMK+HB7r9NrqN0--
