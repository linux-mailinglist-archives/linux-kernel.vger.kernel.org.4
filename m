Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740A5F6F46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiJFUh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJFUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:37:53 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A304BEFBC;
        Thu,  6 Oct 2022 13:37:53 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id o64so3339132oib.12;
        Thu, 06 Oct 2022 13:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsJf1jIE/km10hvxy0ZEFbMCeQkg6zPVruRq/QiL3As=;
        b=HG9doz3EVx3v9yPY1rjwlJ29QMzysNf3tTaEnRN30Fv2Ws8B+/F4oSPVU/LKKW5jzI
         4IDOawY9nQYPKAaqPF5dsgH+VhYpiNovWBhta1vPYaQSPxGXU+ueGu20zXUuTPXUaQkD
         kJ7gZzTip9DDTZ77dmrIrX1bdBqsM/jmq/07GerQVlu9WjlEtPQFjAT/dRzq3ZV+DzPu
         qk6RzaGbuPN+Pe8xeZ+CKHQwKiQqX5t3PNbzIrO9Og/OwRFs+emom6+lwXvzlMIr+BkP
         bVX+mx/AwkAQioNY1yNaiyTCAWhxSPQpvY1ESJxVgD8ohJAPmvK1FYK0RBDkzLz+/Zwp
         DUvg==
X-Gm-Message-State: ACrzQf2Kd3FdJhEyjs6pu6VLX1nZSFZaMleDWBHFnRnXZSpSx06Y6IA3
        fE6TPWYGVkjHJ9kzmBvINQ==
X-Google-Smtp-Source: AMsMyM67QDTjUkunwomU35Qc4A34Fx4QSKIada0gjkh1BrTX92A/hC/mhx53aWbRN7/rLdYFYfv1HQ==
X-Received: by 2002:a05:6808:10c4:b0:354:1f74:c8fb with SMTP id s4-20020a05680810c400b003541f74c8fbmr727003ois.143.1665088672387;
        Thu, 06 Oct 2022 13:37:52 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id q21-20020a056808201500b003515cc974a6sm98069oiw.14.2022.10.06.13.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:37:51 -0700 (PDT)
Received: (nullmailer pid 115711 invoked by uid 1000);
        Thu, 06 Oct 2022 20:37:42 -0000
Date:   Thu, 6 Oct 2022 15:37:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-gpio@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 18/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: minor
 style cleanups
Message-ID: <166508866106.115662.9779033067332314980.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-19-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-19-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:21 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml           | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
