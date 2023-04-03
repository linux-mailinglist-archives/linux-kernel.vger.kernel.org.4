Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7A6D4E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjDCQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjDCQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25404A8;
        Mon,  3 Apr 2023 09:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4537621B3;
        Mon,  3 Apr 2023 16:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C22EC433AA;
        Mon,  3 Apr 2023 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680539806;
        bh=Kt9moSViwJx5yBWxvRA4G9k3CxuCk+dcQWzL3AwN3FE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ahWI5wtUMMDF/JK6RX094BK6NZ4T3EfR3FIlVMMZneVIfsnYjpL09ROA1rQ6N5jfQ
         sRX9euqVfFzODLoLQso+AiLu0FoMjhWvYGA5C7Cdd/+NzJiHkqmP5bCMRxQPmEli69
         URsh71mUZUFo3QSt1BlR6mhlS4XBNMQXcRgbncFMGYq8HoteBav1rRoR3IrUzF67dp
         Vs/ZGSfMozsTso9jBogHMNAOICUDN1o7lp1uSHkGCUmL7mxK1k7BW5g/kCsM1bVBFr
         8dtlBK8VMT8B6Om9g1PGZ+jeQxgi5TI2dbmkKnwTP3tQ7/cI3ydNFRXEp4NS7lXPPF
         Is0zZPWMKCb/w==
Received: by mail-lj1-f178.google.com with SMTP id q14so30980687ljm.11;
        Mon, 03 Apr 2023 09:36:46 -0700 (PDT)
X-Gm-Message-State: AAQBX9cZpC4XjtY615PUfQ1OpDslpy9yGhXJJ1jtiHjrAxbnaJ3DB+iX
        mvA2+9DTvPUxYJw2RgFzsIcedoRhpspXdEcKZQ==
X-Google-Smtp-Source: AKy350YI8MSRmypV7liUfnAR04I0V60fJ/SJAQ6mMQYLy3vXtuAOgKEuMnQZv1aQSY0uDcu20Z1RIZDPBPLHhmfbBBA=
X-Received: by 2002:a2e:9dda:0:b0:2a6:199a:bd38 with SMTP id
 x26-20020a2e9dda000000b002a6199abd38mr30959ljj.10.1680539804050; Mon, 03 Apr
 2023 09:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230403071929.360911-1-jstephan@baylibre.com> <20230403071929.360911-3-jstephan@baylibre.com>
In-Reply-To: <20230403071929.360911-3-jstephan@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Apr 2023 00:36:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-cd0gQ6AEK_bLZf6m87M0G7Ag_AYKKPBFyBXGgh-2y1g@mail.gmail.com>
Message-ID: <CAAOTY_-cd0gQ6AEK_bLZf6m87M0G7Ag_AYKKPBFyBXGgh-2y1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: mtk-mipi-csi: add driver for CSI phy
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

Julien Stephan <jstephan@baylibre.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
>
> This is a new driver that supports the MIPI CSI CD-PHY for mediatek
> mt8365 soc
>
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> [Julien Stephan: use regmap]
> [Julien Stephan: use GENMASK]
> Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/phy/mediatek,csi-phy.yaml        |   9 +-
>  MAINTAINERS                                   |   1 +
>  drivers/phy/mediatek/Kconfig                  |   8 +
>  drivers/phy/mediatek/Makefile                 |   2 +
>  .../phy/mediatek/phy-mtk-mipi-csi-rx-reg.h    | 435 ++++++++++++++++++
>  drivers/phy/mediatek/phy-mtk-mipi-csi.c       | 392 ++++++++++++++++
>  6 files changed, 845 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-rx-reg.h
>  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi.c
>

[snip]

> +
> +#define REGMAP_BIT(map, reg, field, val) \
> +       regmap_update_bits((map), reg, reg##_##field##_MASK, \
> +                          (val) << reg##_##field##_SHIFT)
> +

Use FIELD_PREP() macro  so you can drop the definition of SHIFT symbol.

Regards,
Chun-Kuang.
