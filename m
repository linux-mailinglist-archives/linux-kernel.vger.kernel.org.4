Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1378364B6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiLMOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiLMOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:05:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7E1FCF8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:05:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b13so5077576lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7BqOo+kSVPojQOVkzbf9L5JFXaDuXdJjEL2ta9kBZk=;
        b=ipcLqkcCSJBmYMcjWYAK8N7S4kv1xzpURdexxEDp8GEA3roaRmw0q7SFBciihXd/l3
         3r+BnPdP8QlkJDjP3glXn26OL3FDTB1Hs0pR6CpcfIAH8QR2dtkK4sJs0phs4zzqnHuc
         8Vrv8esCATPjkZgdBLXr8Mo3hmY1E7jMYX5+dHqWlnADTHGIVmcPNfQPEZG3baQzqC/A
         tetYPXB1KJQNZqLuM/mRfdu7WkxVrQ/RxgddZdtUULtYt29aQd1SCueOJ1SiyQFyw39Q
         TTIhsu+dK/1j0QsXEf68bhgKSb1MnRnkCypiRuoJqf4hc5IMSzVwReeuaG66SUfZvNf2
         cGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7BqOo+kSVPojQOVkzbf9L5JFXaDuXdJjEL2ta9kBZk=;
        b=5KSNZEOzSzhlqQ6PDaj0KZ+AySl5QeYWYEuoj2dpduUXgzFANlxgapV8u0XrICbxny
         i5wTPja48VGDaV72G0DdoFAyDuGzvbSjmHcwfDgO6O/2Jk0o1+4RhGY25QvociRt3KoG
         EDMvVhILzMPo7S0GaOfSuh+N813cfRkPJiLI1MIfUrAdeAqBVtekNKHBDZYbsXj5c9BE
         hzC03u/QXXPsKhSz1x11gErq9Lv6ewoOKMo33LtnBCxsmoShifmp6T7THlPm7hySxTqP
         aK5GvfAuJ1hqbMtU3Wxu7SlShKZlK02+ZGGmG/kmMN53ZHOgeqxeZjKB9/MzAYMnkelE
         7kTQ==
X-Gm-Message-State: ANoB5pnNA9wE/2M3eFjTix+552JxdvpZZqP2T8A3QVok0JFs6XgBEpII
        26Dg25pz8Gp3F4v+ME+NQMioHg==
X-Google-Smtp-Source: AA0mqf7Xn1MU+m77o/IGeVd3CC1B0v4t8tqlCYVBFgxIcspAoPClDDqZKKcrYEERk/eC9teZbMP6ag==
X-Received: by 2002:a05:6512:32b7:b0:4b5:82f1:7f3d with SMTP id q23-20020a05651232b700b004b582f17f3dmr7803471lfe.58.1670940354892;
        Tue, 13 Dec 2022 06:05:54 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id d28-20020a194f1c000000b00498fbec3f8asm384059lfb.129.2022.12.13.06.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:05:54 -0800 (PST)
Message-ID: <fe5e52d9-3f93-ecc3-b7ef-d3e17e07d2a5@linaro.org>
Date:   Tue, 13 Dec 2022 15:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v10 2/4] dt-bindings: usb: Add Qualcomm PMIC type C
 controller dt-binding
Content-Language: en-US
To:     Wesley Cheng <wcheng@codeaurora.org>, sboyd@kernel.org,
        heikki.krogerus@linux.intel.com, agross@kernel.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, sergei.shtylyov@gmail.com
References: <20201008235934.8931-1-wcheng@codeaurora.org>
 <20201008235934.8931-3-wcheng@codeaurora.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20201008235934.8931-3-wcheng@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.10.2020 01:59, Wesley Cheng wrote:
> Introduce the dt-binding for enabling USB type C orientation and role
> detection using the PM8150B.  The driver will be responsible for receiving
> the interrupt at a state change on the CC lines, reading the
> orientation/role, and communicating this information to the remote
> clients, which can include a role switch node and a type C switch.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
Hi all, sorry for playing archeology, but it looks like the driver
was merged 2 years ago and this binding has been omitted..

Konrad
>  .../bindings/usb/qcom,pmic-typec.yaml         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
> new file mode 100644
> index 000000000000..40e0a296f922
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/qcom,pmic-typec.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm PMIC based USB type C Detection Driver
> +
> +maintainers:
> +  - Wesley Cheng <wcheng@codeaurora.org>
> +
> +description: |
> +  Qualcomm PMIC Type C Detect
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8150b-usb-typec
> +
> +  reg:
> +    maxItems: 1
> +    description: Type C base address
> +
> +  interrupts:
> +    maxItems: 1
> +    description: CC change interrupt from PMIC
> +
> +  port:
> +    description: Remote endpoint connection to the DRD switch
> +    type: object
> +
> +    properties:
> +      endpoint:
> +        description: Connection to the DRD switch being used
> +        type: object
> +
> +  connector:
> +    $ref: /connector/usb-connector.yaml#
> +    description: Connector type for remote endpoints
> +    type: object
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - usb-c-connector
> +
> +      power-role: true
> +      data-role: true
> +
> +      ports:
> +        description: Remote endpoint connections for type C paths
> +        type: object
> +
> +        properties:
> +          port@1:
> +            description: Remote endpoints for the Super Speed path
> +            type: object
> +
> +            properties:
> +              endpoint:
> +                description: Connection to USB type C mux node
> +                type: object
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - connector
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pm8150b {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pm8150b_typec: usb-typec@1500 {
> +            compatible = "qcom,pm8150b-usb-typec";
> +            reg = <0x1500>;
> +            interrupts = <0x2 0x15 0x5 IRQ_TYPE_EDGE_RISING>;
> +
> +            port {
> +                usb3_role: endpoint {
> +                    remote-endpoint = <&dwc3_drd_switch>;
> +                };
> +            };
> +
> +            connector {
> +                compatible = "usb-c-connector";
> +                power-role = "dual";
> +                data-role = "dual";
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    port@0 {
> +                        reg = <0>;
> +                    };
> +                    port@1 {
> +                        reg = <1>;
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        usb3_data_ss: endpoint {
> +                            remote-endpoint = <&qmp_ss_mux>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
