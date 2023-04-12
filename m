Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960E96E0061
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDLVEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDLVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:04:01 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B57D85;
        Wed, 12 Apr 2023 14:03:56 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id bm45so2991434oib.4;
        Wed, 12 Apr 2023 14:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333435; x=1683925435;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Q95Knbpjeo78pZINMZAvNZ8f1W6NvaHbQpZHgZ+DhU=;
        b=jUTC+/hdRPUAJNg2SJoLrVPCwphEGcjwMOVjA+DuD9WtFL+SMCfBdnNhiI7jk3XAsW
         eEzH/pZxv7vFmJgAs99LA6N3+rB3o86p6i6NoPyTzadRINpQLh8+bYSbyiuRg0zwjkap
         0vaSOQOKENjm1NFGp3gF20mqr2Ix6LvrfvT2joHDF2q4CITIYbucovZBNtKUEKMwn79O
         BR47ZDXv3LN8KOwzcq0G66Gk1gtdeacW+Hudy1MV76jo8V1BN2Lw6YykSAb+1jUpCYjR
         QwdpotsY+J7GZDqNoWp8cnm4nWo+RSOdLGnl6JfAiLGwbpRxCU+uQy2E2TOzqIADwUcr
         F0/Q==
X-Gm-Message-State: AAQBX9dnaflsbPQEYn/KmBe1WejHAcDMQMPW0PkHerykGip+iB76yXzw
        tXIaxMGzSQXcgCEbNK67wg==
X-Google-Smtp-Source: AKy350ZAQUKENqZQK/BkT1GzRkK8etcW3v2rWKWM1oDiBBATLa6RSgxvv4SclTk2dvtCGsASeNojAw==
X-Received: by 2002:a05:6808:4b:b0:387:12e5:543a with SMTP id v11-20020a056808004b00b0038712e5543amr7422991oic.29.1681333434837;
        Wed, 12 Apr 2023 14:03:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i128-20020acaea86000000b00386eff32f58sm7148418oih.13.2023.04.12.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:54 -0700 (PDT)
Received: (nullmailer pid 3200537 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, kishon@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-pwm@vger.kernel.org,
        airlied@gmail.com, robh+dt@kernel.org, chunfeng.yun@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        kernel@collabora.com, xinlei.lee@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        p.zabel@pengutronix.de, jassisinghbrar@gmail.com,
        chunkuang.hu@kernel.org, houlong.wei@mediatek.com,
        jitao.shi@mediatek.com, daniel@ffwll.ch
In-Reply-To: <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319583.3191294.4759319842761199183.robh@kernel.org>
Subject: Re: [PATCH 09/27] dt-bindings: display: mediatek: color: Add
 compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 16:03:44 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Apr 2023 13:27:21 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's COLOR block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,color.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-10-angelogioacchino.delregno@collabora.com


color@1400b000: 'power-domains' is a required property
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

