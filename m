Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533366429F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjAJN7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbjAJN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:58:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E42DEE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75897B81673
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0D7C433D2;
        Tue, 10 Jan 2023 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673359110;
        bh=lF/saPJXboEiKAom+2j+crI83CaqhVkfm0qrNigQRTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=munQoUGvJ1wVnawEOm1XVAwqy9FchXaPwxlgUwY435kPFQ24oJieCz7c486ad4lyY
         nft95+w4qsRdpS+w27iTDIK3o3dEtcPbTV1M/fzMonNyLmxGz28ZZ5FeIYK8ejtyso
         qy0oQLxEJ77CnoW2HzPwqz5AfDCL2C04H/CMtpNHfH1PyUwksyrNBdVnLkStB6oFSb
         wmaoNvjDtl6uazVwh2m3FF4i/IviVtOAiDHvTJfoUz6DuZcv7GIOeKTQE8d0JwIrIX
         VKRpY3FAky59ooFjua8S8HQYCcKPkISdwLLfXT0rfaoGgwdsmUMSCf5d0l7qBOtVaY
         zNKwZOYQBboLA==
Date:   Tue, 10 Jan 2023 13:58:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Ken McGuire <kenm@desertweyr.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 15/27] ASoC: pxa: remove unused board support
Message-ID: <Y71vABj05MAYEbHJ@sirena.org.uk>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-16-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mUO23bK4vSgaY15P"
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-16-arnd@kernel.org>
X-Cookie: I think we're in trouble.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mUO23bK4vSgaY15P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2023 at 02:46:10PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Most PXA/MMP boards were removed, so the board specific ASoC
> support is no longer needed, leaving only support for DT
> based ones, as well as the "gumstix" and "spitz" machines
> that may get converted to DT later.

This doesn't apply against current code, please check and resend.

--mUO23bK4vSgaY15P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO9bv8ACgkQJNaLcl1U
h9CmuAf/QrI3z3oJ4pU/rY4gmnY4otSvXcS25C5zSiDcRACA362DAnPbjJqs/ZNr
ZxkPTrMY1RIPLDZfZf6/BREI9LEw8GYOEMmkDVTys1mcT/cx7rd/4dhlD/uZjls0
7xITTtwxw7vQ++qTpoHClcgiuEg22MJcviMzFNg3lHd/4zVuTlA/O7fe+IfmV7I7
+b2Mx645/T9OALXfcXWa7xc6r8a++as0+sBn1T9wsk7ciqYGSUUEda3zPrf/DlvM
4t3WYY7WCWZ9m3kG37mKn/qPpCf3xG9nfUcjkJ3cOsqpj/M6z21IidSLRKq5mv9h
S7DQ4GBmjlPVPqZ7jzYrWwLyML9cWQ==
=uKo2
-----END PGP SIGNATURE-----

--mUO23bK4vSgaY15P--
