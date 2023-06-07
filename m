Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5955F72654A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjFGP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjFGP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:57:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF8199D;
        Wed,  7 Jun 2023 08:57:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso1603800a12.1;
        Wed, 07 Jun 2023 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686153462; x=1688745462;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHtYOKWjXE4LNBHmSRISovcNXkXYAO+Eyv40xIPPG9k=;
        b=UmTnMb0IeP5nrNarQDqeInEpB9GQV+6xbAgySdcKusGk7/15Y/Rgqu53ADIeiEL9Kf
         SU5pqvJdldXL26hQWBSzOJRAyA856Knqp5nUuUqHAwjbvsxRAAXRhfmDCbqCaiUMGsPu
         L0kTnMuUnR6azxnKImPO1vzw8uZsyHeedQjqDXhWpkAIlHM5FNBGXZYyGd5kqSreOV9n
         4792yvzZmKc4D2AVygogBwuiO/gUa3qqnKSW5O1aWG/fADp42gvahpp2bBY+3rNz9nYG
         RvmdDU6/8Xx991szzAFdCSv+voh4DDOYZ4lSA4GXdsF1WUmvVwI/e5WC4APTuvXqS04c
         94jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153462; x=1688745462;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHtYOKWjXE4LNBHmSRISovcNXkXYAO+Eyv40xIPPG9k=;
        b=DjW8b5uxZD2VkgbfOz2AurlNUgvD+1ySXYYjBAosjPNKZTtj5/c+cSZFIp66sQG9c7
         ZDGL+Hnkq3zrs7K5/UZxhxtxCC+4wkigvGvZdBwhqrU8yys0ePmVv86gGaXqmr9V9ikE
         GdWcsqMrLRsi++zML7J7uPyg5uAzHIdziD1EvYrkV8w1O4YBBYXut/TWGCGqflRXagvJ
         WhJxrNX7XLWvEPAHt0iHKUF2yjqlSiXYE9tj/4CUnhaPXjuHNt7xynDpUQsElc1Gv7xt
         V0b4wsGmhZ3W7x5/sNGbWu8AGiws+pwAI3ZR7TwA9Saj4DLyNfu2KvN7sTEygV1D8UUW
         i9hg==
X-Gm-Message-State: AC+VfDzvx6bgNxCA/lMzorrLreHBNMo0po96K+LVp2IcXIJwsyswhbhf
        X7eK0tZTqrXh/D80HEe3Nfn8V3rxXD0=
X-Google-Smtp-Source: ACHHUZ440OktHbvcRSQlHCV6PoPnUOV8yGww7BdxQ6bF3JhMhC75Gc/Kz8wpWp4EO9w9QSZBf4SDoQ==
X-Received: by 2002:a17:907:6d11:b0:978:6c0e:354e with SMTP id sa17-20020a1709076d1100b009786c0e354emr6606213ejc.4.1686153461898;
        Wed, 07 Jun 2023 08:57:41 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b00977cc473b41sm5157196ejx.142.2023.06.07.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:57:41 -0700 (PDT)
Date:   Wed, 7 Jun 2023 17:57:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, mperttunen@nvidia.com, sudeep.holla@arm.com,
        talho@nvidia.com, robh@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZICo8wYqM8tmCEob@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
 <ZGNOXO3rRtFx_12R@orome>
 <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gObwIVTIUUFZASFm"
Content-Disposition: inline
In-Reply-To: <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gObwIVTIUUFZASFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 12:55:03PM +0300, Peter De Schrijver wrote:
> On Tue, May 16, 2023 at 11:35:24AM +0200, Thierry Reding wrote:
> > On Thu, May 11, 2023 at 04:20:51PM +0300, Peter De Schrijver wrote:
> > > Implement support for DRAM MRQ GSCs.
> > >=20
> > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > ---
> > >  drivers/firmware/tegra/bpmp-tegra186.c | 232 ++++++++++++++++++-----=
--
> > >  drivers/firmware/tegra/bpmp.c          |   4 +-
> > >  2 files changed, 168 insertions(+), 68 deletions(-)
> > >=20
> > > diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmwar=
e/tegra/bpmp-tegra186.c
> > > index 2e26199041cd..74575c9f0014 100644
> > > --- a/drivers/firmware/tegra/bpmp-tegra186.c
> > > +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> > > @@ -4,7 +4,9 @@
> > >   */
> > > =20
> > >  #include <linux/genalloc.h>
> > > +#include <linux/io.h>
> > >  #include <linux/mailbox_client.h>
> > > +#include <linux/of_address.h>
> > >  #include <linux/platform_device.h>
> > > =20
> > >  #include <soc/tegra/bpmp.h>
> > > @@ -13,12 +15,21 @@
> > > =20
> > >  #include "bpmp-private.h"
> > > =20
> > > +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_DRAM };
> >=20
> > Still not convinced about this one.
> >=20
> > > +
> > >  struct tegra186_bpmp {
> > >  	struct tegra_bpmp *parent;
> > > =20
> > >  	struct {
> > > -		struct gen_pool *pool;
> > > -		void __iomem *virt;
> > > +		union {
> > > +			struct {
> > > +				void __iomem *virt;
> > > +				struct gen_pool *pool;
> > > +			} sram;
> > > +			struct {
> > > +				void *virt;
> > > +			} dram;
> > > +		};
> >=20
> > The drawback of these unions is that they can lead to ambiguity, so you
> > need the tegra_bpmp_mem_type enum to differentiate between the two.
> >=20
>=20
> No, on the contrary, now it's clear you can either have void __iomem *
> and struct gen_pool * or void *virt but not both.

No, it's not clear. You can have one part of your driver write the
sram.virt field and another read dram.virt and they'll end up pointing
at the same memory location but with different meaning. That's why you
need to introduce the enumeration in order to specify which one of the
two you want to pick.

And that's exactly where you start introducing the potential for
inconsistency: now you need to be extra careful that the enumeration and
the unions are set correctly. You effectively have two sources of truth
and they don't necessarily match. You can also end up (at least
theoretically) with the invalid value, so you need an extra check for
that too.

You can avoid all of those inconsistencies if you reduce this to one
source of truth, namely the pointers that you're going to use.

Your variant would be slightly better if you omitted the invalid value
because then you could still have an internal inconsistency, but the
likelihood is much reduced.

> > If you change this to something like:
> >=20
> > 	struct {
> > 		struct gen_pool *pool;
> > 		void __iomem *sram;
> > 		void *dram;
> > 		dma_addr_t phys;
> > 	} tx, rx;
> >=20
> > you eliminate all ambiguity because you can either have pool and sram
> > set, or you can have dram set, and depending on which are set you know
> > which type of memory you're dealing with.
> >=20
>=20
> No. You just add ambiguity. It's not clear from looking at the data
> structure which fields are valid for which case.

That's easily fixed by adding comments explaining what you use them for.
But the code should make that pretty clear already.

Thierry

--gObwIVTIUUFZASFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSAqPEACgkQ3SOs138+
s6Frrg//ZrJkuxlHWAd1z2xHHXEIOkzdtcXyHgaIXwEUyUHlIpOt3KWDRuDLJcNt
9eD/zPyD/P+FKoqmzf9GmhINi90pGVsiegEU6bMIoOdEtgnujiqwyhw18eNT70Cv
1aEIaDs0ZAd9G30Y3TTt7GknBdLqecGSv9p1CLrtGTEew2J6dXgb+cT7cYuawK8B
W7nl05lQYd2oxzBTGwncy3MyoVhyx11R6Cmb37DDZK4fA7KsJylZgRFlaj8jZtZq
A8vHkzvk6r2l9VyEUezPP18OXDVpoqRaE1geOHj9RAzuee5XiUMjtn4UYmGxqS2b
qfQkMiLqSMaFulQLqIiKiOuWs5So339UVYygx/Jb0qGdmU2fEH69SZghazbtm0IM
SiluRtBtDdCaOZzu8aYxdF+fcqNCMaAxSzBF+7WLJeHSx+6smaFWjXRsOIBg2kBd
CpcoTG8kBIMxfEJiwgQfPOvFWp8jy5lg6f+uiJQLltTK16oZGSS7fUOM1sDBHlnC
SsITSkSSbQQ0hpk3UBU0/URrIf7L/aH84VkmvrrrP1r8ZX/O75U4a33+GAoQUxH7
g2cDpKxx20VdCMcTUk2Xtyk/DSFAby1JkVckjK/Mp9XeI7bDPAiYBLOkWF/dpMwi
X0EX0yJt66hcs64bGmt7Jhut64KxM6bV8/HfXMaS+sIrkuyGm14=
=0L5G
-----END PGP SIGNATURE-----

--gObwIVTIUUFZASFm--
