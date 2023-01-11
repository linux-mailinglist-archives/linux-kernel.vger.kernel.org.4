Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A846662A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjAKSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAKSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:19:17 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E11EEC2;
        Wed, 11 Jan 2023 10:19:15 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30BIJ2ri114692;
        Wed, 11 Jan 2023 12:19:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673461142;
        bh=Zs3Ynwf5Vr90rNQZhzl2CyOc9tGJkvAICxtJFLF7zdk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xjuWjHbtaoj2jtSb2MHQ3QbqkzgJwYb9tD36ZHKx3HOR0oPQKKsS3TOszG9QfNLRN
         Fe83RckGfXHgnc5u7hB2YnMw6/J5ZwtWtuQevvHsfSk5II3VjNMvM66TTy1gcVJoxC
         6KzMv961p2y4xslv3jB80GRHeBXI+LnilEt3iN0I=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30BIJ2As005581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jan 2023 12:19:02 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 11
 Jan 2023 12:19:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 11 Jan 2023 12:19:02 -0600
Received: from [10.250.233.151] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30BIIvdW058943;
        Wed, 11 Jan 2023 12:18:58 -0600
Message-ID: <9d6841f3-e3d5-a875-8057-1727f7ccaf1e@ti.com>
Date:   Wed, 11 Jan 2023 23:48:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-am625-sk: Add support for USB
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     <kernel@collabora.com>, Nitin Yadav <n-yadav@ti.com>,
        <martyn.welch@collabora.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230111132348.553061-1-sjoerd@collabora.com>
 <20230111132348.553061-4-sjoerd@collabora.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230111132348.553061-4-sjoerd@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sjoerd,

Couple of comments which I failed to notice on v2, sorry

On 1/11/2023 6:53 PM, Sjoerd Simons wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> AM62 SoC has two instances of USB and they are brought on to the board
> in the following way,
> 
> -> USB0 instance
>  - This is brought out to a USB TypeC connector on board through TPS6598 PD
>    controller. The PD controller should decide the role based on CC pin in
>    the connector. Unfortunately the irq line for the TPS isn't hooked up
>    which is a mode not yet support by the driver (some patches were
>    submitted earlier this year[0]). So for now the PD controller is left
>    out and periphal mode chosen.

s/periphal/peripheral

> 
> -> USB1 instance
>  - This is brought out to a USB TypeA connector on board.
> 
> Therefore, add the required device tree support for the above in the board
> dts file.
> 
> 0: https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/T/
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [merge from vendor bsp, drop TPS6598 support, reword commit message]
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Tested-by: Martyn Welch <martyn.welch@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Rebased against current ti-next aka 6.2-rc1
> - Add Martyn's tested-by
> 
> Changes in v2:
> - Rebase against linux-next 20221220
> 
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 50 ++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

[...]

> +
> +&ecap0 {
> +	status = "disabled";
> +};
> +
> +&ecap1 {
> +	status = "disabled";
> +};
> +
> +&ecap2 {
> +	status = "disabled";
> +};
> +
> +&main_mcan0 {
> +	status = "disabled";
> +};
> +
> +&epwm0 {
> +	status = "disabled";
> +};
> +
> +&epwm1 {
> +	status = "disabled";
> +};
> +
> +&epwm2 {
> +	status = "disabled";
> +};
> +

Unlike downstream vendor kernel, these nodes are "disabled" by default
in k3-am62-main.dtsi. So, these can be dropped.

> +&usbss0 {
> +	ti,vbus-divider;
> +};
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb1_pins_default>;
> +};

Regards
Vignesh
