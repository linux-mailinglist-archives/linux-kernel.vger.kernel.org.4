Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755445F0003
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiI2WVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiI2WVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:21:03 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7096128A2B;
        Thu, 29 Sep 2022 15:21:01 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id z9-20020a4a4909000000b0047651b95fbdso1069792ooa.5;
        Thu, 29 Sep 2022 15:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vbV1DtvSHJhcWuXT3vdsY4xZKXVxNAIzFVbACIVlsMQ=;
        b=J2ZY+3cVTPFLwPpxfTvvYgImutxjdx4SDd5HSsMxkYQ3Q6oQoBJvQlWrFi+/wM5wRp
         95awWinL+oU53sScHPAlLmFqb69oFD5yXXuWC2r9ZC39o8jqV8vTd14sHg+r1Lw+rhJj
         vgErhK4TyNr/mWrYUu/5PvrKcG8eTnS6wZcjTXgw5eXiRYjJ9TrtjwgXmJg/CrGqoeP9
         AC1rF6u1MEw8vNAzhhhEuOBw76+hhSGV9Q3kyq43rxJLf+m9JxKNpAHVysD6MxuENQqJ
         lvWl8iTITrNewGe8ah1fL8KUJl2I689EDecEa1mqNWJdKcBAQXg+52tMCloJO9N+0lCN
         1THw==
X-Gm-Message-State: ACrzQf3HyoRx11K3xJPS/PpquhV4cEOYYDa08xY/yMddjBSmgrfPkdN4
        WPSLw+U6SbZvMnA7H8xQVbyN34xDAw==
X-Google-Smtp-Source: AMsMyM4ojGskLItr1bfagfw9SHxFbnxPc2zqgcWTnl4VPPq9a2WeVu74EhOyJGMCk3AWvHaL0c63EQ==
X-Received: by 2002:a05:6830:3982:b0:65c:46b7:bb63 with SMTP id bs2-20020a056830398200b0065c46b7bb63mr2302067otb.101.1664490061126;
        Thu, 29 Sep 2022 15:21:01 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f10-20020a056870210a00b001279f95d63bsm265391oae.7.2022.09.29.15.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:21:00 -0700 (PDT)
Received: (nullmailer pid 2869569 invoked by uid 1000);
        Thu, 29 Sep 2022 22:20:59 -0000
Date:   Thu, 29 Sep 2022 17:20:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: xlnx,versal-wwdt: Add binding
 documentation for xilinx window watchdog device
Message-ID: <20220929222059.GA2864801-robh@kernel.org>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-2-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927110257.41963-2-srinivas.neeli@amd.com>
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

On Tue, Sep 27, 2022 at 04:32:55PM +0530, Srinivas Neeli wrote:
> Add documentation for the binding of window watchdog device.

Subject space is precious, but you say 'watchdog' and 'binding 
documentation' (dt-bindings) twice.

> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
>  .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> new file mode 100644
> index 000000000000..986455efa6f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/xlnx,versal-wwdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal window watchdog timer controller
> +
> +maintainers:
> +  - Neeli Srinivas <srinivas.neeli@amd.com>
> +
> +description:
> +  Versal watchdog driver uses window watchdog mode. Window watchdog
> +  timer(WWDT) contains closed(first) and open(second) window with
> +  32 bit width. Write to the watchdog timer within predefined window
> +  periods of time. This means a period that is not too soon and a
> +  period that is not too late. The WWDT has to be restarted within
> +  the open window time. If software tries to restart WWDT outside of
> +  the open window time period, it generates a reset.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,versal-wwdt-1.0

1.0 versions feel made up. Is this a soft IP, because that is really the 
only place we use version numbers. More generally, version numbers need 
to correspond to something.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  timeout-sec: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        watchdog@fd4d0000 {
> +           compatible = "xlnx,versal-wwdt-1.0";
> +           reg = <0xfd4d0000 0x10000>;
> +           clocks = <&clock25>;
> +           timeout-sec = <30>;
> +        };
> +...
> -- 
> 2.17.1
> 
> 
