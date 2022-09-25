Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E25E93A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIYOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIYOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:36:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2C2C11D;
        Sun, 25 Sep 2022 07:36:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so4558119pjk.2;
        Sun, 25 Sep 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=/1pQsiroV35+hQZdkG1ejzo3V+b10OOhO7nXhZ1i6TA=;
        b=L7kdF+Cc3zxrcMWuwHLUJxyjSek3kETxz+SxFXZlYc/JDwXSJA23VDwP0JernxRicQ
         L2PbJDc5U6vyDZv4p3Jhk7SgbdOwQIiiQ7S4dmq9vy+iBEGPt4WYhUqiGmrsVQ8H/atq
         QBiH04Un8dojeI+fkMfOzbqWL6A5ww1wKPJE4Z3CFVwbEwgUevhYk6G7hB6OZpII2/+3
         fbfGCzXO4/mmQqJ6rYrMMAg4+2g8Dn3r8dU25LgkQhFp0bpQYQBqwUw+YfC/k++6OYcw
         XT2cr6nLD9YItuH9HvFJ6XfoTmADXXv3BEtzqhQ9spmv7aqM+cST5Ex9mAIiSDzK1CLD
         vTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/1pQsiroV35+hQZdkG1ejzo3V+b10OOhO7nXhZ1i6TA=;
        b=7zDDt6ET9+yM7KX2OCDIitoOaGBE5KfB5d1A1tlmzCbcQ5gdhVgDUHke7yuNkAFPNL
         zpvupFQ7527uu2/3qGZHoXD968c9+LBcjqPhWp58QdpeLB991np1QWi63lHNzugkYLBp
         IoyYSeSyiubk2Rnsnz2khXiZ4Atvgh6q6qvEPQrboYszyr3rfswKL+NTVssTqXRsIj8i
         mRJ56Y8LT4OOVbs/NDkRBbOOoFbhyL89914yg3DZljc+TToM/JFdrhMPWjnOzlYMM9rm
         Wfd4v/jX7fBOORsfA4B/UoG9yXUlM0BgVPpV71GOfC6h5AaR4/s/xOfe+fGtlORrJbKQ
         Lsdg==
X-Gm-Message-State: ACrzQf0KZFzcFnmOFW+Mk3lZUCQvF57ebldEj+rqsjz7j+ynMcx5YGbt
        OUaPj2E7OSTADd7M2CGNUyk=
X-Google-Smtp-Source: AMsMyM4zEYaVLn00bDKQcUz1SjgekG1k7Zs5sjRiFKbPNcDAMS2r4MvSxQRncgEGxl+tqsZNdBvNLQ==
X-Received: by 2002:a17:90b:1905:b0:202:cbf9:cd76 with SMTP id mp5-20020a17090b190500b00202cbf9cd76mr20557787pjb.171.1664116605782;
        Sun, 25 Sep 2022 07:36:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k7-20020aa79727000000b005484d133127sm9970933pfg.129.2022.09.25.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:36:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 07:36:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        michal.simek@xilinx.com, shubhrajyoti.datta@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        git@xilinx.com, git@amd.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH V2] dt-bindings: watchdog: Convert Xilinx watchdog
 bindings to json-schema
Message-ID: <20220925143643.GA1752768@roeck-us.net>
References: <20220818150637.815-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818150637.815-1-srinivas.neeli@xilinx.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 08:36:37PM +0530, Srinivas Neeli wrote:
> Convert Xilinx watchdog bindings to DT schema format using json-schema
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V2:
> - Updated file name with compatible.
> - Added subsystem name in subject prefix.
> - Address minior comments.
> ---
>  .../bindings/watchdog/of-xilinx-wdt.txt       | 26 -------
>  .../watchdog/xlnx,xps-timebase-wdt.yaml       | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> deleted file mode 100644
> index c6ae9c9d5e3e..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Xilinx AXI/PLB soft-core watchdog Device Tree Bindings
> ----------------------------------------------------------
> -
> -Required properties:
> -- compatible		: Should be "xlnx,xps-timebase-wdt-1.00.a" or
> -			  "xlnx,xps-timebase-wdt-1.01.a".
> -- reg			: Physical base address and size
> -
> -Optional properties:
> -- clocks		: Input clock specifier. Refer to common clock
> -			  bindings.
> -- clock-frequency	: Frequency of clock in Hz
> -- xlnx,wdt-enable-once	: 0 - Watchdog can be restarted
> -			  1 - Watchdog can be enabled just once
> -- xlnx,wdt-interval	: Watchdog timeout interval in 2^<val> clock cycles,
> -			  <val> is integer from 8 to 31.
> -
> -Example:
> -axi-timebase-wdt@40100000 {
> -	clock-frequency = <50000000>;
> -	compatible = "xlnx,xps-timebase-wdt-1.00.a";
> -	clocks = <&clkc 15>;
> -	reg = <0x40100000 0x10000>;
> -	xlnx,wdt-enable-once = <0x0>;
> -	xlnx,wdt-interval = <0x1b>;
> -} ;
> diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
> new file mode 100644
> index 000000000000..493a1c954707
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/xlnx,xps-timebase-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx AXI/PLB softcore and window Watchdog Timer
> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> +  - Srinivas Neeli <srinivas.neeli@xilinx.com>
> +
> +description:
> +  The Timebase watchdog timer(WDT) is a free-running 32 bit counter.
> +  WDT uses a dual-expiration architecture. After one expiration of
> +  the timeout interval, an interrupt is generated and the WDT state
> +  bit is set to one in the status register. If the state bit is not
> +  cleared (by writing a one to the state bit) before the next
> +  expiration of the timeout interval, a WDT reset is generated.
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,xps-timebase-wdt-1.01.a
> +      - xlnx,xps-timebase-wdt-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: Frequency of clock in Hz
> +
> +  xlnx,wdt-interval:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Watchdog timeout interval
> +    minimum: 8
> +    maximum: 32
> +
> +  xlnx,wdt-enable-once:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: If watchdog is configured as enable once,
> +                 then the watchdog cannot be disabled after
> +                 it has been enabled.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@40100000 {
> +      compatible = "xlnx,xps-timebase-wdt-1.00.a";
> +      reg = <0x40100000 0x1000>;
> +      clock-frequency = <50000000>;
> +      clocks = <&clkc 15>;
> +      xlnx,wdt-enable-once = <0x0>;
> +      xlnx,wdt-interval = <0x1b>;
> +    };
> +...
