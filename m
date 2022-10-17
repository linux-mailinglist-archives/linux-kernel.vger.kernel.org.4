Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCFE60117B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJQOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJQOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:47:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B867475
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:47:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w18so18820515wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8LpMhm01GULZEgQy6vPU4ZVmV+/KnoXv9S8pTMacCYA=;
        b=Fh/pgU7S92v+YQXIHLarbPmbajs7DcJe8exv41Vhoc3DTJLe6/B3BAeQTnXcMw7g7A
         6u8shSDLALEP5zUqF6NhJoNAJJSBuEfTL98Oldg3gCz2+ew8bkWVI+9fPOvYVR07z5FJ
         WV0LIMHq2ceNI21XC4B3YwTwmmA37WR4VqDXRCRzrbYFXRbv26D7nUcetn32I+17C1jT
         az/5wnXqj5EVMm+tHJ/HAmRoElkRBdwXPXiKSa5xLVtZfQegCLBf3NSK4mTqto8pRS2s
         8vGbdoofaNHn8sCQLBrsnhYLN/nkNtsTm2ea0YxUX4z1qdbMUIzm7dXK1wtigkhpzdii
         xNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LpMhm01GULZEgQy6vPU4ZVmV+/KnoXv9S8pTMacCYA=;
        b=wpLr5dJF/0HB38IAKnz3S4f2VjDSvvB38Efr8VJYIyEYb+IE/5xsNW6Q74bu/er1ax
         jrwjXW1Dhr+umbZpl3QNblrvsTHmI8BWHwmbzQ0+24eDYPT/gib54uiy+dobUJ8VIPeq
         Fz4pqp/iVmUyzpGTAd1eEBxIaYsEwuRMtrOUGQ+UBdxygqJAebQG1X3GMEZwIEh1+PIz
         MyxjVCSEs+aS+sQRj2LSjEXFaSA7Q+O8jfOC2fsz5Ta0cUPO5nFMr5ZLVsFrWaSkMwq5
         J90ZeD9UIZ2NoKxM2w3pEMyav6EH7hrxuro8/yJVCwfmA2Yf5P0V6qZ/yUdVDRyjsb5k
         rx6A==
X-Gm-Message-State: ACrzQf2cofBAhND7xCy+xDRcHzNudP9svwpthEIDZv6guQ564f5Sm0Hz
        gdN4b8+5+cPy0S88k65tFhmw8g==
X-Google-Smtp-Source: AMsMyM7SHgNdHQJO4o1LjJ2uEuRR9fVu0uG5LiJ44wePV66PtSRT7Z69TA7HaDkLEd5P9d1ROjN9FQ==
X-Received: by 2002:adf:f709:0:b0:22e:327d:f147 with SMTP id r9-20020adff709000000b0022e327df147mr6396581wrp.240.1666018066384;
        Mon, 17 Oct 2022 07:47:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:18de:9cc5:22bd:5fc6? ([2a01:e0a:982:cbb0:18de:9cc5:22bd:5fc6])
        by smtp.gmail.com with ESMTPSA id e10-20020adfdbca000000b0022e66749437sm8657755wrj.93.2022.10.17.07.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:47:46 -0700 (PDT)
Message-ID: <9b5df679-3561-b51b-7127-bf8bdc8cb65f@linaro.org>
Date:   Mon, 17 Oct 2022 16:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/5] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
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
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v2-4-639fe67a04be@linaro.org>
 <20221017143951.GA1434507-robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20221017143951.GA1434507-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/10/2022 16:39, Rob Herring wrote:
> On Mon, Oct 17, 2022 at 12:23:08PM +0200, Neil Armstrong wrote:
>> Convert the non-SMD Regulators bindings to dt-schema, the old text based
>> bindings will be deleted later since the RPM bindings are not yet converted.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++++++++++++
>>   1 file changed, 127 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
>> new file mode 100644
>> index 000000000000..e18bb8b87c43
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,ipc-rpm-regulator.yaml
>> @@ -0,0 +1,127 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM IPC RPM REGULATOR
> 
> Fix your capslock.

It's literally taken from Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml:

title: QCOM SMD RPM REGULATOR

> 
>> +
>> +description:
>> +  The Qualcomm RPM over IPC regulator is modelled as a subdevice of the RPM.
>> +
>> +  Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
>> +  for information regarding the RPM node.
>> +
>> +  The regulator node houses sub-nodes for each regulator within the device.
>> +  Each sub-node is identified using the node's name, with valid values listed
>> +  for each of the pmics below.
>> +
>> +  For pm8058 l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15,
>> +  l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, s0, s1, s2, s3, s4,
>> +  lvs0, lvs1, ncp
>> +
>> +  For pm8901 l0, l1, l2, l3, l4, l5, l6, s0, s1, s2, s3, s4, lvs0, lvs1, lvs2, lvs3,
>> +  mvs
>> +
>> +  For pm8921 s1, s2, s3, s4, s7, s8, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
>> +  l12, l14, l15, l16, l17, l18, l21, l22, l23, l24, l25, l26, l27, l28,
>> +  l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
>> +  ncp
>> +
>> +  For pm8018 s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
>> +  l12, l14, lvs1
>> +
>> +  For smb208 s1a, s1b, s2a, s2b
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,rpm-pm8058-regulators
>> +      - qcom,rpm-pm8901-regulators
>> +      - qcom,rpm-pm8921-regulators
>> +      - qcom,rpm-pm8018-regulators
>> +      - qcom,rpm-smb208-regulators
>> +
>> +patternProperties:
>> +  ".*-supply$":
>> +    description: Input supply phandle(s) for this node
>> +
>> +  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switch)$":
>> +    description: List of regulators and its properties
>> +    $ref: regulator.yaml#
> 
>         unevaluatedProperties: false

Ack

> 
>> +    properties:
>> +      bias-pull-down:
>> +        description: enable pull down of the regulator when inactive
>> +        type: boolean
>> +
>> +      qcom,switch-mode-frequency:
>> +        description: Frequency (Hz) of the switch-mode power supply
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum:
>> +          - 19200000
>> +          - 9600000
>> +          - 6400000
>> +          - 4800000
>> +          - 3840000
>> +          - 3200000
>> +          - 2740000
>> +          - 2400000
>> +          - 2130000
>> +          - 1920000
>> +          - 1750000
>> +          - 1600000
>> +          - 1480000
>> +          - 1370000
>> +          - 1280000
>> +          - 1200000
>> +
>> +      qcom,force-mode:
>> +        description: Indicates that the regulator should be forced to a particular mode
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum:
>> +          - 0 # QCOM_RPM_FORCE_MODE_NONE do not force any mode
>> +          - 1 # QCOM_RPM_FORCE_MODE_LPM force into low power mode
>> +          - 2 # QCOM_RPM_FORCE_MODE_HPM force into high power mode
>> +          - 3 # QCOM_RPM_FORCE_MODE_AUTO allow regulator to automatically select its own mode
>> +              # based on realtime current draw, only for pm8921 smps and ftsmps
>> +
>> +      qcom,power-mode-hysteretic:
>> +        description: select that the power supply should operate in hysteretic mode,
>> +          instead of the default pwm mode
>> +        type: boolean
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/mfd/qcom-rpm.h>
>> +    regulators {
>> +      compatible = "qcom,rpm-pm8921-regulators";
>> +      vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
>> +
>> +      s1 {
>> +        regulator-min-microvolt = <1225000>;
>> +        regulator-max-microvolt = <1225000>;
>> +
>> +        bias-pull-down;
>> +
>> +        qcom,switch-mode-frequency = <3200000>;
>> +      };
>> +
>> +      pm8921_s4: s4 {
>> +        regulator-min-microvolt = <1800000>;
>> +        regulator-max-microvolt = <1800000>;
>> +
>> +        qcom,switch-mode-frequency = <1600000>;
>> +        bias-pull-down;
>> +
>> +        qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
>> +      };
>> +    };
>> +...
>>
>> -- 
>> b4 0.10.1
>>

Thanks,
Neil
