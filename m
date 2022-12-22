Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6C65461A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLVSth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:49:32 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350420F4C;
        Thu, 22 Dec 2022 10:49:32 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id i127so2669870oif.8;
        Thu, 22 Dec 2022 10:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaCghvYX4zqIQSRPuINugLmKgprjE1HEO0untMrq5r4=;
        b=2qtm+bJPGl79q8HskDa0P1ZpaQQs/BQDCGSkW1WowvEcnhqfUufyP81DDVGVI1ySAS
         ub6ux0V6dJeM4TCd/TRQfraqpKWOdla/MqbD6hHhgAT0doWLMM18zQU5TuPJ6p4TWDOe
         x78iz6KRkzHNdvsXcHXNnaVZClm98c+9i2CESb/Xd22hnvT0P9e0rb9giNbGURqxs4fk
         IHck7GUnwcf4nVLTzLZUV4omZi36PusMp5A5kxMKNJLJLAiAFsVPhYEgQIU8V48f/7P0
         APYqtn2RatjFy5kEPZ0ukZrGujHOjPR97AIE1zvtDIVDWS/dOLQH8BIe/Hmg5Gc4jqjr
         0lbw==
X-Gm-Message-State: AFqh2kqUqyYFAu77vmkxae5y1XR1pQpyvjXhI4D4saxyE8iai8Iq/vFb
        /TOcN/7Abxg9j0OMjp5QQQ==
X-Google-Smtp-Source: AMrXdXtZLtFmRderXdXOtuvucKah+umvBa8SBMJB0TRrYFjgkxxQHQw9uYW4Q6UE/RewGts39YXWFw==
X-Received: by 2002:aca:1b09:0:b0:35e:18a6:cf70 with SMTP id b9-20020aca1b09000000b0035e18a6cf70mr3258190oib.50.1671734971474;
        Thu, 22 Dec 2022 10:49:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f18-20020a05680814d200b003544822f725sm642840oiw.8.2022.12.22.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 10:49:30 -0800 (PST)
Received: (nullmailer pid 1898844 invoked by uid 1000);
        Thu, 22 Dec 2022 18:49:29 -0000
Date:   Thu, 22 Dec 2022 12:49:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emekcan Aras <emekcan.aras@arm.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: Add Arm corstone500 platform
Message-ID: <20221222184929.GA1897073-robh@kernel.org>
References: <20221222123244.147238-1-emekcan.aras@arm.com>
 <20221222123244.147238-3-emekcan.aras@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222123244.147238-3-emekcan.aras@arm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:32:44PM +0000, Emekcan Aras wrote:
> Add bindings to describe implementation of
> the ARM Corstone500 platform.
> 
> Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
> ---
>  .../bindings/arm/arm,corstone500.yaml         | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,corstone500.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,corstone500.yaml b/Documentation/devicetree/bindings/arm/arm,corstone500.yaml
> new file mode 100644
> index 000000000000..cfe41f7760fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,corstone500.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,corstone500.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Corstone500

It's 'Arm' now. :)

> +
> +maintainers:
> +  - Emekcan Aras <emekcan.aras@arm.com>
> +  - Rui Miguel Silva <rui.silva@linaro.org>
> +
> +description: |+
> +  Corstone-500 is an ideal starting point for feature rich System on Chip
> +  (SoC) designs based on the Cortex-A5 core. These designs can be used in
> +  Internet of Things (IoT) and embedded products.
> +
> +  Corstone-500 includes most of the Arm IP in the SSE-500 subsystem and
> +  example integration layer, an FPGA, and access to modelling options.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - const: arm,corstone500
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.25.1
> 
> 
