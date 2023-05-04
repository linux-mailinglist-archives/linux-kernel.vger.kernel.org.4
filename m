Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA76F670E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjEDIOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjEDIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAF240FD;
        Thu,  4 May 2023 01:10:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3448AUat032194;
        Thu, 4 May 2023 03:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683187830;
        bh=s+Ys96Yudt+ULH0EPdgm7zVCRR4Q7qjSR+OtIRskrwo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LBNuVKOs5Yvm+/vtJLc7IGpAeMCPUjDPYK2ZFy0ytsCm/IfTpwS3Yc3xwOZpgnhKP
         GpFwzWJwcnQHrzyHtULqfVhaar86v2WNkFFb21LGmp/WkI2ool4tuVk54Kbg+OYdPA
         0TP4Po0MQjZXvt5ijRwaoPFj7bhM7etwaNsFpfNw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3448ATJi101839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 03:10:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 03:10:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 03:10:29 -0500
Received: from [10.24.69.249] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3448AQrD095902;
        Thu, 4 May 2023 03:10:26 -0500
Message-ID: <72eb1506-e915-8547-ac6d-587404a40197@ti.com>
Date:   Thu, 4 May 2023 13:40:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/2] arm64: dts: ti: k3-j784s4-evm: Add support for
 OSPI and QSPI flashes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
References: <20230504080305.38986-1-a-nandan@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20230504080305.38986-1-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/23 13:33, Apurva Nandan wrote:
> From: Vaishnav Achath <vaishnav.a@ti.com>
>
> J784S4 has S28HS512T OSPI flash connected to OSPI0 and MT25QU512A QSPI
> flash connected to OSPI1, enable support for the same.
>
> Changes in v3:
> - Split the SoC dtsi changes and EVM dts changes into separate patches
> - Added QSPI flash node and partition information in EVM dts
> - Removed address-cells = <1>; and size-cells = <1>; in OSPI0 flash node
> - Add flash partition information for OSPI flash.
Link to v2 patch: 
https://lore.kernel.org/linux-arm-kernel/20230329060057.13654-1-a-nandan@ti.com/
> Changes in v2:
> - Fixed address 0x0 to 0x00
> - Fixed dtbs_check errors (removed syscon and created simple bus)
> - Fixed whitespace error
Link to v1 patch: 
https://lore.kernel.org/linux-arm-kernel/20230327082924.12427-1-a-nandan@ti.com/
> Apurva Nandan (2):
>    arm64: dts: ti: k3-j784s4-mcu-wakeup: Add FSS OSPI0 and FSS OSPI1
>    arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flashes
>
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 158 ++++++++++++++++++
>   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  41 +++++
>   2 files changed, 199 insertions(+)
>
-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

