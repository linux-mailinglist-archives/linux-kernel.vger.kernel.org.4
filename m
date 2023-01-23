Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F9677622
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAWING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAWINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:13:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF91717C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:13:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d2so9947433wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vmftNUH4lJM4o0fNkA/Mo2hyPMGER9tgtwQaLax718=;
        b=CEmcLOfj2uvDlsYOFfECG5QQo4JiI2GmtU0n2XxyqOL1bKFVNhfJ1/+xG9c7Gdn9LR
         5WwlQ7E8XLdqIc9GgYHkGSOFz5wBs2OMXwVD82N7gP7gQj04Ivlt99ERv5AUh/UZDsNR
         g3dOMhaO/2LOy8qXRrQPLe0HcSFLVLis05909Xe0Agfyn5QqxRzxc6ofRoeYgjaX0XJh
         fq7tNfnzb7n891YjupRGBvu4HUgA4zVFs7BwZsFnNZMTAPLZcOwzetuKwbGqGM/cFXTh
         flK1UERpj2Z+YpqtvJwleYtcFX9c2NWvvDSuVUBwZ0797nRn4xn7RvPt9YZdGxuAfQkZ
         ykvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vmftNUH4lJM4o0fNkA/Mo2hyPMGER9tgtwQaLax718=;
        b=8Hb39CcSwLbAgwB7EkPZ/VDG/tJI88Ndt5eYBbU7ciK3yLi3N7rhOOnyUHO1uJ/Vcq
         zBsTrGee3/VJ42qx5qLltgYDTj0+FSFS83mf8SEYlYH6hb9qNmS4JD/L4pgo790Rkzjr
         RzM+pLPz++TCWo8aAJzsjXEakeuHedHA05nm24SE7PRG3UPv3eMZgHFWBeWthoZaPPdf
         wM5cMa6evJVT/NrngaVQ4qbx7aDh/VNFwVcMJ5nEBMSrPb0PTP8t9Gvuy20QlGAmJIxA
         eX3i+StnwJF3FeJjDcUvhOVipYLXGNcE+VAj5VckihQ9uOU5WrLtoZXNG74mAQGWszof
         e54w==
X-Gm-Message-State: AFqh2kr53EeXA9vQY4oO66wHJL+wgj7sxDpGU8+4rLy8uRQ0/AlJO54h
        0xCLvl8JwOI2HZAyGo/MqMr0kw==
X-Google-Smtp-Source: AMrXdXuwG3DQj4QQEJp6l1ReLzlEPBchCHBIwvu+r6Zfs2PgFt87jgzGiZo4ZgAND9u0Z90u0jypyA==
X-Received: by 2002:a05:6000:1b83:b0:2be:34f5:ac05 with SMTP id r3-20020a0560001b8300b002be34f5ac05mr14935369wru.0.1674461582432;
        Mon, 23 Jan 2023 00:13:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c24-20020adfa318000000b002366e3f1497sm4719097wrb.6.2023.01.23.00.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:13:02 -0800 (PST)
Message-ID: <f6545c08-3be2-523e-db21-81b2b9233743@linaro.org>
Date:   Mon, 23 Jan 2023 09:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 11/15] dt-bindings: mtd: Add binding for Ambarella
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Li Chen <me@linux.beauty>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY TECHNOLOGY DEVICES (MTD)" 
        <linux-mtd@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-12-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-12-lchen@ambarella.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 08:32, Li Chen wrote:
> Ambarella SoC contains nand flash controller.
> Add compatible for it.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: I4108699a0678ba45e5d4347cbd860bc552dd91dd
> ---
>  .../bindings/mtd/ambarella,nand.yaml          | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/ambarella,nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ambarella,nand.yaml b/Documentation/devicetree/bindings/mtd/ambarella,nand.yaml
> new file mode 100644
> index 000000000000..7c2e7c2ebc7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ambarella,nand.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/ambarella,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella NAND Controller
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>
> +
> +properties:
> +  compatible:
> +    - const: ambarella,nand
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 1

All your patches are weirder and weirder. Do you see such syntax in any
patches before?

Drop minItems.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 1

Drop both.

> +    items:
> +      - description: fio irq
> +
> +  clocks:
> +    maxItems: 1
> +    description: reference to the clock for the NAND controller
> +
> +  nand-on-flash-bbt:

OK, so this was for sure not tested.

Do not send untested patches.

Best regards,
Krzysztof

