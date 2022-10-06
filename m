Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DE5F6E97
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiJFUEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:04:32 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDB6B1BAD;
        Thu,  6 Oct 2022 13:04:31 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q10so3270547oib.5;
        Thu, 06 Oct 2022 13:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qF8uUgZw7uB5rU3ByXrhVDO91RxN/lulR0zHwr6JoU=;
        b=DdUDVB69JpZS74z+RBE3bHgCVkSEFG/lmlm26A2IAvgngsys21xYCP11Z7eb0EoRZA
         LD1maBBH9LvtOsiqy37LuiGS/5SKqZLlkBGVj81e4P/XvjXkeC7Te4U0726qQomkmt+m
         xR1Asc/Q+LE1qDZbYex0NJHHw5I1yV67ucGCh2XGx81rRnxXzalkxvyIrk1TWlMvtWLZ
         CfJNHDIhAV8/mHM76gQPtXKPvO23VDB27ibrC2Bcwa3ENMusSGzF4pT1dPPxQJVFfn1Z
         jStrYwRwZ0vytHySjYhCdMx8Fi+xpTsVqSDvOJoYGCRH/MPi62YZZ0mlyHbJ51Qk6RL9
         16Qw==
X-Gm-Message-State: ACrzQf3dEW/xVt5sPUmOqy1O333ApXCbIKxVnUnNaWdelMJ8Z0gpNxN2
        KEmYHpELsSRytVVMFoxSZg==
X-Google-Smtp-Source: AMsMyM5ePwUNAIteXDi1GNzpz4aWevPwQYV8Ykk5sXu6RvssHaG+tu9eFHpcQQ7/SrUk+UZEN/pXRg==
X-Received: by 2002:a05:6808:2217:b0:354:1aea:1328 with SMTP id bd23-20020a056808221700b003541aea1328mr674736oib.7.1665086670461;
        Thu, 06 Oct 2022 13:04:30 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id y5-20020a056808060500b00350c5d946casm65220oih.4.2022.10.06.13.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:04:30 -0700 (PDT)
Received: (nullmailer pid 86412 invoked by uid 1000);
        Thu, 06 Oct 2022 20:04:23 -0000
Date:   Thu, 6 Oct 2022 15:04:23 -0500
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
Subject: Re: [PATCH 5/6] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Message-ID: <20221006200423.GA77998-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-5-0cbc006e2a30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-5-0cbc006e2a30@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:58:02AM +0000, Neil Armstrong wrote:
> Convert the non-SMD Regulators  bindings to dt-schema and remove the
> old text based bindings now we have migrated all the content.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 246 ---------------------
>  .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++
>  2 files changed, 127 insertions(+), 246 deletions(-)

Ah, the 'regulators' node for the parent should reference this schema.

> diff --git a/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
> new file mode 100644
> index 000000000000..e18bb8b87c43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM IPC RPM REGULATOR
> +
> +description:

'|' if you want to maintain the formatting.

> +  The Qualcomm RPM over IPC regulator is modelled as a subdevice of the RPM.
> +
> +  Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> +  for information regarding the RPM node.
> +
> +  The regulator node houses sub-nodes for each regulator within the device.
> +  Each sub-node is identified using the node's name, with valid values listed
> +  for each of the pmics below.
> +
> +  For pm8058 l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15,
> +  l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, s0, s1, s2, s3, s4,
> +  lvs0, lvs1, ncp
> +
> +  For pm8901 l0, l1, l2, l3, l4, l5, l6, s0, s1, s2, s3, s4, lvs0, lvs1, lvs2, lvs3,
> +  mvs
> +
> +  For pm8921 s1, s2, s3, s4, s7, s8, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
> +  l12, l14, l15, l16, l17, l18, l21, l22, l23, l24, l25, l26, l27, l28,
> +  l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
> +  ncp
> +
> +  For pm8018 s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
> +  l12, l14, lvs1
> +
> +  For smb208 s1a, s1b, s2a, s2b
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpm-pm8058-regulators
> +      - qcom,rpm-pm8901-regulators
> +      - qcom,rpm-pm8921-regulators
> +      - qcom,rpm-pm8018-regulators
> +      - qcom,rpm-smb208-regulators
> +
> +patternProperties:
> +  ".*-supply$":
> +    description: Input supply phandle(s) for this node
> +
> +  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switch)$":
> +    description: List of regulators and its properties
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +    properties:
> +      bias-pull-down:
> +        description: enable pull down of the regulator when inactive
> +        type: boolean
> +
> +      qcom,switch-mode-frequency:
> +        description: Frequency (Hz) of the switch-mode power supply
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum:
> +          - 19200000
> +          - 9600000
> +          - 6400000
> +          - 4800000
> +          - 3840000
> +          - 3200000
> +          - 2740000
> +          - 2400000
> +          - 2130000
> +          - 1920000
> +          - 1750000
> +          - 1600000
> +          - 1480000
> +          - 1370000
> +          - 1280000
> +          - 1200000
> +
> +      qcom,force-mode:
> +        description: Indicates that the regulator should be forced to a particular mode
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum:
> +          - 0 # QCOM_RPM_FORCE_MODE_NONE do not force any mode
> +          - 1 # QCOM_RPM_FORCE_MODE_LPM force into low power mode
> +          - 2 # QCOM_RPM_FORCE_MODE_HPM force into high power mode
> +          - 3 # QCOM_RPM_FORCE_MODE_AUTO allow regulator to automatically select its own mode
> +              # based on realtime current draw, only for pm8921 smps and ftsmps
> +
> +      qcom,power-mode-hysteretic:
> +        description: select that the power supply should operate in hysteretic mode,
> +          instead of the default pwm mode
> +        type: boolean
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/qcom-rpm.h>
> +    regulators {
> +      compatible = "qcom,rpm-pm8921-regulators";
> +      vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
> +
> +      s1 {
> +        regulator-min-microvolt = <1225000>;
> +        regulator-max-microvolt = <1225000>;
> +
> +        bias-pull-down;
> +
> +        qcom,switch-mode-frequency = <3200000>;
> +      };
> +
> +      pm8921_s4: s4 {
> +        regulator-min-microvolt = <1800000>;
> +        regulator-max-microvolt = <1800000>;
> +
> +        qcom,switch-mode-frequency = <1600000>;
> +        bias-pull-down;
> +
> +        qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
> +      };
> +    };
> +...
> 
> -- 
> b4 0.10.1
> 
