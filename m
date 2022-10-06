Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56F45F6EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiJFUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiJFUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:23:54 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934DFBB05B;
        Thu,  6 Oct 2022 13:23:53 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so2171886oog.12;
        Thu, 06 Oct 2022 13:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPWP0KpJA0aoYsscbImmg7JQPmBRUUzxOfR9nexD/6E=;
        b=rFbL/1+txViTLMg5xTCrkZ9lAjvFFdazAcZRLKJMD6TPOR7DQ3jkRxK3iEczUOtYRB
         VtftUotsHgiMFdSzaeiOabMrq1m7ZdQObZQcZPh6mujAbfOazaM6ZSdlpel/Z6fZa+JP
         X+T2R5dMHWhCRBIXKINN6zBLIxgzfsQHscULB67LnrhoCuxUzIJQ1lj8bXH8n1U2G/uf
         ziGuRuZmL5MMK55GDkwy2TdaoGYZfX1bCBGduixz4R9ZgXlZl16OivuMuhkC0kX01Djc
         judImh3nKIsZYRvllfwAKU3idT8PuWPujQJ5nbEglLaADxgJSP6SFxkaHNcg/2x/4A1R
         mTiA==
X-Gm-Message-State: ACrzQf129iJUtVt4tUJiPW/toaCqh6TT5DedwSb7mHbNIbmI4zhIgLC6
        9unoMsI8NgwzGugAimijLA==
X-Google-Smtp-Source: AMsMyM7HU3angDBdVcDFOit/ekZpr32kKnybQYOQhrjY4p9dBC35ZruKxKPJJpLRHxFIrU8uWXqyIw==
X-Received: by 2002:a05:6830:b85:b0:655:d942:251c with SMTP id a5-20020a0568300b8500b00655d942251cmr685992otv.195.1665087832875;
        Thu, 06 Oct 2022 13:23:52 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id n126-20020acabd84000000b003512f3195d7sm72546oif.30.2022.10.06.13.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:23:52 -0700 (PDT)
Received: (nullmailer pid 103068 invoked by uid 1000);
        Thu, 06 Oct 2022 20:23:51 -0000
Date:   Thu, 6 Oct 2022 15:23:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 04/34] dt-bindings: pinctrl: qcom,sc8180x: drop checks
 used in common TLMM
Message-ID: <166508782473.102940.7577744025713263258.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:07 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml        | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
