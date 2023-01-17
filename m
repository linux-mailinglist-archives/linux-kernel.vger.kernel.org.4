Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9F66E604
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjAQSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjAQS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:29:37 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6164741E;
        Tue, 17 Jan 2023 10:01:02 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so8162321oom.9;
        Tue, 17 Jan 2023 10:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/kHOFH1wU0NreMHdddHDbHuXCpkHB1PoZhcRnQt444=;
        b=foCc1PFG7lYBexT6/8fkfiieupPw+yUWKOVHP2BP/rJxwJ+iP1fXirFkKgDzI/Qa4D
         EZzGo/EbvWRN627NhAb2M+NsDIoD5dd1uaINbLVstiCqf7m0CSbYU2vWkeBPkZWbVAAq
         c32/bO38RLbHr3WWC4FZy8T4aU+hWdLJBBw9dvYFh3F7SogOVmBEKmsrzte0n6NDzmbC
         m+xLZOMqDZbBLKi+DJhW0WAfwbvxh/9RD63V8axdpToc/ESemhiaS/VIC/QQO8niZ9r6
         sQUU9AAFfuLqi4RYhqGb2R9WVIrMDt/UokL0moYzRzRBLelOCDGb8P5Ch3ytui0fcv7M
         r/nA==
X-Gm-Message-State: AFqh2kqun0Ns/yMzVJNHuHbKMQA5pPcH9kqd9WR0VWAqg6rkOk4Y0d0H
        jfYJSb25/de7O5E7ei6URg==
X-Google-Smtp-Source: AMrXdXvcuKQfn+7icDnE4nUlh/ljNLsmHBHplIQtCw0qWiIdq35al99wEU9lDuQyulZvwL6n7ShSQA==
X-Received: by 2002:a05:6820:3c7:b0:4f8:2e60:6afd with SMTP id s7-20020a05682003c700b004f82e606afdmr1593239ooj.8.1673978460048;
        Tue, 17 Jan 2023 10:01:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p2-20020a4ab382000000b004d8c6815287sm15040211ooo.17.2023.01.17.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:00:59 -0800 (PST)
Received: (nullmailer pid 3319602 invoked by uid 1000);
        Tue, 17 Jan 2023 18:00:58 -0000
Date:   Tue, 17 Jan 2023 12:00:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK
 binding
Message-ID: <20230117180058.GA3314512-robh@kernel.org>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <20230113041132.4189268-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041132.4189268-2-quic_bjorande@quicinc.com>
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

On Thu, Jan 12, 2023 at 08:11:29PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
> platforms and implement USB Type-C handling and battery management.
> This binding describes the component in the OS used to communicate with
> the firmware and connect it's resources to those described in the
> Devicetree, particularly the USB Type-C controllers relationship with
> USB and DisplayPort components.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Added reg under connector, to identify multiple connectors
> - Updated maintainer email
> 
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml    | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> new file mode 100644
> index 000000000000..a79dd0ed9275
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PMIC GLINK firmware interface for battery management, USB
> +  Type-C and other things.
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description:
> +  The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
> +  platforms and implement USB Type-C handling and battery management. This
> +  binding describes the component in the OS used to communicate with the
> +  firmware and connect it's resources to those described in the Devicetree,
> +  particularly the USB Type-C controllers relationship with USB and DisplayPort
> +  components.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sc8180x-pmic-glink
> +          - qcom,sc8280xp-pmic-glink
> +          - qcom,sm8350-pmic-glink
> +      - const: qcom,pmic-glink
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^connector@\d$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +    properties:
> +      reg: true

       required:
         - reg

Or '@\d' needs to be optional.


> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    pmic-glink {
> +        compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        connector@0 {
> +            compatible = "usb-c-connector";
> +            reg = <0>;
> +            power-role = "dual";
> +            data-role = "dual";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    endpoint {
> +                        remote-endpoint = <&usb_role>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    endpoint@0 {
> +                        reg = <0>;
> +                        remote-endpoint = <&qmp_out>;
> +                    };
> +
> +                    endpoint@1 {
> +                        reg = <1>;
> +                        remote-endpoint = <&displayport_hpd>;
> +                    };
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    endpoint {
> +                        remote-endpoint = <&sbu_mux>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> +
> -- 
> 2.37.3
> 
