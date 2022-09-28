Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50B5ED1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiI1ATQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiI1ATF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:19:05 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDC100ABD;
        Tue, 27 Sep 2022 17:19:00 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id d64so13680085oia.9;
        Tue, 27 Sep 2022 17:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=h+mIOqSS/RXKWNv5Wg+YqLL9a/fJd6nLXRavL2sAG3Q=;
        b=UAebV6n7zB4V19lBzyOCoRJRK4BwS5NuS6g8weY4YueFMtZhAh6tJD6W/31jjJZsAS
         9sJqsz1viUWo/UcPfH2sh0Hc9efA+oXdVIvl/Fn5orGSyJztRU2ajN254Aray+QsYiVN
         Bf+0lFHGETcbDEIeznqR/sfwffeTl54QM0qD6C4p6r5+AD231yc6qeplWEldRcg6RYBe
         20iQzvX/b2Dy7tCS9d3szCFoS9svGGutnGa4nIb/Yvoe6SLY6BJDJO83yiFpA18Lsw/2
         H8C32j0wY17uLBPKo/+Q8KyP9UWD0fqfOkFf5w0DKrD1AUPsqOwo0w/PTpbmUI9N5hjC
         euzw==
X-Gm-Message-State: ACrzQf2NXfSMxp9DKPaHRDVfd5cQE6hu/tNgXRlAnqhrFbitoeSYQogK
        dcQ/TAuZcrZmuyB2PJc9nA==
X-Google-Smtp-Source: AMsMyM72N5FFnGpi0MrKuOxFAdQHp/qQBBr1t6NbgcVx/to/uAwjxNI8iJynaCbqkNX/KKoVqT48Kw==
X-Received: by 2002:aca:240a:0:b0:350:dfdf:233d with SMTP id n10-20020aca240a000000b00350dfdf233dmr3056859oic.37.1664324339006;
        Tue, 27 Sep 2022 17:18:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x23-20020a9d6297000000b00655bb503564sm1319448otk.50.2022.09.27.17.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:18:58 -0700 (PDT)
Received: (nullmailer pid 2673015 invoked by uid 1000);
        Wed, 28 Sep 2022 00:18:57 -0000
Date:   Tue, 27 Sep 2022 19:18:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: Re: [PATCH v3 16/34] dt-bindings: pinctrl: qcom,msm8226: add
 functions and input-enable
Message-ID: <20220928001857.GA2672959-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-17-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-17-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:44 +0200, Krzysztof Kozlowski wrote:
> The MSM8226 pinctrl driver supports input-enable, blsp_i2c4, blsp_uart4
> and sdc3 functions and DTS already uses it:
> 
>   qcom-msm8226-samsung-s3ve3g.dtb: pinctrl@fd510000: 'blsp1-i2c1', 'blsp1-i2c2', 'blsp1-i2c3', 'blsp1-i2c4', 'blsp1-i2c5' ...
>   qcom-apq8026-lg-lenok.dtb: pinctrl@fd510000: touch-state: 'oneOf' conditional failed, one must be fixed:
>     'input-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml         | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
