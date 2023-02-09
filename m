Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190DD69102B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBISQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBISP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:15:57 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83307868F;
        Thu,  9 Feb 2023 10:15:53 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-16aca2628c6so1419677fac.7;
        Thu, 09 Feb 2023 10:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQXSzsZMJZnsLWdCsM/m+xJ0lR6ba3BNbI//iLuwLy0=;
        b=DhRWrKKeqVd4qwx7VBpOyYC8jjYX+lgA8Cry4uWxtc/VLhf27EWmwgCdP/ojHSQpOY
         lXy8TdDNxoB12Ef2sm4Uu2f9pGM9VrbvkgPuwxpiSyUMjnwOxB1+0znamo0a59YCD3HF
         pljFqCeJ1f5Vy88JRyAob9RIo4xPoMUEIkugwMpU8A6qR47abf+8R8jznHfPuBcv1Q1w
         LuYWkkQozG9m9RefXP+Vy+83ZKN4UZ0N4ZRF4QmzkKZeNdjHtnKhNboaaWelZdT6zem4
         l4t6udnWWMnpOPLjxqoOzBuwIKkeTrPYIxflRncvYFLHLoZ8nfOSjnkvJmFSY8If4anO
         12Xw==
X-Gm-Message-State: AO0yUKVSbnaP9vnYOzqHi9vbXNAFYr3UJf/fEudFZ4XS7VhKdg2lkoQM
        XaHivIjIUesWhHha7fPTWg==
X-Google-Smtp-Source: AK7set+YmvLpY9HqVM+xUbJq3vy7hLO//HB2AnV0s8lDsqBKdWE0jNTtCstDuwkFYC/+P4B6nmCcZw==
X-Received: by 2002:a05:6870:6011:b0:163:2c2e:b3b1 with SMTP id t17-20020a056870601100b001632c2eb3b1mr5646434oaa.9.1675966552749;
        Thu, 09 Feb 2023 10:15:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cy3-20020a056870b68300b00155ffbdbaffsm983220oab.18.2023.02.09.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:15:52 -0800 (PST)
Received: (nullmailer pid 589042 invoked by uid 1000);
        Thu, 09 Feb 2023 18:15:51 -0000
Date:   Thu, 9 Feb 2023 12:15:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, linux-mediatek@lists.infradead.org,
        steven.price@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alyssa.rosenzweig@collabora.com,
        tomeu.vizoso@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH 4/9] dt-bindings: gpu: mali-bifrost: Add new MT8183
 compatible
Message-ID: <167596655120.588989.9166090358280103013.robh@kernel.org>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
 <20230208103709.116896-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208103709.116896-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 11:37:04 +0100, AngeloGioacchino Del Regno wrote:
> Since new platform data was required in Panfrost for getting GPU DVFS
> finally working on MediaTek SoCs, add a new "mediatek,mt8183b-mali"
> compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

