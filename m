Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165665F6EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiJFUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJFUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:22:26 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D6B489D;
        Thu,  6 Oct 2022 13:22:26 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q10so3320178oib.5;
        Thu, 06 Oct 2022 13:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X4NTfyW68xcDvOoHuC3UhXHTbFnsytgLqmsy3+1Fxo=;
        b=GYkkc69zavltCPGmdc0JrdSkiiOG5c6gE+gAlusdQ120FVUpIYn4vtTImyeaQ3cqR9
         z/hP/l6p2Jtu/4Hkeytt8HzNPBxcYqM8AI9lzdLde7ey0quwdB6YW5ESv1EWtru7VCWU
         13dfjWTjhjz7gu8QJdEGrz/1zhy8fXdktSGHMa/doNL363ueNqe5A56tJm2zAX22HEXi
         RCg6m8pGMVyiH1yT/0X9KZjbdwLxQu3sOsxhqKqwqSUbbN02Z3T4W37oX1MfqzoQfH0c
         67q49yEikmN1iXdRx3MUtYrgpKe3ssyNsjiihb4WeBCTDRdAnyB6GAffsWd2r9ZK1bPu
         d8eQ==
X-Gm-Message-State: ACrzQf0e/Br9Fhy1zglLDGMSgUwRfHiBTxalufstSg1ilZnvFVGethhy
        SSj9/SdB0O7RH+HRRY4Mmw==
X-Google-Smtp-Source: AMsMyM6B7tTkaENCdWFfpiMRWy1v2hVKVCkbDNcHdJPIYeKll39TOiHLcfZb4SDbyiBx4msHWvI9iQ==
X-Received: by 2002:a05:6808:13d0:b0:34f:f370:b581 with SMTP id d16-20020a05680813d000b0034ff370b581mr5539509oiw.148.1665087745440;
        Thu, 06 Oct 2022 13:22:25 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id e19-20020a544f13000000b00344a22e71a9sm81509oiy.9.2022.10.06.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:22:24 -0700 (PDT)
Received: (nullmailer pid 101469 invoked by uid 1000);
        Thu, 06 Oct 2022 20:22:23 -0000
Date:   Thu, 6 Oct 2022 15:22:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 01/34] dt-bindings: pinctrl: qcom,mdm9607: drop ref to
 pinctrl.yaml
Message-ID: <166508774217.101420.6342597727651083853.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:04 +0200, Krzysztof Kozlowski wrote:
> The binding references common Qualcomm TLMM pin controller schema, which
> references pinctrl.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml        | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
