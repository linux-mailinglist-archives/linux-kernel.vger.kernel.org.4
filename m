Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415E4729EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbjFIPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFIPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:38:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F3E35A3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:38:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-970056276acso291588366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686325124; x=1688917124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jorRTe9x5lJeJhWfN/tUaEbK9cETxBDWnzXXAk2nPIU=;
        b=LoTlSmKD8bjtAmd0AQnZrlssa8ZiOjN5pw90ZA+Nx4ze9+O4IXxvyRQJ12U+HCekvG
         NuIpZEEqfYz/lIwanx4zEDhAHu4nRAWAfVElS61M04uvzM++LbvDq9CNl4vf91hJIdPZ
         MaFmTMRgJbekFuzszLbGkriejLMK+WHquwo77er2yzrUuwirMAGYeoGnjKyLklLnr4j8
         MsBfXGpFcgOKxtiD2bZv6fsDPuEprwkIUp4SrOaC5qDQVh0TgfDLkud021KMQ7xJARKo
         J19bBo9p+IC9iSIoZLKFeccwg3VYNyZ3soF5xuFLrvJorMgcf1+Ee2n1ci0GD64UfQJL
         vu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325124; x=1688917124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jorRTe9x5lJeJhWfN/tUaEbK9cETxBDWnzXXAk2nPIU=;
        b=EUVzmZXv1BjNzaMuSlyc4wbaFsYHXHgmW36n6nPdY6vT8IiO6ZYm4iHpW1Y8TgFx29
         +6NK19oWKTAyDUbAlOvTGwSASVlvy13Gqb7dQhqvdxRg6B9QqihLO76b9ip7smFB6LzZ
         17TUfX6lE7DYix3oZm0vaChtou98lOKgiqiw3D5r/bXyAFKDGRQNp1i0TwBc/LRz2eMY
         3a21MLpQh1vJqGg6jYKEW6f8tGqF8/sWITkuVtITRercQ/CRVyy/3D4eHLJrWiPmoCUN
         cqK266Bfyxxnxl08+B7y4Hun0NnNF8PoiqSIsfyoIgREox4UOUjYnggt423jTEyTaAHW
         q66Q==
X-Gm-Message-State: AC+VfDxPIqDGc2k8cB30uOGztmcfhyH2+ZL1WXcYjKNkG7OYmKWecVHR
        NDi/4uGsPdiHx2KqFlEpVIUOGn2yr/ijeJjI3SI=
X-Google-Smtp-Source: ACHHUZ7Wu5jmfQjkYkox8N1dR5VIsH+RE9uA5DNord0lEbqHRXmFw/c2UNSs/zPBWk9kJ5cszg9boQ==
X-Received: by 2002:a17:906:fd85:b0:969:f54c:dee2 with SMTP id xa5-20020a170906fd8500b00969f54cdee2mr1905215ejb.26.1686325124285;
        Fri, 09 Jun 2023 08:38:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090680cc00b0096f7105b3a6sm1418119ejx.189.2023.06.09.08.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:38:43 -0700 (PDT)
Message-ID: <22e3c25e-487b-c02f-46f3-6d2ab2be8813@linaro.org>
Date:   Fri, 9 Jun 2023 17:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@amd.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, siva.durga.prasad.paladugu@amd.com,
        git@amd.com
References: <20230609110447.151235-1-piyush.mehta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609110447.151235-1-piyush.mehta@amd.com>
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

On 09/06/2023 13:04, Piyush Mehta wrote:
> Convert the binding to DT schema format. It also updates the
> reset-controller description.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> - Addressed the Krzysztof review comment:
>  - Update DT binding to fix the dt_binding_check warning.
> 

...

> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> new file mode 100644
> index 000000000000..a39b17599e05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/xlnx,zynqmp-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zynq UltraScale+ MPSoC and Versal reset binding

Drop "binding"

> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@amd.com>
> +
> +description: |
> +  The Zynq UltraScale+ MPSoC and Versal has several different resets.
> +
> +  The PS reset subsystem is responsible for handling the external reset
> +  input to the device and that all internal reset requirements are met
> +  for the system (as a whole) and for the functional units.
> +
> +  Please also refer to reset.txt in this directory for common reset
> +  controller binding usage. Device nodes that need access to reset
> +  lines should specify them as a reset phandle in their corresponding
> +  node as specified in reset.txt.
> +
> +  For list of all valid reset indices for Zynq UltraScale+ MPSoC
> +  <dt-bindings/reset/xlnx-zynqmp-resets.h>
> +
> +  For list of all valid reset indices for Versal
> +  <dt-bindings/reset/xlnx-versal-resets.h>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,zynqmp-reset
> +      - xlnx,versal-reset
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>

Drop, won't be needed after removing unrelated parts.

> +
> +    firmware {

Drop

> +        zynqmp_firmware: zynqmp-firmware {

Drop, three level of indentations for that simple reset-controller...

> +            zynqmp_reset: reset-controller {
> +                compatible = "xlnx,zynqmp-reset";
> +                #reset-cells = <1>;
> +            };
> +        };
> +    };
> +
> +    /* Specifying sata reset control of devices */
> +    sata {
> +        resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
> +        reset-names = "sata_rst";
> +    };

Drop this - not related.
> +
> +...

Best regards,
Krzysztof

