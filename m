Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106F25F6F82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiJFUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiJFUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:41:34 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6AC4C3A;
        Thu,  6 Oct 2022 13:41:31 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1326637be6eso3515267fac.13;
        Thu, 06 Oct 2022 13:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVBlQF1+B3iU9TZXZJDszDUu8RzYLbOyAR5llGh2m8c=;
        b=2hbGtCerPtWuQk1sapyuDzldGDeOYImkErM89LdsIYSHqlvqOhzVhJj5JNz8CFFFOF
         CmX0eQxSnUO1kxguqOcoeGBLd6tGOxRp07OnRPz2dzinr+5OG7+iAQI/GwiJEoGzLSJu
         YHAsKiwM4df7w0hewXzWaTvTrdEIJZuPvFKAVki1TpPMxPx+9cuJg/d//nR97GatYGtQ
         Rkk+MR0XPa6VQhDcKG9A3HOT92N/F172GdXEI7n1H+5UyZfsEwTqNw2K3+gTYurvdqst
         KEjNdEQmP1ualoEzSRcw/iruS79b1Vq9mmudI55pKFwJ3SnkdbKFHTgG0ujJuGrxs8T7
         Muuw==
X-Gm-Message-State: ACrzQf3HqLtUE/O2WYyRNmn/nq1RSSJ7Mj9CX3CyU7ZuVNmg/NJ5AhiK
        PCIF7ciEgCrxl0qNUfa4sA==
X-Google-Smtp-Source: AMsMyM4tLan0J/A4EqL5fqEqM4sDwAubOunq3a2AoWzebw71vvAPQvnNqyz6pS0d0FDgZRG6lOEhIQ==
X-Received: by 2002:a05:6870:3128:b0:132:3030:9e59 with SMTP id v40-20020a056870312800b0013230309e59mr6483722oaa.246.1665088859573;
        Thu, 06 Oct 2022 13:40:59 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id x60-20020a9d37c2000000b006391adb6034sm245656otb.72.2022.10.06.13.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:40:58 -0700 (PDT)
Received: (nullmailer pid 119763 invoked by uid 1000);
        Thu, 06 Oct 2022 20:40:55 -0000
Date:   Thu, 6 Oct 2022 15:40:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 30/34] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor
 style cleanups
Message-ID: <166508885434.119704.2567049303157172057.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-31-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-31-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:33 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml      | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
