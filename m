Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9D6F8D21
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjEFASZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEFASX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A91981
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9273564086
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D717C433EF;
        Sat,  6 May 2023 00:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683332302;
        bh=Wq0uGoHIP/oC3SNCCfNBqoARzJspGboo0f4dLlaH48g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZakMqozcPnAVeR3QlITmFublG819sNyzB7WvPia0MG8vZWHRLFaPfwdqzG9rIfUzE
         OwfT3sChp9+LFK8l3adjIopvYk3XNI+71qbWNW0EfWJtOb5DMY4JmtqGX4RhP3Yq7g
         XyhKbz90RASM0WXGzDzj0BnwGY1aJks4BsH7ySUeSh0beXR2oqlI3dU1g3Hvo0GJiQ
         E5LkYGGyZJ0X9ZrQpra8BpirRw1DcLzVc7hUkbln8071p8p8s6HmplHhs2eceUvAHs
         teG5fh13MM/CxaYUHthdYMLHvbl+UNtlixd0aW1XQZIK1tYeQsFbkOyrirSZUJKHlT
         gbKnnYK6fQ17g==
Date:   Sat, 6 May 2023 09:18:19 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <ZFWcy/Z19vffsAg+@finisterre.sirena.org.uk>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
 <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
 <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
 <20230428093010.07e61080@pc-7.home>
 <20230428094745.63677228@pc-7.home>
 <ZFU6oepWPoYDJczo@euler>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A0YcxnbFi5Tgizgo"
Content-Disposition: inline
In-Reply-To: <ZFU6oepWPoYDJczo@euler>
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


--A0YcxnbFi5Tgizgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 05, 2023 at 10:19:29AM -0700, Colin Foster wrote:

> Sorry for a really delayed response, but I just got back around to
> thinking about this. Crazy busy times for me.

> What about an explicit parameter in regmap_config that will disable
> alignment checks? That seems like it might be a welcome feature
> addition.

You can already just not specify an alignment requirement - if you can
configure the regmap to specify some new flag you could also just not
specify the alignment requirement in the first place.

--A0YcxnbFi5Tgizgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRVnMoACgkQJNaLcl1U
h9BilQf/ZUDRU4B0h43glhDU+ROceH8YP/1WU9LBIhwtzttgtOqjQC2NKPwu322c
I6r/9/FTXG2k969ejy1S4Dc+O80h5iR3ggmWAsvZ8g3Y13lWml2KM5/HfQdtJ63u
1OYqOpli6iN3y5RSGxPJpR6VVOtT3JLJm/MJvLsctqtaOjPcVjnHkSyAm34Vc6Zk
oDMO/Mbnnt+dsh7oH9+m61faEnLoBy1z5lvKOrq2Vnm2tutZiKmktY0N1fK20TjL
DwvaM0NKwxC2TSM4idK+CaXjYTMDzaUIjurhN2uiN0Rm7T3KzQafUEPgBlzKz/y1
YBfMPPTrwv/RbC6yRScb2wHwCbPGtw==
=NTMu
-----END PGP SIGNATURE-----

--A0YcxnbFi5Tgizgo--
