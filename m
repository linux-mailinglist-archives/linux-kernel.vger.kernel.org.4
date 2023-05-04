Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCF6F6D70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjEDOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjEDOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:02:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038283F5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 727DE6339F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BCDC433EF;
        Thu,  4 May 2023 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683208932;
        bh=boqOdA3P9ek3eoEYJAtDXWA5q44SKyVZQf1j6xosNfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zjf0dUQfun0fJ3towXh4X1xrW6TzRS3wHAnAIhfctBc2ydojtSG9oQb0JXERwWhqw
         PodtB6j2yDXU2Q+/FYwQ6WKJDaTNTfMDbvEl6QYI8g1mwMdOm+8XiKIhfhyXYK5oCz
         RBsX4VSsHX2rORRotB9E00knXDBZkiy93FgG3rNxB33mPkbkDuuR5K7Sgl+OnuxRF0
         L7/uIYaMc5KnMU5TWYF14CTKg/tUNxDHzVFhuV1yEHkIpOio8EBkJ/Lhj1G+85UNGO
         72581MPvkeNCSidcEADeyvpu1SJKVYcX9Pc4zsMHs6Ujh+gQSbPjv+fnUP3QCTu4X3
         Nz2bIHf9qNGMg==
Date:   Thu, 4 May 2023 23:02:09 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "Ding, Shenghao" <shenghao-ding@ti.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        Shenghao Ding <13916275206@139.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 3/5] firmware: tasdevice_fmw: tasdevice
 firmware loading lib
Message-ID: <ZFO64aZtVGNkNpZW@finisterre.sirena.org.uk>
References: <20230502053235.27066-1-13916275206@139.com>
 <ZFGqhM0VYFdorkRa@finisterre.sirena.org.uk>
 <82b9ac35631a4c4993dd2cd75f137273@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yXUEvluyKD4ppgaS"
Content-Disposition: inline
In-Reply-To: <82b9ac35631a4c4993dd2cd75f137273@ti.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yXUEvluyKD4ppgaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 01:55:21PM +0000, Ding, Shenghao wrote:

> In fact, we have a dilemma whether to put the code into firmware folder o=
r sound/soc/codecs.
> As you know, most cases are audio-related application,  such as a pure au=
dio device or=20
> audio2haptics device, keeping the tasdevice-firmware lib into sound/soc/c=
odecs would make sense.
> However, in other cases, tasdevice(such as tas2781) can be used  as pure =
haptic to drive the Motor.
> moving the lib into firmware folder would make sense, although such an ap=
plication is a niche.
> Would you be so kind and give some comments on it? Thanks.

That sounds similar to the other examples where you've got some
non-audio applications and keeping things in firmware as you've done
makes sense.  If you resend then mentioning this in the commit message
would be helpful.

--yXUEvluyKD4ppgaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRTuuEACgkQJNaLcl1U
h9A7zwf/b6ny0QHL9iLXXdY4D9Cs76zcHWGK02RlFjksYRlREn/AzRhh8dXugkzu
9csP6zKqAPpXNiVwd1OSJ1eDphIykU2RA7FBZdD+yFbEsng5RvOf8xV0l4lEJN2/
6xXVora+UzezqmrUsx/3n+jUaflmXA8NV5k2JxuCxeSwuyyE3rV1kfxfdYULa0m8
MxarzrbyiYruWlyXGNJRH6sWIcE1fdmvamFHzJHFqVyuaD9Osn594+YL4dgtGwl2
Aa0AtJw6o/FXxtHP1eWlbrDsI6n4wit6DpG7oakRotroYFPYMS/crIFB5/VsC/Cc
KINDpd67o74N7AQlc85gr73tBobeQA==
=jKYb
-----END PGP SIGNATURE-----

--yXUEvluyKD4ppgaS--
