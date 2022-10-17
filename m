Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFA60114D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJQOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJQOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:39:55 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5215715;
        Mon, 17 Oct 2022 07:39:52 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id p127so11655764oih.9;
        Mon, 17 Oct 2022 07:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPwfPK3EvtxcAdNM3QeXgKohvai02yl2ezXKG6UBn74=;
        b=Q+k7golip2pWVZTZg5xm8LEtaMhqb+ZSx4wMi45Vj/HpQPNWTn8vfB5IUpqd5Ncy+8
         yJXchghi9Xn2eYmCpiBQ0W3bad9ds1ujwXiBDkk4WnZdqWivsiRPWYQ/9u0g7Lq9NHhy
         ax6PJOp3NYZlogKBv7XOIbYQA1v/aPt+A/MZ/uNtefMYixp1FtKk3pJHLWERSSemS/bp
         dwaLI7B7Y1mZNsGw/312JbtdeXXz/yg72TtvNQuJgE7O/H4r0dPALiHUBr1remTZcvSn
         HBeOvtTqncFcB6SKPNQKt4+ljpRN0af5Kx6Wh2KkWe5tKmQO6sVUSd1az3Uy+ldyJ3Fm
         pABA==
X-Gm-Message-State: ACrzQf25ShXgNtlfTxAu8hyu8X4CFGY02/U3x5gEOKC4r8i4tEFNUUAD
        WXSheu+dTh1RhWL0K7xbuA==
X-Google-Smtp-Source: AMsMyM6Oi+bR18VwQXoDoTir4Z1EcavucRzsc5p6cuq8sMvK11mcn/J+Aq90KODUyH2oeXFsokClYQ==
X-Received: by 2002:a05:6808:10cc:b0:355:2dff:5e14 with SMTP id s12-20020a05680810cc00b003552dff5e14mr4200598ois.103.1666017591447;
        Mon, 17 Oct 2022 07:39:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p35-20020a4a95e6000000b00475f26931c8sm4277093ooi.13.2022.10.17.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:39:51 -0700 (PDT)
Received: (nullmailer pid 1438031 invoked by uid 1000);
        Mon, 17 Oct 2022 14:39:51 -0000
Date:   Mon, 17 Oct 2022 09:39:51 -0500
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
Subject: Re: [PATCH v2 4/5] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Message-ID: <20221017143951.GA1434507-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v2-4-639fe67a04be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v2-4-639fe67a04be@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 12:23:08PM +0200, Neil Armstrong wrote:
> Convert the non-SMD Regulators bindings to dt-schema, the old text based
> bindings will be deleted later since the RPM bindings are not yet converted.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
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

Fix your capslock.

> +
> +description:
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
