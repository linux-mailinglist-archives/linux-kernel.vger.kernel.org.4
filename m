Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990307366F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjFTJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFTJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:06:37 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F134C10E0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ms9IFXx1cU+8Zk60e73BpYfGrv8J
        92dt/bB++deqPeU=; b=3cjM/PUFBMUYl8mVV04AuxGsp872a7IKahd/AmKvKtw6
        XkUdsM2ILVykSMnsX8aatX7WpVUQJl3mlohnMs2oLyGmZ0Og0L4t+WbAFOWqg+SV
        /F2r5Rcz74wh4S6WZhpDpvLCDcreXNY0QJbkXYF+wOd5SSpJdJxt/cCyuG0M8fo=
Received: (qmail 570683 invoked from network); 20 Jun 2023 11:06:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 11:06:34 +0200
X-UD-Smtp-Session: l3s3148p1@hae+94v+Xt5ehhtC
Date:   Tue, 20 Jun 2023 11:06:33 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Message-ID: <ZJFsGWepuvkSjL9a@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
 <ZJFSjrf41PHe400c@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NFnAm7lP5qvTJ8qE"
Content-Disposition: inline
In-Reply-To: <ZJFSjrf41PHe400c@hovoldconsulting.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NFnAm7lP5qvTJ8qE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Tested with a Renesas KingFisher board. The chip correctly disappears
> > from the I2C bus when the 'gnss0' device is not opened.
>=20
> What do you mean by "disappears from the I2C bus"?
>=20
> Does this device support both I2C and UART?

Yes, and on my board, both are wired.


--NFnAm7lP5qvTJ8qE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRbBkACgkQFA3kzBSg
KbZM3xAAg1SqEMhfAlfzc6ZMIn+TriiLv8gNXKWZIMt+6y7FAxXeChNTFMAWFl/Q
Ya9y8smzMiQbE9VeRfJcLg8Rkm9wHf6JAW+pHVTtfCUlmHvvq+XR9L791U9t8ZoY
pLTJSfuFUgdBzOQExK7Mfxyd6toqSG5Ji/fE6+BN0LkSsv29pVRqtXlQlz8EpGNV
gvpg2xCzxxunsNHddsq6DelfpfeE0WVhO4uuPhcy823GOhD708iKu6R/DCjEI3UI
7yJH8SIoh0rgU1dvBxrs5IVzhg0OQTH6i20OX+lyEiUGxcppAtDB6KrJcZxn5VhI
vdjfkq+ziWmsAQFU/VDkjFsNbzQOPKoEIU/xlFt+iylvCtGLc1sqqGOsRLn/nqiT
SI/KVSBA8YXcZ6OOVUMxZex5nHd6plcbUWH+/x3jNd+NmE0ox2IgSImVe1IkLBa+
q6pUOT9EQip9p7mCKtrCOQEpjHWESwSv3lELRhtmsBiJ8IrrgxZclqVgm8glO99x
Utj9NREXcKmfE9MZHTvSYXg+oLTtf6bUQ6x2LtgSxIQN4BbrZ4nE7pZb2xJ6Kodx
6GPGrmy4MKOIRhOFVZxHYooG2t4adMGYniwMQkaxwo2HRDKx3dEFupkqIv+aTyy9
TGv/YAnBDuoVTShVQg+i/ZSPDA2snzWPgdZ+wXX1BonWPlab10g=
=EMNT
-----END PGP SIGNATURE-----

--NFnAm7lP5qvTJ8qE--
