Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB16B11AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCHTEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCHTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:03:24 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE859E64E;
        Wed,  8 Mar 2023 11:03:22 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176261d7f45so19749043fac.11;
        Wed, 08 Mar 2023 11:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9il/DGJIQiu6Ue8jvxZUwoY7ORjCm0v/Im7Io+dDxPs=;
        b=1+DmG54gF+Vfqn3vPES1nflB5L6mo89DnGvVArtTKoVWoMRzaAvt0R5gNybmsdThkq
         QS+SvBr5nxLHVwkDkVPj3uIXhroynxk54SXt39sfPXUyZ2lJ86NFIExXVlJHLq37gqiE
         gPM7WXVUZrK9berxrR2SWtwX93eFyxtENa786q9aqHQkiO39ZVFmrzngpurH6ZYQ02s5
         x82w5y6QbicItC7Xr5W8K1Ryi9NyoaiBDjCv2cFLeld8U6JJWKax2LLNKFhfY4VFH6VP
         VGTYBsImOcyc9LOCyotFZpt+C+oaNZSIWrkkWuzijDPfwAopMvuXYuVHT1fYu8MAoXF6
         dqhQ==
X-Gm-Message-State: AO0yUKUNXQL4gZcoro+4HtXMUbV/id8OErSEizPCac8znye3RjDizo0E
        p2289gqOc7SfBGk8j1c7ig==
X-Google-Smtp-Source: AK7set/POqWuscJib/lrSJTB9epA2owd4C+73BtnHIuJFrEFJL2xeHZhaNT4yQoIOLqI2Iaqknu/XQ==
X-Received: by 2002:a05:6870:f292:b0:172:c578:d78b with SMTP id u18-20020a056870f29200b00172c578d78bmr1164117oap.23.1678302201744;
        Wed, 08 Mar 2023 11:03:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dx12-20020a056870768c00b0017281100b75sm6506505oab.42.2023.03.08.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:03:21 -0800 (PST)
Received: (nullmailer pid 3605141 invoked by uid 1000);
        Wed, 08 Mar 2023 19:03:20 -0000
Date:   Wed, 8 Mar 2023 13:03:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     steven.price@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        daniel@ffwll.ch, alyssa.rosenzweig@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, airlied@gmail.com
Subject: Re: [PATCH v4 06/12] dt-bindings: gpu: mali-bifrost: Add support for
 MediaTek MT8186
Message-ID: <167830220018.3605078.16960763301333635462.robh@kernel.org>
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
 <20230228102704.708150-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228102704.708150-6-angelogioacchino.delregno@collabora.com>
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


On Tue, 28 Feb 2023 11:26:58 +0100, AngeloGioacchino Del Regno wrote:
> MT8186 has a Mali-G52 MC2 2EE GPU (two cores): add a binding with
> two power domains (one per core) for it.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../bindings/gpu/arm,mali-bifrost.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

