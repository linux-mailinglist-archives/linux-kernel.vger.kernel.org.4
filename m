Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E848612C99
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3UPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3UPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:15:31 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CAA185;
        Sun, 30 Oct 2022 13:15:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 81C001C0049; Sun, 30 Oct 2022 21:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1667160928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SRUdneXHxh/Cv6fvYSjs07wKwz7JXwgYVVxDoXQty8s=;
        b=eqHxQA1emI0dt09Uf566QBHKNMWni+R6zQZbJvKogxPJquSKsnd+IPfrLMxFT7V//xgQmv
        luoikPnbPz2F2gcOyhOL5MOvA4CutdR6miiuiGneuzQO6zTG6VGBVcw9QtlKF03rYdgPL7
        YLddMeumTV/qvZ2GZyxlBBHz7nS8WoY=
Date:   Sun, 30 Oct 2022 21:15:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Message-ID: <20221030201527.GA23195@duo.ucw.cz>
References: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
 <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
 <20221030122029.GA8017@duo.ucw.cz>
 <b7304844-a654-2120-2159-29f6134dbadb@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <b7304844-a654-2120-2159-29f6134dbadb@sberdevices.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This allows to set own workqueue for each LED. This may be useful, bec=
ause
> >> default 'system_wq' does not guarantee execution order of each work_st=
ruct,
> >> thus for several brightness update requests (for multiple leds), real
> >> brightness switch could be in random order.
> >=20
> > So.. what?
> >=20
> > Even if execution order is switched, human eye will not be able to
> > tell the difference.
> Hello,
>=20
> Problem arises on one of our boards where we have 14 triples of leds(each
> triple contains R G B). Test case is to play complex animation on all led=
s:
> smooth switch from on RGB state to another. Sometimes there are glitches =
in
> this process - divergence from expectable RGB state. We fixed this by usi=
ng
> ordered workqueue.

Are there other solutions possible? Like batch and always apply _all_
the updates you have queued from your the worker code?

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY17bXwAKCRAw5/Bqldv6
8nHqAJ460FAvTohZFx62OjyLkAZzcTBWuwCdEuMPpqEQExkcrAlv3eJJ2vF6Yx4=
=fMSI
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
