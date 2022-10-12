Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759345FC872
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJLPcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:32:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C3C695E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:31:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 8so3207706qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoV8mWntzVcAfAl3JXoUDwAhCZVSliB3wLU/NyVEXwU=;
        b=VyuN/nNatDf74KMBwFIFfCSQivpKpSpD9ESjBMxz3NW6mCzQAywWGakXKDe/EwvhjA
         UVSLYp2oqrC/g6Nd9S4QrRPNxYTvFwX4gl5R64orFhLCgpFV2B3neOVhY3I+0pyCfzcG
         GijF9/JtQ19/haPSrgKp8eAHyPPcwWfc7xV7JwuLY+IvoeKO5eiHsvLKWSRiRG4V550r
         9A1bU0IMAbl0jhI6RfWzlXSM8L2OTjujpNvxn/oU5hVh0+NgKiO7Wj0dJyM5XJ5VFlvl
         YkYr6cv1jQ3PGWNMtNbcLNn/KJUi6Cuf8CdlfzHIXj7j6TrDisARjpOdWFOGC+0/3UkN
         D7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoV8mWntzVcAfAl3JXoUDwAhCZVSliB3wLU/NyVEXwU=;
        b=AgWzeDE9ZDTO+3NKxwQjWrCH3vqbeL+uafrd6f9gksH6wXr1HHRzdLj4+qR1/zouzb
         NttWQ6scoXPeeJShsLcRaoBppi+uaHlWDK88brnh3JMtSFtjHk5EZhwNV1IMWZCZG4YI
         B9EC16Bsz5D69IQ4A/lQxqV7g/iRUhjF0PXY4oTBI7+8dLlbSyG8M8RmGYO//WVtszy4
         1RLDBvRikBOigDiUn5a8wPob5W5tH/1GByE2LHqVOw5K02SgcLOJPJQPf8Nee+8m40hn
         niN+k2HORJR+7XUOwykauWM6njzvYmsFskem3HPmK7bbohIFaiBo68R+lird/9dXLQDi
         TCuw==
X-Gm-Message-State: ACrzQf33vQkJ+OGuHaLWoKNsS+DJMu5P33VfDuNhTfGXS5g755+1hI9G
        ViYublOb6jqSfUGgX1i8oiisFg==
X-Google-Smtp-Source: AMsMyM6Rdj22kqr3e0wlZpFGK9jDuY9Gjwj7v+n72OmUgaqR6812NyzJhXQ8IbnACDj8n5J3lPCvuA==
X-Received: by 2002:a37:e205:0:b0:6ee:834:1a1b with SMTP id g5-20020a37e205000000b006ee08341a1bmr8712931qki.342.1665588718677;
        Wed, 12 Oct 2022 08:31:58 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006ee949b8051sm2360358qkp.51.2022.10.12.08.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:31:58 -0700 (PDT)
Message-ID: <fa60ba81-6cc7-7f78-55cc-9ca0053336b8@linaro.org>
Date:   Wed, 12 Oct 2022 11:29:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v10 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
 <20221011212501.2661003-2-tanmay.shah@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011212501.2661003-2-tanmay.shah@amd.com>
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

On 11/10/2022 17:24, Tanmay Shah wrote:
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v10:
>   - rename example node to remoteproc
> 
> Changes in v9:
>   - remove power-domains property description
>   - fix nitpicks in description of other properties
> 
> Changes in v8:
>   - Add 'items:' for sram property
> 
> Changes in v7:
>   - Add minItems in sram property
> 
> Changes in v6:
>   - Add maxItems to sram and memory-region property
> 
> Changes in v5:
> - Add constraints of the possible values of xlnx,cluster-mode property
> - fix description of power-domains property for r5 core
> - Remove reg, address-cells and size-cells properties as it is not required
> - Fix description of mboxes property
> - Add description of each memory-region and remove old .txt binding link
>   reference in the description
> 
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in example
> 
> Changes in v3:
>   - None
> 
>  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> new file mode 100644
> index 000000000000..8079b60b950e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

The convention is to have filename matching the compatible, so:
xlnx,zynqmp-r5fss.yaml

> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx R5F processor subsystem
> +
> +maintainers:
> +  - Ben Levinsky <ben.levinsky@amd.com>
> +  - Tanmay Shah <tanmay.shah@amd.com>
> +
> +description: |
> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> +  real-time processing based on the Cortex-R5F processor core from ARM.
> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> +  floating-point unit that implements the Arm VFPv3 instruction set.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-r5fss
> +



Best regards,
Krzysztof

