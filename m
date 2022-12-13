Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059C64B908
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiLMP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiLMP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:57:29 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF91F61E;
        Tue, 13 Dec 2022 07:57:26 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so13072558fac.2;
        Tue, 13 Dec 2022 07:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/0ZaUd0WEu1InS6OXlcKOnl3jQcBGpJUNfyPLpGBMo=;
        b=P/0g686pBWqVDGJjBGkR1OdUmI+BqIfi7LUGq+RI9gZfJVCCA0CBW0LtoycifUEidt
         W5I+t6CiW2NMATqp0AChox/fPzTwdKqYYXcG7Ph8SNPk+Z3NFTWARmeNH9SauSVaelo8
         BQ6SpJqdebbj0GwBxtAzkjvtPUIUobDZLsxtDa7LUT6frAIHQ6l5Qjy1mShn4k95I08z
         Zj8ioiBheyyohRDdb3YMMfBu0H9nUeV2QxL3GJr17bVpQzPA0TDvXYEN9L2kMiV/J81i
         uD0KDoG15HSgUtPUQ6t2jOQKF77dCokf4IKu13x0NBKYm+PCg1wQCmAuBgzmjhLryEwi
         Qjtw==
X-Gm-Message-State: ANoB5pmzeRP7ya9G5osZG5+uMXXeKIF2tVFTq3Ge6b0MXOJK3xyaLJxU
        zrBEetv1dcA0Rzw/aKdC6g==
X-Google-Smtp-Source: AA0mqf6zrg1ETDHNCsPI/wvimmyIqmVOxGMO3hbvItrj2UrTfNoRmS5KXMb8Y6TvVbKC2lIIb/3kHg==
X-Received: by 2002:a05:6870:514d:b0:143:c900:521b with SMTP id z13-20020a056870514d00b00143c900521bmr9894704oak.0.1670947045989;
        Tue, 13 Dec 2022 07:57:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020a056870439300b0014474019e50sm1553616oah.24.2022.12.13.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:57:25 -0800 (PST)
Received: (nullmailer pid 1681578 invoked by uid 1000);
        Tue, 13 Dec 2022 15:57:25 -0000
Date:   Tue, 13 Dec 2022 09:57:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH] dt-bindings: watchdog: allow "timer" as node name
Message-ID: <167094704439.1681253.14474697830592674495.robh@kernel.org>
References: <20221212174933.208900-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212174933.208900-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 12 Dec 2022 18:49:33 +0100, Krzysztof Kozlowski wrote:
> On some SoCs the watchdog device is actually mixed with timer, e.g.
> the qcom,msm-timer on older Qualcomm SoCs where this is actually one
> hardware block responsible for both system timer and watchdog.
> 
> Allow calling such device nodes as "timer".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> See also:
> https://lore.kernel.org/linux-arm-msm/20221212163532.142533-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> which causes warnings:
> 
> qcom-msm8960-cdp.dtb: timer@200a000: $nodename:0: 'timer@200a000' does not match '^watchdog(@.*|-[0-9a-f])?$'
>   From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
