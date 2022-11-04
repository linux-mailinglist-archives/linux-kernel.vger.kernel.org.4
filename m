Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15BD619B28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiKDPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiKDPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:14:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60E65582
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:14:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k2so3222251qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSAQ8HyevbU1SRu/HWCnDYZ7sesPwd2iwJjeHcOhri0=;
        b=p9CminsN53qrFplpvggdvKqaLyOKNBrntrAp19vf9oPCrthGfFnypEKUwZg9xGCMK4
         tlAkh8aPlPv6bgVXnI5olTf9u/Jk3rpBLNGmBUk91noqbdvwrZpf2j+aV2dTz+9PhwK4
         +Ox755t9PDNDs+dx3ML4giDlVS5Mg55PCenbf87phpCV68riMhHT7ZLZcGZxvWVOstDC
         P46DQiP2YhibJHquAwbiwmnurl22WpSdPMvsQuY28y/29wsdM9RlKYMyEzBTV1X2Coxj
         nRQR27JtXxOwDZPkoCu95H2QrUb7E4jwsH7jm2Zhnz+qwD/bN7hNDaxtbe+eMo2s11wI
         xEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSAQ8HyevbU1SRu/HWCnDYZ7sesPwd2iwJjeHcOhri0=;
        b=1kjPXoMULSrS6B6S+MA8UJljwSjf7/GISXNchew6yb5haBdiOdvRgK+X6kxtlneDhT
         2uj9KZAKW8QCdgocm8YdAjkAoaImG+lLIYYWcBndHpwhph47pqYx33r2/F2yeaBTu5Jd
         +OjxuunRerkpUcT+IZwLvnBOn287bisv7kWL4jgONxoIiMuYuqveafE7LQdRLGoYHDMB
         KHFoB5t/a8UP6MaRfUAPpqmGrIpzPhVIqNlGtzL7TOjCwM5Nnw3Kqw+Ned/JigmGvU0b
         nmvLo4uQme3wdsLTZAUXmt/3tuPxdDgp2Xw8FgJ9hJFCbEYTUSlqTOTNAfFpKuUTXJhs
         T0zQ==
X-Gm-Message-State: ACrzQf3et0ZFUHpMX1a4EWujEaVrTIKovW8gkbL4VS9fndg+qM+NVw7m
        VpRID0uH8zochwNtvcBXcfO0cA==
X-Google-Smtp-Source: AMsMyM6iKfQ55uRl1/mtMB2lg88XM5Tn9yhOcXnHuhJnX4Ds+U0VSJAiSVrSxyVuJsRIDOFlmYrIxw==
X-Received: by 2002:a37:a8d2:0:b0:6f9:75d0:fddb with SMTP id r201-20020a37a8d2000000b006f975d0fddbmr27055868qke.101.1667574855536;
        Fri, 04 Nov 2022 08:14:15 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id e22-20020a05622a111600b003996aa171b9sm2579338qty.97.2022.11.04.08.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:14:14 -0700 (PDT)
Message-ID: <e17dbc8c-b2ba-6acf-7b56-85a246aaa765@linaro.org>
Date:   Fri, 4 Nov 2022 11:14:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221104044135.469797-1-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104044135.469797-1-thippeswamy.havalige@amd.com>
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

On 04/11/2022 00:41, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---


> +
> +title: Xilinx AXI PCIe Root Port Bridge
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-pcie-host-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ranges:
> +    items:
> +      - description: |
> +          ranges for the PCI memory regions (I/O space region is not
> +          supported by hardware)
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller:
> +    description: identifies the node as an interrupt controller
> +    type: object
> +    properties:
> +      interrupt-controller: true
> +
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - 'interrupt-controller'
> +      - '#address-cells'
> +      - '#interrupt-cells'

Use same style of quotes as in other places, either ' or "

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - interrupt-map
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pcie@50000000 {
> +        compatible = "xlnx,axi-pcie-host-1.00.a";
> +        reg = < 0x50000000 0x1000000 >;

Still wrong - no spaces around <>

Best regards,
Krzysztof

