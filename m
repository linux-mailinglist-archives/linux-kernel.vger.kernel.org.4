Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97945F734B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJGDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJGDUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:20:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62404115C2F;
        Thu,  6 Oct 2022 20:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C7C4B82188;
        Fri,  7 Oct 2022 03:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDA4C433C1;
        Fri,  7 Oct 2022 03:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112723;
        bh=VIRCARV4gIGvlbOIUNJTjqc5GfsC7pCcDdS4M+4yack=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6Eauuy4UH/9AcNPIArm8dP6MAw8uQ2qCtPExmACJ97QcM0AL9Q/uPXAlCJl6i/Bh
         ZgZVf5U233XrjrbtLBaqaCotvJTEfwzHvLYJXdjhz0EehRVS4m6Xv2ZG7bF4z8PekA
         LM8UQhTB8NBawC4/zGIg//RwrwcE4HaXzb9GZaP/M4Wcs4Zd/ZaEoMxAWL4C8yDbV5
         7hr/g9yoRjhFSPEBHBI/MIGBie8+fxe8mBR+s5jOmwgSB0E0NdSB8fDGtJprUE7cTV
         vweQeWqivC2Wlg7WfFHIwJMdgbWLghxcpe29WTMNr5k3fGlhZ43urFK15gXCyVxHa4
         mfai3tzsJAxfg==
Date:   Thu, 6 Oct 2022 22:18:40 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 16/16] dt-bindings: pinctrl: qcom,sc7280: correct
 number of GPIOs
Message-ID: <20221007031840.bce6x3put5zpcd67@builder.lan>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-17-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-17-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:29:54PM +0200, Krzysztof Kozlowski wrote:
> SC7280 has 175 GPIOs (gpio0-174), so correct size of gpio-line-names and
> narrow the pattern for matching pin names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> index 1db05c43d58c..2a6b5a719d18 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> @@ -43,7 +43,7 @@ properties:
>      maxItems: 1
>  
>    gpio-line-names:
> -    maxItems: 174
> +    maxItems: 175
>  
>    wakeup-parent: true
>  
> @@ -70,7 +70,7 @@ $defs:
>            subnode.
>          items:
>            oneOf:
> -            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9]|18[0-2])$"
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-4])$"
>              - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
>                        sdc2_cmd, sdc2_data, ufs_reset ]
>          minItems: 1
> @@ -132,7 +132,7 @@ $defs:
>        - if:
>            properties:
>              pins:
> -              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9]|18[0-2])$"
> +              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-4])$"
>          then:
>            required:
>              - function
> -- 
> 2.34.1
> 
