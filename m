Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1804E745BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGCLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjGCLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3594DE8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2BA160F00
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDC3C433C8;
        Mon,  3 Jul 2023 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688385213;
        bh=nAJqEJjqd103PNUthqFq7I5PdjEeHyuw/Cr2QYYzxaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niyDHYH/vWrzMGGe1m8sX19Q4KR8xJpr0I5MYpF16wzGkHcC374dCpkVGzbIviILK
         UBn4pLoLBR3609gHTme7laQ2Uuk+0lev/tpEx6z+/g4YFJ9DaNltwZIoRqIEvVFIy/
         kS++lJ7kd5JYblRq+dCujBA8EyQWC7ooynrADQYUD9sjgyqjvDE9sg11+hmZWLGZV1
         BRJMOlhebar0gl2SCiqxhvAqThAUBNu0RMqShLQZGqLN/Pzs8rANBbBvAw1KP/A5dV
         c/wkExMsNu5YYVxbZE06mYjXKWHxKKvfbFh3qPwSE/hhjF7kmyRMc8TpXLZUhlyxp3
         gYhQMFiJl/i4A==
Date:   Mon, 3 Jul 2023 12:53:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: dwc: Add TDM mode support
Message-ID: <eb78f309-da69-48c6-9c8b-dd3b75172d48@sirena.org.uk>
References: <20230622200031.120168-1-fido_max@inbox.ru>
 <a8198e25-50e3-3f65-e77c-8d2f1dd263b8@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O2g0lER0iMA0CshW"
Content-Disposition: inline
In-Reply-To: <a8198e25-50e3-3f65-e77c-8d2f1dd263b8@inbox.ru>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O2g0lER0iMA0CshW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 09:16:06AM +0300, Maxim Kochetkov wrote:
> On 22.06.2023 23:00, Maxim Kochetkov wrote:
> > Depending on hardware implementaion of DWC I2S controller may support
> > TDM mode if enabled in SoC at design time.
> > Unfortunately there is no way to detect TDM capability for DWC by
> > reading registers. Anyway, if such capability enabled, TDM mode
> > can be enabled and configured by dai-tdm-slot-* DT options.

> Do we need some extra steps to upstream this patch?

We're in the merge window...

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--O2g0lER0iMA0CshW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSitrYACgkQJNaLcl1U
h9BhyAf9FKOH76Ok35QY0wNL+U8A5tqfRwPDewnM95g6OXfYCf+sNxl+h+9glRFQ
BnjWzLMdaLOV9I7L14XoWA6HWxTxRT104aVskyn1lmYlz2BIZIS/QrDwz0UUDQCM
mbkbXVqt1O6V+F8XOC+iICtxYjolCEf4IbCHlXlQcwAPKcQa2z7NbKD2YqP+lNc0
hqamMUNVeMU+VcUB+b6zverex57w9SYjCrDWn4B213x04WmDxsHgG8ZLX7wnmMLi
5EorNRkyfg/2jI8ZIuijb7z8sADqLIOH9qFOEXWlw3y7ELagvUf6DznhqLJy34YJ
gzLTHb5eUjvKfYQDtxYMPTV0eZ/Vhg==
=4c5B
-----END PGP SIGNATURE-----

--O2g0lER0iMA0CshW--
