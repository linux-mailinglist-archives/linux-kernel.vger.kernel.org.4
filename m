Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2316984F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBOTvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBOTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:51:46 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD6341B43;
        Wed, 15 Feb 2023 11:51:28 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x24-20020a9d4598000000b00690bf2011b2so2461ote.6;
        Wed, 15 Feb 2023 11:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+iuWlg41wdj9dsD9ORs/lnnSLbHgXl/OfpkvXkGtHs=;
        b=U5Sdo59u0cs083SmSLQpSEdmDf+yTgO7sLNwPz6vf6Neq3oAZOpDPtcQdgFR2WtrP0
         jk6gkmBQ8B19QkjC89Aoy/gaJ9HnPrskkqMvfvhLnyShn7yqNQZQ/gXBsW7IYVqkRxjF
         alDgfLiW49GiYWTcP42QhSFK4iv6JDBSTbwhOIIAbp6LbcCd6WFXS8RDyB3B59Vw9Lnj
         7GcycruoklEJtOdty7lTkR+0Caj+YqALeJN+iXww83mAP86iL5p0kTKHBC3lkXAwamle
         m9hsgY0T/e7VeURDYTD2CABjSMQ81O/3uarGq4I0GrPnSw1bNKOVpYxjrwKYlZSfyATE
         HQWQ==
X-Gm-Message-State: AO0yUKW6uy6dJDdmsxRW9l5NKVZX1J3KiuWYaJFASqKJOmY2by6GhAQQ
        yfBnSJO6ve13+i3IjImlOyVYEFZdJA==
X-Google-Smtp-Source: AK7set9vg3F2/fpcnJD4aal3lfEtigJLUSjMzaiQ4iS1okk2WkDSxToxUr2UntVD7TP27C1xl5blSQ==
X-Received: by 2002:a05:6830:129a:b0:68b:dc52:10f9 with SMTP id z26-20020a056830129a00b0068bdc5210f9mr1512185otp.5.1676490586196;
        Wed, 15 Feb 2023 11:49:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a05683020ce00b0068bb6043362sm7888188otq.11.2023.02.15.11.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:49:45 -0800 (PST)
Received: (nullmailer pid 461289 invoked by uid 1000);
        Wed, 15 Feb 2023 19:49:45 -0000
Date:   Wed, 15 Feb 2023 13:49:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Message-ID: <20230215194945.GA458740-robh@kernel.org>
References: <cover.1676289084.git.zhoubinbin@loongson.cn>
 <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 08:15:27PM +0800, Binbin Zhou wrote:
> Add Loongson Extended I/O Interrupt controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../loongson,eiointc.yaml                     | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> new file mode 100644
> index 000000000000..88580297f955
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Loongson Extended I/O Interrupt Controller
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +description: |
> +  This interrupt controller is found on the Loongson-3 family chips and
> +  Loongson-2K0500 chip and is used to distribute interrupts directly to
> +  individual cores without forwarding them through the HT's interrupt line.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,eiointc-1.0
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    description:
> +      Interrupt source of the CPU interrupts.
> +
> +  interrupt-names:
> +    description:
> +      List of names for the parent interrupts.
> +    items:
> +      - const: int0

Why do you need this if there is only 1 interrupt?

Rob
