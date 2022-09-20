Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0445BEED0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiITU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:56:41 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD9869F77;
        Tue, 20 Sep 2022 13:56:39 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D39121C0003; Tue, 20 Sep 2022 22:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1663707397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=r9rh1lRm/DkkVvz81Uc8+tUw8Wdv4XX3sKR27wWxMCA=;
        b=LC52VEXvq1rVE1t+lOnf2OqwQeopaPe3q7iZInndd/etq9hxrkigPjISG2LJVG+oZP5It+
        tVPzDJQjkpkVjQLBByiv69YaUpTULjJkRSfNYgtb6vBXAUmkSAgi2tsrK7U/A3zH10ImWt
        a0BhY308WW+TcHECmGojd7wv53Kb+So=
Date:   Tue, 20 Sep 2022 22:56:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, robh@kernel.org,
        linux-serial@vger.kernel.org, ribalda@kernel.org,
        andriy.shevchenko@linux.intel.com, johan@kernel.org
Subject: Cutiepi, serdevs, and right way to handle its power button
Message-ID: <20220920205637.GA17170@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Cutiepie is a small handheld tablet. It has embedded controller
connected via serial to the main system, handling stuff such as power
button and battery percentage. Currently they are using userland
deamon for communication, but I believe that should eventually go into
kernel.

For debugging, it would be really nice to be able to attach my module
to given serdev. Is such thing possible? I see "[PATCH v2 00/19]
Dynamically load/remove serdev devices via sysfs*" series
(https://www.spinics.net/lists/linux-serial/msg30732.html) but I'm not
sure if equivalent functionality exists in mainline kernel?

Is there some kind of similar hardware already supported by mainline?
Using driver as a reference might be easier than starting from
scratch.

Thanks and best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYyopBQAKCRAw5/Bqldv6
8sB6AKCU3BmN+mPnuXU0+Ay0EuRrQ+LYyACgmGBIVcVSKQjvDVelmUqHEOqXxT0=
=5Nv7
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
