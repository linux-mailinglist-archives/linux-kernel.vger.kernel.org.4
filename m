Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0872300B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjFETr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjFETr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:47:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3098F4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:47:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-777b0cae9ecso73095139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994438; x=1688586438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+K6g914agxSzdAPlI+h0RmOBH1n0CtAnyZzQVNjIUM=;
        b=LGPCz9DvKsyT9C8LZ9HHpOOrT9bXarBQQ+BVreynXf2mlZl2hNRCwGBsNlryPGc8Pj
         xpPDisLUTr2xtZgpybZjPFeBUdorJMXrAConsuhsjfWzExoSIn1TCIe87jfJQHKt40h0
         fWIB1MgHX78h5bxP1DvOh3li1dehPTwfeCoC7LjYMibTSGlHZadmzJV+VmrZ2pedViBE
         hwFqL+IHqxzpFWvp+ajunZH7d40P5DXlpE+K44PApHpL51fi7Cv9mkjXYJwIvOqy4QG8
         rFSKoMoe5kAubUNzxGQX6HyhT+rSuaLwOD9lVPV2Nrzr00L3oROWkf7o4XNXddpuqIjb
         gIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994438; x=1688586438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+K6g914agxSzdAPlI+h0RmOBH1n0CtAnyZzQVNjIUM=;
        b=k2d3cIc1GHVEG5RJFUDSCAy9MLTOZ9LaZay4mhNyor7nkOMpz2N93Xykj8q7/MKnpT
         fRI+m9Mzn1hcmbXzR+N/pUpiDPG0N9WX7J7H+GeaS5TIbEqsaMEErE4PZ+RUx0nN25AF
         tXKK3UREgki/BbpMmt4nlPqPnTDjndDiynZeso6MPqCPID0aE1yxyG7aWPCXpptJ0cs/
         WvarY27BuM/Wdpa+WhuLtRvPYHEf6o9KPsphZM613PXLrQ9OCI8Rf02+7cWudHXAhv1i
         WMEyzFTpPRXe2WS0T6BGhdig72z0lkB6TZKNLwdMi99ZXA+LzAJeBP+sNjWksr6vQihB
         5OvQ==
X-Gm-Message-State: AC+VfDzCmFlFh1evsOlQE+Te3nwgao9EX7IyaF4bXDj8nxfBtRYXieOk
        cJ32ke4xBDIOkDBYA66NNG3yVQ==
X-Google-Smtp-Source: ACHHUZ5SoD1YOSrw3jMzia5Q4kjhwaSzD+xdYs4pIbAN8BkuqCkgDEzo0mvuY5RckZGzss9s1JBa2g==
X-Received: by 2002:a6b:5909:0:b0:778:735c:9bed with SMTP id n9-20020a6b5909000000b00778735c9bedmr266718iob.0.1685994438313;
        Mon, 05 Jun 2023 12:47:18 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id g17-20020a05663811d100b0040fd1340997sm2408770jas.140.2023.06.05.12.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:47:18 -0700 (PDT)
Message-ID: <8ec23850-77af-7194-61dd-c3c1bf10ea00@linaro.org>
Date:   Mon, 5 Jun 2023 14:47:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 01/24] dt-bindings: Add binding for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-2-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-2-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
> Resource Manager applies a devicetree overlay describing the virtual
> platform configuration of the guest VM, such as the message queue
> capability IDs for communicating with the Resource Manager. This
> information is not otherwise discoverable by a VM: the Gunyah hypervisor
> core does not provide a direct interface to discover capability IDs nor
> a way to communicate with RM without having already known the
> corresponding message queue capability ID. Add the DT bindings that
> Gunyah adheres for the hypervisor node and message queues.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Rob has reviewed this so I presume it's fine, but I wonder
why there's no "qcom," prefix on the compatible strings.

It also seems like there might be more bindings to define
for Gunyah.  See a few more comments below.

					-Alex

> ---
>   .../bindings/firmware/gunyah-hypervisor.yaml  | 82 +++++++++++++++++++
>   1 file changed, 82 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> new file mode 100644
> index 000000000000..3fc0b043ac3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gunyah Hypervisor
> +
> +maintainers:
> +  - Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |+
> +  Gunyah virtual machines use this information to determine the capability IDs
> +  of the message queues used to communicate with the Gunyah Resource Manager.
> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c

Looking at dto_create_msg_queue() at the above link, it seems
that Gunyah message queues and capabilities get represented
in DTS, but I don't see those things documented in bindings.
I might be misinterpreting that code, but if not, should
these other things be documented as well?

> +
> +properties:
> +  compatible:
> +    const: gunyah-hypervisor

Should this be qcom,gunyah-hypervisor?

> +
> +  "#address-cells":
> +    description: Number of cells needed to represent 64-bit capability IDs.
> +    const: 2
> +
> +  "#size-cells":
> +    description: must be 0, because capability IDs are not memory address
> +                  ranges and do not have a size.
> +    const: 0
> +
> +patternProperties:
> +  "^gunyah-resource-mgr(@.*)?":
> +    type: object
> +    description:
> +      Resource Manager node which is required to communicate to Resource
> +      Manager VM using Gunyah Message Queues.
> +
> +    properties:
> +      compatible:
> +        const: gunyah-resource-manager

Here too, should this be qcom,gunyah-resource-manager?

> +
> +      reg:
> +        items:
> +          - description: Gunyah capability ID of the TX message queue
> +          - description: Gunyah capability ID of the RX message queue
> +
> +      interrupts:
> +        items:
> +          - description: Interrupt for the TX message queue
> +          - description: Interrupt for the RX message queue
> +
> +    additionalProperties: false
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    hypervisor {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "gunyah-hypervisor";
> +
> +        gunyah-resource-mgr@0 {
> +            compatible = "gunyah-resource-manager";
> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> +                  /* TX, RX cap ids */
> +        };
> +    };

