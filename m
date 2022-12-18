Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2967065046F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLRS6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLRS6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:58:06 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F338FEE;
        Sun, 18 Dec 2022 10:58:04 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 602CA1C09DB; Sun, 18 Dec 2022 19:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1671389883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FGFdHHTtpuX5Ly4phczSAMx8RAJOhEVAay3kGEN6IR8=;
        b=b3Ekrtp9D0DsqUbf5GNoJgxgDJMjwu/CrSAIU6w+u45aG9GgO7cUwioBf5u6NDSSML63kZ
        IFtHughU0zfhrUFKCXMzbCT5KP5cv7o3eCDc7QLqbs+VtA9ydyTG2ZWvofTznUiZ+TXYGt
        cqnqNvy4XKSCBYncHYzJsngFl/qLzVI=
Date:   Sun, 18 Dec 2022 19:58:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     tumic@gpxsee.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@amd.com>,
        Martin =?utf-8?B?VMWvbWE=?= <martin.tuma@digiteqautomotive.com>
Subject: Re: [PATCH v4 0/1] Digiteq Automotive MGB4 driver
Message-ID: <Y59iurFF9CM21p7o@duo.ucw.cz>
References: <20221123140431.4730-1-tumic@gpxsee.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aKB7rpqiU3Up+ofL"
Content-Disposition: inline
In-Reply-To: <20221123140431.4730-1-tumic@gpxsee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aKB7rpqiU3Up+ofL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Martin T=C5=AFma <martin.tuma@digiteqautomotive.com>
>=20
> Hi,
> This patch adds a driver for the Digiteq Automotive MGB4 grabber card.
> MGB4 is a modular frame grabber PCIe card for automotive video interfaces
> (FPD-Link and GMSL for now). It is based on a Xilinx FPGA and uses their
> XDMA IP core for DMA transfers. Additionally, Xilinx I2C and SPI IP cores
> which already have drivers in linux are used in the design.
>=20
> The driver is a quite standard v4l2 driver, with one exception - there are
> a lot of sysfs options that may/must be set before opening the v4l2 device
> to adapt the card on a specific signal (see mgb4.rst for details)
> as the card must be able to work with various signal sources (or displays)
> that can not be auto-detected.

Uff, that's "interesting". What kind of platform does this run on? You
should be getting non-probeable parameters from deice tree (or APCI).

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--aKB7rpqiU3Up+ofL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY59iugAKCRAw5/Bqldv6
8lMSAJ9SB9PBRGjXPnIO1uAbVvXBLCDCuACfSoR6Gu3fbUu2czcZd34M8PcIjr4=
=CGKZ
-----END PGP SIGNATURE-----

--aKB7rpqiU3Up+ofL--
