Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50BC61187F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ1Q7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJ1Q6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:58:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2D22D590
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:58:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g16so3839097qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58GOvMV52uUxymQqy5aVEfV+16WqrWo4mtephS1+1JE=;
        b=TfsR+4Q8amUxOC/VIrn26+llDPbMbmr0tVb/4VNpnntTnGkZAbztx7/NYxVHCFEAzb
         4uIcVrmnIUpgFpryo3NVtdThUvoqZl626HnTt4uLMA6cbCJVSah8KLoXpU7rfM6gL0ru
         n44aQHuG1mCqYNF0dCoi2/raBOwLrijnsSzZqHs8RYYpbQYIvIL2vPgVPM1hN5rkS9I7
         S/IxFYUZ89QCwK2nfK6krgFOp90GfVdQGYwYzAw9qKSRz6IACl5k1liMk3cw1FQ1NqBq
         r+KDuzkbH7s2WtIhoXDCn3Q+gxJI2i/0vG3t2ZWoo7cJPRvZ92qdZcppYOkp2ffYrWx9
         WcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58GOvMV52uUxymQqy5aVEfV+16WqrWo4mtephS1+1JE=;
        b=xLA1kgZLEzRAooBD9zxWxVL4OG8H7gfCMkRFFsfYjRsZQxIBC6Z+EApe6cIF1ZuN3A
         D7R1GFrclA+XM+5/b9OVRPJ5EcNVczkTo+fcEijrFWn8C9mNYwsuxP7B/QNRYJZzogxM
         hTm7aaZt3t6zRy2vgl7b5SIpsZ9Ivfy8DBWW0vF+xHl1Vi8Aov4o12edjOpYtcXBvz/K
         //lGBF4QOicsviguk3aOt66onPy2ZVvQ4EEL3h8N2eT1XOn64mnfA5GP5JSdzEQBRoWP
         nE09I74fbA23HEjuwVrKyZVBe+B6T2s6wyQZ4G05VMI9hmaA9yxgDZng+7Vgohrs16kG
         5oXg==
X-Gm-Message-State: ACrzQf0kGwo+M2/nqIW/pXip+MaDQwbOpI1F6bu7dP5HkHX/AisNbL1L
        F8UpZ99NruqkPcBqUOLXndBpWg==
X-Google-Smtp-Source: AMsMyM7QDV4uNhKRw3MgZMaE0KjQ2UyAsevxvY+yJec6Rce4EyZVk3duRZFCxbpuEPeaJ55jJPdTDg==
X-Received: by 2002:a05:622a:58d:b0:39c:d5e3:2346 with SMTP id c13-20020a05622a058d00b0039cd5e32346mr348259qtb.227.1666976298720;
        Fri, 28 Oct 2022 09:58:18 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id r22-20020ac84256000000b0039467aadeb8sm2315719qtm.13.2022.10.28.09.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:58:18 -0700 (PDT)
Message-ID: <7522b13d-ad50-f2bc-1242-97a23d15c3b1@linaro.org>
Date:   Fri, 28 Oct 2022 12:58:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] dt-bindings: thermal: Add qcom,qmi-tmd-device and
 qcom,tmd-device yaml bindings
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.linux@gmail.com
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
 <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 12/09/2022 04:50, Bhupesh Sharma wrote:
> Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings.
> 
> Qualcomm QMI based TMD cooling device(s) are used for various
> mitigations for remote subsystem(s) including remote processor
> mitigation, rail voltage restriction etc.
> 
> Each child node represents one remote subsystem and each child
> of this subsystem in-turn represents separate TMD cooling device.
> 
> Cc: daniel.lezcano@linaro.org
> Cc: rafael@kernel.org
> Cc: andersson@kernel.org
> Cc: robh@kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../bindings/thermal/qcom,qmi-tmd-device.yaml |  78 +++++++++++
>  .../bindings/thermal/qcom,tmd-device.yaml     | 122 ++++++++++++++++++
>  include/dt-bindings/thermal/qcom,tmd.h        |  14 ++

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

>  3 files changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
>  create mode 100644 include/dt-bindings/thermal/qcom,tmd.h
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
> new file mode 100644
> index 000000000000..dfda5b611a93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/thermal/qcom,qmi-tmd-device.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes.

> +
> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description:
> +  Qualcomm QMI based TMD cooling device(s) are used for various
> +  mitigations for remote subsystem(s) including remote processor
> +  mitigation, rail voltage restriction etc.
> +
> +properties:
> +  $nodename:
> +    const: qmi-tmd-devices

Why enforcing node name?
> +
> +  compatible:
> +    items:
> +      - const: qcom,qmi-tmd-devices
> +
> +  modem0:

Why 0? Do you think it will grow for more devices?

> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +  adsp:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +  cdsp:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +  slpi:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/qcom,tmd.h>
> +    qmi-tmd-devices {
> +      compatible = "qcom,qmi-tmd-devices";
> +
> +      modem0 {
> +        qcom,instance-id = <MODEM0_INSTANCE_ID>;
> +
> +        modem0_pa: tmd-device0 {
> +          label = "pa";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_proc: tmd-device1 {
> +          label = "modem";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_current: tmd-device2 {
> +          label = "modem_current";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_skin: tmd-device3 {
> +          label = "modem_skin";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_vdd: tmd-device4 {
> +          label = "cpuv_restriction_cold";
> +          #cooling-cells = <2>;
> +        };
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml b/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
> new file mode 100644
> index 000000000000..38ac62f03376
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/thermal/qcom,tmd-device.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm thermal mitigation (TMD) cooling devices
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description:
> +  Qualcomm thermal mitigation (TMD) cooling devices. Each child node
> +  represents one remote subsystem and each child of this subsystem in-turn
> +  represents separate cooling devices.
> +
> +properties:
> +  $nodename:
> +    pattern: "^(modem|adsp|cdsp|slpi[0-9])?$"

No need to enforce node name.

> +
> +  qcom,instance-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Remote subsystem QMI server instance id to be used for communicating with QMI.
> +
> +patternProperties:
> +  "^tmd-device[0-9]?$":
> +    type: object
> +    description:
> +      Subnodes indicating tmd cooling device of a specific category.
> +    properties:
> +      label:
> +        maxItems: 1
> +        description: |
> +          Remote subsystem device identifier. Acceptable device names -
> +          "pa" -> for pa cooling device,
> +          "cpuv_restriction_cold" -> for vdd restriction,
> +          "cx_vdd_limit" -> for vdd limit,
> +          "modem" -> for processor passive cooling device,
> +          "modem_current" -> for current limiting device,
> +          "modem_bw" ->  for bus bandwidth limiting device,
> +          "cpr_cold" -> for cpr restriction.

Why these are acceptable and others are not? What does it mean here the
"acceptable"?

Best regards,
Krzysztof

