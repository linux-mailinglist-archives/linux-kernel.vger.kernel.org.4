Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA96A9275
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCCIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:30:43 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B416E2126;
        Fri,  3 Mar 2023 00:30:40 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3238UQqq109971;
        Fri, 3 Mar 2023 02:30:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677832226;
        bh=rlN6i9GoilkArfAt3gWnmzuKf78tjlq44dHBhfJgoGE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=BoN+hpURM5dwbjucVqJTajhNMRAOl8mWtY/xofG5uZlZ2qFfwlhw1P407O0pOjepr
         TQL74IUezTWfipkf/b7rzJBCrYpWhGl3qOGyfgTfVCafkwTNyVRj1h/jTMaBTibeNX
         9iAtMG4LxMMVhClo/QET+ipCDftuVVckr+6/n5zg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3238UQAJ012568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Mar 2023 02:30:26 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 3
 Mar 2023 02:30:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 3 Mar 2023 02:30:26 -0600
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3238UMPp048896;
        Fri, 3 Mar 2023 02:30:23 -0600
Message-ID: <b83a2c9e-481b-a15e-d4a4-d8d68ae084a7@ti.com>
Date:   Fri, 3 Mar 2023 14:00:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12 3/8] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support
 of OSPI
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     Andrew Davis <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <vaishnav.a@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230301091136.17862-1-r-gunasekaran@ti.com>
 <20230301091136.17862-4-r-gunasekaran@ti.com>
 <61fab807-42df-cc2c-51de-f54e9ea477c8@ti.com>
 <7843adf0-f883-280b-1d87-44010ceef767@ti.com>
In-Reply-To: <7843adf0-f883-280b-1d87-44010ceef767@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 02/03/23 9:03 am, Ravi Gunasekaran wrote:
> 
> 
> On 01/03/23 9:27 pm, Andrew Davis wrote:
>> On 3/1/23 3:11 AM, Ravi Gunasekaran wrote:
>>> From: Aswath Govindraju <a-govindraju@ti.com>
>>>
>>> Add support for two instance of OSPI in J721S2 SoC.
>>>
>>> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---

[...]

>>>
>>>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 46 +++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>>> index 0af242aa9816..ab3ce8be7216 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>>> @@ -306,4 +306,50 @@
>>>               ti,cpts-periodic-outputs = <2>;
>>>           };
>>>       };
>>> +
>>> +    fss: bus@47000000 {
>>> +        compatible = "simple-bus";
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
>>> +             <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
>>> +             <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
>>> +
>>> +        status = "disabled";
>>
>> Since this node doesn't need pinmux, why is it default disabled? Same for
>> the other parent nodes in this series.
>>
>> Andrew
> 
> In this patch and others in this series, since child node is disabled,
> I thought of disabling the parent as well. And to later enable the
> parent node at the time when the child node needs to be enabled.
> 

Could you please provide your input on this?

If the preferred way is to keep the parent node enabled, then I will
do so. For the IPs added in this series, if the parent node needs additional
information such as pinmux, gpio, I will disable both parent and child.
And if only child node(s) need additional info, then I will keep the parent
enabled and children disabled. 

>>
>>> +
>>> +        ospi0: spi@47040000 {
>>> +            compatible = "ti,am654-ospi", "cdns,qspi-nor";
>>> +            reg = <0x00 0x47040000 0x00 0x100>,
>>> +                  <0x05 0x00000000 0x01 0x00000000>;
>>> +            interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
>>> +            cdns,fifo-depth = <256>;
>>> +            cdns,fifo-width = <4>;
>>> +            cdns,trigger-address = <0x0>;
>>> +            clocks = <&k3_clks 109 5>;
>>> +            assigned-clocks = <&k3_clks 109 5>;
>>> +            assigned-clock-parents = <&k3_clks 109 7>;
>>> +            assigned-clock-rates = <166666666>;
>>> +            power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            status = "disabled"; /* Needs pinmux */
>>> +        };
>>> +
>>> +        ospi1: spi@47050000 {
>>> +            compatible = "ti,am654-ospi", "cdns,qspi-nor";
>>> +            reg = <0x00 0x47050000 0x00 0x100>,
>>> +                  <0x07 0x00000000 0x01 0x00000000>;
>>> +            interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
>>> +            cdns,fifo-depth = <256>;
>>> +            cdns,fifo-width = <4>;
>>> +            cdns,trigger-address = <0x0>;
>>> +            clocks = <&k3_clks 110 5>;
>>> +            power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            status = "disabled"; /* Needs pinmux */
>>> +        };
>>> +    };
>>>   };
> 

-- 
Regards,
Ravi
