Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9101638DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKYQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKYP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:59:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E2A1DF26
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32D31B829AB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 15:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F04C433C1;
        Fri, 25 Nov 2022 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669391996;
        bh=kdumfihSJADK+Kq+yJKT9k5SPIezgficIYgrrEDbVJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kA7vO9Siw3wMoxdG/yBf5+vK5r5UxqFnQURWId3gUqTP1wTZHongrFakTL+Q53/3B
         peRvSDajDp+wUYr0ds6tXMZuJRxHj4IG8TRAfAp2RxRFMQETQGJ9Kg501FVvoCAV4q
         UuU96Q08c1BkvIeWaZsLkalgE5ZzzVwmUITpdSyybKm77ayLcZAcb7OBSb1miTPzPc
         sKvU/487rDCgHh77V6DRUlBBidpfg/82Pg0pwS+ZYfB4EHv8ROAzh204kInrfqkuf9
         AXIYfqaa2TVq9rp73KplQiFdct44Gu6go7e8BFYez/xyX17YcVPPms8Df9FT0lUZVr
         GMlIjBWHBs7qg==
Date:   Fri, 25 Nov 2022 15:59:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>,
        linux-kernel@vger.kernel.org,
        Tan =?utf-8?B?TmF5xLFy?= <tannayir@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: SOC_DOUBLE_R_SX_TLV controls broken in cs24l51 driver
Message-ID: <Y4DmdmMUCkHkAAQh@sirena.org.uk>
References: <CABDcavYdsk-O4x3oPX4i4+T5wsoZV26_kpEq6JvpD8A_cAGHxg@mail.gmail.com>
 <20221124111336.GE105268@ediswmail.ad.cirrus.com>
 <CABDcavbRryENG58LO7+gbJeKbBBPP1uG1Xc00yXUBNzspWpWoA@mail.gmail.com>
 <20221125155023.GF105268@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iliBHVfTx4YPr1QE"
Content-Disposition: inline
In-Reply-To: <20221125155023.GF105268@ediswmail.ad.cirrus.com>
X-Cookie: Time and tide wait for no man.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iliBHVfTx4YPr1QE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2022 at 03:50:23PM +0000, Charles Keepax wrote:

> Yeah they definitely should, I have resent the two patches
> including that fixup, lets see what Mark says. You are CCed
> on them so be great if you could give them a test too.

Please send the incremental fix (which you didn't mention in the cover
leter...) as an incremental fix.

--iliBHVfTx4YPr1QE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOA5nUACgkQJNaLcl1U
h9CeMwf/YLf31WS/3Nn6O7G7MbZ3p2lo72AkUx0WAB4cHcoGqV0XeoxYEkHP64mJ
uRlnP2TG+ObCt+sdsQQ1msxNxnrUKCgJhI8zLm4eWB28fbAzqLn8q1FFjvtM4xPc
17CVOWwB5UtOGBUAp+LKrgttAdq9AXVRX8PHHquEsxko+xNAjraZYmFPH+mtuQSl
yeIo7Py5P8bHH/I4QBb+6VIAYoHnq2PR0NoyyV9q7caK+RgxMU9WKL41vJ+HuwaC
DE/Pyp+r2ejfd3BFT4dj8+6kOO2sHfRbbRXoD1a5QAkCljs+0RKir4e+nsI+lk6h
OlgTFcYJc4rxFDZLxelvcrR6uEEopg==
=sdYP
-----END PGP SIGNATURE-----

--iliBHVfTx4YPr1QE--
