Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD96C1A10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCTPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjCTPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:43:42 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13D3D903;
        Mon, 20 Mar 2023 08:34:31 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1755e639b65so13451035fac.3;
        Mon, 20 Mar 2023 08:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT0AHmQ3LShuOXZctue2K5uPH5tMEpocTPWo5CKLfa0=;
        b=bkMrArMDEPOKJucZppT7+/OnPxvi7mvJN0X05hQXRVA80sR7ZFh894pzrsV/WzMVis
         2pxOrUeMHmZQ/LSwSKPXeHYyQzWLBCLF9DTWJVag7W7M7r2u/M9TzmRTRcBJp7cCDMxu
         INyzQ1F8XkLq4GVJLSupwRM1O8MyrF+m/LqhzKMIVgjIXX10nsxXcvsnR17plNHwADEL
         du6+6UJA8qvYetVLmn9AfvZ5dg4RJSOg2aREhNWoUzOZD/YSCH64VEOpRdLjMqA/5e79
         fyKbZhF+dRTQ0CFgzGcDR1h1Bd1/5yFwJonpUr8g7SCt0MJuhQbLwzwQEJxcNata0KKk
         g7bg==
X-Gm-Message-State: AO0yUKWVfaYvOY3ThgKwlQ9CXjwZLO7yPRuxq7UZbOOhXhaCXx03+DjC
        9PvR5wh8LMpygphKFjIkTQ==
X-Google-Smtp-Source: AK7set9L5/qTXuFZHlohcnrxPqSNgsXDyQvryNGkS1I36QP55MJIx++eLXjYhVeo+Ka0kocDB+oHog==
X-Received: by 2002:a05:6870:8092:b0:177:ac2e:fc5 with SMTP id q18-20020a056870809200b00177ac2e0fc5mr5391174oab.50.1679326461151;
        Mon, 20 Mar 2023 08:34:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id di7-20020a0568303a0700b00690e21a46e1sm4018649otb.56.2023.03.20.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:34:20 -0700 (PDT)
Received: (nullmailer pid 1733448 invoked by uid 1000);
        Mon, 20 Mar 2023 15:34:19 -0000
Date:   Mon, 20 Mar 2023 10:34:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 5/5] dts: usb: add StarFive JH7110 USB dts
 configuration.
Message-ID: <20230320153419.GB1713196-robh@kernel.org>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-6-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315104411.73614-6-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:44:11PM +0800, Minda Chen wrote:
> USB Glue layer and Cadence USB subnode configuration,
> also includes USB and PCIe phy dts configuration.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 54 +++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index a132debb9b53..c64476aebc1a 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -236,3 +236,10 @@
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	status = "okay";
> +	usbdrd_cdns3: usb@0 {
> +		dr_mode = "peripheral";
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index f70a4ed47eb4..17722fd1be62 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -362,6 +362,60 @@
>  			status = "disabled";
>  		};
>  
> +		usb0: usb@10100000 {
> +			compatible = "starfive,jh7110-usb";
> +			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
> +				 <&stgcrg JH7110_STGCLK_USB0_STB>,
> +				 <&stgcrg JH7110_STGCLK_USB0_APB>,
> +				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
> +				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
> +			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
> +			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
> +				 <&stgcrg JH7110_STGRST_USB0_APB>,
> +				 <&stgcrg JH7110_STGRST_USB0_AXI>,
> +				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
> +			starfive,stg-syscon = <&stg_syscon 0x4 0xc4 0x148 0x1f4>;
> +			starfive,sys-syscon = <&sys_syscon 0x18>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x10100000 0x100000>;
> +
> +			usbdrd_cdns3: usb@0 {
> +				compatible = "cdns,usb3";

This pattern of USB wrapper and then a "generic" IP node is discouraged 
if it is just clocks, resets, power-domains, etc. IOW, unless there's an 
actual wrapper h/w block with its own registers, then don't do this 
split. Merge it all into a single node.

> +				reg = <0x0 0x10000>,
> +				      <0x10000 0x10000>,
> +				      <0x20000 0x10000>;
> +				reg-names = "otg", "xhci", "dev";
> +				interrupts = <100>, <108>, <110>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				phys = <&usbphy0>;
> +				phy-names = "cdns3,usb2-phy";

No need for *-names when there is only 1 entry. Names are local to the 
device and only to distinguish entries, so 'usb2' would be sufficient 
here.

> +				maximum-speed = "super-speed";
> +			};
> +		};
> +
> +		usbphy0: phy@10200000 {
> +			compatible = "starfive,jh7110-usb-phy";
> +			reg = <0x0 0x10200000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
> +				 <&stgcrg JH7110_STGCLK_USB0_APP_125>;
> +			clock-names = "125m", "app_125";
> +			#phy-cells = <0>;
> +		};
> +
> +		pciephy0: phy@10210000 {
> +			compatible = "starfive,jh7110-pcie-phy";
> +			reg = <0x0 0x10210000 0x0 0x10000>;
> +			#phy-cells = <0>;
> +		};
> +
> +		pciephy1: phy@10220000 {
> +			compatible = "starfive,jh7110-pcie-phy";
> +			reg = <0x0 0x10220000 0x0 0x10000>;
> +			#phy-cells = <0>;
> +		};
> +
>  		stgcrg: clock-controller@10230000 {
>  			compatible = "starfive,jh7110-stgcrg";
>  			reg = <0x0 0x10230000 0x0 0x10000>;
> -- 
> 2.17.1
> 
