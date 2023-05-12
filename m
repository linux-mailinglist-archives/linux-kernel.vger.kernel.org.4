Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6857000CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjELGp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjELGp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:45:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F76E9D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:45:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so17490734a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683873924; x=1686465924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxmRIVgJbH21xI5omvFh5VfiTvl96m6s21/ADl6LOKI=;
        b=HjK/uNElZISVsBcR3CnWuOxRorqLrg3g3/2ajTw89MoeTxTFvlKRVjxviziGEvedUP
         Xwsta7e1NGBdDEu932SvMlOfRrBLQQLqZ6mMF48XKCCv7XYKrAGXXGC3M3vlBum9MEtF
         8VnV4Uu5RPkA9GL6I9gJrdd4pmTz+GWktuhqaIO6bwnA9ckRLEmi0BpLO10sTHUGDOPj
         +zDynNsKWt20BGkw5hyU/mfQKkmEY71Hepdxq7SAXFXC3lo2LB6aWkw8HR9fwtrLXFkZ
         H9THyFUtsJMlJqGBIJqlvvJbYjG5F8QUPHcJfnuFpLT5/6zmqzTJicYNAUoN8toOvnKm
         YPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683873924; x=1686465924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxmRIVgJbH21xI5omvFh5VfiTvl96m6s21/ADl6LOKI=;
        b=h8PFiiLPG3yq2ScEmiH1PwyfunhqDo5XQgdLAlSmNWeC//sK8SQ+5zKtubZmQ79QCZ
         Wc67me/ckfjyh0J6wJnxv8Gs43orCjjaXLxCPlK5P2Eos2NnMF/AhSEIy8w6fpmRCDdv
         nifgV2B9ijaSKjNHhOzQPkUAIXmXXyRx4dpNfuWhYUlltQTwdYo92MqxANVZlxFI2BPf
         iACeexX3APmvwtT8p44woX30x4VaxGHZsYEWY8Ii7UtHQxjRkYupDfXonxAzQmWRmhs6
         DxsMzHucde29xecjKUW2G3NZcAozfAsXZlR0lQZiosRqVF33iocorz0SopYzP5H1uweW
         mIqg==
X-Gm-Message-State: AC+VfDw44uSi8arR79YPT1G6tmiSsQYfEYAjSrJe1G/YRlM4MzGWFqdS
        vbQBORK7hW1uCIwy/7N6uG3DNQ==
X-Google-Smtp-Source: ACHHUZ7cZ6v/D1ylTqNsSevf4I0ePIDunMl9dS5fmkbpKoSNjDTH9PjNuamxaS3/L4amuhjroyUprg==
X-Received: by 2002:a17:907:2689:b0:961:272d:bda5 with SMTP id bn9-20020a170907268900b00961272dbda5mr20940240ejc.49.1683873923664;
        Thu, 11 May 2023 23:45:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060f9200b00965e1be3002sm4950840ejj.166.2023.05.11.23.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:45:23 -0700 (PDT)
Message-ID: <80ff83ab-d5e9-7a00-1099-a752330ef28d@linaro.org>
Date:   Fri, 12 May 2023 08:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/6] dt-bindings: Add support for tegra186-bpmp DRAM
 MRQ GSCs
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-6-pdeschrijver@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511132048.1122075-6-pdeschrijver@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 15:20, Peter De Schrijver wrote:
> Add memory-region property to the tegra186-bpmp binding to support
> DRAM MRQ GSCs.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../firmware/nvidia,tegra186-bpmp.yaml        | 37 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
> index 833c07f1685c..f3e02c9d090d 100644
> --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
> @@ -57,8 +57,11 @@ description: |
>    "#address-cells" or "#size-cells" property.
>  
>    The shared memory area for the IPC TX and RX between CPU and BPMP are
> -  predefined and work on top of sysram, which is an SRAM inside the
> -  chip. See ".../sram/sram.yaml" for the bindings.
> +  predefined and work on top of either sysram, which is an SRAM inside the
> +  chip, or in normal SDRAM.
> +  See ".../sram/sram.yaml" for the bindings for the SRAM case.
> +  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for bindings for
> +  the SDRAM case.
>  
>  properties:
>    compatible:
> @@ -81,6 +84,11 @@ properties:
>      minItems: 2
>      maxItems: 2
>  
> +  memory-region:
> +    description: phandle to reserved memory region used for IPC between
> +      CPU-NS and BPMP.
> +    maxItems: 1
> +
>    "#clock-cells":
>      const: 1
>  
> @@ -115,10 +123,15 @@ properties:
>  
>  additionalProperties: false
>  
> +oneOf:
> +  - required:
> +      - memory-region
> +  - required:
> +      - shmem
> +
>  required:
>    - compatible
>    - mboxes
> -  - shmem
>    - "#clock-cells"
>    - "#power-domain-cells"
>    - "#reset-cells"
> @@ -184,3 +197,21 @@ examples:
>              #thermal-sensor-cells = <1>;
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/mailbox/tegra186-hsp.h>
> +
> +    bpmp {
> +        compatible = "nvidia,tegra186-bpmp";
> +        interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
> +        interconnect-names = "read", "write", "dma-mem", "dma-write";
> +        mboxes = <&hsp_top1 TEGRA_HSP_MBOX_TYPE_DB
> +                            TEGRA_HSP_DB_MASTER_BPMP>;
> +        memory-region = <&dram_cpu_bpmp_mail>;

I am not sure if difference with one property justifies new example...

Best regards,
Krzysztof

