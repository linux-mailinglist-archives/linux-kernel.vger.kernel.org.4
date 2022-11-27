Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC61639CBD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiK0UVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0UVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:21:03 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B88E38B9;
        Sun, 27 Nov 2022 12:21:01 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8FDCD1C09F4; Sun, 27 Nov 2022 21:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669580458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQSiP00ewSNPZIkyVYzfOoRP3X4eN7ZOZf6yRncMeBM=;
        b=n1EDJeMwegBpWiQIoVQCD1CukJSnJMB5uK5yY3H8tu8adfmAaf1amF4HmqHZJ87ywFBR25
        J8pzNBGQnalZpyiQ9McSgNo0I3I4HHlVHOOy8prULIF1t/JHxlqyupnOtpTR381DPL5Ki7
        SGxjSoj4qxK64zUy4JO+Hp2sUETQd4A=
Date:   Sun, 27 Nov 2022 21:20:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Extend Intel On Demand (SDSi) support
Message-ID: <Y4PGpORGjW/h7469@duo.ucw.cz>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wPXwv1mWyFZ3kGfq"
Content-Disposition: inline
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wPXwv1mWyFZ3kGfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Intel Software Defined Silicon (SDSi) is now known as Intel On Demand. The
> following patches do the following:

Quick google gets me to
https://www.intel.com/content/www/us/en/products/docs/ondemand/overview.html
=2E.. which is not really clear.

Do I understand it correctly that this is support for unlocking
features on silicon user already owns?

That is rather user hostile, is it?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--wPXwv1mWyFZ3kGfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4PGpAAKCRAw5/Bqldv6
8s3uAJ4xN8yaazGvmri7XBMsBJOfeUivvgCeOeBPm1ROJgjhytzO4/YEHtSdVJU=
=nfTL
-----END PGP SIGNATURE-----

--wPXwv1mWyFZ3kGfq--
