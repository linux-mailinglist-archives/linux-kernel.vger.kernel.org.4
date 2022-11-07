Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0661EE34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKGJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:07:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4F167FC;
        Mon,  7 Nov 2022 01:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F7260F6A;
        Mon,  7 Nov 2022 09:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D30C433D7;
        Mon,  7 Nov 2022 09:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812050;
        bh=NExr18SAzyXYkii6f9h88e7VFGJJiIJjiIyLxLarNyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbRu5qlUwoVm6c4Vn1uOZOm3uDLldohqcEkHf2r/F+UkX4FspEnqHdoF1f6lqsiXA
         Y5J/zX3+wv89K8F0nawnRdQ1FO0Zren7eKtvipsZP4vTfv7Rs3B4HPM3GfupB55NmV
         FpbPfHVAkFe6TP9s/6oQLASaGIMY/AOX3JBU25W/UcNhwgQQVgU4rfwNc+/L2OWDpe
         2Xi9B8GaGdKX4nZQmpN0lMxTBqDfDGZ7XF2zCbpx+XP++vlJXh/JIaI1icnRjCYvn/
         fKbxpADaJpuMytMeH5O83sAztqs2TRo+pu9vUXUiGdOiGEBEBakO+pDeH5oMelDju0
         QGEOZKC9dDXbA==
Date:   Mon, 7 Nov 2022 09:07:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: support more
 types
Message-ID: <Y2jKyyZqAssNiRNB@google.com>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031173933.936147-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Luca Weiss wrote:

> * 'adc@' is either spmi-iadc or spmi-vadc
> * 'charger@' is either pm8941-charger or pm8941-coincell
> * 'usb-vbus-regulator@' is usb-vbus-regulator
> * 'vibrator@' is now in yaml format, so add it
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v1:
> * Change dcdc@ to usb-vbus-regulator@
> * Link to pm8xxx-vib.yaml
> 
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml  | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

I don't see the other 2 patches.

Is this okay to take on its own?

> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 777f2da52f1e..cf10d62ace54 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -105,7 +105,9 @@ properties:
>  patternProperties:
>    "^adc@[0-9a-f]+$":
>      type: object
> -    $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
> +    oneOf:
> +      - $ref: /schemas/iio/adc/qcom,spmi-iadc.yaml#
> +      - $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
>  
>    "^adc-tm@[0-9a-f]+$":
>      type: object
> @@ -115,6 +117,12 @@ patternProperties:
>      type: object
>      additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
>  
> +  "^charger@[0-9a-f]+$":
> +    type: object
> +    oneOf:
> +      - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
> +      - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
> +
>    "extcon@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
> @@ -135,9 +143,13 @@ patternProperties:
>      type: object
>      $ref: /schemas/thermal/qcom,spmi-temp-alarm.yaml#
>  
> +  "^usb-vbus-regulator@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/regulator/qcom,usb-vbus-regulator.yaml#
> +
>    "^vibrator@[0-9a-f]+$":
>      type: object
> -    additionalProperties: true # FIXME qcom,pm8916-vib binding not converted yet
> +    $ref: /schemas/input/qcom,pm8xxx-vib.yaml#
>  
>    "^mpps@[0-9a-f]+$":
>      type: object

-- 
Lee Jones [李琼斯]
