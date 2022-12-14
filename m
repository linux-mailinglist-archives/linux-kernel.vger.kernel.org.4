Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E550764C16C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiLNAjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiLNAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:38:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8514227CC4;
        Tue, 13 Dec 2022 16:35:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so9542056wms.2;
        Tue, 13 Dec 2022 16:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwOOzI6378k5zR3Mxw4FbFTi85HMYmdqVxdJz1WIibc=;
        b=GZHz7WgN+XOt5/kC/999OwX7pe8Eo5jBi1BKlH7Rnfcank49MrLpRE33QyVVr+TMy9
         Fm+r+Dl2Ul8rt9mnnJ/4tnKcURjjTsirOP5RViOnbyzjBTtYS9MCFEBgaXfb2m4yeetn
         RIdSZTZGpdlukPLXLO4QvJKIMtSNTSmBynyDr/wqoBp6NsPPY4lQYGpIR25ABYRUettw
         dLBN4kQttmD7XtD4GIZldI6HEuBboMn5BK7xTUp7TXtICG57tvaQ8jPJ9wHUhWat1B+V
         aF1EnNW+zkZOJJzthA3df6z+8NxWR7P8Nx4jUXMNl02PVfXNad49kkD9Qh10wtA5dFC5
         34Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwOOzI6378k5zR3Mxw4FbFTi85HMYmdqVxdJz1WIibc=;
        b=ccu6k9yEaAYDeiCB9DcdmkAKgmkc5maHrfbblyBxeaQ40sXju7rAri6BuyVC5595Fu
         nyUqpLpo8721igGw8tr+JTak75/F6Eq4gFcbeJso9E/TG7PS+PpqS8jIqpwyYESGlsYV
         B3dCWvYeRQMDdbxrXNUtltRtRnZ8mGfRCBVL/vExTActTrPVy0YV2kuQLXpLq8x6/Tre
         /A3JlmrIT6Wja3h3nBx33J+012OjT+fDa7qStGXnJY1609B1ylbQz8/8sbWvI26dgTyu
         /KJ0xyD4/LlXxP7gdkkurGbffU3zSSiM+AJ2cvsEqFdOxO7RyFBsI2f3lN/tY9EnzHFy
         ax7g==
X-Gm-Message-State: ANoB5pm66tKePsVICGTscuMiu/Te4ZPCNm3g5H1WYPazbTGHdh9yOaHD
        gBeo4E/8A4eP2hmUjaJxa17q4mN73ZiEegnkPgQ=
X-Google-Smtp-Source: AA0mqf5bw2CZOHff1M9ghZjQpkBPI0Fwl3B4Z4cVcz+CM1fpg7V+lCr8Z/p0RLbsaTV++pVaMSInAFlrQ2XewTovylY=
X-Received: by 2002:a05:600c:713:b0:3cc:a9be:d9e9 with SMTP id
 i19-20020a05600c071300b003cca9bed9e9mr32019wmn.173.1670978144486; Tue, 13 Dec
 2022 16:35:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0@eucas1p1.samsung.com>
 <1670311341-32664-1-git-send-email-u0084500@gmail.com> <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
 <CADiBU39-FUD787RmV9Z+jsSrb2Se66A6FrLWGxf78q2Ud-SrjA@mail.gmail.com> <dc6c80f1-f34d-eaab-d561-32caa7fa140c@samsung.com>
In-Reply-To: <dc6c80f1-f34d-eaab-d561-32caa7fa140c@samsung.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 14 Dec 2022 08:35:32 +0800
Message-ID: <CADiBU3_+T1QiTHVkDbby_eoCS7Jg-AfCA5PS=rWhx_L9d_OAjA@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: core: Use different devices for resource
 allocation and DT lookup
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     broonie@kernel.org, djrscally@gmail.com, hdegoede@redhat.com,
        markgross@kernel.org, lgirdwood@gmail.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        yangyingliang@huawei.com, gene_chen@richtek.com,
        chiaen_wu@richtek.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Szyprowski <m.szyprowski@samsung.com> =E6=96=BC 2022=E5=B9=B412=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=99=9A=E4=B8=8A10:29=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> On 13.12.2022 15:19, ChiYuan Huang wrote:
> > Marek Szyprowski <m.szyprowski@samsung.com> =E6=96=BC 2022=E5=B9=B412=
=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=99=9A=E4=B8=8A7:33=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >> On 06.12.2022 08:22, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Following by the below discussion, there's the potential UAF issue
> >>> between regulator and mfd.
> >>> https://lore.kernel.org/all/20221128143601.1698148-1-yangyingliang@hu=
awei.com/
> >>>
> >>> >From the analysis of Yingliang
> >>>
> >>> CPU A                         |CPU B
> >>> mt6370_probe()                        |
> >>>     devm_mfd_add_devices()     |
> >>>                                |mt6370_regulator_probe()
> >>>                                |  regulator_register()
> >>>                                |    //allocate init_data and add it t=
o devres
> >>>                                |    regulator_of_get_init_data()
> >>> i2c_unregister_device()               |
> >>>     device_del()                       |
> >>>       devres_release_all()     |
> >>>         // init_data is freed  |
> >>>         release_nodes()                |
> >>>                                |  // using init_data causes UAF
> >>>                                |  regulator_register()
> >>>
> >>> It's common to use mfd core to create child device for the regulator.
> >>> In order to do the DT lookup for init data, the child that registered
> >>> the regulator would pass its parent as the parameter. And this causes
> >>> init data resource allocated to its parent, not itself. The issue hap=
pen
> >>> when parent device is going to release and regulator core is still do=
ing
> >>> some operation of init data constraint for the regulator of child dev=
ice.
> >>>
> >>> To fix it, this patch expand 'regulator_register' API to use the
> >>> different devices for init data allocation and DT lookup.
> >>>
> >>> Reported-by: Yang Yingliang <yangyingliang@huawei.com>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>
> >> This patch landed in linux-next 202212 as commit 8f3cbcd6b440
> >> ("regulator: core: Use different devices for resource allocation and D=
T
> >> lookup"). Unfortunately it causes serious regression on my test system=
s.
> >> It looks that some supplies are not resolved correctly and then turned
> >> off as 'unused', even if they provide power to other core regulators i=
n
> >> the system. I've observed this issue on Samsung Chromebook Peach-Pit a=
nd
> >> Peach-Pi (ARM 32bit Exynos based). The symptoms are somehow similar to
> >> the issue reported here some time ago:
> >>
> >> https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsu=
ng.com/
> >>
> >> I've post more information once I analyze this issue further.
> >>
> > It seems the issue occurs in 'regulator register' resolve supply.
> > Due to the parent device don't have the of_node, to resolve the
> > supply, it may need to get the
> > dt node by recursively finding child regulator.
> > Like this
> > parent {
> >    regulators {
> >       xxx-supply =3D <&vdd12-ldo>;
> >       vdd12-ldo: vdd12-ldo {
> >           regulator-name =3D "xxx";
> >           regulator-min-microvolts =3D <xxxxx>;
> >           regulator-max-microvolts =3D <xxxxx>;
> >        }
> >    };
> > };
> > >From this case, 'resolve supply' need to parse at least the more top
> > level like 'regulators'.
> > But now, it only take 'vdd12-ldo' as the node or its child to parse its=
 supply.
> >
> > Below's the fix I guess.
> > It'll make the parent of the regulator the same as the dev parameter
> > in 'regulator_config'.
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index ea4a720..7c5036e 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -5526,7 +5526,7 @@ regulator_register(struct device *dev,
> >
> >          /* register with sysfs */
> >          rdev->dev.class =3D &regulator_class;
> > -       rdev->dev.parent =3D dev;
> > +       rdev->dev.parent =3D config->dev;
> >          dev_set_name(&rdev->dev, "regulator.%lu",
> >                      (unsigned long) atomic_inc_return(&regulator_no));
> >          dev_set_drvdata(&rdev->dev, rdev);
> >
> > I don't have the board. Could you help to test this change to see
> > whether it's been fixed or not?
>
> The above change fixes the issue. Thanks! Feel free to add following
> tags to the final patch:
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
Thanks.
I'll submit the change to fix it.

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
