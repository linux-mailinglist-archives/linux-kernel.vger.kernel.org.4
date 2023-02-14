Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908AA696830
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjBNPg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:36:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E814231;
        Tue, 14 Feb 2023 07:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F9BDB81E17;
        Tue, 14 Feb 2023 15:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D953C433D2;
        Tue, 14 Feb 2023 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676388982;
        bh=SUUZC64r6jozYPFZgHOdcKJ2XL7T3VA4vV3vgcIkpZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8ubYdnPp+ayC/tfWvgz6Nra4BJzPHgJj5KDbiZBBzGo8d9piqINqrzDsfV/5RxQ5
         jlsu4ohRkyOXS+vdVjZReJv2kGfiXRlKAb7zOOfurqThNTWdkmGoTeTxpVjfq1WNbf
         w9NFXUkhwuvEpKRL07zIkaukxFh07ItJPmrfJpc0klt599BN+tGaoc3B8VoCX3ZcMQ
         FjT+wLhnuqlfFRwzBSiLIH4A9Q1616fVu3qse+hBWze7B8JSsAlsxUZ/Ch7IQbGqcX
         ldI5K1/UG3egqxzxwo5rVDR4Otl46XaxBysahq7C5ZjzFy6h7mw6oZvR8X0ygfnbhr
         85EjWc8RBDZ3Q==
Date:   Tue, 14 Feb 2023 21:06:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] dt-bindings: mfd: qcom,spmi-pmic: Add pattern
 property for phy
Message-ID: <Y+uqcb+CZUy/8GYh@matsya>
References: <20230208190200.2966723-1-abel.vesa@linaro.org>
 <20230208190200.2966723-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208190200.2966723-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-23, 21:01, Abel Vesa wrote:
> The phy pattern property will be used for providing eUSB2 repeater
> functionality. This will be modelled as a Qualcomm PHY driver.

Lee,

Can I get your ack and merge this thru phy tree


> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v4 is here:
> https://lore.kernel.org/all/20230207135551.1418637-3-abel.vesa@linaro.org/
> 
> Changes since v4:
>  * none
> 
> Changes since v3:
>  * made this the second patch rather than the first in the series
> 
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index adf88245c409..1e6fadec1301 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -135,6 +135,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
>  
> +  "phy@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/phy/qcom,snps-eusb2-repeater.yaml#
> +
>    "pon@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/power/reset/qcom,pon.yaml#
> -- 
> 2.34.1

-- 
~Vinod
