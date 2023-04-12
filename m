Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53606E0057
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDLVEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDLVDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:03:55 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50A76A9;
        Wed, 12 Apr 2023 14:03:52 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id z8-20020a4ad1a8000000b00542190bf1fcso335457oor.9;
        Wed, 12 Apr 2023 14:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333431; x=1683925431;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iAvkCDu3hruxgiOJqmE1sAlKDaRv3MBstRHxkz3IG9s=;
        b=PZYohEZzCHMYvCewn9xyTWh+S3ue2bDItStlS5bUVPotCBOoXt9N1fjFEaQv5dSBvD
         jRpJ7BGPIEo/LRK/KB5xLRiDWgABxmyAO/MGN9CVYnJomDkz6EpMx2rLQ140AWv0AP6T
         mjZDSrUK5BBvAMoXn3Qo5pK2e6NXdpAS0QCiLp0PRr2cU5ki98GlLGpwhTNWzBr15BoE
         0JwH4r2T0GNV4+Wv3P9Il56vS6+AM5QK1H5i4Ty0ELI+DQi409SXxsdBEjnDp24WhSdS
         LYWcDVgqN/d1gokFwFgayxXa1GwvYfJE86cqWUa1m7y0SNmCJP04F/zDOFX+X6zWRgS/
         4hxQ==
X-Gm-Message-State: AAQBX9fCAv3vyTfMLTrv2Ax7cTZTPNgyCWpa9txSKdUDXGEKs11Da99j
        hFMMN20Ch2XBInZAb4FL1g==
X-Google-Smtp-Source: AKy350Z5Q9mJ1edtUqGeVZax9s2dgjb2Rbg2T6w0rBrdB1GGVndSVyqgynTnqgRdU1HgIe3DZDxvJQ==
X-Received: by 2002:a4a:4153:0:b0:532:7281:93fc with SMTP id x80-20020a4a4153000000b00532728193fcmr8643020ooa.2.1681333431639;
        Wed, 12 Apr 2023 14:03:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o7-20020acad707000000b0038b0dd1c040sm7217626oig.3.2023.04.12.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:51 -0700 (PDT)
Received: (nullmailer pid 3200533 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, linux-mediatek@lists.infradead.org,
        chunkuang.hu@kernel.org, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, vkoul@kernel.org, ck.hu@mediatek.com,
        xinlei.lee@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
        kishon@kernel.org, robh+dt@kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        daniel@ffwll.ch, phone-devel@vger.kernel.org,
        jassisinghbrar@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        airlied@gmail.com, chunfeng.yun@mediatek.com,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        jitao.shi@mediatek.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230412112739.160376-7-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-7-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319361.3191144.6939545255340146019.robh@kernel.org>
Subject: Re: [PATCH 06/27] dt-bindings: display: mediatek: ovl: Add
 compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 16:03:44 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Apr 2023 13:27:18 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's OVL block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-7-angelogioacchino.delregno@collabora.com


ovl@14007000: 'power-domains' is a required property
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

