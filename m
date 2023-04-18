Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A296E6C48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjDRSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjDRSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:40:36 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F79EE9;
        Tue, 18 Apr 2023 11:40:28 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-541b60e2647so559249eaf.1;
        Tue, 18 Apr 2023 11:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843228; x=1684435228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVoZ5jfOnNbsV5RCrFCLEcKUdvZXtTkTCfu3VsjqCdU=;
        b=PtMXOXj2VAIyvdnpwOQPtIYh57ESt4s55PPUXROdF7SnPYFrSkUfN147p+nXOA4+S5
         cJXrHlZNd/ZtkaPbyL2VL3HNKvcHrM4WoL60y2GLZnUL1KqTAafVOi6DwbjCYQfj2RuX
         t6vZsc0ZsHze7yVTC9PNJeKUELPbWHXCn4oMzyB8oKPowkdc3obifiqEEOmqj4082Bnc
         oDaCZyBYzUfutdMh7EJR4/bMdu/lADAKrrgalvKpKgx6hCypTlVJmaX+G/Pk/Vxj3WFJ
         jt25zRRChLmxCoY7SltLs/vVkWxn8GEChjnIJu3E5XmKgJgsjp4f44QF9FG2Dl1aR2AQ
         OE0w==
X-Gm-Message-State: AAQBX9dmRgs1cEVzf8RChk81Mwb6e12tFTJvFiP3nAI095MG/k1kh8Pe
        ElSp3JC5K77Ma0Lcc4ZbSg==
X-Google-Smtp-Source: AKy350ay6nFNMxQ83XRd8U60mc2eXRdXQkw1ye3h63bw1IX2GqtAUAvg4g7zK6RXBZ9qG1tXi/7ZFQ==
X-Received: by 2002:a05:6870:e2cb:b0:187:b836:4d33 with SMTP id w11-20020a056870e2cb00b00187b8364d33mr2201662oad.30.1681843228224;
        Tue, 18 Apr 2023 11:40:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a0d83000000b005251e3f92ecsm6174692oob.47.2023.04.18.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:40:27 -0700 (PDT)
Received: (nullmailer pid 2102644 invoked by uid 1000);
        Tue, 18 Apr 2023 18:40:26 -0000
Date:   Tue, 18 Apr 2023 13:40:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, siva.durga.prasad.paladugu@amd.com,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names to
 include hibernation interrupt
Message-ID: <20230418184026.GA2099329-robh@kernel.org>
References: <20230412060843.149283-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412060843.149283-1-piyush.mehta@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:38:43AM +0530, Piyush Mehta wrote:
> The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
> Added host mode interrupts and "usb-wakeup" interrupt-names optional
> property in the binding schema to capture remote-wakeup and connect/
> disconnect event in the hibernation state.
> 
> Xilinx dwc3-core uses "host" and "otg" interrupts interrupt-names DT
> properties from dwc3-core.

Is wakeup really not implemented in the DWC3 core, but outside it? 

> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> Note:
> - Xilinx uses dwc3-cores interrupt-names DT property.
>   Link:
>   Xilinx-dwc3 core: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml#L129
>   dwc3-core: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/usb/snps%2Cdwc3.yaml#L42
> ---
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> index 098b73134a1b..abc32db2448a 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> @@ -44,6 +44,15 @@ properties:
>        - const: bus_clk
>        - const: ref_clk
>  
> +  interrupts:
> +    items:
> +      - description: Handle to the line usb-wakeup used to wake
> +          up the host processor.
> +
> +  interrupt-names:
> +    items:
> +      - const: usb-wakeup

'wakeup' is the standard name. And you also need 'wakeup-source' 
property.

> +
>    resets:
>      description:
>        A list of phandles for resets listed in reset-names.
> -- 
> 2.25.1
> 
