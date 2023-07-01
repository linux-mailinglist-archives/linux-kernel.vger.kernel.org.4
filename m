Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE920744BBD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGAXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68EE10DC;
        Sat,  1 Jul 2023 16:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD6360A29;
        Sat,  1 Jul 2023 23:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E98C433C9;
        Sat,  1 Jul 2023 23:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688253212;
        bh=GICJRTi1UBgWyszLEfObDb7ZtWarNasw276bsUk9Edo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ABeUQ/HYxoMx4QNp6spPUkG54BOEVOZZgI49j1meSVbaR/V8ISazd/2jhieBs5FRl
         9TXi1qENoQImrN7kgt51WZIu03YBOsL66LlCm7joI7kdAZNjkVBPq+9j2wMQBxzBXb
         f7tG/QAlAbLP//QLDdrNzyAYh+SlCKFGYRkgId1LE90c6fqo0wgW+fiLktYD+ewhS0
         uvK+rQj+pH1NqFKPNDZcD5iEDE+WvjG6uNT6ok13FfzxG6fGlGQkA4zcrBbO7KQJd9
         d2crJt0i7Ln6RJ6uqrMzdgnAvRKGLv9eUwoW9julgFSBvTJedoKmXb2YVyjgOrFaoA
         dqhEj4XQN/ZRg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f96d680399so4947571e87.0;
        Sat, 01 Jul 2023 16:13:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ9jbvS+JESE+oumBl+z1sCfbG5BJlZpSYVI5OMrIzjAk4myabC
        +qR1dKGeoj1Wdh+QFfRp8Vf80BKPn0E3NqX8+w==
X-Google-Smtp-Source: APBJJlE9BpPtxXnE/La0Tl+6juXJWlIVshoPEKn3r0kp7hY2oRRITeV9xtlN2CPvQoh+eGMqTfvY3/pJslXS8anUemU=
X-Received: by 2002:a05:6512:718:b0:4fb:7a4e:b573 with SMTP id
 b24-20020a056512071800b004fb7a4eb573mr4707448lfs.5.1688253210855; Sat, 01 Jul
 2023 16:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230630100321.1951138-1-jstephan@baylibre.com> <20230630100321.1951138-3-jstephan@baylibre.com>
In-Reply-To: <20230630100321.1951138-3-jstephan@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Jul 2023 07:13:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY__ZzR52fQdsC=J_sH60hz7rsRhBnSOL3trzu-KyOvpNqg@mail.gmail.com>
Message-ID: <CAAOTY__ZzR52fQdsC=J_sH60hz7rsRhBnSOL3trzu-KyOvpNqg@mail.gmail.com>
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
> ---
>  MAINTAINERS                                   |    1 +
>  drivers/media/platform/mediatek/Kconfig       |    1 +
>  drivers/media/platform/mediatek/Makefile      |    1 +
>  drivers/media/platform/mediatek/isp/Kconfig   |    2 +
>  drivers/media/platform/mediatek/isp/Makefile  |    3 +
>  .../platform/mediatek/isp/isp_30/Kconfig      |   16 +
>  .../platform/mediatek/isp/isp_30/Makefile     |    3 +
>  .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
>  .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1561 +++++++++++++++++
>  .../isp/isp_30/seninf/mtk_seninf_reg.h        |   99 ++

I think it's not necessary to create a folder isp_30 inside isp and
you could just place all file in isp folder because there are only few
files. After adding more and more files then we consider to create
folder to separate them.

Regards,
Chun-Kuang.

>  10 files changed, 1692 insertions(+)
>  create mode 100644 drivers/media/platform/mediatek/isp/Kconfig
>  create mode 100644 drivers/media/platform/mediatek/isp/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Kconfig
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/Mak=
efile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk=
_seninf.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk=
_seninf_reg.h
>
>
