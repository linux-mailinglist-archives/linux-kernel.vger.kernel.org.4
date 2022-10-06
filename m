Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C378F5F6FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiJFUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiJFUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:50:06 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB6E0C5;
        Thu,  6 Oct 2022 13:49:45 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id g130so3360602oia.13;
        Thu, 06 Oct 2022 13:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjy3Wn4VL8giwQ9VaXKyDJbUJ669VnerhMJ2vJNsjIo=;
        b=1zPk/EVfbBOUckh8FkVBLIb9AcJjVgkDqGLKNuRVn0vULSxAziYF35U1pgoKfW8t6S
         MAgzrtnCT2/mjxIxXMc3gkvbhEYL0TMGq1FOdreFruvJ02At4pJP18IuRBHJUefjRTl4
         Ny80kT8C06BImunDA5/vr1k36s/dDPbnUltf/LEL5SzvYQpWxLzuu3S59kO/WP/WwB/P
         9qHL8GJa8dsnJ9+roXLAvVs5X2Hgjy1YaSShLZpL2haT2pJDtxjipyUhcF2jfCoui+QB
         QVxCn5XlKxvUXzNKG9huwh1kx9m917vliAcHjEkvEhpq3dR2wg5EL8LMU5lgfY9ZnAOg
         nzpw==
X-Gm-Message-State: ACrzQf3+2lrlBkxomdW4pFGq4/HNJLqyZLZS2QHJ/XSkn36irOXsJpqY
        Pdss8cJkThDlbfJCGITbww==
X-Google-Smtp-Source: AMsMyM6+lM0KhR4dcDRl7C/EhJH/NX3Bz4PutWLN7oRWMt4cljgNlhjZvWiUmepMF9EZUXbjrmSq9A==
X-Received: by 2002:a05:6808:f8c:b0:350:e776:b755 with SMTP id o12-20020a0568080f8c00b00350e776b755mr748729oiw.45.1665089367653;
        Thu, 06 Oct 2022 13:49:27 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id i2-20020a056808054200b003450abf4404sm100155oig.21.2022.10.06.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:49:26 -0700 (PDT)
Received: (nullmailer pid 126982 invoked by uid 1000);
        Thu, 06 Oct 2022 20:49:24 -0000
Date:   Thu, 6 Oct 2022 15:49:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 34/34] dt-bindings: pinctrl: qcom: adjust description
Message-ID: <166508936381.126921.17861755552348808832.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-35-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-35-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:37 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description, because the field should describe the
> hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    | 5 ++---
>  .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml    | 5 ++---
>  .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml    | 5 ++---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml     | 5 ++---
>  .../devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml    | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml      | 5 ++---
>  6 files changed, 11 insertions(+), 16 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
