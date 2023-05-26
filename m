Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A8712966
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbjEZP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243615AbjEZP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5DE52
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D6B650D6
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FE0C433EF;
        Fri, 26 May 2023 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685114732;
        bh=zxx7OmAFKO9T9Ao0oqSq594bi3DhPycIlfbuWJawS1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqTsjnOmr+vQCY4WkJ3s+5S5Jly1Ubce4C3EmAf3MMcvFhc8HqFO3XylWETLCnxrp
         6Jz09dvXDe6nihy6nRsGbds8fkQsnp+Sz1C3pP4VlNXy4l/Z1Nbjx1nYZP7K5W5W6I
         y2hhSy7fAAT+VbrHAIGAmJIkvahW619OB6m6qXJWsVv7j1Cj91L/NUZvdJpYhfWmQ8
         AYp7UiK5WZwA87BYNJpQHrvbO4cmMM6Va8cYJ8C4hjD1KKXwR27l+BB1tAndd1HjM+
         x4SNfMzmXKsNcTNATTil39kS0GQhbAY2AULmcdbUWPB7HlR1U2/HJ2fiuGPIos3zXD
         psErak4pglxeQ==
Date:   Fri, 26 May 2023 16:25:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     rf@opensource.cirrus.com, tiwai@suse.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, simont@opensource.cirrus.com
Subject: Re: [PATCH 13/13] ALSA: hda/cs35l56: Add driver for Cirrus Logic
 CS35L56 amplifier
Message-ID: <e06d149f-1da4-4d7e-89de-208e0e8335d4@sirena.org.uk>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
 <20230525150659.25409-14-rf@opensource.cirrus.com>
 <6ff4235d-f8d0-3c3f-cc67-18aadee2afbc@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yAJCG2p31xUBZol5"
Content-Disposition: inline
In-Reply-To: <6ff4235d-f8d0-3c3f-cc67-18aadee2afbc@microchip.com>
X-Cookie: A Smith & Wesson beats four aces.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yAJCG2p31xUBZol5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 04:40:23AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 25.05.2023 18:06, Richard Fitzgerald wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > From: Simon Trimmer <simont@opensource.cirrus.com>
> >=20
> > Add a driver for the Cirrus Logic CS35L56 amplifier. This uses the same
> > component binding API as the CS35L41 driver. This is not a standalone
> > HDA device; it provides control of the CS35L56 for systems that use a

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--yAJCG2p31xUBZol5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRwz2cACgkQJNaLcl1U
h9A0eAf+ICSD1M5+iPd16MJkaGEt4sMBiQBwOB0zDiDTXy4LkQt5viUWy7Qga8P4
9XJzdkhjK8aASywb4ihzQoDjOE8CKJ1dh1t6jQ5GoM64YIGfM/vXyfCkwk2MyVc2
IX+9TowNt8ISXeOhThVVoqdwsUbgucYrqiK5EgBN+Xkjrz6lbblHB6YnrHpD2B10
YMwydxaQX1RUZmT/0dSl5hNbDZQ0COye3BGykiDeysWAfQB9QJPTtZcOONoqgHHN
hpyDdbIeAzaV1MwMd1MaDD44xKHGjbfotfWREW+jeZUwqaAs8qbAtNuHGeAhVO5X
58kMCF9alh35VwOwrBY0WFT7mzYFYQ==
=kDHu
-----END PGP SIGNATURE-----

--yAJCG2p31xUBZol5--
