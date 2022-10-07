Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC75F7328
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJGDQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJGDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717909C201;
        Thu,  6 Oct 2022 20:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12C09B82188;
        Fri,  7 Oct 2022 03:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D185C433C1;
        Fri,  7 Oct 2022 03:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112561;
        bh=eDTbca+DTsLTKb8dhCgBmM5IFLLb0UhYFf9ErcNZz/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trv4uZlVCrk5gMftWjUSu4NOKbSsWnIzI0lPPf9zqvYHsaCWIHDpclBcT3f+L4ZhC
         4LGpQiGu16yR05CcSDVywN79g1wE6uonsNQLqEThtmCpO/0Cld+2/cmAcaamBgtWay
         pTRQIAihvR1V1hJRclINjLTYnSvp3nNKdOnMm2H3sKlONJblIa/Csg2rocbUEjp+/6
         XAO9EDBKlf+ypnHI+mQLolcaVRUGNoOX45f3KepMZZGS4ndUK5nB3Fnj5J31FaibUL
         oWMbD1SRCPh6XTfIbVAW9XdIObzp1ZzxHThnMZSzUHvs1+RAtxYClGD/O/8AIznM8T
         dyUvsWMgv7jYg==
Date:   Thu, 6 Oct 2022 22:15:59 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/16] dt-bindings: pinctrl: qcom,sm8250: drop checks
 used in common TLMM
Message-ID: <20221007031559.2rptlgxxgfwiqz57@builder.lan>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-13-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:29:50PM +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema brings already
> requirement of function for gpio pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> index d7d8e5d3b659..021592b32904 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> @@ -64,6 +64,7 @@ patternProperties:
>      if:
>        type: object
>      then:
> +      $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
>        properties:
>          pins:
>            description:
> @@ -118,16 +119,6 @@ patternProperties:
>        required:
>          - pins
>  
> -      allOf:
> -        - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> -        - if:
> -            properties:
> -              pins:
> -                pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
> -          then:
> -            required:
> -              - function
> -
>        additionalProperties: false
>  
>  allOf:
> -- 
> 2.34.1
> 
