Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E063AA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiK1OOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiK1OOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:14:40 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A479FD2B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:14:39 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5F3181C09F5; Mon, 28 Nov 2022 15:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669644877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rGJWUVnxuOhXC4OhcqVWVC9NHJW8JSVGyqkZTPU8IEQ=;
        b=Uj4NtVkoQJrMNSno290K4ByVroycMtD1iKTXiOwT0cACzvdwpsJ+QcGlpK2snbTM4P4kgw
        NU/uS0q8QBfm/sB8YmNnz0K3RLNgeMj+Cx4XP78NYXdtiN3ziEPAEo6Ez7lxqvyfs7KWgK
        uWRs9FIM72suoH5uA4iwFZZ3nStnuU0=
Date:   Mon, 28 Nov 2022 15:14:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RDTSCP | IA32_TSC_AUX on x86-32
Message-ID: <Y4TCTE8SIn7Gsisv@duo.ucw.cz>
References: <Y33r3w6xvEeZH2XY@linutronix.de>
 <Y33vAaDu84tU8jf6@zn.tnic>
 <Y33vzIy8Yw49R7am@linutronix.de>
 <Y330qDdrRfzWBGWF@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dNvKA+i7JojndXAj"
Content-Disposition: inline
In-Reply-To: <Y330qDdrRfzWBGWF@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dNvKA+i7JojndXAj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-11-23 11:23:36, Borislav Petkov wrote:
> On Wed, Nov 23, 2022 at 11:02:52AM +0100, Sebastian Andrzej Siewior wrote:
> > Do we have a schedule for the removal? I mean we talk about it for
> > years=E2=80=A6
>=20
> Hahah, nah, no schedule. I don't think the time has come yet - even if
> we want to. I was mostly joking. :-)

Given that Pentium-class machines are last x86s without serious
security holes, I'd keep 32-bit support for a while :-).

							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--dNvKA+i7JojndXAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4TCTAAKCRAw5/Bqldv6
8rvDAJ9cEPya7Loti2dlpz1AULODkjoiRACghLp83sAoI//MTSbBL12J7sTV17Q=
=HMMT
-----END PGP SIGNATURE-----

--dNvKA+i7JojndXAj--
