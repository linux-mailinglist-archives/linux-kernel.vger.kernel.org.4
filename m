Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C515715D53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjE3Lgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE3Lgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BCB0;
        Tue, 30 May 2023 04:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D5C962314;
        Tue, 30 May 2023 11:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E40C433EF;
        Tue, 30 May 2023 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685446607;
        bh=iXCnSpqvku5TBvKgY0SIrL7G7nudm6YESXMmzmXUbU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTcik89aH1GnRIFAEfVubBgatbsO1FId7GW/IRBcONL4z03EgtErF/yMgEsdsRQZA
         WCHlU8TMmnjd2fEuOhJP9psrh5ZK3tq2H6sMZS5IVwsn1cqklw6knLDGF83906Mm3b
         hV5DxEd/3g6UpXojZxw/xkh8dNMZdKcCeAjcLFEoV9tByq24DlBt/giTfLEVxcNORk
         +Qo1KszQrpQG/fQhf174Ns/NlDzklyZLJezgBL+lEPX2RUnFo+Me7vUnP+oFyZDPKR
         OCKfgjykoQy0fVdFmIdVZnNXgw/jZnRwyh7edoQyrn5XMt4KWCxJjHjmLUinu0zfBs
         ZUMkezRxrGs2A==
Date:   Tue, 30 May 2023 12:36:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 1/3] ASoC: es8316: Increment max value for ALC Capture
 Target Volume control
Message-ID: <4a3f54a3-2cbd-4a22-9742-9ba60e78643b@sirena.org.uk>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-2-cristian.ciocaltea@collabora.com>
 <5dbcbf84-602a-44de-ad99-268d4d5b4b2f@sirena.org.uk>
 <cfa23203-1626-440b-ec27-efe56cb297d2@collabora.com>
 <01fd1a9f-56c7-4864-bb2b-8b004284c8cc@sirena.org.uk>
 <3c6b67a4-4892-0057-3dfc-65ed6c7ebc37@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7bOgmCsIJ4exiLW"
Content-Disposition: inline
In-Reply-To: <3c6b67a4-4892-0057-3dfc-65ed6c7ebc37@collabora.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7bOgmCsIJ4exiLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2023 at 09:11:49PM +0300, Cristian Ciocaltea wrote:

> -1.5 dB  |  50-51 %
> -0.0 dB  |  50-51 %

> So it seems the specs are correct, and the problem is the hardware default.

> Is there a better approach to handle this than extending the volume range?

The other option would be to change the value in the register during
probe to one that's in range, that wouldn't stop any existing saved
settings from generating errors but would mean there wouldn't be any new
ones.  Either approach is probably fine.

--d7bOgmCsIJ4exiLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR138cACgkQJNaLcl1U
h9AZDQf8CRVQJfTeFq5Qw9fVO1/pJlyLSgRpJGmTNzHtJqiQWeIHUvhUdQk308MA
F8c9ONRYZYqB1lr26oNF0MWRJYI8BQJC35xYxLiK2EyKYLvyiK7K9JekQybKdzpk
o4fAXlKCjlMHBqVF9ivHEBUjMyM2aZrLc7D0DSX2N+VhVP9evvNNNyccAKxGUE91
7UDcJARuzCs1ENlzyaJKrZxiGDKbVapt6KMcnz7evtqAQpKgjfdDYOoKWyZcRSAp
5yQjcYk7+XfGkn8KddHjGbgAV6ZJ9BKcZfJ4PwwMm9iJhoVTONpUBPn6UQMb4PN0
PmKgoDkU7j2X/W+b/zWraTxZvy6O/g==
=buze
-----END PGP SIGNATURE-----

--d7bOgmCsIJ4exiLW--
