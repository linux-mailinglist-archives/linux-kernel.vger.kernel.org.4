Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6E65F6FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjAEWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjAEWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:45:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE68DEF5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:45:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z16so21051791wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4cO+u87mI/nV+bun08/ev5aZ5aM32c1zKnNuBi2Thmo=;
        b=VOpunnFY5TWwDTmahygTGnYTe+O8Of+jYUboE5H5nJyo3yoDpH0sKBVdx98kK/GjAU
         7JtNMwQQZfhdg70tAcuhdOiW+1S2pOZ3WpVnBGTvNVog/CP9YD8siMTsc3OxL/EqFT7U
         TAAt+mSy92+1ANyEye6HjkbAdb4jvCPP58Bp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cO+u87mI/nV+bun08/ev5aZ5aM32c1zKnNuBi2Thmo=;
        b=UxCtKqmFABrklhFFHPYBalkmTW5g4w8jc4Vt5uhW2xYyahg8Y5cEg3RLS8fMs2Y4Xw
         zYxshLY+ro0fDmhFqUzxDeTz4+Hwb2h6iWaOWmywNJBTdnqYBBlBeRB6lO6bQJkfZS1V
         7FTPpN5DfgB/UxYMVcq60thxYfeC5LY5YOWQszBOk/DyqzseKMTf06D1TuvA1jV7k7in
         01NHVoLIAEFEK+VEQpjYjXDI+mY8tCXmMJQnfJiwpeYnGqOWSRONHnKD5o2rw0T63P5u
         UcfgD+tVKltzr67fX+9WuHGBk62YhxVxV9xr9yFtE5+XrUTYeiyl8hX+faaWMkS25eci
         Z5hQ==
X-Gm-Message-State: AFqh2kpYEnu48ffHfl4hySc13sdbbKhkqm5rv4o1R5dSXDWhllo0OtoT
        Q8WCymFSz2FKGeSCBR57ivOxAg==
X-Google-Smtp-Source: AMrXdXvfbReK1LrViFj6NpGRsd9X417J7+hDteJlHcBGp88rp0eeAozCzjpIm4dLyeBsddSvPm5CaQ==
X-Received: by 2002:adf:e584:0:b0:29c:3721:8fba with SMTP id l4-20020adfe584000000b0029c37218fbamr8309813wrm.15.1672958710759;
        Thu, 05 Jan 2023 14:45:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:49cf:c46d:e32d:e951? ([2001:8b0:aba:5f3c:49cf:c46d:e32d:e951])
        by smtp.gmail.com with ESMTPSA id l7-20020adfc787000000b002238ea5750csm45779874wrg.72.2023.01.05.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:45:10 -0800 (PST)
Message-ID: <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ales Bardorfer <ales@i-tech.si>,
        Ales Snuparek <snuparek@atlas.cz>,
        Alex Osborne <ato@meshy.org>,
        Alex Osborne <bobofdoom@gmail.com>,
        Dirk Opfer <dirk@opfer-online.de>, Ian Molton <spyro@f2s.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Petchkovsky <mkpetch@internode.on.net>,
        Nick Bane <nick@cecomputing.co.uk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Tomas Cech <sleep_walker@suse.cz>
Date:   Thu, 05 Jan 2023 22:45:09 +0000
In-Reply-To: <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
References: <20230105134622.254560-1-arnd@kernel.org>
         <20230105134622.254560-2-arnd@kernel.org>
         <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
         <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
         <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-05 at 23:16 +0100, Arnd Bergmann wrote:
> On Thu, Jan 5, 2023, at 18:05, Richard Purdie wrote:
> > On Thu, 2023-01-05 at 17:50 +0200, Dmitry Baryshkov wrote:
> > > =D1=87=D1=82, 5 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 15:46, Arnd B=
ergmann <arnd@kernel.org>:
> > > >=20
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >=20
> > > > The majority of all pxa board files has not been touched in a long =
time,
> > > > and no users have spoken up in favor of keeping them around. This l=
eaves
> > > > only support for the platforms that were already converted to DT, a=
s
> > > > well as the gumstix and spitz/akita/borzoi machines that work in qe=
mu
> > > > and can still be converted to DT later.
> > >=20
> > > Well, tosa also works in qemu.
> > > Nevertheless:
> > > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >=20
> > I'm kind of sad to see corgi at this point but it isn't really
> > surprising. The hardware is old/slow and likely not used by many
> > anymore, things have moved on and the systems ended up being heavily
> > kernel size footprint limited.
> >=20
> > I'd just note that corgi (and shepherd/husky) are strongly related to
> > spitz/akita/borzoi, the difference is basically pxa25x vs pxa27x
> > processor and pin changes. We chose just to emulate one set in qemu but
> > the others would be relatively trivial.
> >=20
> > tosa and poodle have much less in common with the other Zaurus devices.
> >=20
> > I guess what I'm saying is that if spitz is remaining it might make
> > sense to have corgi with it.
>=20
> Ok, good to know, thanks for the background.
>=20
> The way we came up with the list of unused boards is to
> assume they are all unused unless someone asked for it
> to be kept around for this time, for pretty much any reason.
> I probably forgot to have you on the Cc list when we discussed
> this in the past.

I didn't see any discussion about this until now, no.

> IIRC, nobody specifically asked about keeping either
> the corgi or the spitz series, the reason for keeping it
> was to have at least one handheld platform with qemu
> support remain for testing, but I don't see a reason
> for keeping more than one of them.
>=20
> If you feel like we should keep tosa or corgi and ask
> again next year, we could do that, but reworking the series
> to keep tosa around would have additional side-effects
> on the tmio-mmc driver that can otherwise get cleaned
> up quite a bit.
>=20
> In the long run, I expect we will remove all the remaining
> legacy boardfiles and only keep the DT support. Ideally
> if someone is motivated to convert spitz to DT, supporting
> corgi the same way is also easy.

Personally, I'm not that interested in tosa (or poodle/collie).

The other zaurus devices are interesting for me as I know the platform,
they have qemu emulation, there are set of devices which are similar
but also have differences and there were one of the original targets
for OpenEmbedded and Yocto Project. I did quite a bit of work to get
one kernel which could run on multiple devices, as best you could at
the time! I'd actually forgotten about the qemu emulation.

There is a need for better automated testing around DT in OE/YP and
this is making me wonder about a few potential ideas.

Is there any conversion to DT you can easily point at as an example of
the kinds of changes needed?

Cheers,

Richard


