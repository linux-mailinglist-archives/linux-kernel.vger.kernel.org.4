Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF67708DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjESCTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1437E4A;
        Thu, 18 May 2023 19:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A1865394;
        Fri, 19 May 2023 02:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAB8C433EF;
        Fri, 19 May 2023 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684462737;
        bh=3m3zEYW3ZtDjurspBCO1GS8X3tGts0YUXMYugRQCwEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBI7M/MmAyWcs/qdj+/kJSPhQh1oIEfWzmp8J4unUPqr8JRQhlV+4430MNoNkMEXH
         KWZi5PUsIemrtZ8A+zplqI6v3bb5zLh2l2B2/SEB2/5QXOM84nIkKzdQDPntwTM0Hh
         OyV9VZesh1jfWH2l86yK3KrxJ8SkVy+bk/qT9B3F2eSyCBPLIzuhCISbL73lz4W0LW
         tAA9Innemy41P+IUCmMuD1K6Z1OIKrtjIqFQgd+mOtfYMQE4yRdtx2YTpv06NacdN2
         JDAVXcR+uiWQmQm+smsf7vT6kIuWJ790750BT4ik1lhfkusnfNcEu95/e0NfoJmK8O
         g+6pqyyRCuqkw==
Date:   Fri, 19 May 2023 11:18:54 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Svyatoslav Ryhel <clamor95@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.3 01/24] ASoC: jack: allow multiple interrupt
 per gpio
Message-ID: <ZGbcjv87zExPUCj4@finisterre.sirena.org.uk>
References: <20230507003022.4070535-1-sashal@kernel.org>
 <ZFg2ZWqEBkPsJk+Y@finisterre.sirena.org.uk>
 <ZGZbsIMIa6qgU0ht@sashalap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="50MO9Agatimjxjpc"
Content-Disposition: inline
In-Reply-To: <ZGZbsIMIa6qgU0ht@sashalap>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--50MO9Agatimjxjpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 01:09:04PM -0400, Sasha Levin wrote:
> On Mon, May 08, 2023 at 08:38:13AM +0900, Mark Brown wrote:
> > On Sat, May 06, 2023 at 08:29:57PM -0400, Sasha Levin wrote:

> > > This feature is required for coupled hp-mic quirk used
> > > by some Nvidia Tegra 3 based devices work properly.

> > This is a new feature, why is it being backported to stable?

> The quirk aspect of it :)

The same logic applies to a huge proportion of new features...

> I can drop it and the other patch you've pointed out.

Thanks.

--50MO9Agatimjxjpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRm3I4ACgkQJNaLcl1U
h9DKwQf+Mikt6+8MCZHDxQ1wachhRQ5/pRZKLkBDLYX2s0RJUvXHYfJPYsnDvrGJ
COd3UQRBWcPRc8G8nuSQlB9V93MaL9d8z5nNlBhIltMiX5Vgjg5W7U/ZKiQ/UAEc
O0vGDApPKMqhTwxqFOhm6NnszmtDDMIB5k0kMw7N53W64y8BjQJugwappq2CtkDu
s6UaaLlVwYLJJw+HG2ZOwQ3Ig23uxj3knZzAToG36xFOdGd3J11PqWvR/naDcaDl
sI4yUPvH+ZU4BN79dTa/zihwond2jtHKNsDvZiBJJxul+e2XUKENDT2GKzTlGI5b
w9z3lNVMf+VuuElsCjGxBmKxZqY3hw==
=koQL
-----END PGP SIGNATURE-----

--50MO9Agatimjxjpc--
