Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F7728490
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjFHQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFHQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:05:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC7E57;
        Thu,  8 Jun 2023 09:05:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-978863fb00fso150044666b.3;
        Thu, 08 Jun 2023 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686240328; x=1688832328;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NyFzu3M5YHjAUhNjjqGmUyI4M3GIKjPFz5WvZ/HN50=;
        b=HE1FaZ0djIrml8eMov+fDSJFrgQBl/hQWzY+XLea0KVz5lPtf55SHtMFdx3EkbZbBM
         zo9hN3dnOtCZVvo/eCUvdzGkIctC9Ts7xYUXl+9g+EeUEk0tR4tMYIBnWxqCyD9xw5sE
         AK1I9yuI3aUT+GB+dJTdtd61d5AF839ntz3Nh11JtrJnPQ3yq+KbB3528Ts6K2EbsGMh
         +PnzRgdnfam+46bhBS4yD2BJxpgDIZtTGpRT61sCcOIi2n3axr9QlYLOHX/MAgS5zWKR
         Qv5KfwFLT4PIwHJyWkw308ZLPRbv7XpMidIDJcDIdGNcV01/0Vj9kfAwm4i+TTk+hN/M
         jt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240328; x=1688832328;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NyFzu3M5YHjAUhNjjqGmUyI4M3GIKjPFz5WvZ/HN50=;
        b=HEU6VIUORn2L4etUOwEre/WFs2iwZAVCTR08fi84y3B6o4LHePWD4x89WaXaN6IiOv
         MkZFcJtQXXP2LbnOWTHck3/JL93OBU+VkWPD0Ttv1BtbNTn2ekN2AVxodM25h/w6LX57
         vg4L7DYz5E76JosFVzUL6B9vDZlKttbdh6bsxzQMCDbh3XmHXc1qKKcqB/59+hQbTfju
         nm0gSdTwWp3Byl4yF1fz5wuTmHvt3o8ZQIqB5c14EAmanzOR26sxLdM5STKAMFAPP1uL
         Zfo5OrkB52Jh+LJk1q2/hEjfR6fDDQwTHKNKmlxrku0JTED+AXoNYMkp2+alnifpybEV
         ivJQ==
X-Gm-Message-State: AC+VfDwJQlnLHfXhkbEeFQwvdCwLuGSkytKd7cakGW5K9eFWy07QMUSw
        wO2odUflk+57PiW2SFiW4y5TR1v3s+E=
X-Google-Smtp-Source: ACHHUZ6askCyF71m+fUTSv0laJainyjk++nGWfgdfy3d1rc04bmtsRfpKQ8hQwmjFdFbhaIW9mnwtg==
X-Received: by 2002:a17:907:6d2a:b0:978:ab6b:afd4 with SMTP id sa42-20020a1709076d2a00b00978ab6bafd4mr220202ejc.43.1686240327978;
        Thu, 08 Jun 2023 09:05:27 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qh16-20020a170906ecb000b0096a742beb68sm840197ejb.201.2023.06.08.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:05:27 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:05:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, mperttunen@nvidia.com, sudeep.holla@arm.com,
        talho@nvidia.com, robh@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZIH8RRBvuviey1KA@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
 <ZGNOXO3rRtFx_12R@orome>
 <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
 <ZICo8wYqM8tmCEob@orome>
 <ZIGaMntRUmgatjZE@44189d9-lcedt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iyFPYGRrJPE0J5Bb"
Content-Disposition: inline
In-Reply-To: <ZIGaMntRUmgatjZE@44189d9-lcedt>
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


--iyFPYGRrJPE0J5Bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 12:06:58PM +0300, Peter De Schrijver wrote:
> On Wed, Jun 07, 2023 at 05:57:39PM +0200, Thierry Reding wrote:
> > On Tue, May 16, 2023 at 12:55:03PM +0300, Peter De Schrijver wrote:
> > > On Tue, May 16, 2023 at 11:35:24AM +0200, Thierry Reding wrote:
> > > > On Thu, May 11, 2023 at 04:20:51PM +0300, Peter De Schrijver wrote:
> > > > > Implement support for DRAM MRQ GSCs.
> > > > >=20
> > > > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > > > ---
> > > > >  drivers/firmware/tegra/bpmp-tegra186.c | 232 ++++++++++++++++++-=
------
> > > > >  drivers/firmware/tegra/bpmp.c          |   4 +-
> > > > >  2 files changed, 168 insertions(+), 68 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/fir=
mware/tegra/bpmp-tegra186.c
> > > > > index 2e26199041cd..74575c9f0014 100644
> > > > > --- a/drivers/firmware/tegra/bpmp-tegra186.c
> > > > > +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> > > > > @@ -4,7 +4,9 @@
> > > > >   */
> > > > > =20
> > > > >  #include <linux/genalloc.h>
> > > > > +#include <linux/io.h>
> > > > >  #include <linux/mailbox_client.h>
> > > > > +#include <linux/of_address.h>
> > > > >  #include <linux/platform_device.h>
> > > > > =20
> > > > >  #include <soc/tegra/bpmp.h>
> > > > > @@ -13,12 +15,21 @@
> > > > > =20
> > > > >  #include "bpmp-private.h"
> > > > > =20
> > > > > +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_DRAM=
 };
> > > >=20
> > > > Still not convinced about this one.
> > > >=20
> > > > > +
> > > > >  struct tegra186_bpmp {
> > > > >  	struct tegra_bpmp *parent;
> > > > > =20
> > > > >  	struct {
> > > > > -		struct gen_pool *pool;
> > > > > -		void __iomem *virt;
> > > > > +		union {
> > > > > +			struct {
> > > > > +				void __iomem *virt;
> > > > > +				struct gen_pool *pool;
> > > > > +			} sram;
> > > > > +			struct {
> > > > > +				void *virt;
> > > > > +			} dram;
> > > > > +		};
> > > >=20
> > > > The drawback of these unions is that they can lead to ambiguity, so=
 you
> > > > need the tegra_bpmp_mem_type enum to differentiate between the two.
> > > >=20
> > >=20
> > > No, on the contrary, now it's clear you can either have void __iomem *
> > > and struct gen_pool * or void *virt but not both.
> >=20
> > No, it's not clear. You can have one part of your driver write the
> > sram.virt field and another read dram.virt and they'll end up pointing
> > at the same memory location but with different meaning. That's why you
>=20
> No. You can't the union in combination with the discriminating enum
> tells you you should only either sram or dram.

That's precisely my point. This only works in conjunction with the
additional enum and it unnecessarily complicates things.

> > need to introduce the enumeration in order to specify which one of the
> > two you want to pick.
> >=20
> > And that's exactly where you start introducing the potential for
> > inconsistency: now you need to be extra careful that the enumeration and
> > the unions are set correctly. You effectively have two sources of truth
> > and they don't necessarily match. You can also end up (at least
> > theoretically) with the invalid value, so you need an extra check for
> > that too.
> >=20
> > You can avoid all of those inconsistencies if you reduce this to one
> > source of truth, namely the pointers that you're going to use.
> >=20
>=20
> I don't think pointers should be used as a discriminator.

I don't think we should extra data to discriminate when we can already
discriminate using the existing data.

Thierry

--iyFPYGRrJPE0J5Bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSB/EUACgkQ3SOs138+
s6F49A/9F+foaN+AVR7LMIrsqygrDSHbJ/YQnaK4yviJ0wGxlYJw2s2RIQ2j/p2B
SUmGPImyXhtKdQVIWjeb1vTzr2theNjKZtKV7/zJSCUHY5clCR3dABAGg6Aj7WHm
qtUs2SubBucR4lRNvn/Apmb8xD22Mdog02DKsYA1sOCCjpUKsTxghU3Xcd6YCU44
oz2h4cjQJzkERy8fVrEIH8HMJu7pz515feO7xNMLTcObmpOgV2BvBeLLmbDmZNO5
aXTXk0Cy704welOL/ZVr5uoe+KT4ilUsG0/XrFcSaFxxhjHHwJurZJsEpcbt9ZkT
VDB35UK0U5XiRFaT0LTZY+vdXBQjT0nGRokzBrH7rbYSbRtERyqXHjgrf5Q1Y0Xe
467/LqnwWAIRYjAxX6D3443TwpHESlO4MKoIsw2Iw3giq2p5THpcyXUHQMue0n8i
geSashiuZA13d38iigUHPB8adxXEnwdATyKZ5WuSmHiixyNTGmsj8KCafrJidfpn
Y49lL7GMGIoULlWQAW5BpwKSW9MjEruauhDXHajJ/01AWWY/WoBR9+hGAgizDTio
EksqQGxFS/T12lFcKAb0+3/njbiyYzU/NOPAcGqZXkAXkNYZb38lEH6+3U0YrYnS
CgTEiOqY+MxH/1VKvqBb1d8LCb/GW4yGdXLZy0v/Q3qtmk7Ir9A=
=jN6O
-----END PGP SIGNATURE-----

--iyFPYGRrJPE0J5Bb--
