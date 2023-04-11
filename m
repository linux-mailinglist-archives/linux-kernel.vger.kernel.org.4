Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC556DDA49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDKMI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDKMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FBC44BF;
        Tue, 11 Apr 2023 05:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F5B4617D4;
        Tue, 11 Apr 2023 12:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75764C4339B;
        Tue, 11 Apr 2023 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681214874;
        bh=bfXxxqU7BPs2st8XCWNHLsB7FvX0a15Qddu/KMfKILw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omsQjIkdpV5ZXNyGtnm7EwOZmqwpH0bLCSP/Ss95F5A+c9qm9GzZ6Cd3GTHjKJij9
         t/1s6kAx6lyWAZjE4FXUbYKVXnzmzXNYWAkz0xUtXwVB4AbiVgFpRk3yoKrOcKmZaY
         1H+/YJNIDnttz2SKSJc3/lhN9K/EnWb1Kr4TjSYFrVJvRmH/B8vv6GJXmKd7gM5REW
         nGss0mTDSC5cUhmd6obkJd9Gv00u4d+c+B9of2XTeNzSlxZd8VfF4rlxjAjdgR5oYW
         By5Hf3pk7TvHO1AUZqTh/hg/KkiI7758Wc4IAVr+SCe0i+GM+Bic3FyX0PeWAnYASI
         w2AeoeKjCgbhw==
Date:   Tue, 11 Apr 2023 13:07:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <74f9ebff-3e6f-496f-a776-5bd4650c566c@sirena.org.uk>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
 <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iSZ5n5zgM2M88gcl"
Content-Disposition: inline
In-Reply-To: <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
X-Cookie: In the war of wits, he's unarmed.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iSZ5n5zgM2M88gcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2023 at 11:19:41AM +0300, Matti Vaittinen wrote:
> to 6. huhtik. 2023 klo 16.43 Mark Brown (broonie@kernel.org) kirjoitti:

> > I'm not sure what you're expecting there?  A device working with itself
> > shouldn't disrupt any other users.

> I have no concrete idea, just a vague uneasy feeling knowing that
> devices tend to interact with each other. I guess it is more about the
> amount of uncertainty caused by my lack of knowledge regarding what
> could be done by these handlers. So, as I already said - if no one
> else is bothered by this then I definitely don't want to block the
> series. Still, if the error handling should be kept internal to PMBus
> - then we should probably either say that consumer drivers must not
> (forcibly) turn off the supply when receiving these notifications - or
> not send these notifications from PMBus and allow PMBus to decide
> error handling internally. (Again, I don't know if any in-tree
> consumer drivers do turn off the supply regulator in error handlers -
> but I don't think it is actually forbidden). Or am I just making  a
> problem that does not exist?

I think you are making a problem that doesn't exist.

> > Like I say I'm not sure how much practical difference it makes to think
> > too hard about differentiating the errors.

> I would do at least two classes.

> 1) critical class - it is Ok for the consumer to forcibly shut down
> the regulator, or maybe the whole system.
> 2) warning class - it is not Ok to forcibly shut down the regulator.

How severe an issue bad power is will be partly determined by what the
consumer is doing with the power, it's going to be in a fairly narrow
range but there is a range.

--iSZ5n5zgM2M88gcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1TZQACgkQJNaLcl1U
h9Ducwf9EHoKpcYxaSwEKyyQvCAmCsWGuRLaCXvkIox6rsTHBWQh6U5fsRdaTHBm
6lmAvzXd5fW9OBRiDUngGOEjLtJzQw/KqdgTDB82HKxvmEqWLgDbdLTsmSJLJF+O
/nZ7/KC3+DWgetyLVj5C7j71qnXU6Z/bxkiBwjCEF0dBCRM6unbY/visToQCgPeS
CFlojNzqr8Eu4JWyxdPivheYQKPcfrGvBCpka2rEiv6ywc7BdrnOQOAp8r3FOUJK
qyQ7Ef+tsCjQUxI9ZX+Zc9mukIAPbbI51cEOcCTNykd1ZTVE+0uIWv/Pq16+wR2c
r7SSDYC9AQM7xocLnAYt4+cI/O5G0g==
=/CrN
-----END PGP SIGNATURE-----

--iSZ5n5zgM2M88gcl--
