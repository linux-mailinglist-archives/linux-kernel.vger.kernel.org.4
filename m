Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519B46387A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKYKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:36:27 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0454931ED8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:36:26 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-381662c78a9so37563407b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icn0jb6niHgKih8G3jVCl4LiZcAERsEm2d0y54xh6HI=;
        b=nat6Lwpn6LmNvFUEZ/t0HCZTHQI5rRuHDNhbrHJTTFEykKUopyFFscx/CyCkNWKb03
         34rkkcTGHYZP0XBXo8JJvOjzWtfdp7aKCVLpG9TMGpmt87/IJ6XRSu15IQZtq8bAQ7v5
         3MS9HphUw2/yD47OE4BOpqG2H3mttJudUXGvZQ889ULa2mG+aqp/5HTmT5l94B3bcptj
         0C0yzSslh2nlsL9m6hWOFHCPTvtIQ466H/FLse6mLpHZVjiO/b9KMuCX91jv7STi7tHt
         Ln4BcCWRZVRVRmGR3U3vJyADlucxsinZ43RTlya4x208o79rY+pzkNGP67P3+ddDF8I1
         wpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icn0jb6niHgKih8G3jVCl4LiZcAERsEm2d0y54xh6HI=;
        b=kFOLUv6n7dg3ioHtvIejhTmj0302uk3TiHUCrNl1/iru1Tvlxs1Ox5VIqmOAY3PR5A
         VxZJShNKXiSiVn8bWMu+34MjhAg4W4nOolrFs2uPx3eose0tPbN+IFOALmkFMFwL/wZd
         x0u/F0EnhUcOVm8sFT/fEY0u7TiePnBWytuUk186p97oK3VqhVscpGRcI+UtxqP6TvaT
         WUKd1PAY21C39KUBAR9p+YCGlCppxRHIzv4d/KcWctJ2KJG1wSpneYbDeWSR+63LGuKy
         h+Ah+gOrNBZREluK4J26FidMkGm+MCI0iEzrpEp8xMGsQfc/1noNPkJynpwFYfRT7kPS
         esSQ==
X-Gm-Message-State: ANoB5plNS0DHcA/raF8jV/tpRdOJDRry4XNzZYTEF+Gkq7uNct/Y9FGq
        MEkycBVqVkWnR+J7y00oO6Y/tsO4d37pNnajLLNZjw==
X-Google-Smtp-Source: AA0mqf41E9+NYZ+j5x2IoDghFGfb7rusKNAbGsHkqPhgh6d9kjiyd+ht4jZR3a5RD8KgZ3hbAIyCF745PXR2SQwvn1o=
X-Received: by 2002:a81:1189:0:b0:3b3:7c97:a033 with SMTP id
 131-20020a811189000000b003b37c97a033mr8390257ywr.44.1669372585221; Fri, 25
 Nov 2022 02:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20221122202245.449198-1-nfrayer@baylibre.com> <20221122202245.449198-2-nfrayer@baylibre.com>
 <db869c2f-d34f-1ce5-22f9-634a8454ee79@ti.com>
In-Reply-To: <db869c2f-d34f-1ce5-22f9-634a8454ee79@ti.com>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Fri, 25 Nov 2022 11:36:14 +0100
Message-ID: <CANyCTtSYQKtgXZ0c5VaLoMUPaPwq3ZyMcONkJfig75eA0q7E5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: arch_k3: Removed ti mailbox and sci select
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        glaroque@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 24 nov. 2022 =C3=A0 15:29, Vignesh Raghavendra <vigneshr@ti.com> a =
=C3=A9crit :
>
>
>
> On 23/11/22 1:52 am, Nicolas Frayer wrote:
> > In order to build ti mailbox and ti sci as modules,
> > remove their automatic selection by ARCH_K3
> >
>
> $Subject: s/Removed/Remove,
> s/ti/TI
> s/sci/SCI
>
> > Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platform=
s
> > index 912529ac58b3..5f16eb498dbf 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -126,8 +126,6 @@ config ARCH_K3
> >       select PM_GENERIC_DOMAINS if PM
> >       select MAILBOX
> >       select SOC_TI
> > -     select TI_MESSAGE_MANAGER
> > -     select TI_SCI_PROTOCOL
> >       select TI_SCI_INTR_IRQCHIP
> >       select TI_SCI_INTA_IRQCHIP
> >       help
>
>
> Why not use "imply" instead of "select". This should allow TI_SCI*
> drivers to be built as modules if required. Would make 2/3 and 3/3
> redundant.
>
> Also, note that 1/3, 2/3 and 3/3 have to go through 3 different trees,
> so not a great idea to post as a single series.
>
> Regards
> Vignesh

Thanks Vignesh, I'll send a v2 using imply and drop 2/3 and 3/3
