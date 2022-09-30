Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086C5F0ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiI3LmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiI3Ll6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:41:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D9E66;
        Fri, 30 Sep 2022 04:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664537636; x=1696073636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PS4uCU8B8tGy2lZ6r0+UVwMO1ij6Mi+pVyzCsDjaFCA=;
  b=zy6vAB7nHmGUJI1ZXf/Ix7kaqlDMuoZebUlRSrlgeB5Edcb/+FnPD/c4
   L281ZXsx1JYg6zxAcrS9sbKt3x8KraMrX+67Bnj5TwqtJjsiITM5YqMeb
   4ke8w2UfQnzH82AoxDGUcXZ06CyzROImoVCyTzuu9OSHGG5hotMGL3Lal
   ACcmAqPkVENxoFEvh+TgN8MEtprDzWWPeFLfwg+CGkTcpJQ5G9FU6H9PN
   sxXfMY+MlJNMf03dZo9cYBmDynSLQ9q0txS4i8PTiNhjQKB1sZpjYv/0i
   +Tpsr7wVHJ0p0DsNru9RqaWWsTjy3IxJlGrWqtiq5X+ZeWi08cCSwiAXr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="193242936"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 04:33:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 04:33:53 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 30 Sep 2022 04:33:52 -0700
Message-ID: <f19fa481-334b-4145-d49e-1260d3fde810@microchip.com>
Date:   Fri, 30 Sep 2022 13:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: lan966x: Add interrupt support for PHYs on
 pcb8290
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        <devicetree@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>
References: <20220915064112.1935051-1-horatiu.vultur@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220915064112.1935051-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 at 08:41, Horatiu Vultur wrote:
> Add interrupt support for the PHYs found on pcb8290. They are all
> sharing the same interrupt line towards lan966x.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/lan966x-pcb8290.dts | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lan966x-pcb8290.dts b/arch/arm/boot/dts/lan966x-pcb8290.dts
> index af92bb12bc6cd..2ed53da914acb 100644
> --- a/arch/arm/boot/dts/lan966x-pcb8290.dts
> +++ b/arch/arm/boot/dts/lan966x-pcb8290.dts
> @@ -68,41 +68,57 @@ &mdio0 {
>   
>   	ext_phy0: ethernet-phy@7 {
>   		reg = <7>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy1: ethernet-phy@8 {
>   		reg = <8>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy2: ethernet-phy@9 {
>   		reg = <9>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy3: ethernet-phy@10 {
>   		reg = <10>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy4: ethernet-phy@15 {
>   		reg = <15>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy5: ethernet-phy@16 {
>   		reg = <16>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy6: ethernet-phy@17 {
>   		reg = <17>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   
>   	ext_phy7: ethernet-phy@18 {
>   		reg = <18>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio>;
>   		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
>   	};
>   };


-- 
Nicolas Ferre
