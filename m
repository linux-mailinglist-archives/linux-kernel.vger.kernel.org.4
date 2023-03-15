Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5B6BB5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjCOORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCOORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:17:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A76EAA;
        Wed, 15 Mar 2023 07:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04C8BB81E40;
        Wed, 15 Mar 2023 14:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7763C433A0;
        Wed, 15 Mar 2023 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678889847;
        bh=CQun5NYvCzgck8mLcoHCcDks/YPrwVLykREvoC7nBKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XJWjqUEkahmrvngFt9oyfNfcK+J2smZ7aM21uO/o+ojEQjxERR7bgSDu+m5Op9YpW
         NN2ALZolAGYGgCSxDzmSIGcMjp2YOMPSAr/LAvddBCtAFBM4utuK9P9Lu1EYR5pNtM
         4pKKHg43gq+2vs4C/p39gOAsAwzHharXQa76ru1K9aBMMfwrl+I3uQ2nE9oKtUm3QL
         JHpqRrlE1rjCWcgwgnTrnCI8vZIjTEcdovAAZXp0v/dswlba3bEcxe1d+qjAzz7kXh
         wJ1SCB6MwupEKZGO9r+yQmqxysPGV6POLcLMF9It+ojiQydZfDwSdhYGT3hM4dMieZ
         Y4/5Adbg3tk8g==
Received: by mail-lf1-f48.google.com with SMTP id d36so24499302lfv.8;
        Wed, 15 Mar 2023 07:17:27 -0700 (PDT)
X-Gm-Message-State: AO0yUKX2kL7EuLHPe2WslQPHO6CuFgxpFqIFNZtJXmNz/rqpiELchSTQ
        cewH7BKFXBYMwo1ZHiWmmL39mz+cfOKLmhPV8Q==
X-Google-Smtp-Source: AK7set8Vnq294J+j4qqKSVvr2jzh7ZWYNwCdOd39eacfnl/Ca01w31d255eKrfrDZr8PTwI+xUi8SrZq75uayJmH64s=
X-Received: by 2002:ac2:484f:0:b0:4dd:af74:fe17 with SMTP id
 15-20020ac2484f000000b004ddaf74fe17mr2074084lfy.7.1678889845688; Wed, 15 Mar
 2023 07:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-19-45cbc68e188b@baylibre.com> <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
 <CAFGrd9pa3c3eZcuGg7AmHL8kOAkyx96hwjwnMuO-G9BR1ORJ_w@mail.gmail.com>
In-Reply-To: <CAFGrd9pa3c3eZcuGg7AmHL8kOAkyx96hwjwnMuO-G9BR1ORJ_w@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 15 Mar 2023 22:17:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-TfXBpVbWw54yORqQ9Ubft-6PKofS2VznMi4-jfbA7Mg@mail.gmail.com>
Message-ID: <CAAOTY_-TfXBpVbWw54yORqQ9Ubft-6PKofS2VznMi4-jfbA7Mg@mail.gmail.com>
Subject: Re: [PATCH 19/21] drm/mediatek: dpi: add support for dpi clock
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandre:

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=88=
15=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:36=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Le lun. 13 mars 2023 =C3=A0 16:21, Chun-Kuang Hu <chunkuang.hu@kernel.org=
> a =C3=A9crit :
> >
> > >
> > > +       dpi->dpi_clk =3D devm_clk_get_optional(dev, "dpi");
> >
> > For MT8365, DPI clock is not optional, so make sure that MT8365 DPI
> > should have this clock.
>
> This should be check and notified at build time thanks to the
> device-tree binding. Do you prefer this?:
> #IF MT8365_SOC
>     dpi->dpi_clk =3D devm_clk_get(dev, "dpi");

Add one member in struct mtk_dpi_conf for dpi_clk. In
mtk_dpi_of_ids[], add one item for mt8365

{ .compatible =3D "mediatek,mt8365-dpi",
 .data =3D &mt8365_conf,
},

Regards,
Chun-Kuang.

>
> Regards,
> Alex
