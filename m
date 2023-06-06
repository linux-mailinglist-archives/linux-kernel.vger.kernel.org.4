Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC8A7237CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjFFGgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjFFGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:36:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF54E49
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:36:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-97000a039b2so899482566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686033373; x=1688625373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZOzjrYJ8vg5ALOYOGUwj9aJcj7UgxzEF98joZ3xLB8=;
        b=yncnrNe45sOUCtZ8rykwKmev+OL7Rj6l6op9Iahkmb0PLANZqmGrAMF+l0u5hLOjjx
         y+XdutT8bGIqf6Om7CAxnIu895wSze/B4A9J4ZsyPjrZiAWi9jdhh2ss3du8vJH9H2ak
         A5ZDSWzamPB5T2oafW/TSn5oFTGSlmVLc7j89lNiUZjajZhcz3ElSWy5sEPfCuCuT1ds
         PRGfzEo7UoQrLtHEIZa7EdXZk7N2iI7LKX9UL1CAAkjRacmyTG67ojwJqkbp5FUOSTlx
         t+yMK7x2voBGF0VK+gISFr3flKXdWLHZbOMQyYdOvsEFW+ou09jDg1+VA4mFzYjQvd4K
         aHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033373; x=1688625373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZOzjrYJ8vg5ALOYOGUwj9aJcj7UgxzEF98joZ3xLB8=;
        b=JmpwjvK/4BlFzRjvagCCZ8hy5+rp9WIRRzmhHSVgD8bvVtC/UjL+vFFU9IKeZ7bnoy
         Le86mMvFnyShiRaJ9IiLzD5VbRF2hRy5AA7sWsjnZkokEDVEB/62+AG9konqf1Teitst
         bvqXCT4+TN+GHlJX+e6AvV62bXkmcAqPfN5NnqDxwjv/3S+ISkHDPMZm0VPl6rRxibbx
         hf2kT+SLSjt3w1gmeBdxf4tOPJfvqQFI68Dgo35XSAEvmKD1TAh1J7an2xVePPfOsWdA
         VbW/p4cZdJesP3PY8lZAwWmWnNMnb31tjRqzOBYLqH4gwwhxPpetkoqPb7yh73hHt/li
         L0uw==
X-Gm-Message-State: AC+VfDya5wKzscriAolqfIa0tVTTPPsL7YTbryxfqpU8Ti/6bJjTdDn2
        GR0k1bZ+RGpFhPde+d5ypqnObg==
X-Google-Smtp-Source: ACHHUZ4hm9ehBM1tm5O/uZUvcsyFtnRbE61r0zYdM66CtNloO+x91/38GZaLofn+fiPLwpJ3itq07A==
X-Received: by 2002:a17:906:9753:b0:94f:3980:bf91 with SMTP id o19-20020a170906975300b0094f3980bf91mr1619272ejy.19.1686033373499;
        Mon, 05 Jun 2023 23:36:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709063bc300b0096650f46004sm5120588ejf.56.2023.06.05.23.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:36:12 -0700 (PDT)
Message-ID: <2a479fd0-1d3c-2c28-d2fd-86a8cf610cf9@linaro.org>
Date:   Tue, 6 Jun 2023 08:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 05/14] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 09:08, Stephan Gerhold wrote:
> On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
> described as remote processors in the device tree, with a dedicated
> node where properties and services related to them can be described.
> 
> The Resource Power Manager (RPM) is also such a subsystem, with a
> remote processor that is running a special firmware. Unfortunately,
> the RPM never got a dedicated node representing it properly in the
> device tree. Most of the RPM services are described below a top-level
> /smd or /rpm-glink node.

Then what is rpm-requests? This is the true RPM. It looks like you now
duplicate half of it in a node above. Unless you want here to describe
ways to communicate with the RPM, not the RPM itself.


> However, SMD/GLINK is just one of the communication channels to the RPM
> firmware. For example, the MPM interrupt functionality provided by the
> RPM does not use SMD/GLINK but writes directly to a special memory
> region allocated by the RPM firmware in combination with a mailbox.
> Currently there is no good place in the device tree to describe this
> functionality. It doesn't belong below SMD/GLINK but it's not an
> independent top-level device either.
> 
> Introduce a new "qcom,rpm-proc" compatible that allows describing the
> RPM as a remote processor/subsystem like all others. The SMD/GLINK node
> is moved to a "smd-edge"/"glink-edge" subnode consistent with other
> existing bindings. Additional subnodes (e.g. interrupt-controller for
> MPM, rpm-master-stats) can be also added there.

If this was about to stay, you should also update the qcom,smd.yaml, so
there will be no duplication.

> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
> new file mode 100644
> index 000000000000..c06dd4f66503
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,rpm-proc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Resource Power Manager (RPM) Processor/Subsystem
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description:
> +  Resource Power Manager (RPM) subsystem found in various Qualcomm platforms.
> +  The RPM allows each component in the system to vote for state of the system
> +  resources, such as clocks, regulators and bus frequencies. rpm-proc is the
> +  top-level device tree node that groups all the RPM functionality together.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,apq8084-rpm-proc
> +          - qcom,ipq6018-rpm-proc
> +          - qcom,ipq9574-rpm-proc
> +          - qcom,mdm9607-rpm-proc
> +          - qcom,msm8226-rpm-proc
> +          - qcom,msm8610-rpm-proc
> +          - qcom,msm8909-rpm-proc
> +          - qcom,msm8916-rpm-proc
> +          - qcom,msm8917-rpm-proc
> +          - qcom,msm8936-rpm-proc
> +          - qcom,msm8937-rpm-proc
> +          - qcom,msm8952-rpm-proc
> +          - qcom,msm8953-rpm-proc
> +          - qcom,msm8974-rpm-proc
> +          - qcom,msm8976-rpm-proc
> +          - qcom,msm8994-rpm-proc
> +          - qcom,msm8996-rpm-proc
> +          - qcom,msm8998-rpm-proc
> +          - qcom,qcm2290-rpm-proc
> +          - qcom,qcs404-rpm-proc
> +          - qcom,sdm660-rpm-proc
> +          - qcom,sm6115-rpm-proc
> +          - qcom,sm6125-rpm-proc
> +          - qcom,sm6375-rpm-proc
> +      - const: qcom,rpm-proc
> +
> +  smd-edge:
> +    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
> +    description:
> +      Qualcomm Shared Memory subnode which represents communication edge,
> +      channels and devices related to the RPM subsystem.
> +
> +  glink-rpm:
> +    $ref: /schemas/remoteproc/qcom,glink-rpm-edge.yaml#
> +    description:
> +      Qualcomm G-Link subnode which represents communication edge,
> +      channels and devices related to the RPM subsystem.
> +
> +  interrupt-controller:
> +    type: object
> +    $ref: /schemas/interrupt-controller/qcom,mpm.yaml#
> +    description:
> +      MSM Power Manager (MPM) interrupt controller that monitors interrupts
> +      when the system is asleep.

Isn't this a service of RPM?

> +
> +  master-stats:
> +    $ref: /schemas/soc/qcom/qcom,rpm-master-stats.yaml#
> +    description:
> +      Subsystem-level low-power mode statistics provided by RPM.

The same question.

> +
> +required:
> +  - compatible
> +
> +oneOf:
> +  - required:
> +      - smd-edge
> +  - required:
> +      - glink-rpm
> +
> +additionalProperties: false
> +
> +examples:
> +  # SMD
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    remoteproc-rpm {

remoteproc

> +      compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
> +
> +      smd-edge {
> +        interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +        qcom,ipc = <&apcs 8 0>;
> +        qcom,smd-edge = <15>;
> +
> +        rpm-requests {
> +          compatible = "qcom,rpm-msm8916";
> +          qcom,smd-channels = "rpm_requests";
> +          /* ... */
> +        };
> +      };
> +    };
> +  # GLINK
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    remoteproc-rpm {

remoteproc

> +      compatible = "qcom,qcm2290-rpm-proc", "qcom,rpm-proc";
> +
> +      glink-rpm {
> +        compatible = "qcom,glink-rpm";
> +        interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> +        qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +        mboxes = <&apcs_glb 0>;
> +
> +        rpm-requests {
> +          compatible = "qcom,rpm-qcm2290";
> +          qcom,glink-channels = "rpm_requests";
> +          /* ... */
> +        };
> +      };
> +    };
> 

Best regards,
Krzysztof

