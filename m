Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDDA6F0A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbjD0Qn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbjD0Qny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:43:54 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C2423C;
        Thu, 27 Apr 2023 09:43:53 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-18f16bb1a9bso5471358fac.1;
        Thu, 27 Apr 2023 09:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682613833; x=1685205833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJiIdA94Q3aS3ARaP8pkL/+d3e0e0KYGSZTN/HqjbiA=;
        b=WhlqsutqQb97ZudArF5BW7gsxIhQVCNtYEVi/uWlOI1dRXnpfLNBQc4v5GD8FlymnN
         CmoPPp0KjfsbnJ/2YwqBqj2JHRxF82hPWXi5A4bCBdL+EoI0E+NilMEzvgmRnHYaW/m3
         JaHfTLftKa6fF5mUs2a9fCPJAHKRTAfEzaD8x7Iymyw+kwxQ9eLmp1t2X/8wLf2roM6r
         FNXFH2aUaez9xNe62rjw6Gz38DTDmP7Ngzx4x+LCwS8K4wzn99zM5m0pzT5F559moBBL
         F1jnjrF8A7BpKWwt+31qbC/K2+0H9zduiZlEGCJ+uX1+fHQrHAt6G9untqDa4mSnhy8P
         /RtA==
X-Gm-Message-State: AC+VfDy8Vbd46isq81f5CseOs8c9r3KHNqdSw52N/mZlE+aci1AbOhHr
        B9VUeOoP8xDtXvhaYqc1eA==
X-Google-Smtp-Source: ACHHUZ55HiToOuHvfKeip0szuZ15vtRZWifdWsue8eOz2R5vLG2dLRCg/IzNKYj+3l+gh1lxFjue9Q==
X-Received: by 2002:a9d:651a:0:b0:6a6:463a:1a0b with SMTP id i26-20020a9d651a000000b006a6463a1a0bmr1066482otl.1.1682613832950;
        Thu, 27 Apr 2023 09:43:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w21-20020a056830145500b006a6558ef17fsm5245754otp.30.2023.04.27.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:43:52 -0700 (PDT)
Received: (nullmailer pid 3147753 invoked by uid 1000);
        Thu, 27 Apr 2023 16:43:51 -0000
Date:   Thu, 27 Apr 2023 11:43:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@amd.com, git@amd.com, radhey.shyam.pandey@amd.com,
        shubhrajyoti.datta@amd.com, srinivas.goud@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
Message-ID: <20230427164351.GA3146210-robh@kernel.org>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:59:46PM +0530, Manikanta Guntupalli wrote:
> Add optional gpio property to uartps node and add reference to rs485.yaml

The diff tells me that already. Why?

> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index a8b323d7bf94..34ed0d80b923 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -46,6 +46,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  txrx-gpios:
> +    description: Optional GPIO to switch transmit and receive modes via pmod.

What's pmod?

> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -55,6 +59,7 @@ required:
>  
>  allOf:
>    - $ref: serial.yaml#
> +  - $ref: rs485.yaml#
>    - if:
>        properties:
>          compatible:
> -- 
> 2.25.1
> 
