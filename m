Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01AC6235B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiKIVXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKIVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:23:15 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0377613DFF;
        Wed,  9 Nov 2022 13:23:13 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A9LMqWK025525;
        Wed, 9 Nov 2022 15:22:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668028972;
        bh=taVfVIDYMNui3PEkZ8ZkZTWHd9u49AI3RyPfz1lTqew=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=h5oEPMDmpTO1wG6MMKLW4W2EohTvJl1Gyonx8dyzknsBlTKPYvgTxWKueHLQogesJ
         DhDI4l3OFT6whlqpFGQMbU4RQ2f/r3cqs1kiX+VVP+O8W9nD2vOh1u4TyircQZFK1m
         OFXxPqXA+NcD3jdelGa2x39eh6cFVwagyIz3A/YM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A9LMpMp003342
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 15:22:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 15:22:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 15:22:51 -0600
Received: from [128.247.81.39] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A9LMpcl058121;
        Wed, 9 Nov 2022 15:22:51 -0600
Message-ID: <d54ccc35-8670-15b7-ecd3-e77772001c81@ti.com>
Date:   Wed, 9 Nov 2022 15:22:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am625-sk: mark MCU watchdog as
 reserved
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221109093026.103790-1-jpanis@baylibre.com>
 <20221109093026.103790-3-jpanis@baylibre.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221109093026.103790-3-jpanis@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 3:30 AM, Julien Panis wrote:
> MCU wdt is typically used by M4F.
> 

See it's this "typically" part I'm concerned about.

It depends on the firmware which peripherals will be used. The firmware
doesn't communicate this to Linux, and Linux doesn't give the firmware
permissions to use one of these peripherals.

We only keep from stepping on the firmware by changing device tree to
never use peripherals that are often used by firmware, and that is not a
hardware description, nor complete when a remote core firmware can use any
device in our systems.

What happens when I change firmware? How do we power sequence this? Who
controls the clocks and clock parents if shared for this peripheral?

I'm thinking we can used something like "application nodes"[0] here. These
are basically DT nodes for a specific firmware application. The nodes
describe the firmware and all hardware it uses (in the linked example,
the remote core to run on, DMAs, SRAM, PHYs). All these devices are under
exclusive control of the application node. So while Linux will still
handle power/clock/state control, no driver will be bound. This also
handles the power sequencing question above, sub-devices need to be active
before starting the firmware, and firmware needs to go down before the
controlled peripherals.

These nodes could be loaded/unloaded as DT overlays, along with the
firmware. So resources are only "reserved" for firmware when
the firmware is actually active.

Thoughts?

Andrew

[0] https://www.spinics.net/lists/netdev/msg823883.html

> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am625-sk.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index 93a5f0817efc..089970b304cf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -503,6 +503,11 @@ &main_mcan0 {
>   	status = "disabled";
>   };
>   
> +&mcu_rti0 {
> +	/* MCU RTI0 is used by M4F firmware */
> +	status = "reserved";
> +};
> +
>   &epwm0 {
>   	status = "disabled";
>   };
