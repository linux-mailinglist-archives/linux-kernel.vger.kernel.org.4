Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E0E5F6F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiJFUmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiJFUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:42:29 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CBFF8EB;
        Thu,  6 Oct 2022 13:42:15 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id n83so3355055oif.11;
        Thu, 06 Oct 2022 13:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg+Uo1zpi1C5p+UKCGILEDIgQu1mRxcSKD12TP8yRcE=;
        b=Bh7KC0vrS4r7m037LHsOrVWYntQ5pOoDefCL8Ys75wmmwpeY/mJuyGDv8zWH8UWfFO
         PRmfwITX9iJ4Se9nLUSVu6/70JcLZv0mMH398U+aZe+SyXYrVAESKkCWZ9KnNKl/sZFR
         CQbqoJE//bGH2E8l1GgW1YCMjrDlZzGWHgMgWLD+H8gCVddQLPAZe9fR+2ajV1SMqBGK
         8c4JGSuvsw83vtJZGSlhnDDhuXiIVKZZQjte08Jwd3TLD/iCtq/CuuXTSZ7PY/p6jlKs
         4QMkZap3i2TDDyw1CjYBlCuk9OPbxAqvXURIbD21dDCXqN/aAh/j1xv/wEQMWyfHnplt
         LP8A==
X-Gm-Message-State: ACrzQf2hlSGC+sGJEYB7IiWWP+TTYfXv/eF4Q2DeTUK7pWfU8JaV122h
        LtsUJ4uXNshRTeW44yG/dA==
X-Google-Smtp-Source: AMsMyM4CUb8wzpAUKrWbU2uyyVArNB2BRnMnsn/WOfipPuCJijr4UwWO8razHhWKkDg0Z97H7t9Y2A==
X-Received: by 2002:a05:6808:1447:b0:350:a9db:d721 with SMTP id x7-20020a056808144700b00350a9dbd721mr5795220oiv.33.1665088923612;
        Thu, 06 Oct 2022 13:42:03 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d550f000000b006393ea22c1csm307622oth.16.2022.10.06.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:42:02 -0700 (PDT)
Received: (nullmailer pid 120810 invoked by uid 1000);
        Thu, 06 Oct 2022 20:41:56 -0000
Date:   Thu, 6 Oct 2022 15:41:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-gpio@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 32/34] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi:
 minor style cleanups
Message-ID: <166508890253.120586.9547541955788820065.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-33-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-33-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:35 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml    | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
