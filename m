Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6864DA08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLOLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLOLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:08:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6EE23147
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6465161D74
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F06C433EF;
        Thu, 15 Dec 2022 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671102509;
        bh=otXxm55EM0gptTM4VLPHIyJ/tLPdBuolhb0wODRxQCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lx+5SojMH5fis6ZcnVj5HLBZCgmYcUwLC/eplUDlxbSOwrzCrMfp511K+Qmh4+k3f
         0TeSWNVEbGokD1O0cD+HPh3XUI/3HInp2wJne6bcHVy9yevrQbqYb6YK8aCyHsfOxx
         BFAJgaXilny7T8DoZAHjclIXd1SEovEHXTSPRfDvXwTwQ7uD52YKfGTCT7QPgamUtb
         4Gh0CoypR7uJ0nJn4uE9RTizZWeJ0sHF5BtFPut8sCogrRihgx4WDYPTpPOrr0CsAE
         TPs/ttlxnccV3Mxnopsbyr3uG63QMwEZQqfKyc04EPPWYw+BVy6F9T9T7hcRnUrnZ5
         k8Xtu13arpQ4w==
Date:   Thu, 15 Dec 2022 11:08:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: wm8940: Remove warning when no plat data
 present
Message-ID: <Y5sAKNV4p4G5VVtP@sirena.org.uk>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221215093615.3794156-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFRj7qQIoixq6PZz"
Content-Disposition: inline
In-Reply-To: <20221215093615.3794156-1-lukma@denx.de>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFRj7qQIoixq6PZz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2022 at 10:36:13AM +0100, Lukasz Majewski wrote:
> The lack of platform data in the contemporary Linux
> shall not be the reason to display warnings to the
> kernel logs.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--SFRj7qQIoixq6PZz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmObACcACgkQJNaLcl1U
h9DSXQf9EkpxJ5dy2QkgnI9yJH0jtMm/WEJp0BP3BJ9Ka5U3Hc1MI7QlSJSZzisW
DNpojEv9KQAa44ZApBjCVSmtf5gcS3nH6hGKTa3Ry8Q3MrJlGNJoroTSzefJOONw
1h1Fvo4VLGqqHwmZeJ78nYPUlANvu6AITv/BxrOORiMMoCwgHGX2wRbd9rcHIn3b
OyADFZdv/oCT+pwJ4iFhgmO3f2OWyHRa/CyydB+q+7wMUolWYMQBlHMhp0RjXeUk
trDz7kDK4O/DI0d7lbexgjevycQLZFHqMD7L4lgfPermbNbvYwX7/kcMJ+YZZInI
9ib5D8iy4OfhxlLtfpme7Z5spcPrPA==
=0n0n
-----END PGP SIGNATURE-----

--SFRj7qQIoixq6PZz--
