Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0666DD8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDKLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjDKLIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD6CA;
        Tue, 11 Apr 2023 04:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0F060B73;
        Tue, 11 Apr 2023 11:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1B2C433D2;
        Tue, 11 Apr 2023 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681211329;
        bh=qIOyfzkrxRB9OOp+QuQSjfXfnjkj0SIKOFRLoZwQrbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kulBDfZ7GTodEsmRewzDDmRR0Nt0c/Zv5+WN3Skp0gkFogX8cByLFPdB2FTWmrWao
         4x8hNIEexXqwwlUXs6g7O/pr0/ZfzeipWTZD3dQo+osoT/CTyaNCzaHatM23fAM6hF
         f3ZdmP7zQ2b2ShZpsUxSyqmdqmsB+w3T81YixA3SiOlm0Qwia98EHhtjpCsymOKSaP
         rK8mWoqBu4xXxzYdDbJr2lmPEgwtaicr9RhrCcYpUfQJ/KUhWSywXWBAkXm0fz7SPS
         a261y//qIHjTy0Vw4zzlpSpp0pTuz/jGlzPy60SE1vPlOEfN1uOFhbWJ9UvhsnaATU
         BTPVO8VMiKJIQ==
Date:   Tue, 11 Apr 2023 12:08:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <d5bdc21e-72cf-457c-8a5f-4ccbd37272c1@sirena.org.uk>
References: <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
 <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
 <7c71d182-2ac5-b01e-2875-5060fb509056@roeck-us.net>
 <65e06627-c368-d081-e18f-a45f245c37ab@gmail.com>
 <b49cc518-634e-4812-ae4a-ee6ec45b42f2@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/rU+/PCyIIhYVt+l"
Content-Disposition: inline
In-Reply-To: <b49cc518-634e-4812-ae4a-ee6ec45b42f2@roeck-us.net>
X-Cookie: In the war of wits, he's unarmed.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/rU+/PCyIIhYVt+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2023 at 10:47:18AM -0700, Guenter Roeck wrote:

> Personally I think you are concerned about a non-issue, but without
> explicit guidance from regulator maintainers (and no clear definition if
> and when regulator notifications should or may be sent) I won't be able
> to apply this series.

I would expect that regulator driver should just pass through whatever
they get from the hardware.  I really don't understand what the
confusion is here.

--/rU+/PCyIIhYVt+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1P7oACgkQJNaLcl1U
h9CZEQf/U78igDONvambVgDJmwswCLzgiCuNk6cJgRmmUKJ4vbNE7S8Hex0P179X
YkS9RRpWn4Tb0os0XeFj4oG8RWtWYvU+wlrJxZdA/lf4aOHJbQqlngtlQWjtgfGQ
Lt0EKieZl9It5wD49BSSbP1rbTsMDQzpmsfhUg/KlurFYzBs9bM5KhEfNKUUpS9F
csHFCacN2Dn/ZeHt2Vme50sEPN5IODa2ZEMxugVMj04G+dEDp/hdbOy9bmTicWE4
vWN26j+t37CotdAb9h7mwyNwJ+wEuDMlOsyQ52OfZ2YWTyW5DEDK+hGq9S617P6q
c0WLg5eewbsL5DCaaY/hiJxRquuK+w==
=CrIZ
-----END PGP SIGNATURE-----

--/rU+/PCyIIhYVt+l--
