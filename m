Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A960458A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiJSMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiJSMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAD2EAA;
        Wed, 19 Oct 2022 05:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BF16174B;
        Wed, 19 Oct 2022 12:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88008C433D7;
        Wed, 19 Oct 2022 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666181454;
        bh=GWr+pXdg4KAo4cm6ndECUvEjk2iIp9Udlw6HdytD74s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjRgwK82xNTsABYyqlr8BKxalnQQsibfZTFAOamdK5hDwR/68+Cx2S/zX6i0MRQxp
         T0crx1/UCoUvIBNb08r6YB6S4aOpA66cGj52RwxQ+sJvET2GGqMSuAUuvmXNiVG3s9
         aTeXZ09DXkIm0Dzuy1OdMxVuMRQtL+f1fG1jaMUGy0nraMtyM1UNyQEaJPyahI4Rvz
         F5IHTKOhmBdG8PqB7zX5baQBOCj/Kg/fJCl9rUVecEFATYO+YzWltUuLB1vZ9FWG7w
         fN2ccE5iOoMFtTTcFjTAMxbjneGFbgD5mMaSvT/GYdNPn+MkRjLoedlJMPoYg6wLc3
         j9FS/IlvurxGg==
Date:   Wed, 19 Oct 2022 13:10:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] ASoC: codecs: jz4725b: Fix spelling mistake
 "Sourc" -> "Source", "Routee" -> "Route"
Message-ID: <Y0/pSVbueZYXBsmA@sirena.org.uk>
References: <20221019071639.1003730-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RSRYBU1FRm2IiFjJ"
Content-Disposition: inline
In-Reply-To: <20221019071639.1003730-1-colin.i.king@gmail.com>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RSRYBU1FRm2IiFjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2022 at 08:16:39AM +0100, Colin Ian King wrote:
> There are two spelling mistakes in codec routing description. Fix it.

Bit disappionting that people didn't notice the errors during boot
there...

--RSRYBU1FRm2IiFjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNP6UgACgkQJNaLcl1U
h9AMAAf/QC3eZNYr9/3n2kIr05IslQ40odVk7BW7aJxsPlGbyo3UWe9aVyLNxPFg
ButRyaxZyFUaLjORA4747at7NxfUw6dkCBeq9WxQvLkOryJVmZIWVNhIDPDnquqP
Ze6pexDoUZsvlEaVkJXd28PXKgQSjI6tLyQTG0y+wM4Xv5L05ISaSZtku0eZM28z
DmG8fGdquHZFUZOVKQWu+Ny1G3sSkdrBkBUJcSkGVdn7TWIklLVqNuy4w3pq+0RF
rviZ2Wo0NMzE5ksTXv2+t/UIYzNWjv/K0jcNVB16EnEqfI1pFDQJZyrKDrF1YyQu
6Up7a5YP6VPCJgs3A3yWVpWcFahADw==
=c0mZ
-----END PGP SIGNATURE-----

--RSRYBU1FRm2IiFjJ--
