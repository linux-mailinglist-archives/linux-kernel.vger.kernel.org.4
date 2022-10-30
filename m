Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9E612A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 13:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJ3MUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 08:20:33 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E076BF71;
        Sun, 30 Oct 2022 05:20:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 807BE1C0049; Sun, 30 Oct 2022 13:20:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1667132430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hias7VKQjUdpPuflqVLK7lqLnK3ZQmAq9dgwF0j30I=;
        b=P4xQRB9OzNp7ztxscH434CKzniC138bu/A6I791xRrNCR5aCAhukHKwuJoJ1qdli+6Ro/T
        tN3aXWi3700Fxqgn+lOUTg2PShpiyg2fpWXkxxZHCqELtA9mjo1EDu/xuv3muVrQgRTyaF
        teVqaaeouMFNEK2OtzMNwzjg6usXIt0=
Date:   Sun, 30 Oct 2022 13:20:29 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Message-ID: <20221030122029.GA8017@duo.ucw.cz>
References: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
 <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2022-10-30 06:07:05, Arseniy Krasnov wrote:
> This allows to set own workqueue for each LED. This may be useful, because
> default 'system_wq' does not guarantee execution order of each work_struc=
t,
> thus for several brightness update requests (for multiple leds), real
> brightness switch could be in random order.

So.. what?

Even if execution order is switched, human eye will not be able to
tell the difference.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY15sDQAKCRAw5/Bqldv6
8j4YAJ49gFu2Mn9ni7m78Dvmkjkr6uiv9gCcC4IPh83zrbPvx9dgc1udEucyI8Q=
=KvNb
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
