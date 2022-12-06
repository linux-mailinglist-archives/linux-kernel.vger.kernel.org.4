Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F711644418
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLFNHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiLFNHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:07:02 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A112B608;
        Tue,  6 Dec 2022 05:05:31 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1445ca00781so10710509fac.1;
        Tue, 06 Dec 2022 05:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PA9L06FReN9gMJW1BhOEhzIMLjiatd9la6VdvyM95E=;
        b=YCES/+6xXRyWPBK2V5B/SESK10ZFPZhEAhtBl5e+xoB4XO0dWZBMddzB4fex8SIebh
         jiV0OqCUzttTBjqSqRJhXfRacQbDy0AGP2aRQGojNlLNyFg1G0xRk0aGanOrOqt4loso
         nBZwtCMkc+FP1J7wc7RRbtHWkhNgz1KHZeZkIcI2k/KSAuDwNNdVpSu8tQy+rKGHGGtl
         hMyos6dfNiap4mAY5I6m04YGNOMv47aU1m5XIcb9kw3HVOw4Gxoipty58YuBg4UZt8y9
         gtMyJgmFsTFu/ijSvNge0QJn16EHVGmi9bckB9yg814urBijNCgouuaK9gXqGl/PpRdD
         sOaA==
X-Gm-Message-State: ANoB5plVV58dUQ/lOa+o1L2P73q8pOV2t7xP5EHqjvtc5f0/D0SochlZ
        LYqdsCojl3JGgaqfsr5plw==
X-Google-Smtp-Source: AA0mqf4OD6Dy3yFsVoldxMcqJvPGCgCh+F/7YTzrJMkOhg4PXj2JwTNX9wO+2Gqu7sAuwvEhtKG/Hw==
X-Received: by 2002:a05:6871:410d:b0:144:4557:320a with SMTP id la13-20020a056871410d00b001444557320amr9285238oab.112.1670331896981;
        Tue, 06 Dec 2022 05:04:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j20-20020a056830271400b0066e80774203sm6638956otu.43.2022.12.06.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:04:56 -0800 (PST)
Received: (nullmailer pid 229159 invoked by uid 1000);
        Tue, 06 Dec 2022 13:04:55 -0000
Date:   Tue, 6 Dec 2022 07:04:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jeff Chase <jnchase@google.com>
Subject: Re: [PATCH v2 7/9] media: dt-bindings: cec-gpio: convert to DT schema
Message-ID: <167033189469.229101.10106957833693362255.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 16:18:43 +0100, Krzysztof Kozlowski wrote:
> Convert HDMI CEC GPIO bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../devicetree/bindings/media/cec-gpio.txt    | 42 -----------
>  .../bindings/media/cec/cec-gpio.yaml          | 73 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 74 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cec-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
