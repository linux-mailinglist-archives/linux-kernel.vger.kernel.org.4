Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30EC613C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiJaRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJaRTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:19:55 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4A3F58F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:19:54 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 21E081C09D9; Mon, 31 Oct 2022 18:19:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1667236793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0XGmai5ivnaKB8YXBUpgaZp0PyAsndY8ri/r88VFPM8=;
        b=UTz6QjJTlGz9Zu5fZRZF5LnqRVWx1dQz06NUM5+OnFG5YxvO3S+8BMr0+15RwD2t85j82D
        IDfrRm77DYUL6RN35Ws8ueln0dgzJR7v70Nky0qRYliCzbDZbByYOXa8e99xWd6VQBl1aZ
        QRxGgtQxO0dsbfV3ScPCpzXey7k4AKQ=
Date:   Mon, 31 Oct 2022 18:19:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 6.1-rc: names of video outputs changed?
Message-ID: <20221031171952.GA10666@duo.ucw.cz>
References: <20221031165834.GA10150@duo.ucw.cz>
 <Y2ABatgNLVAAjpSW@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <Y2ABatgNLVAAjpSW@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I used to be able to do:
> >=20
> > pavel@duo:~$     xrandr --output HDMI1 --mode 1920x1080 --primary
> > warning: output HDMI1 not found; ignoring
> > pavel@duo:~$     xrandr --output VGA1 --mode 1280x1024 --below HDMI1
> > warning: output VGA1 not found; ignoring
> >=20
> > ...but now I have to do:
> >=20
> > pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> > xrandr: cannot find crtc for output VGA-1
> > pavel@duo:~$     xrandr --output LVDS-1 --off
> > pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> >=20
> > Notice the change from HDMI1 to HDMI-1. I believe that's new in 6.1 or
> > so. Who did it and why? Hardware is thinkpad x220, and this breaks my
> > scripts :-(.
>=20
> Are you sure you didn't just switch from intel ddx to modesetting ddx?

How do I tell?

I don't think I did such changes recently. It is Debian 10.13 system
(rather old) so I don't think it did update for me.

Thanks and best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2ADuAAKCRAw5/Bqldv6
8uYEAJ4m5bpuOYMIQXtrbhTYNT+QRcqJVwCdGo9ypjMVbnMFfbexsePY9Evj9tA=
=8cyY
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
