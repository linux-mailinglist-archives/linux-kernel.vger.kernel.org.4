Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE364B726
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiLMOTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiLMOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:19:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A19D15A01;
        Tue, 13 Dec 2022 06:19:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso6562196wmp.3;
        Tue, 13 Dec 2022 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G/W/pA5c77Ozx/lB9t1wWPCHBNjkAyhIac3Hljze3s=;
        b=hoVtgwqRx2OgdKO+29kxFa9pe9KTPPft85ySdMPXAY90L6m1SSWYKAjE7l2FwEwVpg
         u3jpgseZXSt5f09MFGkIH/vj6j01mCcSQc/WNTQXg69mGlyug2TZIWoXYBUnEatZyDJ4
         4Q2FdgCm3DYVhGKrmnq74LzK484iwLACvpyLDbb4nk9hsivlKhp7gyY3tMucOV2CCHp9
         dHiOkTWPg9/aukKDHdHz+SNwzi6jSL/xIZGGrUdRbosciL7X9qEiMPSk+Nd4F5znFCf3
         NKDaRDthicZmOk/68PqwfGJeFPozsw4wo3x4B4bZ6NpCcIknA9B+bHLJJkAMFosJw91u
         B2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G/W/pA5c77Ozx/lB9t1wWPCHBNjkAyhIac3Hljze3s=;
        b=hwt1liPoLPJe+Ntj8cXyW1msAXi9Z3thJENYZb1eUbd2YDI00j2pWcufY+b7eGS8Ri
         mFYL5Vxi/1QrXpJei5+9Hs59NUQfqVrTMJHlUHimlRXzDlxMdMgezVardWcMiQxeUprs
         yNzL+zEO2U9uQN1FiGfxDONlcqRxQdH3FeELq0RXDQWe1CpEoWDRZp9Z5QtVlC9W6bfT
         0A/iOyi7qB8UpyabWy3i17uc1deao4kAQwEpOG/SRX3qFldB6PiG0E3BogZI5wfZbJ6Q
         b68diGL0RsdYVBjvqbh6FD7PVsYQXU67snUUebawyhaJtXijS7zPIY92/Lp9Ixfn4cF7
         nooQ==
X-Gm-Message-State: ANoB5pmSE0eRpYGuZ5dHmtOqHodK387xBADw5Z2U+uLvMuLQGuTFUHlb
        AugFlc7O1A3hsrSGvKDzUjl7WVN0TVkn5Hb0G4Y=
X-Google-Smtp-Source: AA0mqf4MmrQhFjfwhKMrUpvFumuZLYrNGjnNtx8wi+H/cF5KWjh30ZrrdiWAtTcbjRSIeSVer/GCaIZB/B7OOZDA2Vc=
X-Received: by 2002:a05:600c:3d94:b0:3d2:2b70:f307 with SMTP id
 bi20-20020a05600c3d9400b003d22b70f307mr245503wmb.153.1670941158482; Tue, 13
 Dec 2022 06:19:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0@eucas1p1.samsung.com>
 <1670311341-32664-1-git-send-email-u0084500@gmail.com> <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
In-Reply-To: <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 13 Dec 2022 22:19:06 +0800
Message-ID: <CADiBU39-FUD787RmV9Z+jsSrb2Se66A6FrLWGxf78q2Ud-SrjA@mail.gmail.com>
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

HI,

Marek Szyprowski <m.szyprowski@samsung.com> =E6=96=BC 2022=E5=B9=B412=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=99=9A=E4=B8=8A7:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Dear All,
>
> On 06.12.2022 08:22, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Following by the below discussion, there's the potential UAF issue
> > between regulator and mfd.
> > https://lore.kernel.org/all/20221128143601.1698148-1-yangyingliang@huaw=
ei.com/
> >
> > >From the analysis of Yingliang
> >
> > CPU A                         |CPU B
> > mt6370_probe()                        |
> >    devm_mfd_add_devices()     |
> >                               |mt6370_regulator_probe()
> >                               |  regulator_register()
> >                               |    //allocate init_data and add it to d=
evres
> >                               |    regulator_of_get_init_data()
> > i2c_unregister_device()               |
> >    device_del()                       |
> >      devres_release_all()     |
> >        // init_data is freed  |
> >        release_nodes()                |
> >                               |  // using init_data causes UAF
> >                               |  regulator_register()
> >
> > It's common to use mfd core to create child device for the regulator.
> > In order to do the DT lookup for init data, the child that registered
> > the regulator would pass its parent as the parameter. And this causes
> > init data resource allocated to its parent, not itself. The issue happe=
n
> > when parent device is going to release and regulator core is still doin=
g
> > some operation of init data constraint for the regulator of child devic=
e.
> >
> > To fix it, this patch expand 'regulator_register' API to use the
> > different devices for init data allocation and DT lookup.
> >
> > Reported-by: Yang Yingliang <yangyingliang@huawei.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>
>
> This patch landed in linux-next 202212 as commit 8f3cbcd6b440
> ("regulator: core: Use different devices for resource allocation and DT
> lookup"). Unfortunately it causes serious regression on my test systems.
> It looks that some supplies are not resolved correctly and then turned
> off as 'unused', even if they provide power to other core regulators in
> the system. I've observed this issue on Samsung Chromebook Peach-Pit and
> Peach-Pi (ARM 32bit Exynos based). The symptoms are somehow similar to
> the issue reported here some time ago:
>
> https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsung.=
com/
>
> I've post more information once I analyze this issue further.
>
It seems the issue occurs in 'regulator register' resolve supply.
Due to the parent device don't have the of_node, to resolve the
supply, it may need to get the
dt node by recursively finding child regulator.
Like this
parent {
  regulators {
     xxx-supply =3D <&vdd12-ldo>;
     vdd12-ldo: vdd12-ldo {
         regulator-name =3D "xxx";
         regulator-min-microvolts =3D <xxxxx>;
         regulator-max-microvolts =3D <xxxxx>;
      }
  };
};
From this case, 'resolve supply' need to parse at least the more top
level like 'regulators'.
But now, it only take 'vdd12-ldo' as the node or its child to parse its sup=
ply.

Below's the fix I guess.
It'll make the parent of the regulator the same as the dev parameter
in 'regulator_config'.

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ea4a720..7c5036e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5526,7 +5526,7 @@ regulator_register(struct device *dev,

        /* register with sysfs */
        rdev->dev.class =3D &regulator_class;
-       rdev->dev.parent =3D dev;
+       rdev->dev.parent =3D config->dev;
        dev_set_name(&rdev->dev, "regulator.%lu",
                    (unsigned long) atomic_inc_return(&regulator_no));
        dev_set_drvdata(&rdev->dev, rdev);

I don't have the board. Could you help to test this change to see
whether it's been fixed or not?
>
> > ---
> > loop Yang Yingliang in cc list.
> >
> > Since v2
> > - Fix typo 'int3742' to 'int3472' for kernel build test
> >
> > ---
> >   drivers/platform/x86/intel/int3472/clk_and_regulator.c | 3 ++-
> >   drivers/regulator/core.c                               | 8 ++++----
> >   drivers/regulator/devres.c                             | 2 +-
> >   drivers/regulator/of_regulator.c                       | 2 +-
> >   drivers/regulator/stm32-vrefbuf.c                      | 2 +-
> >   include/linux/regulator/driver.h                       | 3 ++-
> >   6 files changed, 11 insertions(+), 9 deletions(-)
> >
> > ...
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
