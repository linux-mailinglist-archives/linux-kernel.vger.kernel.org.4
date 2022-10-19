Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1529C604E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJSR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJSR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:26:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79F1D1A98;
        Wed, 19 Oct 2022 10:26:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29JHQXLG116399;
        Wed, 19 Oct 2022 12:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666200393;
        bh=3hvx9pr5K+0guJn4DKXmTSuodCT3VlQZ4faEGDqq4No=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=v2YFb2MRCK2ydlVtJg3M8fj+9tfFUlNJSrR81RTgl+kRfVt+1at2w9sIgjM29DnsB
         50HZbFREPlqJ/t4hwfdylSqSedOpk0cA3eRzx4aLjASO4Ez24CNIGO2ApNcGyLXEHa
         UjTixXMg1pnkfrKjELk/Brh1IpO4hh+kTJBt05sM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29JHQXM6047730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Oct 2022 12:26:33 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 19
 Oct 2022 12:26:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 19 Oct 2022 12:26:32 -0500
Received: from [10.250.33.68] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29JHQVvj123567;
        Wed, 19 Oct 2022 12:26:31 -0500
Message-ID: <90cbb65b-389e-95b5-26d8-39bc33f88df6@ti.com>
Date:   Wed, 19 Oct 2022 12:26:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: Add initial support for J784S4 SoC
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Hari Nagalla <hnagalla@ti.com>
References: <20221014082314.118361-1-a-nandan@ti.com>
 <20221014082314.118361-4-a-nandan@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221014082314.118361-4-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 3:23 AM, Apurva Nandan wrote:
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
> 

[...]

> +
> +		hwspinlock: hwlock@30e00000 {
> +			compatible = "ti,am654-hwspinlock";
> +			reg = <0x00 0x30e00000 0x00 0x1000>;
> +			#hwlock-cells = <1>;
> +			status = "disabled";

Why is this disabled? The node is complete and usable.

I do not know if we settled on a set of rules for disabling nodes
by default in the dtsi, I couldn't find one if we did, but how does
this sound,

If a node in a dtsi file is incomplete, or the described hardware
unusable, without additional information provided by board-level
additions, then the node may be disabled. Otherwise it must be
left in the default enabled state.

Without something like that, we will end up with the same problem
we are trying to fix here, but in reverse, one will have to
enable nodes in board files that would not otherwise need to
refrenced. Worse that sounds like a configuration setting, not a
hardware description, so it would not belong in the device tree.

Same for main_ringacc, main_udmap, cpts, and mcu_navss below.

> +		};
> +

[...]

> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/k3.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +/ {
> +

Extra newline not needed.

Andrew

> +	model = "Texas Instruments K3 J784S4 SoC";
