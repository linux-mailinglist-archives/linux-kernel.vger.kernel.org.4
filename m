Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7826BDBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCPWrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCPWrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:47:13 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5E6C6AE;
        Thu, 16 Mar 2023 15:47:13 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id o14so1519172ioa.3;
        Thu, 16 Mar 2023 15:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiqPZg2ZTgKffnR9XFMa4QhSTiutEFWHrj4g4T7n9Lw=;
        b=IT86h5iVI72ELwxDQTzjK7gOzdCPREeM5LjF3+pRNyeL/ydoSDzNINTZoW6UubzR4q
         RwsBCVR9fZVcXXUj6sb8nwgOXDcZ/YhrUtsrdTc1JJ7G8l3Q2SMC/kgapp1s857R+1qE
         ZhdcHU7nD7ZW48pnlyovB3LnnmVvLizS/KivUaa6KSXfQKDHQGY6CeMmOAI7GrIQsVnR
         u6WX305pKzg6YAiiDZTBfHoJtPsyf1jLpl8FTyelpipco59L8b9Nh7DI2mj2Kx3UwvWB
         id7dwahrSMaJ3Pt76O88c+ZU0nBUR37m5tF7U+ekXviewdtmZjCSqAuqlbCRvNQWrOBU
         rYAw==
X-Gm-Message-State: AO0yUKWoG14CN/ndJ47gRLEAwkXPa8zcYk6mSSzFRxeoNqBNafRJJnyU
        bxEJdK3hHmIyZ9xOZVhIMw==
X-Google-Smtp-Source: AK7set9v8zT4EFQnx1vHiQ/UkkNQXNwGxm3TKplHRez+qjRO74ICnrtsQor1FCUTOPSDJBtQseTlfQ==
X-Received: by 2002:a5d:8612:0:b0:74c:c239:ba57 with SMTP id f18-20020a5d8612000000b0074cc239ba57mr499547iol.1.1679006832245;
        Thu, 16 Mar 2023 15:47:12 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z9-20020a6b0a09000000b0074cda4bc4b8sm107074ioi.50.2023.03.16.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:47:11 -0700 (PDT)
Received: (nullmailer pid 4026428 invoked by uid 1000);
        Thu, 16 Mar 2023 22:47:10 -0000
Date:   Thu, 16 Mar 2023 17:47:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: armv7: Don't sanction
 address/size-cells values
Message-ID: <20230316224710.GA4017716-robh@kernel.org>
References: <20230308012854.294939-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308012854.294939-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:28:53AM +0100, Konrad Dybcio wrote:
> The driver itself does not read the -cells values (and frankly, it
> shouldn't), 

Agreed, because this is standard address translation and only the DT 
core address functions should read cells props.

> so there's little sense in only allowing [1, 2] x [1].

Why does the timer need 64-bits of address space? It doesn't, so that's 
the reason for restricting it.

> Allow any values.
> 
> Fixes: 4d2bb3e65035 ("dt-bindings: timer: Convert ARM timer bindings to json-schema")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml      | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> index f6efa48c4256..236e2a05c1ad 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> @@ -26,11 +26,9 @@ properties:
>      maxItems: 1
>      description: The control frame base address
>  
> -  '#address-cells':
> -    enum: [1, 2]
> +  '#address-cells': true

So 3 address cells is valid?

Until recently (and not yet in a dtschema release), there was no 
constraint on #address-cells or #size-cells values other than the 
#.*-cells constraint of 8. Now it is 3 and 2.

>  
> -  '#size-cells':
> -    const: 1
> +  '#size-cells': true
>  
>    ranges: true
>  
> -- 
> 2.39.2
> 
