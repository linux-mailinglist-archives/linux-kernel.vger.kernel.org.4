Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA46F0016
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 06:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbjD0EOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 00:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0EOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 00:14:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36946107;
        Wed, 26 Apr 2023 21:14:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33R4Efan031374;
        Wed, 26 Apr 2023 23:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682568881;
        bh=xAjERUvYRTHSLxch3No3kEFC4BEqtB21qVD0snlUb5w=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=BP4iKz8TttOyH5zGxt/O0MkUkHO8YjSp1fOHktXhs2f8qzgj9teDZx3zWOxuPb34e
         /hpXUpBQpfmramwwtG7ypYDBnEnnciAwjczxEmwNitL5um7tRu8PBu/ll1z7qtCrJf
         16zt6/dXEXCwAF6j9KQUwmec7FiVBES3pcGfSAjs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33R4Ef8a033316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 23:14:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Apr 2023 23:14:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Apr 2023 23:14:40 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33R4Eajg073378;
        Wed, 26 Apr 2023 23:14:37 -0500
Message-ID: <eb1052a9-dd1b-57f1-3223-720b7ea87088@ti.com>
Date:   Thu, 27 Apr 2023 09:44:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [RFC PATCH 2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable
 main CPSW2G with GESI
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
References: <20230426105718.118806-1-s-vadapalli@ti.com>
 <20230426105718.118806-3-s-vadapalli@ti.com>
 <20230426130003.q2fotsm3b5r7hh27@ominous>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230426130003.q2fotsm3b5r7hh27@ominous>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/04/23 18:30, Nishanth Menon wrote:
> On 16:27-20230426, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> The MAIN CPSW2G instance of CPSW on J721S2 SoC can be enabled with the GESI
>> Expansion Board connected to the J7 Common-Proc-Board. Use the overlay
>> to enable this.
>>
>> Add alias for the MAIN CPSW2G port to enable kernel to fetch MAC address
>> directly from U-Boot.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>  .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 83 +++++++++++++++++++
>>  2 files changed, 85 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index c83c9d772b81..13db9b8dbe1d 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>>  # Boards with J721s2 SoC
>>  dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
>>  
>>  # Boards with J784s4 SoC
>>  dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>> @@ -49,3 +50,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>>  
>>  # Enable support for device-tree overlays
>>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>> +DTC_FLAGS_k3-j721s2-common-proc-board += -@
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
>> new file mode 100644
>> index 000000000000..2ec08754bf04
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * DT Overlay for MAIN CPSW2G using GESI Expansion Board with J7 common processor board.
>> + *
> 
> product link please.

Thank you for pointing it out. I will update this patch with the product link in
the v2 RFC series.

> 
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/net/ti-dp83867.h>
>> +
>> +#include "k3-pinctrl.h"
>> +

[...]

>> +
>> +&main_cpsw_port1 {
>> +	status = "okay";
>> +	phy-mode = "rgmii-rxid";
>> +	phy-handle = <&main_cpsw_phy0>;
>> +};
>> -- 
>> 2.25.1
>>
> 

-- 
Regards,
Siddharth.
