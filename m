Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7F6D5F69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjDDLqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjDDLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7EFF;
        Tue,  4 Apr 2023 04:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA2263293;
        Tue,  4 Apr 2023 11:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F18C433D2;
        Tue,  4 Apr 2023 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680608791;
        bh=RHCs8FphgqOMMWc0BCoMg/a16dbHn72xyUKpV1s96HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJBvY7VDPPEbSY7kL6tl4DGnbEZo0yrwkM4oAcyc/8vXICAUPShFvBOICNYF3ye0M
         247NnTkfHBhivIeoQEWVZ2YWJ5gRlWBfeUpaI8QaFyvd4/71ulYBmJoKBnj66e/1WZ
         9MBLKcR3JRIQogsAkATJ1ZVXiXsqp6EH+SdDkPUYfL5tUnxgQxO8FiNrvL1hVEx0Xe
         vsAJ2oym40KfGNFWWqQEYCjm60OfD4tPkJX1Ji6cF6FSQMz+2s10FsdpOmO5y2jLEt
         kMhPx3eUpz3SjK2LB3RnZj1bdNw8ieNdpg432ZOUCSOF5rMzymE1JFLvSLucMHY1CK
         UTRXv6zWXdSTw==
Date:   Tue, 4 Apr 2023 12:46:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: =?iso-8859-1?Q?omap-?=
 =?iso-8859-1?Q?dmic=3A_use=A0devm=5Fplatform=5Fioremap=5Fresource=5Fbynam?=
 =?iso-8859-1?B?ZSgp?=
Message-ID: <48369cd0-cac8-421e-8691-e730a619d928@sirena.org.uk>
References: <202303221410035741246@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8bHbsp7cSqyHRWkg"
Content-Disposition: inline
In-Reply-To: <202303221410035741246@zte.com.cn>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bHbsp7cSqyHRWkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 02:10:03PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource_byname(), as this is exactly what
> this function does.

This doesn't apply against current code, please check and resend.

--8bHbsp7cSqyHRWkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsDhAACgkQJNaLcl1U
h9Azgwf/bZGUQm4wOkmEdAXrBeNHI6JSXBqe+aLgVAVjMpYhHvFlp952bmZ5toBW
VeTFZ8tkjLJZ4x+9xFot3Q5ohBg/WVmfC2PHAf2UdFWdemogpmype3GtCRScfUKb
pAX+GHOGZlHsHMBb5+2mtFT50LFGSW7wfK2NCw7VkNcahj/157huhZX3HR84bMJt
FZJ/xu7WWZTSL+3FX8RgeVc2Orp6TwbujXGbQOh0ETrn4Py4hSVIxJfwtPlGQb7R
UbiINWoLhuuWLiVlOboPHx0QiNJyJWFboj4eI50GkFPK4OCH36vzdgkzON85Uewy
Fg3bd6Jk1B7/h02FQKzvnqGlibBCCA==
=2nf1
-----END PGP SIGNATURE-----

--8bHbsp7cSqyHRWkg--
