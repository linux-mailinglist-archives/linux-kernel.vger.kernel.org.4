Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7D6C2386
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCTVVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCTVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:21:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454B30B22;
        Mon, 20 Mar 2023 14:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51613B810F4;
        Mon, 20 Mar 2023 21:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD943C433EF;
        Mon, 20 Mar 2023 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679347300;
        bh=qlNHY3AtvWM7FXZ0JBT4vSXElewhp64RqmgLO5c9uUA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ix7ZaNOlKAc03BSJ5Yo5CFuhMP1KPy47cHjl2PazM9iz8L+mGwNHH/jnYEkSTC6yM
         +BibgyyMHBkRKkeYwciv/AmH1EZmsFJSNq7/gggByVWpHjcFcChlaNqPFkFHYI38Il
         dUtshLcxPsukp5NjNYyuphYZl0p3/uy6vs5V6aYXkgmAk7sa+TJ8a2pUsqUIL3SW8y
         4DnARn1o9d+LuKw9TzBL9WNbns0wXiDeLZf96/7gXhE8k3PAUgQL2swfpxqJ1lWins
         wQ2dHlZmAP222HeWmVaxu0E75beLz77mPOEDd3Ano5EwSPn0Tt06v0QCvQRxYPY7z0
         c4b31eGXpvKFA==
Message-ID: <90dd1f841e7941d8b5931ef68cd6d14e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H-y6TsSoKsJzM0gkFk6wx7xNigXKJb7wm8rBzrigtJANg@mail.gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com> <20230320161823.1424278-8-sergio.paracuellos@gmail.com> <966523bee1d28d546969a24eff60d315.sboyd@kernel.org> <CAMhs-H-y6TsSoKsJzM0gkFk6wx7xNigXKJb7wm8rBzrigtJANg@mail.gmail.com>
Subject: Re: [PATCH 07/10] mips: ralink: remove clock related function prototypes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 20 Mar 2023 14:21:37 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-03-20 13:17:47)
> Hi Stephen,
>=20
> On Mon, Mar 20, 2023 at 8:38=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Sergio Paracuellos (2023-03-20 09:18:20)
> > > Clock related code has been removed from 'arch/mips/ralink' folder an=
d put
> > > into drivers space. Hence remove clock related prototypes which are n=
ot
> > > used anymore.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  arch/mips/ralink/common.h | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> > > index 87fc16751281..fcdfc9dc6210 100644
> > > --- a/arch/mips/ralink/common.h
> > > +++ b/arch/mips/ralink/common.h
> > > @@ -23,9 +23,6 @@ extern struct ralink_soc_info soc_info;
> > >
> > >  extern void ralink_of_remap(void);
> > >
> > > -extern void ralink_clk_init(void);
> >
> > Why isn't this removed in the patch that removes the function?
>=20
> Because the function exists for all the SoCs code and there are
> several patches removing it; one per SoC, so I decided to remove this
> at the end. Should I squash all patches together instead?

No. But you should squash this with whatever patch removes the last one.
