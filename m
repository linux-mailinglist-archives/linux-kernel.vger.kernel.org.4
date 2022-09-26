Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809755EB541
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiIZXPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIZXPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:15:11 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB76429;
        Mon, 26 Sep 2022 16:15:07 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id m130so10096994oif.6;
        Mon, 26 Sep 2022 16:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Vz68Lk2kxrzVR9ZcDrB+1WM7IQNoKfKua8tQt/LiNtw=;
        b=J/VBjbDGvpyQGO3RWBGOUZdmBaV4lUm98QoKMBamYk48RzxSz5WwTk56ZpY1164sg1
         mSx1XTOZT6M/c/q9syGmk2sUZ8eSpn0xJCQDjBWO1bRJmwDAV9hnN7cKMrfiQ2OTustT
         IzWO84GHfoIpyOcIfyphGPbHur+V3CjoLIYP2aCHJLZhKndfEuuqu+v2jEwFqpbAu8qT
         b7Y+7dqFUmG1WfFkNY17oN3xv1QU5G32dsvIZJxDCuC4xEQMkeKw4pC7ZeYiz1HQc5Nc
         PNbjMVZRYtjOBDCUTaFH1AVds9ZuMGfja41SahFCQDgMCXyyNvLYXvY1MGLvyY3PysuW
         1vrA==
X-Gm-Message-State: ACrzQf3/po4AprZmG8GSmgRRIM2xjrHruBfiahHkVW5gn0KsvYJP5Z/f
        49XWM6vZEhp6KGUPML1p/Q==
X-Google-Smtp-Source: AMsMyM73qzv/hD5AQvnFp6+wEO9RP64apZTcvTj0Uezwme+910XQ+Sc15BeMKY41Viol+ydX0XIaIg==
X-Received: by 2002:a05:6808:a01:b0:350:4832:2902 with SMTP id n1-20020a0568080a0100b0035048322902mr532451oij.163.1664234106634;
        Mon, 26 Sep 2022 16:15:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g20-20020a544f94000000b00344f28a7a4csm5669058oiy.22.2022.09.26.16.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:15:06 -0700 (PDT)
Received: (nullmailer pid 3150610 invoked by uid 1000);
        Mon, 26 Sep 2022 23:15:05 -0000
Date:   Mon, 26 Sep 2022 18:15:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/32] dt-bindings: pinctrl: qcom,qcm2290: do not require
 function on non-GPIOs
Message-ID: <20220926231505.GA3149014-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-26-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-26-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 10:04:52AM +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml        | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
> index 5324b61eb4f7..89453cb60c12 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
> @@ -60,7 +60,6 @@ patternProperties:
>      description:
>        Pinctrl node's client devices use subnodes for desired pin configuration.
>        Client device subnodes use below standard properties.
> -    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
>  
>      properties:
>        pins:
> @@ -116,6 +115,16 @@ patternProperties:
>      required:
>        - pins
>  
> +    allOf:
> +      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"

You can drop the quotes here.

> +      - if:
> +          properties:
> +            pins:
> +              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-6])$"
> +        then:
> +          required:
> +            - function
> +
>      additionalProperties: false
>  
>  allOf:
> -- 
> 2.34.1
> 
> 
