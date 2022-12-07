Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DA64624B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLGUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:20:09 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B87B4CF;
        Wed,  7 Dec 2022 12:20:08 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C5F6A1C09FA; Wed,  7 Dec 2022 21:20:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670444407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eh9NhAnoQecLCp7nuLOnthOFNLGPDmhbnX28mSicZBc=;
        b=QycL77zaG/WL3VgRHdJ0wqN9TQbgn2McpFJ5gCNR5Qvy0DIgf6E+MYTylfi1V4eg/9mIjk
        AEydDvDvdHhbB+fz2GoaBVuVgP6bltij+/l3lv9Omz+EJbOLspBuwEVhSpV6itahRS2I6x
        ZL02SAuIuqm19mu8W+HzPmBS9HA5ZDY=
Date:   Wed, 7 Dec 2022 21:20:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] leds: Fix devm vs. non-devm ordering
Message-ID: <Y5D1d3WhLCpmfo+N@duo.ucw.cz>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dtx9TZ7I9qpyVSaS"
Content-Disposition: inline
In-Reply-To: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dtx9TZ7I9qpyVSaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Fault-inject tests reports this issue:
>=20
> DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> WARNING: CPU: 2 PID: 52 at kernel/locking/mutex.c:582 __mutex_lock+0x1366=
/0x15b0
> Call Trace:

Ok, so:

a) this does not happen in wild

b) you have not actually tested any of this

?

It looks reasonable, but the "Fixes:" tags mean -stable will pick this
up almost immediately.

Is anyone else willing to say this looks ok to him?

Any testers?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Dtx9TZ7I9qpyVSaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5D1dwAKCRAw5/Bqldv6
8uu1AJ4gVur77IXI3520H+FU3r8u1VsyvACfSGnZBEhHWc7ZFUK6Gn6UMbXrYOg=
=IH31
-----END PGP SIGNATURE-----

--Dtx9TZ7I9qpyVSaS--
