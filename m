Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F387F5FC865
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJLP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJLP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:27:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B4BA93C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:27:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o2so3456815qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyOn+XjhMrkROUZxuY81sZKNPsWKYHOGOyEQrBWv/Ko=;
        b=ILJgM3xVO0tv24Z1liMTbC+6lSxwxapAMZoN0MXneb4BfPvujCP63uAv25AZdl/yKU
         jTFPQoaN/IlwjiRq5nRvj3qfOniHoqBymUh6iYrsk9fHcbKizFtC6vSL3nkOMlVMtLzw
         vsl/p81LPGTQcw+q6JFLVnuHByT0oz87QPnJRmQQBAe2WT5nzBT697gWXdKlp1tKwwMi
         nBYaGiSs/T27onVYKKIeCSRXRx2VuJL6dSvLLQ8RslELgfYWbZ/3hjopXo3qH99ZnIlP
         6i27+VGlYnZMZOH/9R1RHTwxcrxC6zq2O0d9ysHImx3X/KDNDofj8d5/NiAw1tufh7X3
         BsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyOn+XjhMrkROUZxuY81sZKNPsWKYHOGOyEQrBWv/Ko=;
        b=df0o+HbC4AlL72v7JAI9G6vzVKL7STFa4TVrZO/kVLA4UGp6GHVfVvZA6Z4/nc59nc
         wlYIrtn9D2/OA2GG4/4PPqzoVuJX08C6WB72PBKRhq/+908f0EKIlcIvoNyg5nTVPXAD
         ZyVx2d5t4hZVIpFXWmli0FtND5BR3BHNW5E0gKgsl9AnytSOUjIrdZ8yp2drPc7IRdJA
         qzvjrdchnWRQZY+NqKVDbyP5z0OUyQc/l0Cd7o8sbj/a/WAAkh8d5HSFgiS2u8BMxtq/
         /1prGN2kXLACMFgjUHPP/WLXfZvRMMFKDnPtwVvtfSO+B3eS3i4hWy5W6M03f6t4UJ8V
         rSeg==
X-Gm-Message-State: ACrzQf0NUgrL7PJVIV8ocedTp5Th+7yAu1F8ALZAk5paStopXUOjDDVM
        TpOxRFUMe/ujuO4nDQEznqefEKGVSq1tVg==
X-Google-Smtp-Source: AMsMyM4itbCgzgNfgASHz/vlYDDlKaHFmCfg/cUdJzUglgTaIjdWhaDmIdu8FQnnBvkHuxYUpZYr+w==
X-Received: by 2002:a05:620a:4448:b0:6e2:5ec9:c697 with SMTP id w8-20020a05620a444800b006e25ec9c697mr20636959qkp.438.1665588433177;
        Wed, 12 Oct 2022 08:27:13 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a25c800b006cbe3be300esm15799584qko.12.2022.10.12.08.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:27:12 -0700 (PDT)
Message-ID: <78805233-0802-7a7e-f1b1-84c566084833@linaro.org>
Date:   Wed, 12 Oct 2022 11:24:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 1/5] dt-bindings: remoteproc: Add PRU consumer bindings
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <t-kristo@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Puranjay Mohan <p-mohan@ti.com>
References: <20221012114429.2341215-1-danishanwar@ti.com>
 <20221012114429.2341215-2-danishanwar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221012114429.2341215-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 07:44, MD Danish Anwar wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add a YAML binding document for PRU consumers. The binding includes

Add a DT schema binding for ...

Second thing: where is a user of this common binding? How do you apply
this schema to anything?

> all the common properties that can be used by different PRU consumer
> or application nodes and supported by the PRU remoteproc driver.
> These are used to configure the PRU hardware for specific user
> applications.
> 
> The application nodes themselves should define their own bindings.
> 
> Co-developed-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> new file mode 100644
> index 000000000000..16be98b7d600
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common TI PRU Consumer Binding
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  A PRU application/consumer/user node typically uses one or more PRU device
> +  nodes to implement a PRU application/functionality. Each application/client
> +  node would need a reference to at least a PRU node, and optionally define
> +  some properties needed for hardware/firmware configuration. The below
> +  properties are a list of common properties supported by the PRU remoteproc
> +  infrastructure.
> +
> +  The application nodes shall define their own bindings like regular platform
> +  devices, so below are in addition to each node's bindings.
> +
> +properties:
> +  ti,prus:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandles to the PRU, RTU or Tx_PRU nodes used
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      maxItems: 1
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    minItems: 1
> +    maxItems: 6
> +    description: |
> +      firmwares for the PRU cores, the default firmware for the core from
> +      the PRU node will be used if not provided. The firmware names should
> +      correspond to the PRU cores listed in the 'ti,prus' property
> +
> +  ti,pruss-gp-mux-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      enum: [0, 1, 2, 3, 4]
> +    description: |
> +      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
> +      This selects the internal muxing scheme for the PRU instance. Values
> +      should correspond to the PRU cores listed in the 'ti,prus' property. The
> +      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
> +      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
> +      same slice in the associative array. If the array size is smaller than
> +      the size of 'ti,prus' property, the default out-of-reset value (0) for the
> +      PRU core is used.
> +
> +required:
> +  - ti,prus
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    /* PRU application node full example */
> +    icssg2_eth: icssg2-eth {
> +      compatible = "ti,am654-icssg-prueth";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&icssg2_rgmii_pins_default>;
> +      sram = <&msmc_ram>;
> +      ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
> +        <&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;

Fix alignment. In other places as well.


> +      firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> +          "ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> +          "ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> +          "ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> +          "ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> +          "ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> +

Best regards,
Krzysztof

