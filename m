Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8162C0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiKPOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiKPOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:33:02 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACF5167F5;
        Wed, 16 Nov 2022 06:33:01 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1322d768ba7so20262934fac.5;
        Wed, 16 Nov 2022 06:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqn+VpkyaVOXbC/hpj4uzzFiJO18ERrQThzp4BwoimE=;
        b=ZekgsNM85Sz2y2IdV+7yCnMV0Hl6QaIWi1XDvlpiz+FfzgmaDpY3qW8JGGW7In4vzN
         HARuZCJgAmBtLwDsQrOO6zO4TfuHMshk16XTD5ltKdCmOyMe3DtzFGHDxo4YtZ72r08A
         ooq795GfVrnq1GnEbUAQ6cHTtVjo6lrNOhkBYe81O+CBYQdHBYkFWR51MJB1JbOz4unx
         SGxs4Py0yjuFvi9GC3UmEK5VhNCaJbYs/vzXuaRUQFvyXSKmnrWHaDuiag+HGodkuT7S
         ORboALmjolvnopJ4gS+m8BoZumeOFuThO2Z56V5yUNwgdvrFAI+LtvG46DEjT+leT1ok
         VwZg==
X-Gm-Message-State: ANoB5plrWrSNwlH7PzptTk6nmGtLOfgWJisHkcyWK5YxJF47Wnyn3gfS
        aHybgHqjzTtdeWpHu0TaRg==
X-Google-Smtp-Source: AA0mqf5NVHnziasxHfj1GRbI3eGEGLdHD1pPC8kYFKj0a6d/3z5N2SnKoAZ8ZP7XBjj9cphDIrTRJA==
X-Received: by 2002:a05:6870:b94:b0:131:842a:110c with SMTP id lg20-20020a0568700b9400b00131842a110cmr1864268oab.201.1668609180804;
        Wed, 16 Nov 2022 06:33:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a056830101a00b00667ff6b7e9esm6781696otp.40.2022.11.16.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:33:00 -0800 (PST)
Received: (nullmailer pid 3809684 invoked by uid 1000);
        Wed, 16 Nov 2022 14:33:02 -0000
Date:   Wed, 16 Nov 2022 08:33:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     quic_srivasam@quicinc.com, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, quic_plai@quicinc.com,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 02/11] ASoC: dt-bindings: qcom,apr: Split services to
 shared schema
Message-ID: <166860918054.3809609.16135727023403702366.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:26 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR nodes are organized like:
> 
>   apr-or-gpr-device-node <- qcom,apr.yaml
>     apr-gpr-service@[0-9] <- qcom,apr.yaml
>       service-specific-components <- /schemas/sound/qcom,q6*.yaml
> 
> The schema for services (apr-gpr-service@[0-9]) already grows
> considerably and is still quite not specific.  It allows several
> incorrect combinations, like adding a clock-controller to a APM device.
> Restricting it would complicate the schema even more.  Bringing new
> support for sound on Qualcomm SM8450 and SC8280XP SoC would grow it as
> well.
> 
> Simplify the qcom,apr.yaml by splitting the services to a shared file
> which will be:
> 1. Referenced by qcom,apr.yaml with additionalProperties:true,
> 2. Referenced by specific bindings for services with
>    additionalProperties:false (not yet in this commit).
> 
> While moving the code, add also required 'reg' and
> 'qcom,protection-domain' to further constrain the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Keep compatibles in qcom,apr.yaml
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/soc/qcom/qcom,apr-services.yaml  | 54 ++++++++++
>  .../bindings/soc/qcom/qcom,apr.yaml           | 98 +------------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 58 insertions(+), 96 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
