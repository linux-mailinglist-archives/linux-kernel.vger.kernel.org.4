Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87E5F6E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiJFUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFUFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:05:30 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C668B5171;
        Thu,  6 Oct 2022 13:05:30 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w70so3296091oie.2;
        Thu, 06 Oct 2022 13:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pJH4PuTjBuoWmRihPf+t/jCmt8a+4/g7Af5wjTdXEM=;
        b=53Cp7wvbJkMXMlMZm4ZWr3H4v/VZIGPc7cBlmhikUTJw7MH0UHJVRKzOsTRKxKnIam
         2SBgqH26NsZHqJaP9ZL5Z3iZQWAXKfbaJSm3XhFmsEB7g7wwx/TzMNysTtP4zMQKHHLd
         q9e7uvJdKdqGscR4F/wAE6IsintM4dvn72OV4jmg1zrjPrwfGnje1t7YksVu/6QCxUCU
         d7JmmL7bo1IdTrH/3Haby1mfz1sAYlUm7KNJwgXgidVmQZdVzmL9LQvLSJM/Q5YZYEFq
         kFz4AaXKcEBG4tMJIRyG2Uh+rZfB1s6lqX1Iav3SFesXZZOvzLDXdcQHMi1pswQ9U7Z6
         PMSQ==
X-Gm-Message-State: ACrzQf3/tOp23Wsx4aL+USge7HK/wzhg61akD8zWxr8kXEMGEY3PhTxt
        F/61ISARJ8KW46Fik1k2kA==
X-Google-Smtp-Source: AMsMyM6MPRvfPqvI2vExExGRa1lwJqmLSVRATOQPJ/DAK/Z5xSR06U0pHHn4GRWU8UIJ+GfZxlzqXg==
X-Received: by 2002:a05:6808:11c8:b0:353:f092:f11b with SMTP id p8-20020a05680811c800b00353f092f11bmr641084oiv.239.1665086729360;
        Thu, 06 Oct 2022 13:05:29 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id h13-20020a056870538d00b00127ba61535fsm319188oan.15.2022.10.06.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:05:28 -0700 (PDT)
Received: (nullmailer pid 87333 invoked by uid 1000);
        Thu, 06 Oct 2022 20:05:26 -0000
Date:   Thu, 6 Oct 2022 15:05:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: soc: qcom: ipc-rpm: refer to
 qcom,ipc-rpm-regulator.yaml
Message-ID: <20221006200526.GA86823-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-6-0cbc006e2a30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-6-0cbc006e2a30@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:58:03AM +0000, Neil Armstrong wrote:
> Now we have bindings for the expected regulators subnode, refer
> to the right qcom,ipc-rpm-regulator.yaml bindings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> index d416950189d1..d18200d5c5b5 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> @@ -47,7 +47,7 @@ properties:
>  
>    regulators:
>      type: object
> -    $ref: /schemas/regulator/regulator.yaml#
> +    $ref: /schemas/regulator/qcom,ipc-rpm-regulator.yaml#

Just reorder your patches.

Rob
