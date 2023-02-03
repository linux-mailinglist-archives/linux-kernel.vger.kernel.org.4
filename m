Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534FD68A443
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjBCVIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjBCVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:08:14 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DDAF539;
        Fri,  3 Feb 2023 13:06:56 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 20so4485649oix.5;
        Fri, 03 Feb 2023 13:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M3uCygjl6A7JEgAG4k6+cW+0sg8+m53vsWpI9AOYpU=;
        b=647zWnkQFz0Xl6IfS49gNxT3GGpnWPu/Pynls/qASVM0W2zXQuKoluddJYDRph5C2n
         n4Lpx/shk3EiblEbgj52JfnBb5ZGNced/HUpC9kFQBfBsxXJt4wzbw6CfCVRxLPBpCA2
         y4v8HIQXq0EeOfn5LAU0OSoUIKCZ4rEz4D9H15mK87XI1HtzbyAUT65yL11aGNT4SvOI
         Y0rWsxA6cemjPeF/0TgKWGIFa+Oc1+g0pr/slXNEJae8/JYPnF/MV+4F8WgdCJukIZ50
         eDwWv7jOkR+yCya570Z6L4X5oiMdvrsNV80EJPx3N7/ki9q8sE/8OlWGCOaqnO8abCDk
         ts2w==
X-Gm-Message-State: AO0yUKVEcMM3fp7nk2DrsSFBNtpZhNYmWnNvvpzGUVhgJt+1S4ojd7lE
        oIEVaSD95/dA1XoVAS7MvAQJVy81ow==
X-Google-Smtp-Source: AK7set+H/nG7YyvidvAYYh3VYdVW5g3Srm/T1GZeEAdyv/8iFdAFcD9Vzx0MLXCuqnk5RWAl3H/0OQ==
X-Received: by 2002:a05:6808:1187:b0:35e:d286:2317 with SMTP id j7-20020a056808118700b0035ed2862317mr6590582oil.25.1675458415510;
        Fri, 03 Feb 2023 13:06:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m38-20020a05683032a600b0068d56f93d73sm1598677ott.26.2023.02.03.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:06:55 -0800 (PST)
Received: (nullmailer pid 893142 invoked by uid 1000);
        Fri, 03 Feb 2023 21:06:54 -0000
Date:   Fri, 3 Feb 2023 15:06:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: mmio: new binding for MMIO
 accessible NVMEM devices
Message-ID: <20230203210654.GA877968-robh@kernel.org>
References: <20230201064717.18410-1-zajec5@gmail.com>
 <20230201064717.18410-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201064717.18410-2-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 07:47:14AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With the NVMEM layouts binding in place we should now use:
> 1. NVMEM device access bindings
> 2. NVMEM content description bindings
> 
> This binding allows describing NVMEM devices that can be MMIO accessed.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/mmio.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mmio.yaml b/Documentation/devicetree/bindings/nvmem/mmio.yaml
> new file mode 100644
> index 000000000000..27e3f6142769
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mmio.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/mmio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMIO access based NVMEM
> +
> +description: |
> +  This binding describes simple NVMEM devices that can be accessed by using MMIO
> +  (memory-mapped I/O access).
> +
> +  It's a generic solution for providing NVMEM content access. The way of
> +  handling actual content may be device specific and can be described using a
> +  proper layout.

Please add some guidance based on the discussion about when this should 
and shouldn't be used. Specifically, anything with potential write 
accesses should use a device specific compatible and not the generic 
one.

> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    const: mmio-nvmem
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-io-width:
> +    description: |
> +      The size (in bytes) of the IO accesses that should be performed
> +      on the device.
> +    enum: [1, 2, 4, 8]
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nvmem@10000 {
> +        compatible = "mmio-nvmem";
> +        reg = <0x10000000 0x10000>;
> +    };
> -- 
> 2.34.1
> 
