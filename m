Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014175F6EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiJFUYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiJFUY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:24:26 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A4C45A5;
        Thu,  6 Oct 2022 13:24:23 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id g130so3291271oia.13;
        Thu, 06 Oct 2022 13:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scRAT74lgavRW7SzbNbUGr+QJSU90dPHxJUHNsKshuw=;
        b=DQVoV6nZECXvuU4y4cLrFt7yVlhFMFbCyO7PsTUJ4nVPmNJSIIpo88i3BHwzFya5rp
         B14bD9N0Uw/sFOUneZcZV/Lc9U4t/exZH4fdMrtVmEArtmSg89j9wMuInfiKGnlntgTp
         XrOAiiJkX7kdhTIpxI86OSl3dye+y/3OfaYkhoYzqZSxCHo5NUYDLmRHZ52mWW52w+N+
         2OeRtNB0AM4KEF5B1s6aGx83Z8jYS6nGeZLBL7jg1LvFRhRUHUck3PWu3ceLAF4OPg0m
         2fxcHdeaZ6Nqvibp3pJLfXSCRmpXgXncykdaekildC+ssockoZjq9IH2gFdFWVHhQTlE
         ltwA==
X-Gm-Message-State: ACrzQf24DJ5+v2CfmBM7whAghgj9bDOie9N8R0rTN77scltnWXwYPaGk
        klhf7HbU8porSHY4EkuTtA==
X-Google-Smtp-Source: AMsMyM7beGP61n1gYR6nTvDd3n0zJuKEfSlOFVH2O9ZnGMbJWLMIhlPEo2n5Ub2qLFu906t8k8Ka2Q==
X-Received: by 2002:a05:6808:d4d:b0:350:d8e8:9039 with SMTP id w13-20020a0568080d4d00b00350d8e89039mr6100901oik.274.1665087862579;
        Thu, 06 Oct 2022 13:24:22 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id w2-20020a056870430200b00127ebb410a4sm354305oah.11.2022.10.06.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:24:22 -0700 (PDT)
Received: (nullmailer pid 103591 invoked by uid 1000);
        Thu, 06 Oct 2022 20:24:20 -0000
Date:   Thu, 6 Oct 2022 15:24:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 05/34] dt-bindings: pinctrl: qcom,sc8280xp: drop checks
 used in common TLMM
Message-ID: <166508785674.103489.4658007345170895985.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:08 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml       | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
