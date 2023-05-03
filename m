Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750F6F57B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjECMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjECMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:13:54 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50CC59DA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:13:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a214572e8so54946477b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683116031; x=1685708031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLFpTw4Opsx0SIhXDBcwLEPI4lObbahA52WBgGIUVsM=;
        b=w24SJl1jEsx1dsysGc/JqXn8TRE0UMobpr8S9T3y+gEnR/nI+CHCSx5trFpTNAVCVG
         8XS7YABKoVXwdqhydgmtWe9LQJJ7LBPnr1fCtb0rshbAxTDbaTU+5U0WNdSypx0SKblE
         0CP6meVuOVDCtCX96ONGJ58N4h4LCh6KY7HQXwOPLcftT7CWUqTxxZHaVMF/ygVuJ3xU
         KtX9ixUBAF79tkLLjx9Hg+1rarQ5Su54dehEmdGZNBkbkoufEbwweYd9rnB2Q94mEjKe
         bYeSIwtnrv7tEjxTeB2h1XUenyGb9cWojKfDEo4AC69c880iPhtph2axVQ7WlTkbXxO7
         +S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683116031; x=1685708031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLFpTw4Opsx0SIhXDBcwLEPI4lObbahA52WBgGIUVsM=;
        b=Gv8j+wicifWLjz2XOAtPQZjlquWCI1NLNLq/bXBZvLXnvfDJFM/rLV0s20CHZ8jhcR
         859LAW82WvPpl6LRnnMiVLal8VkEvqpMjenStJY5dfT5LCKwCnGqtoyV1L88wcB4PTah
         QeYJ6bEo95sI6drIUPwjd2Y9ij5XfGpdg2IhOvHyr4lSqrXM9tlB4XCz0Yv4ssT5Z6dr
         8Ej48a3GnSLRWywM0bS7Wk20q0hl6uUdYwgVK/nPZE3ySUOL9Vk+c/RZKlgvOfYnuLlN
         Qj92HzJoSKyn7uXaeGOp8WEd6jTv/3Atdfpd1T6KkVE/ZeWS1IW+3qoZFxf17WsMV1fF
         rQWw==
X-Gm-Message-State: AC+VfDzj++BsoSpFMHe5DlK2PLDWsyKr5Nl9uMs7STTqAurYLoziETR8
        qs4E2JMDMOA9MsDOzF+mIk8VAzROKWzOPQrOW2YW3w==
X-Google-Smtp-Source: ACHHUZ66hRgZLiqP0HgNywmuyEJNjQjxpzuYU/Ewr0nLiWAs/k7+ydf4eMIyKQKo0mpz4nSzQd/diYDGzmnUCVXeNlI=
X-Received: by 2002:a81:4f04:0:b0:54f:ddb9:95e7 with SMTP id
 d4-20020a814f04000000b0054fddb995e7mr20136923ywb.34.1683116031053; Wed, 03
 May 2023 05:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org> <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
 <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
In-Reply-To: <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 3 May 2023 15:13:39 +0300
Message-ID: <CAA8EJpq8x5wQa3fMebaSP3hCdMiCsZRaF+B4Y3N3royW_CeXCA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 at 13:39, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 3, 2023, at 03:17, Rob Herring wrote:
> > On Tue, May 2, 2023 at 5:52=E2=80=AFPM Dmitry Baryshkov <dmitry.baryshk=
ov@linaro.org> wrote:
> >> On 02/05/2023 22:40, Rob Herring wrote:
> >> >      'berlin' : 'berlin',
> >> >      'pxa2' : 'pxa',
> >> >      'pxa3' : 'pxa',
> >> >      'pxa' : 'marvell',
> >>
> >> I'd question if it makes sense to split the pxa line. Yes, it was sold
> >> by Intel to Marvell, but IIRC the devices still had some inheritance.
> >> So, if we have the 'pxa' subdir, I'd move Marvell PXAs to that dir too=
.
> >
> > I think I probably split it because it was different maintainers.
> > Though it doesn't look like pxa168 or pxa910 have any maintainer. They
> > are a mixture of pxa and mmp I think.
>
> I think the original split here is probably the best we can do,
> but there is no good way to do it because of the confusing naming
> and the problem that there is no clear line between pxa and mmp.
> As far as I can tell, the release timeline was:
>
> Intel pxa2xx (mach-pxa, xscale, still exists)
> Intel pxa3xx (mach-pxa, xscale, still exists)
> Intel pxa90x (never merged)
> Marvell pxa93x (mach-pxa, xscale, removed in Linux-6.3, no DT)
> Marvell pxa92x (never merged)
> Marvell pxa91x (mach-mmp, pj1, still exists)
> Marvell pxa168 (mach-mmp, pj1, still exists)
> Marvell pxa95x (mach-pxa, pj4, long gone)
> Marvell pxa688 (mach-mmp, pj4, known as mmp2)
>
> So with pxa93x out of the picture, we can simplify it as using
> 'pxa' as the name for all the above chips with an Intel XScale
> core, and 'marvell' for all the other ones that have a Marvell
> core and exist in mach-mmp.

Should it be 'intel' for pxa[23]xx then?

>
>      Arnd



--=20
With best wishes
Dmitry
