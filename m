Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407E45ED190
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiI1ASE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI1AR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:17:58 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5E1003B6;
        Tue, 27 Sep 2022 17:17:55 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id q10so6130048oib.5;
        Tue, 27 Sep 2022 17:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2EUSaBhhoVGUvVWSWIwrsdm4Yqn4IkEOris8uMOD3+s=;
        b=FEruYSfdPmVx+ZxlXrosYsP+lS3wOtpr0hUs34DJnMXbK/FslMZjALKxbohALYhqPU
         Lr/HdyLygr60N3+fGlo2EqPk985uC5C0dA6PzCm1eZzss04r9DsFXq5wB8+7rTNOigEL
         Blfgxk+AouqYT5ChY8GtFn/7C0UooqjhWN9AIYrUwDlKu+Hcy0wOFGVhPBcdnobwvA6v
         7t3o+20EupGZKGIO5d4FrCCp9GZw3uszwt6lAP1XS/IhGfqAQkC5gysfmE0k/YB1Ey8U
         7P9XFsghFJzvcsJybF1ME9+byGA2YZw5TN2qo7BPW+fUi8xxGgCSA8J7DfNZoL8Ein2N
         mOsw==
X-Gm-Message-State: ACrzQf2IozK90gt18i03YtfT5rdUcgpaPE++TkOaGWNWUaZ7/V7cOjVu
        B4AX6PmB0HCyoRAnieCxFp5z6rFI0Q==
X-Google-Smtp-Source: AMsMyM6aZI8cqhjnFcG/Pr5UlAMFxAXfH9yPNio4vLPqZ8fgwepUtxzZ6HCOMouqnmew3zeTdGwZkw==
X-Received: by 2002:a05:6808:211d:b0:34f:e0fc:6e6e with SMTP id r29-20020a056808211d00b0034fe0fc6e6emr3168276oiw.8.1664324274496;
        Tue, 27 Sep 2022 17:17:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 31-20020a9d06a2000000b00655fd5b878fsm1366253otx.74.2022.09.27.17.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:17:53 -0700 (PDT)
Received: (nullmailer pid 2665090 invoked by uid 1000);
        Wed, 28 Sep 2022 00:17:53 -0000
Date:   Tue, 27 Sep 2022 19:17:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: Re: [PATCH v3 12/34] dt-bindings: pinctrl: qcom,ipq6018: use common
 TLMM schema
Message-ID: <20220928001753.GA2665002-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-13-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:40 +0200, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring other
> regular schemas and additional checks, like function required only for
> GPIOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> ---
> 
> v1 was reviewed by Rob, but patch was changed since that time, so not
> adding Rob's tag.
> ---
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
