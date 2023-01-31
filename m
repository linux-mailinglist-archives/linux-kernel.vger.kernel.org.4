Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD44F682C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjAaMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjAaMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:09:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAC4DE24
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:09:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E442B81C01
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C2EC433EF;
        Tue, 31 Jan 2023 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166939;
        bh=DLvDCWzk5GytZBU1674pvfja+0MDldug2PT7rFtc6kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJDWPMupCYKjOl/AZArandblM4qbqDNBDsOluBoAV+rGIxSRoMvHO3DEkhlcofMZO
         UJhK7QrLZRAd7PbumqpNP6ApjeHxg/Q7z+uPY37mjzsDOV9VmjgCdTk9SOv4sWFOah
         1JaZoIxOHel8h2+CmQOs8z0w4Dxt8CW+txXkG1srojWlSAdhtgO2dDQYjiwejO25Ur
         SO1IXLEHcpxwYinYgO89nri4QmKz7pCkugFy0nJPAh1U83tUeaUnVNjHCB1CnGy/3k
         8TKg8cx5+ABOMVupfTVJcgGBdWQ68xugDvJalBAXPrrEOrkjZ9H6cBzKrQfKabmzMN
         RsHustz01M/YA==
Date:   Tue, 31 Jan 2023 12:08:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Rau <david.rau.zg@renesas.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <Y9kE1cSUg2CQM5vq@sirena.org.uk>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RWg0+JlsDY3Vw6Hh"
Content-Disposition: inline
In-Reply-To: <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
X-Cookie: MS-DOS must die!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RWg0+JlsDY3Vw6Hh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2023 at 10:16:06PM -0800, Guenter Roeck wrote:
> On 1/30/23 19:58, David Rau wrote:

> > Thanks for the kind feedback.
> > Would you please let me know what kinds of environment such error appears you ever meet?
> > Ex: da7219_aad->gnd_switch_delay = ?

> We are seeing the problem on various Chromebooks.

> Never mind, though. I really don't have time to keep arguing about this.
> I would have assumed that it is obvious that a long msleep() in an
> interrupt handler is not appropriate, but obviously I was wrong.

This is a threaded interrupt handler so it's a bit less clear that it's
meaningfully different to just disabling the interrupt for debounce or
whatever.  Not to say it's ideal.

> I'll see if I can implement a downstream fix.

If you implement something I don't see a reason not to post it upstream.

--RWg0+JlsDY3Vw6Hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPZBNQACgkQJNaLcl1U
h9Dq2gf/fvsbqcA/2q2LDugcFHS+UA30iZOWyzJk/4mkZW0YYSP0HnRGNy6k1b+u
/tazYt83YwhvD7OvuBAwKmMkaQ/FJouw6SbxUJhnObQL1vzc2O+zHCdOTH0Zb1mC
fRVeHipFBvhCxiUgnlcY+oIosWgP0DdIsfmP9ysmACaTqprX5VDQc0Qcu9NX1Jd4
ZYKE2v7BUYpNJqPnNOwRlHbzN/UkIG6LptUDSYZrD4AdiNsvFXlh9SAQ+WmCNOks
quPHbiy0m9MI5CpXZvb92LS4IHMCVPeC6gwskBEVDtz8cHatj1YWapH7ZhDlcVh5
xPFvBwh3Ge5lSG6giq9uYY+SJoc0SQ==
=BYXM
-----END PGP SIGNATURE-----

--RWg0+JlsDY3Vw6Hh--
