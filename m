Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90517734BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFSGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFSGpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:45:25 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C113D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:45:24 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BC81D1C0AAC; Mon, 19 Jun 2023 08:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1687157122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+YQCwNgfXFgVNMY80VzJf/5mlZJ8RmQH0ut1L8gDHSM=;
        b=MVaVYlRjw+Cvmss6qEPIRSBe1QJjN5tV0pbftKbNlFuJTG4SE56Ydi6F6l40tuV4EULRPF
        52wS1CeQGp0QwHKX+PdGAxJkkR1laV+t4y3ZNn2W2i9efQeP4MPCQ2w6yI5qAprQ5snuvU
        odyv4nAQBcph8vD+StHjAEdgngFsHDI=
Date:   Mon, 19 Jun 2023 08:45:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, hexingwei001@208suo.com,
        pmladek@suse.com, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib/test_printf.c: space required after that ','
Message-ID: <ZI/5guHaSPrld+Cv@duo.ucw.cz>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
 <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
 <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
 <20230614110640.57817123@gandalf.local.home>
 <ZInZ1BcHHQbok+wg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0iEVJC1jAlTlG2fb"
Content-Disposition: inline
In-Reply-To: <ZInZ1BcHHQbok+wg@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0iEVJC1jAlTlG2fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-06-14 18:16:36, Andy Shevchenko wrote:
> On Wed, Jun 14, 2023 at 11:06:40AM -0400, Steven Rostedt wrote:
> > On Wed, 14 Jun 2023 15:32:30 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Jun 14, 2023 at 04:30:55PM +0800, hexingwei001@208suo.com wro=
te:
> > > > Add missing spaces to clear checkpatch errors:
> > > >=20
> > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:Vx=
V).
> > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:Vx=
V).
> > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:Vx=
V).
> > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:Vx=
V).
> > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:Vx=
V).
> > > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:Vx=
V). =20
> > >=20
> > > Doesn't make any difference to the code, so let do this (unneeded) ch=
urn
> > > to calm checkpatch down.
> > >=20
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > checkpatch is for patches (new code) and should not be run on existing =
code.
>=20
> Why does it have -f option? What do you propose to prevent people from us=
ing it?

Brain needs to be used while using checkpatch.

Plus, autosel is "great" trying to backport anything that mentions
"error", so better don't do this.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0iEVJC1jAlTlG2fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZI/5ggAKCRAw5/Bqldv6
8vyBAJ4ocqcNDFBf1QDD2WsMcdssX//vvwCgl8k8r9e/JkrXobnf6/zpRDaWFgA=
=xu7X
-----END PGP SIGNATURE-----

--0iEVJC1jAlTlG2fb--
