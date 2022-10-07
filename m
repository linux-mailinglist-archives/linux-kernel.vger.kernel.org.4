Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C134D5F7324
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJGDPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGDPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E219C201;
        Thu,  6 Oct 2022 20:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B73AB821FF;
        Fri,  7 Oct 2022 03:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F1AC433D6;
        Fri,  7 Oct 2022 03:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112538;
        bh=dKACfu26QoQoyQY7gBU6r/J/IBoY9mBm8lL2GrckABQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQjPdruHO5jVmPfwoZt4yQZv55O2xOtEM2i2bzkUomjZFJswe48/7wKSIciktfVC2
         aJ4yd2cvlG524XYaokPToUJ6uEBJNfrv9Q0K5wcPC5Og+qykBL5RtPsjErY4v81EPE
         pmnXP6vFtMf4WX6E94JOr5TFOmoUZab6hC6rAymp/ygrWDDFkSRXgy+S/MWc4MEDcc
         zPXvIJyqXZVYz5CaA7s9wemo7dbgFsrmmePafpb+lg89/GoFlUjyItxZmYgLXbvJSy
         GY0c994z1Z5R/h+Uf+Gm3XrMqFAnT/8NRkjmJUY3X7xbipS+tKqp76SIak6wCt1Eaa
         zYk1gu+gHH7qQ==
Date:   Thu, 6 Oct 2022 22:15:35 -0500
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
Subject: Re: [PATCH v2 11/16] dt-bindings: pinctrl: qcom,sm8250: add
 gpio-reserved-ranges and gpio-line-names
Message-ID: <20221007031535.vultnzkxgznkcfzp@builder.lan>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:29:49PM +0200, Krzysztof Kozlowski wrote:
> Document common GPIO properties (gpio-reserved-ranges and
> gpio-line-names), already used on qrb5165-rb5 board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> index c44d02d28bc9..d7d8e5d3b659 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> @@ -49,6 +49,13 @@ properties:
>    gpio-ranges:
>      maxItems: 1
>  
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 90
> +
> +  gpio-line-names:
> +    maxItems: 180
> +
>    wakeup-parent: true
>  
>  #PIN CONFIGURATION NODES
> -- 
> 2.34.1
> 
