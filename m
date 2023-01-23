Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFF678968
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjAWVUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAWVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:20:42 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E011ABF0;
        Mon, 23 Jan 2023 13:20:39 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id p185so11596935oif.2;
        Mon, 23 Jan 2023 13:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJETK3OSsznW7YVJ84aqO5Pm3VovO6KPLRPmFaeGzU8=;
        b=xo+j1wWbOAgopWBLhc2RMVlS/ylXH0Wj93ImWz3bu2v221bkDTP20QwlqSkcF/pk7G
         7VBbNIcuGG1t7vOaQnnKFkROtVqIDvkN8gzcS46ndjbBELjbqa1SbKLrdKlmvldNCreo
         NHGfU2Mogp9hgt5vEeZlAofa5iODky+NI6s3YC4w1xr7pK8NYTzT4Vtbs8em+hxXneYu
         9u3IkXf9HXPsiVkLnZqDDsB3xXX9f250ayy3wtvPK5LQwZ6Wr0XgOkZ6lOpsTFTzuSMV
         oTPZ1dbLBiWMgAQh5YS2l356hr5ZgIst2gntqWOcQAWinUTRaTGORjJ+6Tiz52Cot7xZ
         1BtQ==
X-Gm-Message-State: AFqh2krf8zqL9WOcL+/z0pcsKV4PNYjsaYkbZBpr1r2lXV2aoj78Vuhx
        O66QItm53tqYBrMtMfdxAg==
X-Google-Smtp-Source: AMrXdXtJ9Hc6xSNFXIXyN/NZ/8XRuK8JDpzti/x/t7iLm86yGhXfW5m3KZ4+rQbjzmzC3AT4qN3p0g==
X-Received: by 2002:a05:6808:404b:b0:36c:cc25:8bc4 with SMTP id cz11-20020a056808404b00b0036ccc258bc4mr9393700oib.26.1674508838860;
        Mon, 23 Jan 2023 13:20:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o8-20020a0568080bc800b003646062e83bsm218464oik.29.2023.01.23.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:20:38 -0800 (PST)
Received: (nullmailer pid 2659455 invoked by uid 1000);
        Mon, 23 Jan 2023 21:20:37 -0000
Date:   Mon, 23 Jan 2023 15:20:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?=2C?=linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, Sean Paul <sean@poorly.run>,
        freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ", Kevin Hilman" <khilman@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH] dt-bindings: drop type for operating-points-v2
Message-ID: <167450883575.2659375.17323544164739111670.robh@kernel.org>
References: <20230119131033.117324-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119131033.117324-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jan 2023 14:10:33 +0100, Krzysztof Kozlowski wrote:
> The type for operating-points-v2 property is coming from dtschema
> (/schemas/opp/opp.yaml), so individual bindings can just use simple
> "true".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on my pull request, at least logically:
> https://github.com/devicetree-org/dt-schema/pull/95
> 
> Patch could be applied in parallel but only if above PULL is
> accepted/correct.
> ---
>  .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml  | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml  | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml | 3 +--
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml  | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml  | 3 +--
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml   | 3 +--
>  .../devicetree/bindings/fuse/nvidia,tegra20-fuse.yaml          | 3 +--
>  .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml          | 3 +--
>  Documentation/devicetree/bindings/power/power-domain.yaml      | 3 ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml  | 3 +--
>  15 files changed, 14 insertions(+), 31 deletions(-)
> 

Applied, thanks!
