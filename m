Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE8657C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiL1PcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiL1Pbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:31:49 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C016498
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:31:39 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id x11so12902698qtv.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hardenedbsd.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vuofHjDm4STYXNdGsep6aD4JXI32+stKyT0rMvY0yIE=;
        b=gtw3JBQVK415jmrBeDvapjJYJdJrnltnKNSkGA6YgrLtP2bs/93MkQJeCOIQjucj2f
         jZ1To18EjK2jj0xhwN8IYMiq6Xg5V/SPv5nZlAucA3ifJ4UAbPbg5X3GMMFD4ImRFlfu
         DJbtp9w36RU53oYDAzNd29JbudrOxckr34nj6U+d9FMncElAubAJ6NiUceU+gLE6umJn
         z6D7sclZS0mLbXhJnd26xqMG2dfmuKWyl6XP/Yyaf2A0JcD1cory6tUYo/TPu2YMttAA
         ZAm4dfTdT/xpiY0SVWQ6xCzNiFlrWcmNlJbolRbXkuSOqJhvyzlCXB04MdpLlyKrX841
         OYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuofHjDm4STYXNdGsep6aD4JXI32+stKyT0rMvY0yIE=;
        b=wJ7+xNV9RfVVT6pvofRj9n7OzWh7bT634M5ZIydm9VKBkS0fKrT0ZHYOkdVWS4Suwn
         smxdpLzZRQVkE7auomUdm1d4O3/szChndOnbC5uVLry0Ze8CBo1XMYbP3fnBfLwQb6XE
         +6wF9Lkg20IbkiY+TYER3dMzp6KWveLCzzQXZfKYA0mZ3PvC/jJ4fk2kMcyvOqsccrP+
         A/wGzDPNRd8AbhpJ/cPX0sJSfs0ZVZVz/jl7OIiMPQ9T5TB1iG81zoBBBg1UmDuA3yFf
         iKtlslZrQMGcBs2RlB7DiaTWXWg+zEstImZo6w3mGq7YDEmn3tCqF4K1smnwBmzJaNWo
         W9xw==
X-Gm-Message-State: AFqh2kqpRZ33QFZtdrohYvfqjGHzH2agW7sNUr2ZF4MWFLpf9Rr4SiFy
        yDk7mOg53BHgNNQXko0sohMnYg==
X-Google-Smtp-Source: AMrXdXsJ7fP4Q5mz0Ra/FOpqE5hbViJkZkTFXPjbP9L+A24yyFhTx8aCgTBTZVxN/TmkNlUjEx+7sQ==
X-Received: by 2002:ac8:534c:0:b0:3a9:8183:6a04 with SMTP id d12-20020ac8534c000000b003a981836a04mr43048522qto.54.1672241498856;
        Wed, 28 Dec 2022 07:31:38 -0800 (PST)
Received: from mutt-hbsd (pool-100-16-219-215.bltmmd.fios.verizon.net. [100.16.219.215])
        by smtp.gmail.com with ESMTPSA id m14-20020ac866ce000000b003a7ee9613a6sm10027215qtp.25.2022.12.28.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 07:31:37 -0800 (PST)
Date:   Wed, 28 Dec 2022 10:31:37 -0500
From:   Shawn Webb <shawn.webb@hardenedbsd.org>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <20221228153137.4w4bhaqt4fb5vlio@mutt-hbsd>
X-Operating-System: FreeBSD mutt-hbsd 14.0-CURRENT-HBSD FreeBSD
 14.0-CURRENT-HBSD 
X-PGP-Key: https://git.hardenedbsd.org/hardenedbsd/pubkeys/-/blob/master/Shawn_Webb/03A4CBEBB82EA5A67D9F3853FF2E67A277F8E1FA.pub.asc
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k7cz6avvpg6f66a7"
Content-Disposition: inline
In-Reply-To: <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k7cz6avvpg6f66a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 10:24:58AM -0500, Shawn Webb wrote:
> On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/VE6BBM=
) wrote:
> > Dominique Martinet writes:
> >=20
> > > But, really, I just don't see how this can practically be said to be =
parsable...
> >=20
> > In its current form it never will be.  The solution is to place
> > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > to get the command+args part (assuming I counted all those fields
> > correctly ...)
> >=20
> > Of course, this breaks backwards compatability.
>=20
> It would also break forwards compatibility in the case new fields
> needed to be added.
>=20
> The only solution would be a libxo-style feature wherein a
> machine-parseable format is exposed by virtue of a file extension.
>=20
> Examples:
>=20
> 1. /proc/pid/stats.json
> 2. /proc/pid/stats.xml
> 3. /proc/pid/stats.yaml_shouldnt_be_a_thing

To expand upon this idea, lets define an example json file:

{
	"schemaver": "20221228001",
	"name": "cat",
	"state": {
		"raw": "R",
		"intval": 1,
		"Pretty": "(Running)",
	},
	"tgid": 5452,
	"pid": 5452,
	"ppid": 743,
	"uid": {
		"real": 501,
		"effective": 501,
		"saved_set": 501,
		"fs": 501
	}
}

And so on.

--=20
Shawn Webb
Cofounder / Security Engineer
HardenedBSD

https://git.hardenedbsd.org/hardenedbsd/pubkeys/-/raw/master/Shawn_Webb/03A=
4CBEBB82EA5A67D9F3853FF2E67A277F8E1FA.pub.asc

--k7cz6avvpg6f66a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEA6TL67gupaZ9nzhT/y5nonf44foFAmOsYVkACgkQ/y5nonf4
4fonfA//aKcBZ1LuRMDhEhGwkR7Iq3V988pnjIrfeJzNM33Cpf4zWtfsyR73gStD
29peSWTP+L9hg6A9K9FcvcbseYYYhlegTtqPtxdbEbL7fqBzm2LDLD9Vh3RTQE1Z
qYMOXSGRjbjivPfoDDGXlFahY5Lqt5NX5w1/wfR+4NpbpGZ/VyXo48XtSmiG9XuV
+LDGIQ1FOul4M1XqqD3CApJsjuOmwtLGQxQIcatQYgkOin9uN1O8bYMVHiXXPEJp
q+s+gZIT9sxHLKvNbAjw3WRzTHMPNPk2PTxLkNjxBbrxd428UNamJlPmLwPsp2xg
OucAMb3coSh+Af71K7f+bZ6lv/ZAVKbA0Vpmun887rww/dlcPKUd+DpdVKc2JK8k
pvQy/OZIly8+uggmx3qfz8svjpR0wD68v5wX/i/+UXsszgp9ArlCKbAlORTxea+A
5R7wQi9QS0jKk04zMA5GZ2W8gEFgjRYdjPe3oIt64mcbHKE8qaj3kZNjgoyqXl7e
zmMjP776S8ot/aPsHTho9sizi8RuqjMbX3q4TePjWajbJC99Akqoo6Ah/x2rNZ54
U3l5aQAEOw8E/sMYAjBNMVIJFZz9yEyDgeYqXBOI3zl68h6A/hdDtd75higpM1Qo
8pHkUFFYDOBKfaIdJmDR4QNf/DPOYQaW9RZFrF6p6c2L5WPdOko=
=Epsn
-----END PGP SIGNATURE-----

--k7cz6avvpg6f66a7--
