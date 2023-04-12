Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82876E0067
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDLVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDLVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:04:12 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8927D85;
        Wed, 12 Apr 2023 14:04:10 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso13538665ott.4;
        Wed, 12 Apr 2023 14:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333436; x=1683925436;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djvELGPiz2X7+nxWdiXWHHU3TDK+TW+pNOfsGeO7c30=;
        b=LPsfdSZt1544Hfk+c2nIC0SSBq6FaXkNJXH528FLmP4/VsQCClCZeY/SsemUs7pH3F
         ReErn+d1Bgy3Kw9mYMqPLYkmjJCZkcsVQN1diwEycPjqkC+mE/HH+Ywh5MNHjKofljlJ
         xNZFIhV/knh3up/7T3w04tWBwmPQakb0Zy6Ty/9ibRWyItsMKBiCmrAZIp7bKsvDSsae
         7R5KEa3na85Hz1CR4XqfrVMS+NeejBcXEzaCRFhC1BiuZttwHyplvgLcBqEXfCchcW1d
         3ML5x3RX68QnxEfTm94ovkO1e0Antv3vlzQ9DlLRRkCF19kQeXRz0g/tmYCAQROpxSnL
         Xl6w==
X-Gm-Message-State: AAQBX9czWe+3TZtpwA4jMPXC7mULP29GsVe0kB/JoX2Ph/v8tCJqw+l1
        iEozRaDZN2vjDJ3qtCbHVg==
X-Google-Smtp-Source: AKy350ZPaxQqCIVs+haHZm96AVYtUTY7Qo26AYMJnx+qKKJp/dAi3OmoVXf+cund9KGn0KbJXB+BWw==
X-Received: by 2002:a9d:7d0e:0:b0:6a1:42ee:1f5e with SMTP id v14-20020a9d7d0e000000b006a142ee1f5emr6568051otn.0.1681333436323;
        Wed, 12 Apr 2023 14:03:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a056830019600b0069d602841e7sm20803ota.72.2023.04.12.14.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:56 -0700 (PDT)
Received: (nullmailer pid 3200539 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel@ffwll.ch, xinlei.lee@mediatek.com,
        dri-devel@lists.freedesktop.org, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, phone-devel@vger.kernel.org,
        matthias.bgg@gmail.com, kernel@collabora.com,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-mediatek@lists.infradead.org, u.kleine-koenig@pengutronix.de,
        linux-phy@lists.infradead.org, p.zabel@pengutronix.de,
        airlied@gmail.com, linux-arm-kernel@lists.infradead.org,
        houlong.wei@mediatek.com, chunkuang.hu@kernel.org,
        chunfeng.yun@mediatek.com, ck.hu@mediatek.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@kernel.org, vkoul@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org
In-Reply-To: <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319867.3191434.734350328370744826.robh@kernel.org>
Subject: Re: [PATCH 13/27] dt-bindings: display: mediatek: ufoe: Add
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


On Wed, 12 Apr 2023 13:27:25 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's UFOE block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ufoe.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-14-angelogioacchino.delregno@collabora.com


ufoe@1401a000: 'mediatek,gce-client-reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

