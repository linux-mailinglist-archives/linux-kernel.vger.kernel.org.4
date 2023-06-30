Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFA744011
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjF3QrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjF3QrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:47:04 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9D10FB;
        Fri, 30 Jun 2023 09:47:03 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-783544a1c90so86487439f.1;
        Fri, 30 Jun 2023 09:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143623; x=1690735623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6DGhP0NKduRLIremGdPnWFJvBxfZB29kWmtTlgPqSY=;
        b=WvpL7lOAuKkgFxaWAFLZ5Tv69C21jl0O0F4s5WOhee/h42pmUQOxC3epSSokUdnXeB
         55MBtoft6M5b/qQOxQoaZHCAD9eUFagU0aOCz56jpa5Hoa3xehnUSPHqT6q7y8irfTKJ
         ftoCHJjXRv5MLpvTsri4RMjsMQS4r6os16CKbA/3ClQbIXYeE/gNi2W074PWGN5TJd9C
         z8JFBkgvLCGt6gzI+VnfMapniCWciBPkm+qWB7Q5PQc7Lwi30YH1rsDlRyOzv2dDc+4q
         jD2JOwgJCci3+Uh+6cUiM3wsemmG0FFMGuXdm95er55l1mLsUxyb7aEvgomzBLhDIouE
         gj/Q==
X-Gm-Message-State: AC+VfDzseNRarC1PJjDvdbQQEB0R+2BZeidfrTR2Ddu09Y6od4/glC/V
        ZF7cFH063RRfwH93mnmDaRaysu2e0A==
X-Google-Smtp-Source: ACHHUZ6OwIYPczmqbgzkEpt6HyXVM0dPvYAT8oKibXf2XmJsco67c0AQJfN7FfdjPE7jY6RKcJU0ng==
X-Received: by 2002:a5d:9a09:0:b0:77e:249e:d84 with SMTP id s9-20020a5d9a09000000b0077e249e0d84mr3330170iol.5.1688143622820;
        Fri, 30 Jun 2023 09:47:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id el16-20020a0566384d9000b0042aebf02107sm2091962jab.138.2023.06.30.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:47:01 -0700 (PDT)
Received: (nullmailer pid 1884430 invoked by uid 1000);
        Fri, 30 Jun 2023 16:46:59 -0000
Date:   Fri, 30 Jun 2023 10:46:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        sbhatta@marvell.com, linux@armlinux.org.uk, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anirudha.sarangi@amd.com,
        harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH net-next V4 1/3] dt-bindings: net: xlnx,axi-ethernet:
 Introduce DMA support
Message-ID: <20230630164659.GA1877117-robh@kernel.org>
References: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
 <20230630053844.1366171-2-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630053844.1366171-2-sarath.babu.naidu.gaddam@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:08:42AM +0530, Sarath Babu Naidu Gaddam wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> The axiethernet will use dmaengine framework to communicate
> with dma controller IP instead of built-in dma programming sequence.

What's dmaengine framework? This is a binding patch about the h/w.

> 
> To request dma transmit and receive channels the axiethernet uses
> generic dmas, dma-names properties.
> 
> Axiethernet may use AXI DMA or MCDMA. DMA has only two channels
> where as MCDMA has 16 Tx, 16 Rx channels. To uniquely identify each
> channel, we are using 'chan' suffix. Depending on the usecase AXI
> ethernet driver can request any combination of multichannel DMA
> channels.

The DMA provider is outside the scope of the binding. Instead, describe 
how Axiethernet can use 2 or 32 channels.

> 
> Example:
> dma-names = tx_chan0, rx_chan0, tx_chan1, rx_chan1;
> 
> Also to support the backward compatibility, use "dmas" property to
> identify as it should use dmaengine framework or legacy
> driver(built-in dma programming).
> 
> At this point it is recommended to use dmaengine framework but it's
> optional. Once the solution is stable will make dmas as
> required properties.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> 
> ---
> Changes in V4:
> 1) Updated commit description about tx/rx channels name.
> 2) Removed "dt-bindings" and "dmaengine" strings in subject.
> 3) Extended dmas and dma-names to support MCDMA channel names.
> 1) Remove "driver" from commit message.
> 2) Use pattern/regex for dma-names property.
> 
> Changes in V3:
> 1) Reverted reg and interrupts property to  support backward compatibility.
> 2) Moved dmas and dma-names properties from Required properties.
> 
> Changes in V2:
> - None.
> ---
>  .../bindings/net/xlnx,axi-ethernet.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> index 1d33d80af11c..ea203504b8d4 100644
> --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> @@ -122,6 +122,20 @@ properties:
>        and "phy-handle" should point to an external PHY if exists.
>      maxItems: 1
>  
> +  dmas:
> +    minItems: 2
> +    maxItems: 32
> +    description: DMA Channel phandle and DMA request line number

Drop this description. That's every 'dmas' property. Instead define what 
each entry is.

> +
> +  dma-names:
> +    items:
> +      pattern: "^[tr]x_chan[0-9]|1[0-5]$"

I think you need some parentheses. Does a channel 10 or higher name 
validate?

> +    description:
> +      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel
> +      Should be "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel
> +    minItems: 2
> +    maxItems: 32
> +
>  required:
>    - compatible
>    - interrupts
> @@ -143,6 +157,8 @@ examples:
>          clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
>          phy-mode = "mii";
>          reg = <0x40c00000 0x40000>,<0x50c00000 0x40000>;
> +        dmas = <&xilinx_dma 0>, <&xilinx_dma 1>;
> +        dma-names = "tx_chan0", "rx_chan0";
>          xlnx,rxcsum = <0x2>;
>          xlnx,rxmem = <0x800>;
>          xlnx,txcsum = <0x2>;
> -- 
> 2.25.1
> 
