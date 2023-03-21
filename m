Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4E6C3A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCUTZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:25:30 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B82BCDCA;
        Tue, 21 Mar 2023 12:25:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D13241C0E0F; Tue, 21 Mar 2023 20:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679426725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHp6qocT5JOMM3snOUIRNwEjiVup1saxJEKPXH3LIBE=;
        b=gID0n8m6SA8ipfHjTNofqRiy7vmUspmy8RXVQ51Bvm2cAeUWSI8/6VTrv4WqYlh617PKFE
        LtO0OLZJ3cZhzc7GIbPg9I4uF/h/lPdTSG4xGCOV1NT2R66UVZcO3KS3aOPU/IumwS/1Wl
        2KrEILSyRMa0shcWlugJQDrXPFVlVKU=
Date:   Tue, 21 Mar 2023 20:25:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, phone-devel@vger.kernel.org,
        maemo-leste@lists.dyne.org
Subject: d4: Usable with some caveats
Message-ID: <ZBoEpYPKRFfr/cpR@duo.ucw.cz>
References: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qmFDAhRrfFm1Hqfm"
Content-Disposition: inline
In-Reply-To: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qmFDAhRrfFm1Hqfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So I believe I found out reason to high power consumption -- web
browser. It is really easy to leave it running, and power consumption
goes from 0.05A to 0.15A to roof depending on website.

With the fix to stop charging on battery full, it is nice enough to
use on daily basis. But there are still few problems:

1) Booting with empty battery will result in Maemo booting then
immediately shutting down, discharging battery all the time.

2) Enabling bluetooth and leaving it enabled overnight will result in
so many oopses it fills root filesystem with syslog.

3) When root filesystem is full on boot, it results in hang with black
screen.

(And yes, today I hit 2) which let to empty battery and 3).)

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--qmFDAhRrfFm1Hqfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBoEpQAKCRAw5/Bqldv6
8mngAKCHkoASjYTwnGhYPwRuRYbftdnbBgCeMidJcnSkuzIYxHfmYmEGT/yXT0c=
=6y8d
-----END PGP SIGNATURE-----

--qmFDAhRrfFm1Hqfm--
