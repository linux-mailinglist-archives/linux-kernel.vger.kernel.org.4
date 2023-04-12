Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA96DF94B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjDLPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjDLPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:04:00 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601486A6D;
        Wed, 12 Apr 2023 08:03:52 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id l13-20020a0568302b0d00b006a416ec44ccso1542741otv.2;
        Wed, 12 Apr 2023 08:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311831; x=1683903831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sli1ujJHYCJfuFT3afLYp4TXGvKZ5csEjqsQF+EWkM=;
        b=esc8pROxOKqvOjYWsCs691+DTVfJCyF5znlpu5aafaq3N0hw3WWXmOazCizYywCGzK
         3rPYsRNI28k03AOSBfxPhWdoo7RqMeUX8vrFPamVk9EvdaI0qGBN+pGD/qVStO3ev/Zo
         q02bqMbYsR4DAPrZ0MXEI7/qlmVFBJ5RZfA85AA8pkwFZf2aysyVANq3JF0AtWhCbVLK
         a7P6DQ+KTGbrVSqvxm3H6icdWQvwe3clI39Pn48T6GQGWNcvRgAYLwdrHCBesJOgF6PS
         9m1kpriOvnHheGQl6wKSzH3Nzm6FyzvfTarQmphth7dq/GSo2URPe4sVGbU3t8iR/lbG
         nVgA==
X-Gm-Message-State: AAQBX9eI6k4JOG1oyq43HR0ViADGuIIg+pQ7gWnYx4NclUIsRqdhXPtI
        kKZ9Pz+I+8L+MNdEidLDG+IAUJfvVw==
X-Google-Smtp-Source: AKy350Zwe/o1P0qbgECgXkd6AaWJzSa0pHXPD83+bo8PJc2hRV6u+FN474DAvwV32gL3QcZhJuBjKA==
X-Received: by 2002:a05:6830:195:b0:6a4:2d62:d3c9 with SMTP id q21-20020a056830019500b006a42d62d3c9mr37626ota.10.1681311831372;
        Wed, 12 Apr 2023 08:03:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d7349000000b006a2ddc13c46sm6441097otk.78.2023.04.12.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:03:50 -0700 (PDT)
Received: (nullmailer pid 2369790 invoked by uid 1000);
        Wed, 12 Apr 2023 15:03:50 -0000
Date:   Wed, 12 Apr 2023 10:03:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mfd: stm32: Fix STM32F4 DT include file
Message-ID: <20230412150350.GA2361252-robh@kernel.org>
References: <20230407201235.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407201235.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
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

On Fri, Apr 07, 2023 at 08:12:43PM +0200, Patrick Delaunay wrote:
> Minor cosmetic change, aligned with file in U-Boot:
> - remove extra space

extra blank line really.

Please make the subject reflect what the change is. This doesn't really 
'Fix' anything and it's so generic it could be any change. Just 'Remove 
double blank line' would be much better and defines the exact change.

> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  include/dt-bindings/mfd/stm32f4-rcc.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/mfd/stm32f4-rcc.h b/include/dt-bindings/mfd/stm32f4-rcc.h
> index 309e8c79f27b..36448a5619a1 100644
> --- a/include/dt-bindings/mfd/stm32f4-rcc.h
> +++ b/include/dt-bindings/mfd/stm32f4-rcc.h
> @@ -34,7 +34,6 @@
>  #define STM32F4_AHB1_RESET(bit) (STM32F4_RCC_AHB1_##bit + (0x10 * 8))
>  #define STM32F4_AHB1_CLOCK(bit) (STM32F4_RCC_AHB1_##bit)
>  
> -
>  /* AHB2 */
>  #define STM32F4_RCC_AHB2_DCMI	0
>  #define STM32F4_RCC_AHB2_CRYP	4
> -- 
> 2.25.1
> 
