Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD15F6F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiJFUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiJFUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:38:27 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A22C34C1;
        Thu,  6 Oct 2022 13:38:26 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1324e7a1284so3519173fac.10;
        Thu, 06 Oct 2022 13:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDkCCj+BXuCoh9ws9yDxBp245Pt/uyoExsdW4Zkcv7I=;
        b=0bTXFITmo3fWoJJCELB2dnsCeKBzh2MFUgh8G+kstJoZzyxYzEOOYM9DlpnvwVgZrd
         B3R5nk0FPNR7HkVHLJuCuwd05JYNGjz+CnLcv41udGiT84M6p9JCWyw8cn3sueqKxqZs
         mQ08pUGEyc23fO2MgCSu+ZksieAfMqJDlcTo3a4CPwJhlEvTi84WBlDsMaQQBhgrh+Dr
         bTNvBr6IngOodOflypscdOPFxdz5T4/UImg2lNJdGRLzfMWXZEb2M8FrsfdcbW4dK6So
         btQc4L3Y7gV4wXySVu3vCoL75d/R6q7QoxSE+lardXsTsXuH6gnHewu81ZVvkKFOd2Xm
         BnGQ==
X-Gm-Message-State: ACrzQf2b/ulnz6YnbOuP6rUw1PrEsVKdaRRIl/sXqDrnStE/Kybj4OlK
        DD9064iAGr5N+dOJlCSRRg==
X-Google-Smtp-Source: AMsMyM6KtWBg4F3XzgBcFZwZZGKAKgpp+u2x3EE0VRVSwWK5b3p+ETk86/CFSxVpbmnUkFeBnvQtnw==
X-Received: by 2002:a05:6870:51f:b0:130:fee6:8295 with SMTP id j31-20020a056870051f00b00130fee68295mr845674oao.49.1665088705932;
        Thu, 06 Oct 2022 13:38:25 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id 95-20020a9d0c68000000b00636fd78dd57sm287944otr.41.2022.10.06.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:38:25 -0700 (PDT)
Received: (nullmailer pid 116491 invoked by uid 1000);
        Thu, 06 Oct 2022 20:38:21 -0000
Date:   Thu, 6 Oct 2022 15:38:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 20/34] dt-bindings: pinctrl: qcom,sdx65: minor style
 cleanups
Message-ID: <166508870128.116448.17194775482109354224.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-21-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-21-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:23 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml           | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
