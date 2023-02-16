Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12AA6999E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBPQYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjBPQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:24:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996373B22A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017B562020
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12194C433A1;
        Thu, 16 Feb 2023 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564638;
        bh=oLvmzj/aD1EWM31O5yP403IS6djcAMB15JbOPF/P86Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1lOndDXJsybp2Y/ndgl5YqHzz8Eh153f99+6Kj5X+kVjptb0AmOa8IxOe48Clag4
         fTiFACAsiIgg3etck8YWzVjetmzlv0OPpHRfzhXxUQjpmb7q3qG3pi79C81V7wORb7
         ocigi+qO5JZCuN+FgGyhxKNA/UAGpMBRIhi/5oG2eD1x0UxrLSyXJsnwIdy3tYHkD1
         axZKc1/ils3+jUrXDwVIPp8qrZMe8CSR+U6FgVM5YMhHqcUInQNYPwGnUNR288nXF7
         vxy8AqTZbnVkUzYu2qYhVZrnpo//P5F0WNx8qoOtlvw7MYS8f6IwmjFRa5yaulpp+/
         cfKR6O0OVs7mg==
Date:   Thu, 16 Feb 2023 16:23:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joseph Hunkeler <jhunkeler@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to
 quirks
Message-ID: <Y+5Ym5rUWLK4TOAf@sirena.org.uk>
References: <20230216155007.26143-1-jhunkeler@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZHmiD/lW1n2dysJL"
Content-Disposition: inline
In-Reply-To: <20230216155007.26143-1-jhunkeler@gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZHmiD/lW1n2dysJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2023 at 10:50:07AM -0500, Joseph Hunkeler wrote:
> Enables display microphone on the HP OMEN 16z-n000 (8A42) laptop

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ZHmiD/lW1n2dysJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuWJoACgkQJNaLcl1U
h9BDugf+KiFB1aCtgMW8HYgkiyjEMXRY2YaLCjP00x4Q/ZM6OqsHagCyTwPglQ8W
0rZewh1DfY9IgIdKz18aPg7FtdyvRLZFRAivGM6LOi1YcY8kg+kTB4BexybQu1UU
PwBozdLDfJZeWZJ0sXn7P8Za3+5Z+fIJdmg7jNJFUyzSMqNM4oP2xKYgLTAhmRhf
TtU12XPL4vEu/dOAbAnfWZv/OH0zJBxzi/DKbbNkYgdyY9X3+6WHYYHAuXyO/IK9
UPfny2HXGaOJGiFLId3p4rRiOv4sDP9HKnPMrUXs0Tt/b8a85najXG+7hVDvbPnZ
wBhoV9WbkRaeRoImS1nj3oALxjJvMw==
=XVyk
-----END PGP SIGNATURE-----

--ZHmiD/lW1n2dysJL--
