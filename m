Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD06F0733
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbjD0OW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbjD0OWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:22:02 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA45FD3;
        Thu, 27 Apr 2023 07:21:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33RELA9O025346;
        Thu, 27 Apr 2023 09:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682605270;
        bh=A/rgv1/AnobUXEkRKW2dduU5AblbNvPTfxFDxods0bQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=X2MlGTw1v8u8knH+jqXxrEJyddKg11MHE83ohUeEmorDLe2f+ZdOhoqvSgNpSvkWE
         CgFeUmHvHG6KlkPOyOgHFjUJGE7yp3nqmtKH3iMi73TMlyb9Q5od6HQH0uTvyVK5g/
         TUNbxuOoGAIOOrFqSX6VbuPaBN4z1oJ0bcMTC9rQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33RELApf020517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Apr 2023 09:21:10 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Apr 2023 09:21:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Apr 2023 09:21:10 -0500
Received: from [10.250.151.20] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33REL5XZ031910;
        Thu, 27 Apr 2023 09:21:06 -0500
Message-ID: <3c412c83-75a0-b7ac-4c43-2305732c1a0c@ti.com>
Date:   Thu, 27 Apr 2023 19:51:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [EXTERNAL] Re: [PATCH v14 3/8] arm64: dts: ti:
 k3-j721s2-mcu-wakeup: Add support of OSPI
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <afd@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
 <20230331090028.8373-4-r-gunasekaran@ti.com>
 <2b74bc3f-85c7-1d2f-d597-968a914c4e6e@kernel.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <2b74bc3f-85c7-1d2f-d597-968a914c4e6e@kernel.org>
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

Roger,

On 4/25/2023 5:02 PM, Roger Quadros wrote:
> Hi,
>
> On 31/03/2023 12:00, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Add support for two instance of OSPI in J721S2 SoC.
>>
>> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---

[...]

>> +			clocks = <&k3_clks 109 5>;
>> +			assigned-clocks = <&k3_clks 109 5>;
>> +			assigned-clock-parents = <&k3_clks 109 7>;
>> +			assigned-clock-rates = <166666666>;
>> +			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			status = "disabled"; /* Needs pinmux */
>> +		};
>> +
>> +		ospi1: spi@47050000 {
>> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>> +			reg = <0x00 0x47050000 0x00 0x100>,
>> +			      <0x07 0x00000000 0x01 0x00000000>;
>> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
>> +			cdns,fifo-depth = <256>;
>> +			cdns,fifo-width = <4>;
>> +			cdns,trigger-address = <0x0>;
>> +			clocks = <&k3_clks 110 5>;
> What about clock parent and clock rate assignment like it was done for osip0?

ospi1 uses default values.

>> +			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			status = "disabled"; /* Needs pinmux */
>> +		};
>> +	};
>>  };
> cheers,
> -roger

