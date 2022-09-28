Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72A5EDF31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiI1Oui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiI1OuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:50:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0595E77;
        Wed, 28 Sep 2022 07:50:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so27605947ejb.13;
        Wed, 28 Sep 2022 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cKWO9+JfzL2fzwwzI1VgJVcxOTRPCNulp/5l/O+wGWs=;
        b=cfG0rNL3i1oY1EJm2ZgBBCmigLLtk6wzMHtiiWZzXw7pWoAIiQpEgrj5Y8YaqKrsPM
         V2H4iIvCrglIUGx0BPw3PuorNMrC0dekdpeChlYVw8dfPFPYxUR3y44truQfDBzq4um7
         QaQf2+G/DvleUX4dJGJ2e2Z5gxOccKUCE86C4WBZq318n4VK6rTZww2qfm0uC/mwvvmN
         fV9XAGqBCCNzrgYd/aKSQvhou8zt9ASXE7omy3w0dIuTcsFTsp9Xzgogp7pBA423Wn59
         5Ylu/N9oWa/mva70zA+1swJtM1XZUNM0F0nMjV0n3efyy46as3ApfQR2fdZPjuy9ot2k
         3CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cKWO9+JfzL2fzwwzI1VgJVcxOTRPCNulp/5l/O+wGWs=;
        b=iIDRTJ48U/GyN1afYe4wAd/gwGGC49zKXtmMBF15tXfb+qKBm87ctcdGZw9SC+OQcy
         hyLclODttFX25VSE0UKyUdCP3LtBY0q2+K1lpLoqJCIjnDA5IBTnSjqNDR8kARMzzDsJ
         Gt29FnhfRRbe5G+q3WcZfSpyykqYK2OLd9O847l/013aSpvGxTUE5pfJ3akPyz/yq6Uf
         mwz43IEkuNiTnMg0WmMHNCFZOSgxVJwLILKMIFR3tHPbpS6cgr+XceE1dbhPIIwNbNLB
         k9plMHmVJROVuqDr3u2+RuQVMiqIBajm/lkoQDzkubmEF8zpTHxT6etZxopsSqlRDFTN
         e0aA==
X-Gm-Message-State: ACrzQf30lTjTSBJf4F91MLDZ+8UDIx+RintAylVVkDw21oLzMlGw8Kle
        6GB99wZQiMJys5Hcwb+4nG0=
X-Google-Smtp-Source: AMsMyM5q4Jb1gflu02dHE290aKNhEsUhWN3orEUliz3hq7XGsv2+zQB2JJi2ujEoI+tWKLEzyx8SFA==
X-Received: by 2002:a17:907:8a13:b0:782:5146:dffa with SMTP id sc19-20020a1709078a1300b007825146dffamr26998139ejc.538.1664376599852;
        Wed, 28 Sep 2022 07:49:59 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b00782cd82db09sm2470286ejj.106.2022.09.28.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:59 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:49:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] pwm: lpss: Make use of bits.h macros for all masks
Message-ID: <YzRfFVdZ5XsStnFq@orome>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
 <20220927162421.11052-7-andriy.shevchenko@linux.intel.com>
 <YzRYPvzWFBXijIBQ@orome>
 <YzRde5PuFnL5KbrC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+v1CZxweel0L0gXY"
Content-Disposition: inline
In-Reply-To: <YzRde5PuFnL5KbrC@smile.fi.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+v1CZxweel0L0gXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 05:43:07PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 28, 2022 at 04:20:46PM +0200, Thierry Reding wrote:
> > On Tue, Sep 27, 2022 at 07:24:20PM +0300, Andy Shevchenko wrote:
> > > Make use of the GENMASK() (far less error-prone, far more concise).
> >=20
> > Very subjective.
>=20
> See an example why not: 0a90ed8d0cfa ("platform/x86: pmc_atom: Fix SLP_TY=
Px
> bitfield mask").

Hardly comparable to this particular case. And really this is stuff
that's getting on my nerves. People constantly replacing perfectly fine
code with something equivalent just for the sake of it.

Thierry

--+v1CZxweel0L0gXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0XxUACgkQ3SOs138+
s6GWbw/+PT/IqxUtpkvtS8FDWP7Q3tbJu/lU9b0EEuQpkJQFJZV3lAdL52Ir3hc5
H1OWcn048rPj24btlM/U0RciJW0gj05sAw+ixHtTtLU7KrhovdfRm/P2aUJNnlUN
99H7ktODgZjDkPcd/4PeO0jGYlvlN/egut5Cp/Rf2d3vJW8nu48+vXdVLydLZjof
N1vHDs+p2Tx+C+HAmaDS+aWIM78/9JkmzpLfv7DQsv0cawPw1Ca+IJ6xumvITjx5
0D8ZV55qMuVd1fb7DqRstKHbL2W/HwX0H90fGeRau1GKu1BFSSb0ub6bSG8QXbW7
ED4L3MeZrB7l/daWp4RtE8iwNlTaimRBC6fJqkQELdj7BXjQymwaJBoJj7IMJv3k
vnDJi+0uhZbaYwGqOX1nsVGBBuEjLlSFtFVDSLvinnKTs0wqEg4vvD0iEJFO4Icu
d/1aQQhnLt4c9uLSHWfzriV9dtexNajABfoCCRCEVu8JuQgc6t3Zr++89eKfHhta
N5cSZ4mWd7i29vqyJIwZ4UEcF7FlI2lJGRM5JTJoaHNkqsPLznwpGSs0PypFI+Qc
S6e+DAnrlcYGZqGfzmYLKi0I/xvg45n3EYgDecnhBX4edFz2vnQxgQipM+GwO3Ii
YIlOBUj9kVgcL4DUg4sr2VxYO+6VI/JCEz7xmzBFC/K01+FGeF8=
=fmm5
-----END PGP SIGNATURE-----

--+v1CZxweel0L0gXY--
