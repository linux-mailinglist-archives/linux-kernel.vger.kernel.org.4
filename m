Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B505EFE81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiI2URH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiI2URE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:17:04 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A611FD899;
        Thu, 29 Sep 2022 13:17:02 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-127dca21a7dso3113623fac.12;
        Thu, 29 Sep 2022 13:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DHcUoF642UjY4b9zFuvNe9ZKuSX/wgdy0rJmGIHFZD8=;
        b=VnzEr4VIpm/kTMbBNCFX6Tdj3vTiiKlDm3f/Y+cAlBhsleDdgVdZ3rYAI4rB6bXEe9
         KynuMToGIbkIrXwTbHmhGxwbq9g9CfMW/LTCKufTQNN5UCRLk2001vVJbp08IlmC7Z24
         4Fbot+u1VCLkz7Kp8Q4AlfNIQ7tlKRbAkcT8s/pQI36t9WAkbVRuwv+RibTTSrzgIdm8
         TQrKmNlZDa8eR1w4LTaUaAjKAJ/vMVWKRUmcVGUEOH2pH6zFE5BT2caQY9C/SCBbXopS
         KvzyeTRhSa7tTxK/71AcjXU75+002peBDlfSaRxiJzupvwWcI7n+1HAZ3KmR4BLHb9eR
         ddGQ==
X-Gm-Message-State: ACrzQf1yMVID6H2Tzp9sN3QZY1dho4MUUmcj/nO6u4ANtXc07BnvfHiu
        eSPin+9uEjltVOAGFxkYew==
X-Google-Smtp-Source: AMsMyM4DDn4+cxL8AV9ZiCMByxzLdWuxaFtY470LMEMTmZULBBKoY7hN21aIAiNCqBJ+Erksv9kgGQ==
X-Received: by 2002:a05:6870:c1d4:b0:127:9423:22b8 with SMTP id i20-20020a056870c1d400b00127942322b8mr2907208oad.123.1664482621907;
        Thu, 29 Sep 2022 13:17:01 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a9d7cc2000000b0065af1b094dasm153010otn.28.2022.09.29.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:17:01 -0700 (PDT)
Received: (nullmailer pid 2667460 invoked by uid 1000);
        Thu, 29 Sep 2022 20:17:00 -0000
Date:   Thu, 29 Sep 2022 15:17:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 14/15] dt-bindings: pinctrl: qcom,sc7280: add
 bias-bus-hold and input-enable
Message-ID: <166448262021.2667399.11748308749284081486.robh@kernel.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925110608.145728-15-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 13:06:07 +0200, Krzysztof Kozlowski wrote:
> The SC7280 pinctrl driver supports bias-bus-hold and input-enable, and
> DTS already use it (sc7280-idp).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
