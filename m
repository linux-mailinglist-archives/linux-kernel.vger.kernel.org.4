Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE175F732D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJGDRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJGDRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:17:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03499F75D;
        Thu,  6 Oct 2022 20:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DC5CB821FF;
        Fri,  7 Oct 2022 03:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C20C433C1;
        Fri,  7 Oct 2022 03:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112631;
        bh=raNQClit9DJjp19Q6anjbdRY6UBhQkOC54kGNTOKIQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBRN1qtaSBv9jpd5V7MCCop08cYRrWLUjMb6G5JAnUDgl2mDuANn1D/6O/NHbDlqY
         NvTFmV+FvBmhdYQx5QfLKSZPig6POedMja5POt/8ggYaLlu3pD69X6JaXsQidJ4+qf
         3omL9fiopNUqvdJk8Wzk6sDVrVlyOC/8dQ2144ajkZgnUG4IG5IHIh0EOn7re8tjWk
         D6rFxXgiuHebkpib0pECqeBLTmxH3gDQbNZCzyYoLs8lQEDqQR0Vt+gd+5W9SnHq6B
         O9cVQrljveSY/bSyLoJ71nlABlH98FWra4CoKNS5yV6ooPkOhwj1Umd7/T3cStObVS
         6td4ZMqqV1Q2w==
Date:   Thu, 6 Oct 2022 22:17:08 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/16] dt-bindings: pinctrl: qcom,sm8250: fix matching
 pin config
Message-ID: <20221007031708.dyqaos3xl3j2twz2@builder.lan>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:29:51PM +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> The change causes indentation decrement, so the diff-hunk looks big, but
> there are no functional changes in the subnode "properties" section.
> The only difference there is removal of blank lines between common GPIO
> pinconf properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 128 +++++++++---------
>  1 file changed, 67 insertions(+), 61 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> index 021592b32904..131eb8c981f8 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> @@ -58,68 +58,74 @@ properties:
>  
>    wakeup-parent: true
>  
> -#PIN CONFIGURATION NODES
>  patternProperties:
> -  '^.*$':
> -    if:
> -      type: object
> -    then:
> -      $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> -      properties:
> -        pins:
> -          description:
> -            List of gpio pins affected by the properties specified in this
> -            subnode.
> -          items:
> -            oneOf:
> -              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
> -              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
> -          minItems: 1
> -          maxItems: 36
> -
> -        function:
> -          description:
> -            Specify the alternative function to be configured for the specified
> -            pins.
> -
> -          enum: [ aoss_cti, atest, audio_ref, cam_mclk, cci_async, cci_i2c,
> -                  cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
> -                  cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
> -                  ddr_pxi2, ddr_pxi3, dp_hot, dp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gpio,
> -                  ibi_i3c, jitter_bist, lpass_slimbus, mdp_vsync, mdp_vsync0,
> -                  mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1,
> -                  mi2s0_sck, mi2s0_ws, mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws,
> -                  mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, pci_e0, pci_e1,
> -                  pci_e2, phase_flag, pll_bist, pll_bypassnl, pll_clk, pll_reset,
> -                  pri_mi2s, prng_rosc, qdss_cti, qdss_gpio, qspi0, qspi1, qspi2, qspi3,
> -                  qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14,
> -                  qup15, qup16, qup17, qup18, qup19, qup2, qup3, qup4, qup5, qup6,
> -                  qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41,
> -                  sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu, tgu_ch0, tgu_ch1,
> -                  tgu_ch2, tgu_ch3, tsense_pwm1, tsense_pwm2, tsif0_clk, tsif0_data,
> -                  tsif0_en, tsif0_error, tsif0_sync, tsif1_clk, tsif1_data, tsif1_en,
> -                  tsif1_error, tsif1_sync, usb2phy_ac, usb_phy, vsense_trigger ]
> -
> -        drive-strength:
> -          enum: [2, 4, 6, 8, 10, 12, 14, 16]
> -          default: 2
> -          description:
> -            Selects the drive strength for the specified pins, in mA.
> -
> -        bias-pull-down: true
> -
> -        bias-pull-up: true
> -
> -        bias-disable: true
> -
> -        output-high: true
> -
> -        output-low: true
> -
> -      required:
> -        - pins
> -
> -      additionalProperties: false
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sm8250-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-sm8250-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-sm8250-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
> +            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ aoss_cti, atest, audio_ref, cam_mclk, cci_async, cci_i2c,
> +                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
> +                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
> +                ddr_pxi2, ddr_pxi3, dp_hot, dp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gpio,
> +                ibi_i3c, jitter_bist, lpass_slimbus, mdp_vsync, mdp_vsync0,
> +                mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1,
> +                mi2s0_sck, mi2s0_ws, mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws,
> +                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, pci_e0, pci_e1,
> +                pci_e2, phase_flag, pll_bist, pll_bypassnl, pll_clk, pll_reset,
> +                pri_mi2s, prng_rosc, qdss_cti, qdss_gpio, qspi0, qspi1, qspi2, qspi3,
> +                qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14,
> +                qup15, qup16, qup17, qup18, qup19, qup2, qup3, qup4, qup5, qup6,
> +                qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41,
> +                sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu, tgu_ch0, tgu_ch1,
> +                tgu_ch2, tgu_ch3, tsense_pwm1, tsense_pwm2, tsif0_clk, tsif0_data,
> +                tsif0_en, tsif0_error, tsif0_sync, tsif1_clk, tsif1_data, tsif1_en,
> +                tsif1_error, tsif1_sync, usb2phy_ac, usb_phy, vsense_trigger ]
> +
> +      drive-strength:
> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +        default: 2
> +        description:
> +          Selects the drive strength for the specified pins, in mA.
> +
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      bias-disable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +
> +    additionalProperties: false
>  
>  allOf:
>    - $ref: "pinctrl.yaml#"
> -- 
> 2.34.1
> 
