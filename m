Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3272E6BAC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjCOJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:26:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354353700
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:26:35 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e194so18483072ybf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678872395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah3hCHxRKLhXbUb0/zDpGbrf+oZe//U+DP3mMWw+T8c=;
        b=d5zFDRwPxETDMQPbed+EfhECDqFpfx8TgxdVjJLVO33pllTKXnCeZ6Hk9QAQn7Dw4+
         oWwetYLyd4CtHpCifM8AroVKcjrw/2ujfEkNx21G9ysAvCmRlxgPsHRPxWKrE2hdexcp
         2idemqhli6FqtgkUkuZRShsSSKCkHav0hjtzcnLS7vLs5njq0I3+r1M58wEZWZSRe/5w
         MCX69ZCeDYaPs4V+n656TCYSZm7Bait5OLJkSVV06dPD39msVSlk9Vj+T+JqXAaZEp+K
         GA8c9VFqG4DPd1462qMWj+Lsk0Zv64cNfsfFiHVdem5Z+73jTMqu/Y35+PZOiQVe4uUq
         AS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah3hCHxRKLhXbUb0/zDpGbrf+oZe//U+DP3mMWw+T8c=;
        b=i6zVAnsOpVPkc0DELWYEyt/UjbR61/GiZVO1VdnhQy2qOYqxZW2sir8M7vNWKzUbO3
         t1bIVf/lBqEigasSMyc9AnlXrFiikhIuu1jeuhjXO99ZfCshhGvVWkbLxwZhskTyDZgU
         SiXnR5jbiZqyyZHhgd9OI7JcAlpCDdilCC9V1XTg72ZuCBpSmR0c+4+N0mHuoQg571En
         9fNHRvYryqSLNixZtx44hrWbxdJaIG3d4PB2OCW4FS7vEn8lsn/WGXeIc/p04h+2LpP4
         +O1muyKye/2U9GnBtCqvs8qce2UKGTMdYfVSPdt4wNz6I/4Gk17AfMefPBzbO6uD4kkw
         uOCQ==
X-Gm-Message-State: AO0yUKWhy9xKkwmFfGWln8tCwiT4KEyPo9nL7nDpPvA1NOe1X6U9QwJU
        n9aelKubPMGh14FcPSRiTmUJ5CJbLf8A7Rdb5x3IPQ==
X-Google-Smtp-Source: AK7set85Tksbs5R01RThGTgUkuOcBof0bxceE3ivDeTB4gA3qDm/+jVks8dAQC4UN3fTwJGP5ML+MUn6x7iNEe2KU4g=
X-Received: by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr23209983ybh.1.1678872394826; Wed, 15
 Mar 2023 02:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-7-45cbc68e188b@baylibre.com> <CAAOTY_819JuuidLgTOm+Ps=WnueW0Quos+abEDjrx8q8GifGKA@mail.gmail.com>
In-Reply-To: <CAAOTY_819JuuidLgTOm+Ps=WnueW0Quos+abEDjrx8q8GifGKA@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 15 Mar 2023 10:26:23 +0100
Message-ID: <CAFGrd9qVhJb--COXJmGHuW6NxDnXZGdQnxbHGRvaA5Jqhx-yNg@mail.gmail.com>
Subject: Re: [PATCH 07/21] dt-bindings: display: mediatek: dpi: add binding
 for MT8365
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Le lun. 13 mars 2023 =C3=A0 16:17, Chun-Kuang Hu <chunkuang.hu@kernel.org> =
a =C3=A9crit :
>
> Hi, Alexandre:
>
> Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=
=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > From: Fabien Parent <fparent@baylibre.com>
> >
> > DPI for MT8365 is compatible with MT8192 but requires an additional
> > clock. Modify the documentation to requires this clock only on MT8365 S=
oCs.
>
> If MT8365 DPI has additional clock, why it is compatible with MT8192 DPI?
> I think some part of MT8165 DPI works under the speed control by the
> DPI clock and this is different with MT8192 DPI, how could these two
> are compatible?

AFAII, The mtk_dpi driver manage the 4th clock as optional
dpi->dpi_clk =3D devm_clk_get_optional(dev, "dpi");
And all configuration variables for mt8192 are the same for mt8365.
These configuration clock variables (like cal_factor) aren't
correlated with the 4th clock.
The clock number doesn't impact the configuration variable because the
4th clock is simply retrieved from DTS, saved in the driver structure
and prepare/unprepare/enable/disable, like other clocks.

Regards,
Alex
