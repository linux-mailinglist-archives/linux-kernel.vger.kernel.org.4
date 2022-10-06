Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04635F6E73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiJFTxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiJFTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:53:45 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4909A4858;
        Thu,  6 Oct 2022 12:53:44 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so2155548oom.1;
        Thu, 06 Oct 2022 12:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR64ZoS03S6Cf4OMN2xctJ5fNp97n//E/duTDF0cLns=;
        b=ZaPLcQGEWsGbVisjC7CUlnoppJ/N6CJLEMRM5PzP7lVEbmknHbOIqK70ozxYHSP9bm
         zo4EckunD5TwBMFFKW6FMsQJ8MdDJM6LJxe2gtLAxuJ/fCtt8DMO6OrMSsfadzg7B7Z9
         ORMEdd1LrJkXKAfBgjwO+z8CtNTjG+2gXv5q1njswqWn9s+Efm4SxlMglNT/spnEyK0Q
         bFP7Ep2/V+TBch7KcULWpd+uQwkJFBLqH6KQrtDv1Jifqgys/AQ21M67iNlKJX6kI6vk
         9FaZjVLtAi9TJoE8PuUs8gAlDDh0Bn0mc8/5tsJZYB/03BTEC2CSB0/6fTk6ofdZhGgM
         E88Q==
X-Gm-Message-State: ACrzQf10MVDR6lm4qYaKQePrDZBAdeq6W6cAgyFwAbMwGDaM/SFqeW9Q
        aJtJFl4LqGBqubTd6OtFsw==
X-Google-Smtp-Source: AMsMyM45uLSlRXQZ2e8/VVkH5FOyJd9ra0oO8PlThWD5+ed024nCjv6jn0yO4T+hqAz+i1uCj25J0A==
X-Received: by 2002:a4a:e54e:0:b0:44a:fb57:7022 with SMTP id s14-20020a4ae54e000000b0044afb577022mr501192oot.91.1665086024072;
        Thu, 06 Oct 2022 12:53:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870460900b001326b043f37sm283272oao.36.2022.10.06.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:53:43 -0700 (PDT)
Received: (nullmailer pid 77842 invoked by uid 1000);
        Thu, 06 Oct 2022 19:53:37 -0000
Date:   Thu, 6 Oct 2022 14:53:37 -0500
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
Subject: Re: [PATCH 4/6] dt-bindings: soc: qcom: convert non-smd RPM bindings
 to dt-schema
Message-ID: <20221006195337.GA69592-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-4-0cbc006e2a30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-4-0cbc006e2a30@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:58:01AM +0000, Neil Armstrong wrote:
> Convert the non-SMD RPM node bindings to dt-schema, the regulators subnode
> refers to regulators,yaml until we have the proper bindings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 39 +-----------
>  .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 73 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 38 deletions(-)


> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> new file mode 100644
> index 000000000000..d416950189d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ipc-rpm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Resource Power Manager (RPM) over IPC
> +
> +description: |
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
> +
> +  interrupts:
> +    minItems: 3

maxItems: 3

(Instead)

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
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#

regulator.yaml applies to a single regulator, but 'regulators' sounds 
like a container node with multiple regulators.

Would be good if the example showed...

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
> +
> +    rpm@108000 {
> +      compatible = "qcom,rpm-msm8960";
> +      reg = <0x108000 0x1000>;
> +      qcom,ipc = <&apcs 0x8 2>;
> +
> +      interrupts = <GIC_SPI 19 IRQ_TYPE_NONE>, <GIC_SPI 21 IRQ_TYPE_NONE>, <GIC_SPI 22 IRQ_TYPE_NONE>;
> +      interrupt-names = "ack", "err", "wakeup";
> +    };
> 
> -- 
> b4 0.10.1
> 
