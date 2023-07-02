Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5D744CEB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGBJUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44741AC;
        Sun,  2 Jul 2023 02:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD1D60B93;
        Sun,  2 Jul 2023 09:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E3EC43395;
        Sun,  2 Jul 2023 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688289639;
        bh=OoxJTr497VHioUOadb8LISKib9/DxBLCZJxT7FykF9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bL0RniYz/c2H9vpv4pnuaegmDqeFYDlUS2BEZ7GDJrxaZs9kAQm8I1PMBYfdWmWpL
         Q4BwNtmNN7cjEb9ZEBMxfdH6HGTTH7ldQIhsTRnan2H8upACk1UfBKxzWVDIqZK7EC
         aoJ9kyx0fO+f5T4QELXyDFR3OOW71En9FO9CRQCv8gCGAKA+8DvNDYz/5JckqAS+Yl
         vdPmulOGE4uWEYbOL2mghdaRMKPAWPkzRISV58zSqCf0nVYb8PmGRuSaqq5toObf3+
         udZE9XFmwFXy7ZVJQy1bsEEI0vrmLPLd+BMr1MqiYnB2kpaKuFh8RCPJN3a206Hxl9
         OIBmWKxePHZ8A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b69f216c73so50938281fa.3;
        Sun, 02 Jul 2023 02:20:39 -0700 (PDT)
X-Gm-Message-State: ABy/qLYQ/gaK092RUztfq/Xg0bUMGQqLLMO/j0Ob3oO03h0F2n+9UNqS
        g9W5bA6Mb7VVIAMv3+DQwO1BZrytKHggI+lm7Q==
X-Google-Smtp-Source: APBJJlFzKkAXMTAQCIn36i2e8A9159bcyumoyoBjKkUas8tkWmueWlSltNowd8sa4B/xy0FSyk17VqHCj3F5LJNwJpU=
X-Received: by 2002:a05:6512:ea0:b0:4f8:6882:ae9d with SMTP id
 bi32-20020a0565120ea000b004f86882ae9dmr5936084lfb.69.1688289637554; Sun, 02
 Jul 2023 02:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-3-jstephan@baylibre.com> <CAAOTY_-qu2RWr496wXxc1Cp14eZfzKt4QgEH8fJns2LOjpwi8Q@mail.gmail.com>
In-Reply-To: <CAAOTY_-qu2RWr496wXxc1Cp14eZfzKt4QgEH8fJns2LOjpwi8Q@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Jul 2023 17:20:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9SFRMb7d3c62SVDnZY00hRAZ=9wBi9QCcv1UKuc8iBtQ@mail.gmail.com>
Message-ID: <CAAOTY_9SFRMb7d3c62SVDnZY00hRAZ=9wBi9QCcv1UKuc8iBtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Julien Stephan <jstephan@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2023=E5=B9=B47=E6=9C=882=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=887:35=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Julien:
>
> Julien Stephan <jstephan@baylibre.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=883=
0=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > From: Louis Kuo <louis.kuo@mediatek.com>
> >
> > This will add the mediatek ISP3.0 seninf (sensor interface) driver foun=
d
> > on several Mediatek SoCs such as the mt8365.
> >
> > Then seninf module has 4 physical CSI-2 inputs. Depending on the soc th=
ey
> > may not be all connected.
> >
> > Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> >
>
> [snip]
>
> > +
> > +static const struct mtk_seninf_conf seninf_8365_conf =3D {
> > +       .model =3D "mtk-camsys-3.0",
> > +       .nb_inputs =3D 4,
> > +       .nb_muxes =3D 6,
> > +       .nb_outputs =3D 4,
> > +};
> > +
> > +static const struct of_device_id mtk_seninf_of_match[] =3D {
> > +       {
> > +               .compatible =3D "mediatek,mt8365-seninf",
> > +               .data =3D &seninf_8365_conf,
>
> Now only support one SoC, so it's necessary to select the SoC data and
> you could directly place the data in the code. After support other

Typo.

Now only support one SoC, so it's not necessary to select the SoC data
and you could directly place the data in the code.

Regards,
Chun-Kuang.

> SoC, so we could know what should be placed in struct mtg_seninf_conf
> (Now we have no any information).
>
> Regards,
> Chun-Kuang.
>
> > +       },
> > +       {
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_seninf_of_match);
