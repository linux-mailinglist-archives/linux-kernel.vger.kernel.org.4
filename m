Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A46E0053
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDLVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDLVDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:03:53 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F10359A;
        Wed, 12 Apr 2023 14:03:51 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1842e8a8825so15298606fac.13;
        Wed, 12 Apr 2023 14:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333430; x=1683925430;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLw3uwkCeeUAAV03Tbbd6RIpAi5xQgVb6ft9jGrKTas=;
        b=YknO4Cvc3pkc24rFvtZV+nuBHCysggZqQI0nMdl0Oiiy/YYYaub9GfsRrZ9RAn3ngT
         0n31K3nfvSREODdE0kxq4Edcu4VJtLYRX2gSv87rFp9A4NfbOPIzVf5M4Ue5az7SE1OB
         U9nAiUwJ3soLEcg05A8yaekE0Grm+Wsr4C1fGyWQjMJJKw6yQqfoKD+hq+MrA+vaDLox
         emXbJ9v8qoQbtGxTvvtF7rhygMDaDsF7v5oa7dLlpQUGJDaL5rJ7qIkOM4aYBeP4BHCg
         Spbp84f7Di8Jb0RC9CbmH1kJVr3ddio+qmozidcPU8Ki4QdbTFU/sQEgHIrBav3acgWU
         2xdg==
X-Gm-Message-State: AAQBX9dfDXWzdXAArZBoiWbrxG/wHMXlvOEP8wfaLzwU+kKGgfMDNd+w
        2a2Xuwa2tEhorqnFSSIpLg==
X-Google-Smtp-Source: AKy350ZSC5jj3xISsp6oFnvk6oBWEtks02c+F/U24WBNcLmHcB6s1GI9dgP3edZehcoihI5kfSHupw==
X-Received: by 2002:a05:6870:c6a3:b0:187:76e6:7527 with SMTP id cv35-20020a056870c6a300b0018776e67527mr202541oab.17.1681333430215;
        Wed, 12 Apr 2023 14:03:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z21-20020a056871039500b00183ff6b45a2sm66090oaf.10.2023.04.12.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:49 -0700 (PDT)
Received: (nullmailer pid 3200541 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunfeng.yun@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        chunkuang.hu@kernel.org, vkoul@kernel.org, daniel@ffwll.ch,
        kishon@kernel.org, thierry.reding@gmail.com, airlied@gmail.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ck.hu@mediatek.com,
        phone-devel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, houlong.wei@mediatek.com,
        xinlei.lee@mediatek.com, jassisinghbrar@gmail.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jitao.shi@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@collabora.com
In-Reply-To: <20230412112739.160376-15-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-15-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319930.3191493.4677860733560353143.robh@kernel.org>
Subject: Re: [PATCH 14/27] dt-bindings: display: mediatek: od: Add
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


On Wed, 12 Apr 2023 13:27:26 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's OverDrive (OD)
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,od.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-15-angelogioacchino.delregno@collabora.com


od@14023000: 'mediatek,gce-client-reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

