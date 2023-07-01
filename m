Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C999744BC8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGAXf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAXf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A8A1725;
        Sat,  1 Jul 2023 16:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA5860B41;
        Sat,  1 Jul 2023 23:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE0EC433CB;
        Sat,  1 Jul 2023 23:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688254526;
        bh=PJQy4/1p5EsjFhKhO/qYY2FRfK0oK1uwx8Obk6wyd3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ImIdfomfjxVZZ0ycehvi+hOi7iRCrcFuxAmQNRY0/n40l4c0ACk7KUddmkDzXw0zA
         6FimANH9VzNgmTdfWB6/BRCHh5wzRB70cdhT5nItmFjwToX5I5Lw8HQp7mqAt+nDQ4
         pQZTUsac+vEjiBj4ZkxLdHDUNcq0OGy7Vs80jvJgeY50p6jRwxY7kvjmf2aikP4vw3
         hfRVc5bZkRF4adFrJpzkpllK9GS94DOH4MUqQ22rXhCmQgOUpVaWSsozaqN1V5cpoX
         J/5u3Gx9ihPhWrsNxU1fkE3X1t8yS0BznuQPUzJDNc/e1ke8+P+/lfWRiMzv1pbvsr
         dLydA7KNsMx1A==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b69a48368fso49636981fa.0;
        Sat, 01 Jul 2023 16:35:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLY/vNcNTlssma+dJLd1dfEa2Di3Tc+VVg0c8wwdEpIM5hr/ufpT
        DGlag+4RTUaHeYrvXnVX5MpmO8QmIckIGNmIDw==
X-Google-Smtp-Source: APBJJlGXb97S4LcC81WPYNWzCLE4ubtRDMfQc+w41cN33vqI4+yfgrMOBvquGaWnyjqwJEnQwSWD1+OZZGu2/rbGrDo=
X-Received: by 2002:a05:6512:2094:b0:4f9:5396:ed1b with SMTP id
 t20-20020a056512209400b004f95396ed1bmr4223084lfr.28.1688254524241; Sat, 01
 Jul 2023 16:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230630100321.1951138-1-jstephan@baylibre.com> <20230630100321.1951138-3-jstephan@baylibre.com>
In-Reply-To: <20230630100321.1951138-3-jstephan@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Jul 2023 07:35:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-qu2RWr496wXxc1Cp14eZfzKt4QgEH8fJns2LOjpwi8Q@mail.gmail.com>
Message-ID: <CAAOTY_-qu2RWr496wXxc1Cp14eZfzKt4QgEH8fJns2LOjpwi8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

Julien Stephan <jstephan@baylibre.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Louis Kuo <louis.kuo@mediatek.com>
>
> This will add the mediatek ISP3.0 seninf (sensor interface) driver found
> on several Mediatek SoCs such as the mt8365.
>
> Then seninf module has 4 physical CSI-2 inputs. Depending on the soc they
> may not be all connected.
>
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>

[snip]

> +
> +static const struct mtk_seninf_conf seninf_8365_conf =3D {
> +       .model =3D "mtk-camsys-3.0",
> +       .nb_inputs =3D 4,
> +       .nb_muxes =3D 6,
> +       .nb_outputs =3D 4,
> +};
> +
> +static const struct of_device_id mtk_seninf_of_match[] =3D {
> +       {
> +               .compatible =3D "mediatek,mt8365-seninf",
> +               .data =3D &seninf_8365_conf,

Now only support one SoC, so it's necessary to select the SoC data and
you could directly place the data in the code. After support other
SoC, so we could know what should be placed in struct mtg_seninf_conf
(Now we have no any information).

Regards,
Chun-Kuang.

> +       },
> +       {
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_seninf_of_match);
