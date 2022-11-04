Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38761A37D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKDVjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKDVj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:39:28 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F82525C;
        Fri,  4 Nov 2022 14:39:26 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1322d768ba7so6934589fac.5;
        Fri, 04 Nov 2022 14:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNrDDbd2ckB4QxqFfPu/GEWK3hxpzOINt9kXLFu/pJY=;
        b=jWmafCaFqc34u7vRA2XUNtmXUWyP653XyYpLDt1HQLKr+tDZaK+nzFq9MkTfap4D1b
         1a67wRDmLM+mt9oxqkKbB/vSMlcjKsxsq4GBwa/hzs49sOEVRhbB/U8S/pVBgJqS5Rul
         lmPNIPMCFc54ka7jWA+QUlMYL6mFxvqSkjA+ju4jCSiEUuooRQa2EivC4TLwu/6FDoSk
         ud7TY1lse4tZL1l7nvVGxHKEqCGoMi7BY4hdigUK8qO9CtjT6VhA01PaOvskQnyzslj5
         9YlzMjFFAu+KHHwdqIx6q9tW9dP2Fcb8HKmnVQkpOf682E9Z/bV6RvsXrAA6Xp0gpV+t
         TkBQ==
X-Gm-Message-State: ACrzQf3rJwVbUjCxnd8H3T+oGgMJ6l8lIgYxQIEkqMYOklwWAwK8/1qv
        MEgF89/cv7zX+woBTAh57lR6Mn/MhQ==
X-Google-Smtp-Source: AMsMyM66fCIVOmqIVbbM/JEBQJ3oMaopqgVh6ohl0TDgf5KlyZvTuGwjkdVYJV3zpqIus/DhKRDFzg==
X-Received: by 2002:a05:6870:e3d1:b0:13c:9dbb:7e95 with SMTP id y17-20020a056870e3d100b0013c9dbb7e95mr23304388oad.43.1667597965724;
        Fri, 04 Nov 2022 14:39:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o30-20020a056870911e00b0012779ba00fesm96527oae.2.2022.11.04.14.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:39:25 -0700 (PDT)
Received: (nullmailer pid 2876774 invoked by uid 1000);
        Fri, 04 Nov 2022 21:39:27 -0000
Date:   Fri, 4 Nov 2022 16:39:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: [PATCH v7 2/2] dt-bindings: pinctrl: add loongson-2 pinctrl
Message-ID: <166759790887.2874515.1534518254921966295.robh@kernel.org>
References: <20221103080217.2533-1-zhuyinbo@loongson.cn>
 <20221103080217.2533-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103080217.2533-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 16:02:17 +0800, Yinbo Zhu wrote:
> Add the Loongson-2 pinctrl binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v7:
> 		1. Add all change log information.
> Change in v6:
> 		1. NO change, but other patch in this series patches set has
> 		   change.
> Change in v5:
> 		1. Drop dependencies.
> 		2. Add spaces after '='.
> 		3. Replace string loongson2 with loongson-2 in title.
> Change in v4:
> 		1. Replace Loongson2 with Loongson-2.
> Change in v3:
> 		1. Drop the quotes in "pinctrl.yaml#".
> 		2. Remove the items in function node.
> 		3. Add requird node for "group" and "function" in properties.
> Change in v2:
>                 1. Add "$ref to pinctrl.yaml".
>                 2. Put required after patternProperties.
>                 3. Add "additionalProperties: false" after '-pins$'
>                 4. Add "unevaluatedProperties: false" after 'pinmux$'
>                 5. Fixup the broken indentation in patternProperties node.
>                 6. Use 4 spaces for example indentation.
> 
>  .../pinctrl/loongson,ls2k-pinctrl.yaml        | 125 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

