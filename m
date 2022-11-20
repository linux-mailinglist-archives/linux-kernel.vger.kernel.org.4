Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B663153B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKTQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKTQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:44:26 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868128739;
        Sun, 20 Nov 2022 08:44:25 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-12c8312131fso11351728fac.4;
        Sun, 20 Nov 2022 08:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RNDe7PJi0Vvvvu6jCjNZ7PvIE5H9BtapmW13nMNVFo=;
        b=adXJm9SBJZfREF3orjs8Q0eJWZN0uvoK8+7oD8JK3wYith3VRt5FuQ/Sb29ZnpM9mS
         g3HtWU6u/97pAS1USusyrZtPOeuuilX8VJ4WLm+vrqflHVr6X4FvzADK5lCkP4ztytcu
         qOr71n+oNNjYWA1N5CudpPzKSSVknbFEBKSg58Sp8B9rgbbJWo6sz17GkY2Ou8Txxjla
         WTW75oIf7GmrRZWMbJEjV17QVhZVB8HWnQUVuGvvhdRA3h3tPvw/6YGZbG59d/TpK1BU
         xFwK1b3DUgGNaZ8O/RwGZ1gW5lhtqdy+yh7eubsITvzHqWs6KWXh09uWsIb7yRQfm/CY
         WJyA==
X-Gm-Message-State: ANoB5pnSmc+IAQVOcu4IgFJO2HQbxs7+IZ7bA/mxaVDzks8R3WvozYSd
        1ZHKaE/nSRS2dm5JaLu/OA==
X-Google-Smtp-Source: AA0mqf4j5kGAon96lXkz4r1HaXEn251bNG+XBFyEskhKVT68GFyBgPHGFIcwsws1J6lrB4dZm+cPog==
X-Received: by 2002:a05:6870:c352:b0:13b:66b0:3ef3 with SMTP id e18-20020a056870c35200b0013b66b03ef3mr210242oak.210.1668962664837;
        Sun, 20 Nov 2022 08:44:24 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:5cb3:df5a:23c3:86fb:15a6])
        by smtp.gmail.com with ESMTPSA id s7-20020aca4507000000b0035a81480ffcsm3437647oia.38.2022.11.20.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 08:44:24 -0800 (PST)
Received: (nullmailer pid 3181600 invoked by uid 1000);
        Sun, 20 Nov 2022 16:44:24 -0000
Date:   Sun, 20 Nov 2022 10:44:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        linux-input@vger.kernel.org,
        Fabien Parent <fabien.parent@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Flora Fu <flora.fu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 03/10] dt-bindings: rtc: mediatek: add MT6357 support
Message-ID: <166896266368.3181509.9918929389784534787.robh@kernel.org>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-3-8210d955dd3d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v5-3-8210d955dd3d@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 13:32:57 +0100, Alexandre Mergnat wrote:
> Add binding documentation of mediatek,mt6397-rtc for mt6357 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
