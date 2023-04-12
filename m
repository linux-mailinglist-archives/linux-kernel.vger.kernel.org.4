Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE856DF57F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjDLMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjDLMhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:37:20 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BE5249;
        Wed, 12 Apr 2023 05:36:59 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id q28so690620oiw.5;
        Wed, 12 Apr 2023 05:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303019; x=1683895019;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LGakXsbZwm/Ty6gSPym0+RMDx7QOU94rKy7DWiElSdA=;
        b=Q4jK168VbOUqtwypTESZJht3RA5T7PLPSloZFIg7/cU4is4/QhVjQbc266B7QoZBZX
         7OIx+O8SIZlVjuq5MtYKz7g3MNNftMgsVfsbY6swp8RRcGMh6SOHkHd/Zoxk1rBXR+/M
         DE6aLKh/MZeit/r1i+3H/t0iHs1yQzQRmAWTYbgUXE/SKG5qQtRE6hmRP3DTXYBTbYFZ
         jAlMACKdenWUntlIeB7oQxP9g6hSWlmfRVY1bC86lFTWpHlRWBwBWxyB1D9VI5MLPT0W
         ySKYfVorqaRAo7FdJUUnGiq/uBcF6v8U596Orchi/qSequHFoy6MmWcxkuVIKKT3XmF7
         +wAA==
X-Gm-Message-State: AAQBX9fU2/lJ8O+sC2dGI/DXxvr0lBlScSiwGTB5FZZRs4Y/vryWwepx
        3j4byYiDmoa/FdMmtSYS/Q==
X-Google-Smtp-Source: AKy350aGsDT4Ft+UU4t4OsTmg+wZBD6FliKsG+1tVHHRQJQZKd5lX7rQs12aCK1Qt7JlvXXMZ3Mg0w==
X-Received: by 2002:a05:6808:7da:b0:38c:ec:8b0f with SMTP id f26-20020a05680807da00b0038c00ec8b0fmr383623oij.16.1681303018725;
        Wed, 12 Apr 2023 05:36:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cz9-20020a056808404900b003895430852dsm6562392oib.54.2023.04.12.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:36:58 -0700 (PDT)
Received: (nullmailer pid 1486747 invoked by uid 1000);
        Wed, 12 Apr 2023 12:36:56 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, git@amd.com,
        devicetree@vger.kernel.org, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com
In-Reply-To: <20230412060843.149283-1-piyush.mehta@amd.com>
References: <20230412060843.149283-1-piyush.mehta@amd.com>
Message-Id: <168130278024.1444455.14085062230182926087.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names to
 include hibernation interrupt
Date:   Wed, 12 Apr 2023 07:36:56 -0500
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


On Wed, 12 Apr 2023 11:38:43 +0530, Piyush Mehta wrote:
> The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
> Added host mode interrupts and "usb-wakeup" interrupt-names optional
> property in the binding schema to capture remote-wakeup and connect/
> disconnect event in the hibernation state.
> 
> Xilinx dwc3-core uses "host" and "otg" interrupts interrupt-names DT
> properties from dwc3-core.
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

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412060843.149283-1-piyush.mehta@amd.com


usb@ff9d0000: 'clock-names' is a required property
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@ff9d0000: 'clocks' is a required property
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@ff9d0000: usb@fe200000:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@ff9d0000: usb@fe200000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@ff9e0000: 'clock-names' is a required property
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb

usb@ff9e0000: 'clocks' is a required property
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb

usb@ff9e0000: usb@fe300000:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@ff9e0000: usb@fe300000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb

