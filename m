Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035EB606BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJTXCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJTXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:02:15 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CABD22EC8A;
        Thu, 20 Oct 2022 16:01:52 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id y72so1346668oia.3;
        Thu, 20 Oct 2022 16:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vKR6Ubf6NLut4evrO2911luI/V0iLPIfihaRv6pSUQ=;
        b=jc9+o5pVBuKvVqiqzSgmYKFFr3A4zp8et/1CVYxJJm10EOe3bcAUR15UFAqJ158VMG
         tfqMEkZCvjbx54Eb0iTuOt5jKHH/jy2MCPsyf7MA3MohIXZ9BtUPTaEmFbyCtaf834UO
         YkfRkBstU1AvPDSJ5yd6twohGYQ5ikDk8Glm0FqAe9NNepWDuJSsThoIuJ8q42cX86Li
         SfYDIsG2+Z/5IMHCTp8TRzZG2wfX+YotvmbaAY9TAir+QlSeM+3dw3xKIoygZ420MGQ/
         X7bI+4mDu7tkZt6a9BEE25kjthL0fpZ3lbsze+yaGyzN7b59ZDbAaUUT1eFXiw9qORcI
         XBaw==
X-Gm-Message-State: ACrzQf0OuEa9H/4Ygwna3X190cFewlST1DnSm0EEWqBvvQ1/SMjfpFGS
        lvTgYnByLXqbkNmCA5iL8A==
X-Google-Smtp-Source: AMsMyM6WL6nqyQzSAS6vpGVeeJq/qC6laTr8Ta6Umw0ZOh8KuscLrjdmPHtIMgkBeB2488ZYBELfLw==
X-Received: by 2002:a05:6808:1986:b0:355:3525:8fb with SMTP id bj6-20020a056808198600b00355352508fbmr8630049oib.3.1666306911273;
        Thu, 20 Oct 2022 16:01:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x3-20020a4ac583000000b00476989d42ebsm8050817oop.8.2022.10.20.16.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:01:50 -0700 (PDT)
Received: (nullmailer pid 1969510 invoked by uid 1000);
        Thu, 20 Oct 2022 23:01:51 -0000
Date:   Thu, 20 Oct 2022 18:01:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, jh80.chung@samsung.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCHv5 1/6] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Message-ID: <20221020230151.GA1957503-robh@kernel.org>
References: <20221019170657.68014-1-dinguyen@kernel.org>
 <20221019170657.68014-2-dinguyen@kernel.org>
 <166622207591.14373.6525811988033372211.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166622207591.14373.6525811988033372211.robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 06:31:53PM -0500, Rob Herring wrote:
> On Wed, 19 Oct 2022 12:06:52 -0500, Dinh Nguyen wrote:
> > Document the optional "altr,sysmgr-syscon" binding that is used to
> > access the System Manager register that controls the SDMMC clock
> > phase.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > ---
> > v5: document reg shift
> > v4: add else statement
> > v3: document that the "altr,sysmgr-syscon" binding is only applicable to
> >     "altr,socfpga-dw-mshc"
> > v2: document "altr,sysmgr-syscon" in the MMC section
> > ---
> >  .../bindings/mmc/synopsys-dw-mshc.yaml        | 32 +++++++++++++++++--
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> dwmmc0@ff704000: $nodename:0: 'dwmmc0@ff704000' does not match '^mmc(@.*)?$'

Not necessary for this series, but it would be nice if existing warnings 
were fixed before adding new things. Especially since most of the  
warnings on this common bindings are all socfpga. It may become 
required at some point, not just nice.

The node name is the cause of most/all the unevaluated property 
warnings.

> 	arch/arm/boot/dts/socfpga_arria5_socdk.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb
> 	arch/arm/boot/dts/socfpga_vt.dtb
> 
> dwmmc0@ff704000: 'altr,sysmgr-syscon' is a required property
> 	arch/arm/boot/dts/socfpga_arria5_socdk.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb
> 	arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb

I thought it was optional? New required properties are a possible ABI 
break.

Rob
