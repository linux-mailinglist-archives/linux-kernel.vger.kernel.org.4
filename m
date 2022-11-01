Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E4614A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKAMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKAMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:12:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73905C29;
        Tue,  1 Nov 2022 05:12:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l11so20275381edb.4;
        Tue, 01 Nov 2022 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdGn5DARrLRsVLDknMy45jKtzxiEPMFN+GBY+Q0PPKc=;
        b=kEURq0m0sP4jb5Ww/xNpN0LBnUbR7mwaI8CsStGywlWWOP/yjGRYyfX6ojOH6p8H8B
         38u2HPzY2x9u/w2o3p6Ria3fJnNWJwh4TgcOc/45uoTowEatQu527QIntMOtQ821J+iK
         QPbzJN6IbKQ3zguEgACL+0AKl8RyjOUM+MFIMzrAZi7gFCGNljjnfClhTukpxWAdNRN3
         YCQx2bsFDCF4aprib7Ii6v9x47RLEQfwD3ned3xGqv/epXoHon0/ntr5sB/7u8eFGP9i
         bP6uuCh546QwNX3vYG713SxZFs74x7UpK8ZFtv/0/mTnMtJkq5FKYyYi1Fsq5pjg79I2
         TVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdGn5DARrLRsVLDknMy45jKtzxiEPMFN+GBY+Q0PPKc=;
        b=44ETrAGy7Npz02T2S1LPnOnJkiOyGJqOf24O1lTnoxEaGJveXZ7xEv2ldVODAxRiWa
         xxoT0dSn7oe99LlbVFp0EIGVLa1IDrm5cTkeXBDUna1wK6SC4GDW44RrelM/ImJiFe8P
         ZXhKraOT4a976Z+MdpZsm1TkD2qHJ5FqTlak5tSESZkH3t1luL7Xk+pUcY27YzIIjTvO
         lrL6ET0eXORvdTWjCDZIzM4fC+hSV2maYjBFNekc60apCBpdOwEjugl1Z2KaZkpJgzko
         PLO6FNG7XWUYT3tLIwoJkd67sM35Yl59RD8YOf6yeyIe9RI4r0BbYCVzkEFXELUHEcEO
         3Mgg==
X-Gm-Message-State: ACrzQf2Xet7fLYHQv2e0O6ckmK7scIKj0z5DOsj8iKX5XWUAeuzpeHe1
        Pqzl+gFaqUPBLlZ0nfEVvvo=
X-Google-Smtp-Source: AMsMyM5ILQZvKfcVUfPDoqSULTwk0I7d6xSbzIUuexZmLef1dXUX3qNKgfXnuiPDd4dzdJVNfDKMAA==
X-Received: by 2002:a05:6402:50cf:b0:462:352e:f4a7 with SMTP id h15-20020a05640250cf00b00462352ef4a7mr18314476edb.317.1667304742880;
        Tue, 01 Nov 2022 05:12:22 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0073dc5bb7c32sm4136099eju.64.2022.11.01.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:12:21 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:12:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     krzysztof.kozlowski@linaro.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory: tegra20-emc: replace DEFINE_SIMPLE_ATTRIBUTE
 with DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <Y2ENJJ1YiSg5oHiy@orome>
References: <20221101081611.8179-1-liubo03@inspur.com>
 <Y2EIblbX0eDgpJ35@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cbnj+pts3jjFBeFs"
Content-Disposition: inline
In-Reply-To: <Y2EIblbX0eDgpJ35@orome>
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


--cbnj+pts3jjFBeFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 12:52:14PM +0100, Thierry Reding wrote:
> On Tue, Nov 01, 2022 at 04:16:11AM -0400, Bo Liu wrote:
> > Fix the following coccicheck warning:
> >  drivers/memory/tegra/tegra20-emc.c:902:0-23: WARNING:
> >   tegra_emc_debug_max_rate_fops should be defined with DEFINE_DEBUGFS_A=
TTRIBUTE
> >  drivers/memory/tegra/tegra20-emc.c:872:0-23: WARNING:
> >   tegra_emc_debug_min_rate_fops should be defined with DEFINE_DEBUGFS_A=
TTRIBUTE
> >=20
> > Signed-off-by: Bo Liu <liubo03@inspur.com>
> > ---
> >  drivers/memory/tegra/tegra20-emc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> This seems incomplete: the rationale in that debugfs cocci script says
> that DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe() is the
> pattern to use vs. the less efficient DEFINE_SIMPLE_ATTRIBUTE +
> debugfs_create_file(). So this patch should probably use the unsafe
> function variant at the same time to take full advantage.

That said, I'm not even sure if these attributes would qualify for
debugfs_create_file_unsafe() since there's really no protection against
removal.

Overall that cocci seems a bit misleading in that it makes these changes
seem like trivial conversions. Only converting DEFINE_SIMPLE_ATTRIBUTE()
to DEFINE_DEBUGFS_ATTRIBUTE() is basically a noop, except that debugfs
has a little more overhead (for example debugfs_attr_read() wraps
simple_attr_read()), so I'm not sure if that's worth doing on its own.

Thierry

> >=20
> > diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/=
tegra20-emc.c
> > index bd4e37b6552d..c2b4caccfae9 100644
> > --- a/drivers/memory/tegra/tegra20-emc.c
> > +++ b/drivers/memory/tegra/tegra20-emc.c
> > @@ -869,7 +869,7 @@ static int tegra_emc_debug_min_rate_set(void *data,=
 u64 rate)
> >  	return 0;
> >  }
> > =20
> > -DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
> > +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
> >  			tegra_emc_debug_min_rate_get,
> >  			tegra_emc_debug_min_rate_set, "%llu\n");
> > =20
> > @@ -899,7 +899,7 @@ static int tegra_emc_debug_max_rate_set(void *data,=
 u64 rate)
> >  	return 0;
> >  }
> > =20
> > -DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
> > +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
> >  			tegra_emc_debug_max_rate_get,
> >  			tegra_emc_debug_max_rate_set, "%llu\n");
> > =20
> > --=20
> > 2.27.0
> >=20



--cbnj+pts3jjFBeFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNhDSEACgkQ3SOs138+
s6FPPxAAgfApfg0sM4SKykyyRUQ93OWB+2k51KntFbXN5HIzeBiLMSJ/1Rrz1lDS
DdAS6ZyLtZ36bFYiCtnQLDisuMMZ6epDiK7WqX9lAfz99uZHi2V7NSpQuBXyQdXV
DGcaVpa49S1gQoX0gXHqLTGBmIFyMBwi1XbNf1pxIRItkMV/tXqDu4vPAM35574I
2/R2FCt9Ehi40JhGyLLyi2sTgXHEa9A073qhCsuYDxif1dj4Mv7pweXMTQsOfyKv
E1h/x/r0LrfcvbmVgLY3Z/tnwHu30nHxfPzBEJTEvRfY4MWABhYuV30TKPRnKzBY
2ssIN1zO5PvEqVaDSADoNCNeWxlKbgwG2cgazCbEFGbnOafc33JAQW27KJWLYgZJ
08O9UH6/QUHmuTLVl0JO671uv2HM3LX4k5vLaP3OBw6I22m6lFm9SevnuomUbER5
2WvZXOWScqme8N5zRqFYG5X4kcbc7HLQxGj2+YAekeP5JCJ946aGJrZ+fG4VIui0
3WXnMDowRnC+ZwnTCxkOpXjcGYRbLjaT3Llt3N2Qn1/2QDbztsW6XExSB0KFnDhS
PDO6Zg1mlHCxdQ9A1MWjDR8Ec0ZnVLOY35SEtbO9oJALDlSL3IpbMDfQviqz8vYc
K1twBzCOSkRlrByqvKB3jieLjv+N0ZG+CRABfVv3Y48a0pkoyZ4=
=OGR6
-----END PGP SIGNATURE-----

--cbnj+pts3jjFBeFs--
