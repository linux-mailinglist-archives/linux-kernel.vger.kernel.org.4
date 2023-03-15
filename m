Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626D6BA9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCOHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjCOHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:45:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF862332F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:44:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so28094272ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Xq5wxRGanCU084dldf05/HLWqQy9WdlKKe6PD7Zt8M=;
        b=OmGVRs5Os7Vv+4EkKyX2c3gkOv4cEACqA9RfB4BA3Y7h2bXUIn9Gy5W85dzNvp0wwy
         v1BaO4kV4DX96jVUVEFH/YSEKz7k6AqzRrq+35HRdy5y11Hx7CcckKX01MzQ5E41Aszt
         15VJQPsU6kJX9PmuPZk9THD0dfPFdaf5T4PUANohFk9OKD/co2OSpJn0GSH7XiXSkCfY
         E4WMg0e0kgpF5WRqywdG7L1Tagq+Xa7TEerHJEJcNLB7JtyHloHe6FkPVFSQtIKewUql
         pXexBNM0s4QKQ5z2CvIQ0OsYTsylLEKbYmoaoofP87kg+tRlEyMdWwrt9OjPIflCOEEA
         lhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xq5wxRGanCU084dldf05/HLWqQy9WdlKKe6PD7Zt8M=;
        b=uvC2+r3ncqxzFgW9yRDKEwfsC7izYxDY267nIh5tS3xevwmpTA/Otj8e6ymUsWUuiL
         DeIEqJkcX/83bX6WjwCph/IUjVgBj1UFAwt9BC3XIn0BPr8dRcylpJVJLgcU8OXLwzp4
         DVITC7jaNj19KgB01jeCcH2niJFpfJESmPwueBLEJHBqDqSq3Q2glRK4P3Dsq3r06BK1
         LkBBwbDS9qKMvS8wuWU1QxDjfmsozC/GmpKduKbGl4xhzs4OTRi/GTHLcOgIunN7ZSX0
         qlXaNWHaOlwLgDv7UcMB9bkN/B9x/svvBIk6bo6iC5VhYlvZnR3163zzzCFzC06kLcN4
         rgCA==
X-Gm-Message-State: AO0yUKWYuVcpuX+CGMo6MuS2MVb5ZoQbCI3DjtBQKfQ+tkvgcY+8sX5U
        8lp+rhdmsBLdt8PRwaGfa1QCKw==
X-Google-Smtp-Source: AK7set8MzP2lTGcLn28jbRXX6z+gna8IQ/2by8rQSHPJejx9TZ2M1EDVo+jHIfkYeCPA1UQx/UEr0Q==
X-Received: by 2002:a17:906:b88d:b0:8b1:806b:7dbb with SMTP id hb13-20020a170906b88d00b008b1806b7dbbmr5176621ejb.51.1678866298091;
        Wed, 15 Mar 2023 00:44:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id sa35-20020a1709076d2300b0092ce7c94332sm1738605ejc.148.2023.03.15.00.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:44:57 -0700 (PDT)
Message-ID: <3649d489-5783-8a66-63f3-a2c0d59e10c3@linaro.org>
Date:   Wed, 15 Mar 2023 08:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 12/13] media: dt-bindings: Add DT bindings for TI J721E
 CSI2RX driver
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, mripard@kernel.org, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        tomi.valkeinen@ideasonboard.com
Cc:     linux-kernel@vger.kernel.org, bparrot@ti.com,
        niklas.soderlund+renesas@ragnatech.se, j-luthra@ti.com,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com, martyn.welch@collabora.com
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-13-vaishnav.a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314115516.667-13-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 12:55, Vaishnav Achath wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> parts together.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---


> +$id: http://devicetree.org/schemas/media/ti,j721e-csi2rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI J721E CSI2RX Wrapper Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +description: |
> +  The TI J721E CSI2RX Wrapper is a wrapper around Cadence CSI2RX bridge that
> +  enables sending captured frames to memory over PSI-L DMA. In the J721E
> +  Technical Reference Manual (SPRUIL1B) it is referred to as "SHIM" under the
> +  CSI_RX_IF section.
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    items:

Drop items

> +      - const: ti,j721e-csi2rx
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: rx0
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +patternProperties:
> +  "^csi-bridge@":
> +    type: object
> +    description: CSI2 bridge node.
> +    $ref: cdns,csi2rx.yaml#

Your patch fails here. This error must be fixed or explain as dependency
in the patch changelog. Patch cannot be taken without that dependency.

Best regards,
Krzysztof

