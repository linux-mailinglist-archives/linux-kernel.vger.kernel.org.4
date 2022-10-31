Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD06613BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiJaQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:58:39 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459A8DFB0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:58:37 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0D47C1C09DA; Mon, 31 Oct 2022 17:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1667235515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=nNuKKzhaDHv5Jvd/BCwuHm16VUQS2j6zeWAvcQDM5yE=;
        b=GPqUlhSnX+KKx6mq2j08PChZWDeLHNlMT+cadrpI6anF9i2AzI+pzZQG7xAUNcMzvCr4eK
        WxKvR5lR5qEa4jjbXtN1vezd+NW6mZzdSdTWOFgb+IFjc9ey/2bUER2FjPTZxBnrksCZOm
        p3Vz6M5R++9+GM4Ke/0L+zG2DXh5pt4=
Date:   Mon, 31 Oct 2022 17:58:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, kernel list <linux-kernel@vger.kernel.org>
Subject: 6.1-rc: names of video outputs changed?
Message-ID: <20221031165834.GA10150@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
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


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I used to be able to do:

pavel@duo:~$     xrandr --output HDMI1 --mode 1920x1080 --primary
warning: output HDMI1 not found; ignoring
pavel@duo:~$     xrandr --output VGA1 --mode 1280x1024 --below HDMI1
warning: output VGA1 not found; ignoring

=2E..but now I have to do:

pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
xrandr: cannot find crtc for output VGA-1
pavel@duo:~$     xrandr --output LVDS-1 --off
pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1

Notice the change from HDMI1 to HDMI-1. I believe that's new in 6.1 or
so. Who did it and why? Hardware is thinkpad x220, and this breaks my
scripts :-(.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1/+ugAKCRAw5/Bqldv6
8hd4AJ49iOfX+4FpOzVurlxNV/4RF4h/twCgu38XdfGmi//K9HOjRhyOEecpr9E=
=KDLK
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
