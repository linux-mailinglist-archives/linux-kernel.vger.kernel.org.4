Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF555EE025
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiI1PWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiI1PWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:22:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D22B5171;
        Wed, 28 Sep 2022 08:21:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so17747155edi.1;
        Wed, 28 Sep 2022 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OayWZ8u8+6BQTEtRBV9XmzzZMOd2fP+V5RF5BmFDxuQ=;
        b=B/5+JfOF4kV5wfgFf+ggX7bAJAiMalon2tDKsn9vA4K4zUak9yJVyGsaOwSefMbuNb
         101TrHwpqxd4wNYGta+C/iCGDkF4GyRBAqt83487Ob+oT+GLgRCTRwa7gXNngsnyTGt3
         5pwFC4EvIdnMX1dWC6dgntyPCIQtJboIDhfSoYtns/I0MYdneEPSWNFjTb0jmkwfwNTn
         PS30nMIf9fqlNAtak/VoDF1Tp7xzanmZhSedsPox5E79RDm/jfSEy+QIumGXuQG8aVkN
         qm0M6N88/Ulv6YjYqbSCXP0elL9f0zzMha0/EKfNjIUOEvdhE8K81dTX4onU9mfjdwWK
         pxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OayWZ8u8+6BQTEtRBV9XmzzZMOd2fP+V5RF5BmFDxuQ=;
        b=m5RzwqvlLgaoFhk8+iyFoGa8onFfAcUITAYAwsS6zQ+LROTTopGEyM9rI5OftsrEio
         ybFmMpnO4a1kX2ypSBcZhb0hzVMO4NVfEfwtJS3u7wvlYd6W6eVcwTMbrWtf3ke5ZQ1G
         emSIcykNjWSfWDuNPiavO2su3ez0AsokxzxWWT7kC5Q00wRwxOn481LBlb7muGKpe/9s
         jzWWXc6WDMTd9BbswdfKozooBl969v8xL4bAQ/LYCZ36cFTb7srv/Fb0eUBPNYgNn/T+
         d4WB8MwCTzNwJcOu7KOJdcbIrpL0Ra2lOOHymJLjmxL+cHYKI9lI0VfjW4wP9jGAB62M
         SV6A==
X-Gm-Message-State: ACrzQf3FrhtDJBqXyRil0pmTOdgF8wPMC3O+XsnelSGaEXjfrFJMTFLW
        +Ka3tO9RmvGp4hgCnXDH4tI=
X-Google-Smtp-Source: AMsMyM6Mg6zKySv/Z4l4ld7UrlOcwm8/1gYSLSuRjfkLzP5n019YYDZJIA7Aozqvr+S0c7mShTxJpA==
X-Received: by 2002:a05:6402:2994:b0:453:4c5c:d31c with SMTP id eq20-20020a056402299400b004534c5cd31cmr33521570edb.412.1664378462989;
        Wed, 28 Sep 2022 08:21:02 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b12-20020a50cccc000000b00456988774c8sm3549487edj.57.2022.09.28.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:21:02 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:21:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <YzRmXAuJLnPLaTsp@orome>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
 <YzQ9+Wzhfnila1s3@orome>
 <YzRO0xrzlrHAYdaI@smile.fi.intel.com>
 <YzRS+VIBK1AiysEN@smile.fi.intel.com>
 <YzRmJ3mBKf+cvy5T@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YS47aw7uj+zoxnlx"
Content-Disposition: inline
In-Reply-To: <YzRmJ3mBKf+cvy5T@orome>
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


--YS47aw7uj+zoxnlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 05:20:07PM +0200, Thierry Reding wrote:
> On Wed, Sep 28, 2022 at 04:58:17PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 28, 2022 at 04:40:35PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 28, 2022 at 02:28:41PM +0200, Thierry Reding wrote:
> > > > On Fri, Aug 26, 2022 at 08:07:15PM +0300, Andy Shevchenko wrote:
> > > > > For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> > > > > instead of the raw sprintf() & co. This patch replaces such a
> > > > > sprintf() call straightforwardly with the new helper.
> > >=20
> > > > How exactly is sysfs_emit() safer here? In all of these cases, the
> > > > values that sprintf() writes are the only values that are written i=
nto
> > > > the buffer and we know that none of them exceed PAGE_SIZE. So the
> > > > additional checks that sysfs_emit() performs are useless.
> > >=20
> > > This is a recommended way to use sysfs_emit() mentioned in Documentat=
ion.
> > > Care to fix documentation?
> >=20
> > For your convenience, Documentation/filesystems/sysfs.rst says:
> >=20
> > - show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> >   the value to be returned to user space.
>=20
> Took some digging to find enough information to convince me. Again, the
> commit message says that sysfs_emit() is safer, but that's a bad reason
> in this case because these cases are fine. The sprintf() calls that this
> replaces aren't unbound and we're not appending to an existing seq_buf,
> so nothing to worry on that front.
>=20
> I think the better argument for broadly applying this is to specifically
> distinguish the sysfs sprintf() calls from others so that they can be
> auditioned better and perhaps help with the documentation[0].
>=20
> Do you mind if I apply this with a reworded documentation?

I meant "commit message", not documentation.

Thierry

--YS47aw7uj+zoxnlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0ZlwACgkQ3SOs138+
s6HZiw/9EmRTXIqd+CvDrDM5AjR4gzSRh/eytChBi/NAaedUSJFsldK17LG8qQy5
l13v3LWdBJBJtMvIR4ybs60J5hA0liRiLt1dDqC3iVAOHJSQaJOvVJJtVBHrHFra
EHBY6NQv7TkX7IbYGYteQaN6dWjPdoJ7ScKOx9U13WfCwNsphTgleew7B569B08C
UVyuJ5QyR4Zlw61GSyB1Y3rL/ad2a+gz40HKF3V2BUxACj7MAFIbM5vukVMApAJR
gaYjLhuB07nBc2byM/8RViF7ZBL/HbC7fH/z4pmYcapVsTOKONcrQi1l0YMICSi5
6q+FvQULJi1FZrXqaVG56gV1fiXlLqcY3pNCvc6KmPr17b/CJwt6ocFUoSw/iCE1
0Y93L0KePe6wy5muN+iQU1M6aIXlbTaxgpEi+T9h1+Zl3RsOPsNzCn5EQuPnETLx
GNkHPKPWoNaY8M0BGAem+253c5wnRGaqZT0rY5jIKBvbnXBYwqb/ANUZF51LwAy9
nDmSdx7/GyEA345KQT7v5wj2QPjbX4ZJzojs1Js1LYGZrExYoOGMsEaIUA6wd/BA
7Eu/XMS59qzKGpBzIFCVQRWkta+0DAoLjtwi9t/G2APK4Tmq9zegN140DabVDaQZ
kjANLINj7FYRtAE3I3OmqUgC2k5G6vxpwTtVlgUdTGvlZ4vg/+0=
=JPGL
-----END PGP SIGNATURE-----

--YS47aw7uj+zoxnlx--
