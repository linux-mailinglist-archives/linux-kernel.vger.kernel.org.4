Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C930C5C052C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIURRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIURRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:17:12 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB69E2EE;
        Wed, 21 Sep 2022 10:17:09 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A935A1C0001; Wed, 21 Sep 2022 19:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1663780627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSRz24bpKnR47fpvXftTQUQXHR+ooHizhrLLLWndvDE=;
        b=FEYJcwSbaBgdCoBdr0O/F/55xd5kYOlPqVKfeuyqdX9gCYmCLspp1mPxjshEGwel90OH1Y
        7LlV301BcHFqrJdScGwkzKUGLujoT23KIjxifJe1pqEeCMgTMeaGrbQLG0QY8oZy9N78CX
        CNOEVpYYOdbYiQt/uJjM2m/SBA2Chk8=
Date:   Wed, 21 Sep 2022 19:17:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, robh@kernel.org,
        linux-serial@vger.kernel.org, ribalda@kernel.org, johan@kernel.org
Subject: Re: Cutiepi, serdevs, and right way to handle its power button
Message-ID: <20220921171707.GA8443@duo.ucw.cz>
References: <20220920205637.GA17170@duo.ucw.cz>
 <YysjjSXao4MERCwQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <YysjjSXao4MERCwQ@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-09-21 17:45:33, Andy Shevchenko wrote:
> On Tue, Sep 20, 2022 at 10:56:37PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > Cutiepie is a small handheld tablet. It has embedded controller
> > connected via serial to the main system, handling stuff such as power
> > button and battery percentage. Currently they are using userland
> > deamon for communication, but I believe that should eventually go into
> > kernel.
> >=20
> > For debugging, it would be really nice to be able to attach my module
> > to given serdev. Is such thing possible? I see "[PATCH v2 00/19]
> > Dynamically load/remove serdev devices via sysfs*" series
> > (https://www.spinics.net/lists/linux-serial/msg30732.html) but I'm not
> > sure if equivalent functionality exists in mainline kernel?
> >=20
> > Is there some kind of similar hardware already supported by mainline?
> > Using driver as a reference might be easier than starting from
> > scratch.
>=20
> Is it arm or x86 based tablet?

arm64, but CPU architecture really should not matter.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYytHEwAKCRAw5/Bqldv6
8qIzAKCRTrRwV/SltYWgSAFyjIxSnh3ONwCfS6ZchPDQ/OqNKYkP+e8SbinwPQU=
=wKSv
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
