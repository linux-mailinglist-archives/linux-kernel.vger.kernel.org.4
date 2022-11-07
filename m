Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ECF61FF1D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiKGUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKGUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:06:00 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922527CC3;
        Mon,  7 Nov 2022 12:05:59 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso7204976otb.2;
        Mon, 07 Nov 2022 12:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzxwEFNUScRHad0GSitNuAPUAQgYGoYkKZUbn1eKG18=;
        b=Pk7c3069xNX4M+ZFbRx1Kg4eokduxQiU4Ya7kmipQd6L8+/a6//TQfwWAvHhWxxTEv
         /dQvBT0WD8rQzh5IPiIjLlaez7mffx5zbRRIcC/KqSaDIKsQmW0SBFh/vJGTwEhrcTYW
         mPB8mC7OuvaGEP9j9ycemv+J6NPRuAbKJewyyrC5reKwPpEiu11JsVdKSRk+tYuJBAVu
         aPLWgiQme7jCVt7a8Hqp49AUZAkC6xhi8Wa215qfSbluW3rHjw82SCTAcRU8FFrvUVKY
         IoDi6O6HogkLk0QoW53xkl1RQMd2Uw7NNnVQ27JXIwFtW7UzztWkUmN7dGV0i8GTZMfZ
         31gg==
X-Gm-Message-State: ACrzQf0Asqv0GGV8K9RVMril0+v3ho0ydyRvzXeNVYndArt/QWUBm5C2
        +RcLk1bfiAmkcrn7w49Bhb0jTW2nGA==
X-Google-Smtp-Source: AMsMyM5F0ZUoojX9ufwQfzy1dN0QLHEBHTBy2a9TmPWOTk7MHOTPAWpdcmmZ5GfaQLGlHKVMLnBdiQ==
X-Received: by 2002:a05:6830:410b:b0:66c:9a3a:53e with SMTP id w11-20020a056830410b00b0066c9a3a053emr8419415ott.225.1667851558934;
        Mon, 07 Nov 2022 12:05:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a4a9506000000b0049201e2b8f4sm2522674ooi.4.2022.11.07.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:05:58 -0800 (PST)
Received: (nullmailer pid 1504075 invoked by uid 1000);
        Mon, 07 Nov 2022 20:06:00 -0000
Date:   Mon, 7 Nov 2022 14:06:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: timestamp: Add Tegra234 support
Message-ID: <20221107200600.GA1489762-robh@kernel.org>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-5-dipenp@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:45:20AM -0700, Dipen Patel wrote:
> Added timestamp provider support for the Tegra234 in devicetree
> bindings.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../timestamp/nvidia,tegra194-hte.yaml        | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> index c31e207d1652..158dbe58c49f 100644
> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Tegra194 on chip generic hardware timestamping engine (HTE)
> +title: Tegra on chip generic hardware timestamping engine (HTE) provider
>  
>  maintainers:
>    - Dipen Patel <dipenp@nvidia.com>
> @@ -23,6 +23,8 @@ properties:
>      enum:
>        - nvidia,tegra194-gte-aon
>        - nvidia,tegra194-gte-lic
> +      - nvidia,tegra234-gte-aon
> +      - nvidia,tegra234-gte-lic

How is the h/w in this chip different from the existing one? I'm 
assuming it must be because you don't have a fallback compatible.

>  
>    reg:
>      maxItems: 1
> @@ -43,9 +45,8 @@ properties:
>      description:
>        HTE lines are arranged in 32 bit slice where each bit represents different
>        line/signal that it can enable/configure for the timestamp. It is u32
> -      property and depends on the HTE instance in the chip. The value 3 is for
> -      GPIO GTE and 11 for IRQ GTE.
> -    enum: [3, 11]
> +      property and the value depends on the HTE instance in the chip.

If this statement was true, then this property makes sense...

> +    enum: [3, 11, 17]
>  
>    '#timestamp-cells':
>      description:
> @@ -55,6 +56,41 @@ properties:
>        mentioned in the nvidia GPIO device tree binding document.
>      const: 1
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-gte-aon
> +              - nvidia,tegra234-gte-aon
> +    then:
> +      properties:
> +        nvidia,slices:
> +          const: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-gte-lic
> +    then:
> +      properties:
> +        nvidia,slices:
> +          const: 11
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-gte-lic
> +    then:
> +      properties:
> +        nvidia,slices:
> +          const: 17

However, if there is only one possible value for each compatible, then 
being per instance can't really be true. I guess 'aon' or 'lic' define 
the instance? That's not normal practice. Are there other differences?

It seems like 'nvidia,slices' should be implied from the compatible 
string.

Rob
