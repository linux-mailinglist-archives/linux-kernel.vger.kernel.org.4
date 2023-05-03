Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6796F589A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjECNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECNJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E874EDB;
        Wed,  3 May 2023 06:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1413614C8;
        Wed,  3 May 2023 13:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C267C4339E;
        Wed,  3 May 2023 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683119343;
        bh=5Xok1b5Bon4dNBT/EG9uKl/6cvSusA5y9BN7upmEzC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=glYqs7G41Oe7Vr2QNmHMivzZ6SgZQ51erxLwa4NoyJylHIWGgJZiJbFOEF9eZRS9n
         xWx6cluWIvaqTZt7zXRHgIkq6tJbMsx2DRAeJtYjsXE4g6fbmacJoLd1zt/7Kc+RNb
         DVYTcfIMk4llzEHHC0AIYjcc1NqABxKW5it0P7I3y/6ACXPplEVw9mnPneYwqWJE1j
         DXf0Ve1xZPIJYMX1EQqZ/49QrXBsnJubhquY8wuE6I2y8dSs6L+d1Z35PcqDp/q7zl
         io5DshylXLfwwhBVdAWKtYrKz5bhQuXIbmxPDl7QiyFIMDTq/uAziVDre8vjyLHGtq
         jmFJ8ehjTEdAg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ac75500798so6202301fa.0;
        Wed, 03 May 2023 06:09:03 -0700 (PDT)
X-Gm-Message-State: AC+VfDx8VIFGsdzwVAt9lIOTgqeOb8/Q9jS97/fHtSElo+tcs5II73Sm
        ZIB/SgALIfvsV9uCVb4WpKzuMOObIZsxOcwOVA==
X-Google-Smtp-Source: ACHHUZ50B+ONgazRTst79ZMphnWydxujQ+xpsmD1oxBiJc6OIwSZRmXeOONoaPS4VdIBDlX9Htpoiog7d0wWQm74E6U=
X-Received: by 2002:a2e:80ca:0:b0:2a5:f82e:e2a6 with SMTP id
 r10-20020a2e80ca000000b002a5f82ee2a6mr239ljg.47.1683119341121; Wed, 03 May
 2023 06:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
In-Reply-To: <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 May 2023 08:08:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL-WMNxHrgCzn=LfH6gpE_Yb3uRwo97ssHPoZenK3CEeQ@mail.gmail.com>
Message-ID: <CAL_JsqL-WMNxHrgCzn=LfH6gpE_Yb3uRwo97ssHPoZenK3CEeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 6:02=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 2, 2023, at 21:40, Rob Herring wrote:
> > On Tue, May 2, 2023 at 3:15=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
>
> > vendor_map =3D {
> >     'alphascale' : 'alphascale',
> >     'alpine' : 'alpine',
>
> I would make this one 'amazon' if we go with current manufacturers.
>
> >     'nspire' : 'nspire',
>
> nspire is the name of the end-user product, so that doesn't quite
> fit. The SoC was apparently an LSI logic Zevio, which is now owned
> by Broadcom.

I'm inclined to leave it. I put it in the category of a one-off thing
that's not sharing anything

> >     'mvebu' : 'marvell',
> >     'mmp' : 'marvell',
> >     'berlin' : 'berlin',
>
> While berlin is related to pxa/mmp, this one is now owned
> by Synaptics, and the 64-bit versions are already in the
> synaptics subdir, so I'd go with teh same here.
>
> >     'openbmc' : 'aspeed',
> >     'en7' : 'airoha',
>
> airoha is a separate company now, but the hardware is still
> shared with mediatek, so we could consider lumping it into
> that subdir, but a separate one may be better long-term.
>
> >     'gemini' : 'gemini',
>
> This one is also a product name, not a company. Apparently,
> gemini was originally made by Storm Semiconductor, and then
> by Cortina, which was subsequently acquired by Inphi, and that ended
> up in Marvell after the product was already discontinued.
>
> Out of the four, I'd probably go with 'cortina' as the
> directory name.

I had 'cortina' previously. Linus wanted gemini...

Rob
