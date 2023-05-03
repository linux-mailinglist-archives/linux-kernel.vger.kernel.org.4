Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875876F58DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjECNRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjECNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D85592;
        Wed,  3 May 2023 06:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81EBC62D8D;
        Wed,  3 May 2023 13:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E72C433AE;
        Wed,  3 May 2023 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683119821;
        bh=CA9HUUoFcRTgCBgzgu0IWVlQEyRERVDtXqxkChGQSj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ole+wwu+SdPiS2aUQcX3tEt0J62DoRGG/xDwP1Q2hBI3sfPftXI2W3kkH/F/59E4N
         Rj2AmEaDcZT0BpGUnm84lYZ85cuHO/HgCWs2zlik5IUL41OlHfPOy59tbtDy7fBx5t
         ZgCFMVN0XHQ4LSBsXc2sJOPg8GrUyA3vIDNzPLKgT+G9Ro3CYUUGu+kdRKJu/W/qY+
         Pcq0qEWFbXc19qYZkj9ZXfSABwacLhUspZQ8xEAXDZ4dRCU4ngqd8rEoQ4x7LNLiYU
         jPAiVOLzrxahB5/VVJTZBCBCdKtT7WYvy7hBlO4AI4UaDtDdPD5K3xc7KZXakiNinj
         sK7EXobVb5Tog==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso6005373e87.2;
        Wed, 03 May 2023 06:17:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDz9CRxeX2tRbaaF+dFdO6B5N+oPzsCxKxt+48iQUzrYc8K4ONg9
        OpoG/5TcZL4I4PgqzqBF2nlLUMI/cngH8qwU9w==
X-Google-Smtp-Source: ACHHUZ4XoUscEY44VabA5tNDJYMyOoaF7CDhHSN63Jv4Bd86fg89uBNzW43NBIrFuEuIivWhSP0hKhXIoN/CJGAf91U=
X-Received: by 2002:ac2:5198:0:b0:4ed:b842:3a99 with SMTP id
 u24-20020ac25198000000b004edb8423a99mr934135lfi.59.1683119819681; Wed, 03 May
 2023 06:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org> <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
 <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com> <CAA8EJpq8x5wQa3fMebaSP3hCdMiCsZRaF+B4Y3N3royW_CeXCA@mail.gmail.com>
 <4e1e70a9-9b28-410b-bd29-fb5f5805798f@app.fastmail.com>
In-Reply-To: <4e1e70a9-9b28-410b-bd29-fb5f5805798f@app.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 May 2023 08:16:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
Message-ID: <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 7:19=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 3, 2023, at 14:13, Dmitry Baryshkov wrote:
> > On Wed, 3 May 2023 at 13:39, Arnd Bergmann <arnd@arndb.de> wrote:
>
> >> So with pxa93x out of the picture, we can simplify it as using
> >> 'pxa' as the name for all the above chips with an Intel XScale
> >> core, and 'marvell' for all the other ones that have a Marvell
> >> core and exist in mach-mmp.
> >
> > Should it be 'intel' for pxa[23]xx then?
>
> Probably yes, that would put it next to ixp4xx, which makes
> a lot of sense (same vintage, same cpu core), though it is
> a bit funny to have these together with lsi axxia and
> altera socfpga, both of which are also in the intel
> directory. socfpga is of course the only one that anybody
> at Intel cares about these days.

We could do a second level of directories here:

intel/pxa/
intel/ixp/
intel/socfpga/

arm64 broadcom dts files are structured that way.

Rob
