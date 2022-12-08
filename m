Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB336466BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLHCJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHCJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:09:56 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320670616;
        Wed,  7 Dec 2022 18:09:56 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so98910otl.10;
        Wed, 07 Dec 2022 18:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVLUA4+byBBb5Ln2m9dCWWr48c4SZxEE3BQRnCIa2aw=;
        b=qIZM5aIH8l2o10s4AkG6JRVChdyg2Pr+wxWzfjVXqPUbwhxNrJ3uptVfbErO7vvCcf
         CpoHCbPChEAu2IEed3JKH6uf3rhhXpvpri7o1JppZuJTvFjTjJo9LQdYJsnLEfCHdK52
         BFpHE4hG3L9rrwHHfm2b5lzk1X24e0TW54AjNshzQuMD69ZoUVqK7n4/X5KD/L43lGG8
         RQxjjsDnEZm3pSyexHh8sBhBVZgHLfbWnvIKyGS7mIBUizVVVx5mx0YCdHI7KW1SoeUe
         JanrED3y2QpWWgJM3uOk9aLgv/rLNmsDiLpT728E+vQ74PmhkA60pbZ354eNuE4dk+UR
         GcIw==
X-Gm-Message-State: ANoB5pk7vDHuaXQR/Kj5X6S90zQCACTrg53nTa61g2x4fKYvG2ffFQ30
        2FabML//BxbTLQA6oY4xVg==
X-Google-Smtp-Source: AA0mqf4vaVnHDI+WM9WbPmItOyfJxH1BenXSZmazdiFTa/ilsVjrRR7uHFHlxsA9W+Z6qVLixy2hoQ==
X-Received: by 2002:a05:6830:1196:b0:670:6552:bac6 with SMTP id u22-20020a056830119600b006706552bac6mr2066715otq.313.1670465395193;
        Wed, 07 Dec 2022 18:09:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v2-20020a05683018c200b006706cd202b0sm617566ote.11.2022.12.07.18.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:09:54 -0800 (PST)
Received: (nullmailer pid 3371218 invoked by uid 1000);
        Thu, 08 Dec 2022 02:09:54 -0000
Date:   Wed, 7 Dec 2022 20:09:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: interrupt-controller: add yaml for
 LoongArch CPU interrupt controller
Message-ID: <20221208020954.GA3368836-robh@kernel.org>
References: <20221114113824.1880-1-liupeibao@loongson.cn>
 <20221114113824.1880-3-liupeibao@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114113824.1880-3-liupeibao@loongson.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:38:24PM +0800, Liu Peibao wrote:
> Current LoongArch compatible CPUs support 14 CPU IRQs. We can describe how
> the 14 IRQs are wired to the platform's internal interrupt controller by
> devicetree.
> 
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
>  .../loongarch,cpu-interrupt-controller.yaml   | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
> new file mode 100644
> index 000000000000..2a1cf885c99d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/loongarch,cpu-interrupt-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LoongArch CPU Interrupt Controller
> +
> +maintainers:
> +  - Liu Peibao <liupeibao@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongarch,cpu-interrupt-controller

This doesn't match what the kernel is using. It has loongson rather than 
loongarch. Please send an incremental fix. (Don't forget the example)

Rob
