Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66BC601194
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJQOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:51:47 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7B66A53;
        Mon, 17 Oct 2022 07:51:47 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-132fb4fd495so13477702fac.12;
        Mon, 17 Oct 2022 07:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQmjr/EyIPHY20SWOjqqwfn8Tg3ceyCJTg73Ix2QS18=;
        b=X2hfTdHHyG/hQukgD4uFSWnxgkmqQ/s2O7LWr8EyCAjSGIrp+oGze3HLSqiLSa3btr
         KQRtdB9yZT8nxfdEeVF9cbkMKFo9vHLi+Dn/Y2McFQ6kv4PMVAPe0ml0PuSvCqep+uoq
         9fhSFdWRIwfUL2tqYEgw9yncPJ0OVtj1+O7lQ7gIiG9SCbz4Y2a6qFasIT3YOPsLEWfN
         3BMSuI4cDxHruZC8l1SWpCab3/J/XG1FSZ3KFNweBjYYQ8HeGtBAoyH+0UfPXznZa6Ga
         qyGiXNNqyI+7VD3MI5sCzrzLICxFVWU/rS+IA87a83QOhk60MAwHcp0snrOT37oZOWw3
         +ZIw==
X-Gm-Message-State: ACrzQf3F9J+cg4VDIHyU5rNUC0nMxKPuKtoiCOrmO4dKKcTiNei6WlKd
        aqWLvk0YirN/mVsMwKJoUw==
X-Google-Smtp-Source: AMsMyM75yYgNPRfaW7vnMPaMOyYJ/gLX0sihjW+W+vJh+8oI6JnRBro8AFX5LC0ESfiV4GGaJIpMpA==
X-Received: by 2002:a05:6870:4798:b0:12c:fdf7:e948 with SMTP id c24-20020a056870479800b0012cfdf7e948mr5546720oaq.247.1666018306227;
        Mon, 17 Oct 2022 07:51:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d61c7000000b00661c3846b4csm4883335otk.27.2022.10.17.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:51:45 -0700 (PDT)
Received: (nullmailer pid 1450524 invoked by uid 1000);
        Mon, 17 Oct 2022 14:51:46 -0000
Date:   Mon, 17 Oct 2022 09:51:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dt-bindings: soc: qcom: convert non-smd RPM
 bindings to dt-schema
Message-ID: <20221017145146.GA1438783-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v2-5-639fe67a04be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v2-5-639fe67a04be@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 12:23:09PM +0200, Neil Armstrong wrote:
> Convert the non-SMD RPM node bindings to dt-schema, the old txt bindings
> are now removed since all bindings were converted.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
>  .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml |  99 +++++++
>  2 files changed, 99 insertions(+), 283 deletions(-)


> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> new file mode 100644
> index 000000000000..4e9df94ecd44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ipc-rpm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Resource Power Manager (RPM) over IPC
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  This driver is used to interface with the Resource Power Manager (RPM) found
> +  in various Qualcomm platforms. The RPM allows each component in the system
> +  to vote for state of the system resources, such as clocks, regulators and bus
> +  frequencies.
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpm-apq8064
> +      - qcom,rpm-msm8660
> +      - qcom,rpm-msm8960
> +      - qcom,rpm-ipq8064
> +      - qcom,rpm-mdm9615
> +
> +  reg: true

Need to define how many entries.

> +
> +  interrupts:
> +    minItems: 3

maxItems instead.

> +
> +  interrupt-names:
> +    items:
> +      - const: ack
> +      - const: err
> +      - const: wakeup
> +
> +  qcom,ipc:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to a syscon node representing the APCS registers
> +          - description: u32 representing offset to the register within the syscon
> +          - description: u32 representing the ipc bit within the register
> +    description:
> +      Three entries specifying the outgoing ipc bit used for signaling the RPM.
> +
> +patternProperties:
> +  "(regulators|-regulators)$":

Can be simplified to this:

'-?regulators$'

However, as there is no constraint as to what comes before the r or -, 
the '-?' doesn't do anything. Either drop it or try to define the 
preceeding part. Perhaps '^([a-z]+-)?regulators$' is what you wanted if 
just 'regulators' is one case?


> +    type: object
> +    $ref: /schemas/regulator/qcom,ipc-rpm-regulator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - qcom,ipc
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mfd/qcom-rpm.h>
> +
> +    rpm@108000 {
> +      compatible = "qcom,rpm-msm8960";
> +      reg = <0x108000 0x1000>;
> +      qcom,ipc = <&apcs 0x8 2>;
> +
> +      interrupts = <GIC_SPI 19 IRQ_TYPE_NONE>, <GIC_SPI 21 IRQ_TYPE_NONE>, <GIC_SPI 22 IRQ_TYPE_NONE>;
> +      interrupt-names = "ack", "err", "wakeup";
> +
> +      regulators {
> +        compatible = "qcom,rpm-pm8921-regulators";
> +        vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
> +
> +        s1 {
> +          regulator-min-microvolt = <1225000>;
> +          regulator-max-microvolt = <1225000>;
> +
> +          bias-pull-down;
> +
> +          qcom,switch-mode-frequency = <3200000>;
> +        };
> +
> +        pm8921_s4: s4 {
> +          regulator-min-microvolt = <1800000>;
> +          regulator-max-microvolt = <1800000>;
> +
> +          qcom,switch-mode-frequency = <1600000>;
> +          bias-pull-down;
> +
> +          qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
> +        };
> +      };
> +    };
> 
> -- 
> b4 0.10.1
> 
