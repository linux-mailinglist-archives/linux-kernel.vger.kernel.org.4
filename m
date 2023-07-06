Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BB749B93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjGFMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F11E70
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40AF61929
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A0EC433C7;
        Thu,  6 Jul 2023 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688645886;
        bh=SQ/W9RMOyrQORdVtYany7w77017RM6VIUNpmJS+u0fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbhR2YaUrMzCYKgoN5vHkB02ikh2Rlp63t8ooNSFj4mB2ORnFCphy3WLCwZ/FjvTq
         rYVKpcSG2/g2X0RHsS33xIuFoS24o4JIQkm2xEJnjWNSGFKOr8bbjGbuukfIBGlq81
         nFwVBNwd2wpwuGZ92Uv+ypW4GthgFzflidpBQa+QExc6Olo1gAeKcqROU7Lm2plbPM
         r1oIxRYqN1PYswNG7VWg12pB0l/KyUW9hIe2pjz9FLlueer2g08oPu6YbNCKtnSrhL
         A986V09qLAAMeCc3fe1aEmd2oMNNCzMQXGM+OGL2qJ4z/vWnC6syUbrO6liEJJWx+o
         wTwW7vAVpJEFA==
Date:   Thu, 6 Jul 2023 13:18:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] regmap: REGMAP_SLIMBUS should select REGMAP
Message-ID: <18425cc3-9a4c-4269-aec0-3f821697bfd6@sirena.org.uk>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dr+DpUY6Xq+EybR1"
Content-Disposition: inline
In-Reply-To: <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dr+DpUY6Xq+EybR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 01:42:03PM +0200, Geert Uytterhoeven wrote:

> Fix this by making REGMAP_SLIMBUS select REGMAP.

Why is this being done as a separate patch?

> Drop the selection of REGMAP by MFD_WCD934X, as this is not needed
> (now both REGMAP_SLIMBUS and REGMAP_IRQ select REGMAP).

This has always been redudnant, why is it mixed into this patch?

--dr+DpUY6Xq+EybR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmsPcACgkQJNaLcl1U
h9BPOwf/ZD9cLVc9wr/gWaOiihgTAFnsuEKYyg5HanL/iuwCWpF0wJsIhTVwEFQf
GBSmNLlS3niisAbotm/TZsmx7+/xnQFTumeWg8EwQnjNX1Y4kSSckF8dRlqtCY+Q
KRqs5jLAhjy47O3ELQaXC/+y416fAhAl4ZQpMW9byQLiK1oOYH5Vrni5GpeJGPmM
G1YNi4K6aUNkODVhZwQO9T4rlp2asrc+rnhO2nR952qmPqbXBlF3fFHzG1Q/SOph
Xu2+5LOU/AS8zyO91VrqrP1vfWYbenHI3DnevBUpQ4eNR/vejyVn/d5Do93/t9HL
2JGJ4i8+Z8m8vvsz32Ky1iDozA54mg==
=qA7K
-----END PGP SIGNATURE-----

--dr+DpUY6Xq+EybR1--
