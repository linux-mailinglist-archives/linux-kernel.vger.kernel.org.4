Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC17284A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjFHQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFHQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:12:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D1D1FFE;
        Thu,  8 Jun 2023 09:12:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977c89c47bdso148478666b.2;
        Thu, 08 Jun 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686240769; x=1688832769;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhZMDOI1ABiSJTJBTG1Vk9XBaG+Nl+0VdaC+LZpHZs8=;
        b=sdtRV/1HVYP5npXw0TpsZI7EIlrW94hJ7tghF8YrKA82jT7LaaV3H5F8pddYSwm75Z
         1l3G7mhI8kZ1fzQ9u9kDjudeQNSpLOt3WRPV7Bml4LWhlF8OlUzZ1wEADU/jjIbHmPRN
         sXm1EvLq/4gj7odd2OKq0tORn5Wd+CL9ogDVIO52mreH7iEuiZfpG/qvvOdBvDksWX02
         sRc4Vd8ob8R/VtOrxIhEVz8t8MAzsY3TFWpe1MMWJFoaFsu+GeFWevRTlBKFrOTNgc+7
         7GzH47g//vgdflAL8fI+g4JJe7h2ZbXZ0L0xD310cGnhOfhh24c91IiEvKipHE274fVY
         3vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240769; x=1688832769;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhZMDOI1ABiSJTJBTG1Vk9XBaG+Nl+0VdaC+LZpHZs8=;
        b=MC4GXjcm7DN3DqvZ88PfiUPxQ5pOvKUg2aPMCCuU8UMqG3xhGL9jOzr1eMn/Ivv+0i
         6h7J3DUunh/QUjEuobJWDoMGfUj9SI57YGQa6/YthWpIcoBn7aSuKjCLQiAn2h4cxFzS
         +0zH1xxkfwWY6YHMnNlkUT65teVP+eyCx5/oJnIaovUm2ov9uE8aXgzBaCTjCB7XKsGu
         aMBbSIcrB8Y2ZQalqnNQ0qt1xLpTByke0FyXvOas3CSs+qUdKnyhOFiDYiH9Os1R9tgc
         EI/PiHRQ3aacMcUICubeHYPp1OBCAi/Ul0khYbTsQVyDGlUBabDMREziar9a+aojnz3N
         Vl8w==
X-Gm-Message-State: AC+VfDw47CIq3C2NfYwvJnZRdmC7JMhIEvAoNoRsUhPffJSPBsNctoKt
        JWREawyM5iRMVmGuOIMmn5k=
X-Google-Smtp-Source: ACHHUZ781H9Iu3Wge6qoi0343fmdAsqXfDhvYI6WKu9AXXkpsBPpXPoK98bnbxKCvtC3W4YXYejV7g==
X-Received: by 2002:a17:907:6d12:b0:94e:e97b:c65 with SMTP id sa18-20020a1709076d1200b0094ee97b0c65mr209967ejc.60.1686240768863;
        Thu, 08 Jun 2023 09:12:48 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id op26-20020a170906bcfa00b00965aee5be9asm10975ejb.170.2023.06.08.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:12:48 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:12:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, mperttunen@nvidia.com, sudeep.holla@arm.com,
        talho@nvidia.com, robh@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZIH9_hFsWz2kKQJy@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
 <ZGNOXO3rRtFx_12R@orome>
 <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
 <ZICo8wYqM8tmCEob@orome>
 <ZIG571modfPCnl2p@44189d9-lcedt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6AOjTCZJVyiG+eT9"
Content-Disposition: inline
In-Reply-To: <ZIG571modfPCnl2p@44189d9-lcedt>
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


--6AOjTCZJVyiG+eT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 02:22:23PM +0300, Peter De Schrijver wrote:
> On Wed, Jun 07, 2023 at 05:57:39PM +0200, Thierry Reding wrote:
> > > No, on the contrary, now it's clear you can either have void __iomem *
> > > and struct gen_pool * or void *virt but not both.
> >=20
> > No, it's not clear. You can have one part of your driver write the
> > sram.virt field and another read dram.virt and they'll end up pointing
> > at the same memory location but with different meaning. That's why you
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
> There are 4 possible states for these pointers:
> both NULL
> both non-NULL
> sram pointer NULL, dram pointer non-NULL
> dram pointer NULL, sram pointer non-NULL
>=20
> So how is this one source of truth?

If you add a tristate enum you turn this into 6 possible states, how is
that any better?

My point is that the pointer contents are enough to determine which mode
we use. In either case we have to make sure that the state is consistent
so we can't end up with both non-NULL. The difference is that without
the enum we only have to make sure that the pointers are correct. With
the additional enum we also need to make sure that that value is
consistent with the values that we store in the pointers.

Anyway, time is running out, so I'll just apply the series and "fix"
this up myself.

Thierry

--6AOjTCZJVyiG+eT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSB/f4ACgkQ3SOs138+
s6FYIg//bIAsnX/x/dT+okl1hS6XmkCxBgUmpv1UQ8zI4WHEw5zLyv8zr8rCWJ6c
YZ5jP+8tf7Z10rLfo5/fgMdlkblJDDHAnve5mMCfHwIpmZiBpEDGYVIsSTsBxIfi
TZ3zAHyyAUQX2EHXGkFk3qH+wIH6hv6XpKP7zB6r/E79yLSh8tVMiqevdQWVgp6t
5mb7q27n0aPLYVO2EVhFKydzYi3G/4t0zKGzZkW1Yccuksk04h9PfkLiMlJ9r24e
SYfLZL2c0Sv3tNR5pCg5lJWg9VhbJPQMIXzeDjsjAISQxyGCU67nq58x8bhQ90af
xHQfY01JiYF8g63olr8L3wkUnWIvtUsosxtTWoa5pJHGm1I5//FjJB6Z1bBD8u2w
b9ZbmIG4cQqUM9wMSiQ6+RLM083x0ZMhAcuhjPKExAO4IIxcmdr6QHj8G96ildia
kOW5Olgjg4yzYau9V59V1cGRdt5skkyrGk45Z7YE2K/LwvZKG6jCuqMHCJOqefcI
Kh8Ly+M18PA+CtXkcqkHYQtJVv5qNLe87JdMD9OKJ6sEGdAZ7wCslexGxPkHEd3Z
q9LftXQLjkAuzItlZaQedUJ5XvsJIwP/4kw0roU4NZe+5g6p8uzwzbPdHiUsQoco
oqd1mhIyo0zJHf9oMmIBRTWJ1Z4AzxNvrr8lx/iVArc1jBeQZi4=
=Frik
-----END PGP SIGNATURE-----

--6AOjTCZJVyiG+eT9--
