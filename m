Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358215BE029
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiITIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiITIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:32:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E80642F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:32:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b6so2065660ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=e5NbNmHqCTNWIuLtFd/xJyd41CdSEWykAKatXf98LzQ=;
        b=F/azeecqNQ0r0OnKpDAK+lE7+mPrDKflODWkdTEhYiPVy2Ds0QR1LfiVWR9QviaZ23
         trYYhU4jIRlDQ5vUkt9fBVt1cOIRRXfcrBK1/wBF35q8CCZCbqafAdBUz2VI/hV0i07B
         zMlW1phPoKNUBDH9Izm77Ov5zwooyXddO3zuIDccbae3TzhNksBA4xTJO3G7zGYBjYpU
         IYYv7D5arE5bM0qCqDFv16+UFwNGaKE1X+hOLWWS8PatSeaB55s4xNv8pk+DaNoiRrN3
         8vQ5cMiNk0hT7JQWeKxzaS6K9Kz8op9IksdAmLqv2WeOvthYgKcJzgD+qyWZNK3d7/t4
         2MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e5NbNmHqCTNWIuLtFd/xJyd41CdSEWykAKatXf98LzQ=;
        b=GnGrvGJNFngsoVjDl4VzZtKSIJ7M1zHnh/LjAiKc4Lx1A7l41FlpS0ewsQJBQBvimj
         fLufS6Vg+EQZPAQbgduVDLLfTIXuxszMXhy9gi4e8EJmShDBMhnRxO1p+xvrltZS/D5a
         DvIGCT9JLq24SZ4Mn9GLHkvzrEPIRSGqybfuSzp3dtK8RzHTnErkNsKFFHDFwdmhZUxM
         jGlczgv8FPSns9jotwySim754bibfD2nmV82VIgiB0viOf51fUd5QZTYugieqdQzhA56
         vOEh8CamiS/nXZDE+ay4RzePJ4By/E7c9xaaA9apmRsL3ZqAqlIy/zLLTsg8KQecAJHe
         m8MQ==
X-Gm-Message-State: ACrzQf2+N4q3oz3TZkNobSLoU8XwmfQAbJeV04XDdcmEVhrJFeR7FOTm
        nqPbY/eWHGvRh4WIBInPBB6QNQ==
X-Google-Smtp-Source: AMsMyM7KNMChPE2Rgyh3kKm/hPSJtpEndm6m6U5vsW842vuEu5FKfr0pg6gGWxliP86yysZq0PMluQ==
X-Received: by 2002:a2e:bc84:0:b0:26c:3bee:575f with SMTP id h4-20020a2ebc84000000b0026c3bee575fmr5775829ljf.389.1663662723105;
        Tue, 20 Sep 2022 01:32:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9b97000000b00261e7244887sm145166lji.60.2022.09.20.01.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:32:02 -0700 (PDT)
Message-ID: <f35a1e45-1856-2443-f87a-33bc97c1c578@linaro.org>
Date:   Tue, 20 Sep 2022 10:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: qcom: add sdm670 pinctrl
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220920021636.1634-1-mailingradian@gmail.com>
 <20220920021636.1634-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920021636.1634-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 04:16, Richard Acayan wrote:
> There is a new driver for the Snapdragon 670 TLMM (Top-Level Mode
> Multiplexer). Document it.
> 
> Adapted from qcom,sm6350-pinctrl.yaml in the same directory at
> commit c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml").

Reference other commits if they relate to the issue described here, e.g.
they cause a bug. If it is not the case, no need for this.

> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> 

(...)

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true
> +  gpio-controller: true
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 76

Do you have 152 or 153 GPIOs?

> +
> +  '#gpio-cells': true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '-state$':
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sdm670-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-sdm670-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-sdm670-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
> +            - enum: [ ufs_reset, sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data,
> +                      sdc2_clk, sdc2_cmd, sdc2_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2, atest_usb1, atest_usb10,
> +                atest_usb11, atest_usb12, atest_usb13, atest_usb2, atest_usb20, atest_usb21,
> +                atest_usb22, atest_usb23, cam_mclk, cci_async, cci_i2c, cci_timer0, cci_timer1,
> +                cci_timer2, cci_timer3, cci_timer4, copy_gp, copy_phase, dbg_out, ddr_bist,
> +                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1, gcc_gp2, gcc_gp3,
> +                gp_pdm0, gp_pdm1, gp_pdm2, gpio, gps_tx, jitter_bist, ldo_en, ldo_update,
> +                lpass_slimbus, m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3,
> +                mss_lte, nav_pps, pa_indicator, pci_e0, pci_e1, phase_flag, pll_bist, pll_bypassnl,
> +                pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc, qdss_cti, qdss, qlink_enable,
> +                qlink_request, qua_mi2s, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2,
> +                qup3, qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sdc4_clk,
> +                sdc4_cmd, sdc4_data, sd_write, sec_mi2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2,
> +                tgu_ch3, tsif1_clk, tsif1_data, tsif1_en, tsif1_error, tsif1_sync, tsif2_clk,
> +                tsif2_data, tsif2_en, tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
> +                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset, uim_batt, usb_phy, vfr_1,
> +                vsense_trigger, wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1, wsa_clk, wsa_data, ]
> +
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +
> +    allOf:
> +      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +      - if:
> +          properties:
> +            pins:
> +              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
> +        then:
> +          required:
> +            - function
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        pinctrl@3400000 {

Still wrong indentation.

> +                compatible = "qcom,sdm670-tlmm";
> +                reg = <0x03400000 0x300000>;
> +                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +                gpio-ranges = <&tlmm 0 0 151>;
> +

Best regards,
Krzysztof
