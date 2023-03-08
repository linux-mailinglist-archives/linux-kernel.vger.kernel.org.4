Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD06B1192
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCHTAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCHTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:00:15 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF78C965;
        Wed,  8 Mar 2023 11:00:14 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id t22so12911327oiw.12;
        Wed, 08 Mar 2023 11:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNa/cVQhueG20Tof7moqLUCFmD+BmRjr+NvaKX3Ihsk=;
        b=NAiwSYgdapx5jyanexgX7LmyjW0JQJsmPlNMzxwrf+3lAoS3AQgo4aPmYeVelVDYKD
         09nZ5/pq/A27EfDOX89ej9rt0dEp5b66d+iRETStlj8U/lsAhjoOWDEoqcoxS/wf2vkL
         CdhOLul883NdmXH/YBasZZ7pGf6y/efwo/FaQjO0SdyNRbgxtxLHsmYEI5yRJNg6xNuR
         jHfsxaJBuXeyFwCVdgKROkxFYnykhyp+QHq0ViK5KBIdyEvX28GrMV2AuFV2ULxKD3P3
         Nf446yZTWGKPCdabdQJYVJ1CaBksz7Jp45t4l9G8+9sE5kMXDqT5jE5dyA0SdbSFz+wz
         dO1w==
X-Gm-Message-State: AO0yUKUAM3QCzyvju8dImCnTaHQh0Vu+qhrAH0A/G4cSBM/vfktm9en/
        YOVwUI2LizsQXbtZnb7kQQ==
X-Google-Smtp-Source: AK7set+m69vr45bRObydhhWKNDty0kaMDB6eJGD8k3EItoKQM01NjxIxem4W68C07DwYBRVbhBjmmQ==
X-Received: by 2002:a05:6808:b14:b0:384:59df:189e with SMTP id s20-20020a0568080b1400b0038459df189emr8580664oij.55.1678302013673;
        Wed, 08 Mar 2023 11:00:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg23-20020a056808179700b0037832f60518sm6591779oib.14.2023.03.08.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:00:13 -0800 (PST)
Received: (nullmailer pid 3600642 invoked by uid 1000);
        Wed, 08 Mar 2023 19:00:12 -0000
Date:   Wed, 8 Mar 2023 13:00:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, alyssa.rosenzweig@collabora.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        matthias.bgg@gmail.com, wenst@chromium.org
Subject: Re: [PATCH v4 01/12] dt-bindings: gpu: mali-bifrost: Split out
 MediaTek power-domains variation
Message-ID: <167830201182.3600568.17557629958296302697.robh@kernel.org>
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023 11:26:53 +0100, AngeloGioacchino Del Regno wrote:
> In preparation for adding new bindings for new MediaTek SoCs, split out
> the power-domains variation from the `else` in the current
> mediatek,mt8183-mali conditional.
> 
> The sram-supply part is left in place to be disallowed for anything
> that is not compatible with "mediatek,mt8183-mali" as this regulator
> is MediaTek-specific and it is, and will ever be, used only for this
> specific string due to the addition of the mediatek-regulator-coupler
> driver.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml        | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

