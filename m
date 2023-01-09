Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C86663312
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbjAIVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjAIVeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:34:37 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716D65FA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:12 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x6so926142ill.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k/HXONRGo7bZlsRB2uyBHqcf2aGFW3+zcgWlK/lbg0=;
        b=I1qFMZj+65WtjeSjsLTnAlwc6Yqecno8FeU0qKB0nJbpG0FBINRX2WY1Cl6scwCgcs
         0iQknR1D7q1U3VPGdwGqpE0PR2UObDZq1tTuyp/aqq/j6lhKsQmorB01zCjmmfFhxaz4
         BkCVhuGkWdX66N1aFeytJ0dPwvIdW0u6sES1ZuVtotwf5brkEMdym6VLT9d7GcYRdvPB
         y1cKDIjj0bpuFhH58NsGYxwFzR67j2QpgAIBQP9vPJFLRLk1gNKXOrO+2Kd3nkxfNJ97
         xg/XqxZ2g8dw4qleoExrqbBao2fzWUQkOMfn3whOq0+6dCSz+ymCFEa3kNfTzZ0DuFUo
         AbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k/HXONRGo7bZlsRB2uyBHqcf2aGFW3+zcgWlK/lbg0=;
        b=IZI+gYs0WR39ExrhMkhozdBo4xvFT3ChRJo5q2V/jEBZfHXeH3ohMpUNUVkmIqo8q2
         2CEoaKYDO61N4TC10/cppKdQeHu+lYDKXmt6PWWVsM9qS2ITzRQmyThz12O5ETcJvoGD
         itUqlupYk9P360tKc+QPLIi/k1zXqnAC+0ONcB89kL63t2KidwtY1SCZQQyAju+FO6tu
         P4n1/n4dfriYwtLDq4WbIBam3GtiPIbdpcQWt9ou62HlFlmI17A/NlGCpKxRhMkfkCNa
         c1P31Z8eIPIG3qAZcCKC7tlV0lNZfjVo7ig5BpHM7O7r+NcpPq9fWTizWE6VGQreX94V
         LPQQ==
X-Gm-Message-State: AFqh2kpTwvI4ZYOVAVfWBfFmarAufVkPzP33fYLHyQS2C9KLaM0p9hS6
        wGjx+u+mDF5T03wM7F4FJp9iew==
X-Google-Smtp-Source: AMrXdXv4Gkn298z+3bm+fxv8MeTlTlufXTUH/sZnchM9YS9rAquRgkS5A8qcFkk/F7t4rStpDU27GA==
X-Received: by 2002:a05:6e02:6d2:b0:303:5d8e:5bcf with SMTP id p18-20020a056e0206d200b003035d8e5bcfmr46922682ils.29.1673300052190;
        Mon, 09 Jan 2023 13:34:12 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id b8-20020a92ce08000000b0030bfdb6ef60sm2989949ilo.58.2023.01.09.13.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:11 -0800 (PST)
Message-ID: <10c02ba3-96cb-3c7e-3b19-04871276b24f@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 02/28] dt-bindings: Add binding for gunyah hypervisor
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-3-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20221219225850.2397345-3-quic_eberman@quicinc.com>
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

On 12/19/22 4:58 PM, Elliot Berman wrote:
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

At this point I have no input on this patch; if Rob's happy with the
bindings, that's good enough for me.

					-Alex
> ---
>   .../bindings/firmware/gunyah-hypervisor.yaml  | 82 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 83 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> new file mode 100644
> index 000000000000..9fd1d254b156
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
> +  - Murali Nalajala <quic_mnalajal@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |+
> +  Gunyah virtual machines use this information to determine the capability IDs
> +  of the message queues used to communicate with the Gunyah Resource Manager.
> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
> +
> +properties:
> +  compatible:
> +    const: gunyah-hypervisor
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1dd8f58d6e01..f32320a9efa4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8939,6 +8939,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>   M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Supported
> +F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   F:	Documentation/virt/gunyah/
>   
>   HABANALABS PCI DRIVER

