Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6691169D9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjBUDv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjBUDvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:51:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF92529A;
        Mon, 20 Feb 2023 19:51:03 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31L3oarR070269;
        Mon, 20 Feb 2023 21:50:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676951436;
        bh=5nR3k80shCGeURAZbqYYF3c9KVUbj3jYZCIKs8jOpms=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eFBWGPqqS2fhvHn3Ipn+TX0wlmF8/G/jonAZHADV2vj86ZxcJjjfRjlUJ8xPrNoIx
         GxF8vYhC/vTA2ra+MkXB0o7ax75YUDzGxPE0rNWOrHC7OAZACgq++Has15sN2aR3Is
         Ptot64vK6WHlWy7Q0T9aTnNTwRcatm/ptVCvRuvE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31L3oa5W067564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Feb 2023 21:50:36 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Feb 2023 21:50:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Feb 2023 21:50:36 -0600
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31L3oXSZ036825;
        Mon, 20 Feb 2023 21:50:33 -0600
Message-ID: <c33e79b5-d597-a116-f574-c335a78f0bca@ti.com>
Date:   Tue, 21 Feb 2023 09:20:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 2/9] arm64: dts: ti: k3-j721s2-main: Add support for
 USB
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230220111408.9476-1-r-gunasekaran@ti.com>
 <20230220111408.9476-3-r-gunasekaran@ti.com>
 <be22049d-b732-09d9-5cc5-45584244f2e1@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <be22049d-b732-09d9-5cc5-45584244f2e1@ti.com>
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



On 20/02/23 8:15 pm, Andrew Davis wrote:
> On 2/20/23 5:14 AM, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Add support for single instance of USB 3.0 controller in J721S2 SoC.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Link: https://lore.kernel.org/r/20221122101616.770050-2-mranostay@ti.com
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>> I had reviewed this patch in the v5 series [1].
>> Since I'm taking over upstreaming this series, I removed the self
>> Reviewed-by tag.
>>
>> Links:
>>
>> [1] - https://lore.kernel.org/all/134c28a0-2d49-549c-dc8d-0887d8fd29c3@ti.com/
>>
>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 42 ++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 8915132efcc1..c0daa75116f9 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -26,6 +26,20 @@
>>           };
>>       };
>>   +    scm_conf: syscon@104000 {
>> +        compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +        reg = <0x00 0x00104000 0x00 0x18000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x00 0x00 0x00104000 0x18000>;
>> +
>> +        usb_serdes_mux: mux-controller@0 {
>> +            compatible = "mmio-mux";
>> +            #mux-control-cells = <1>;
>> +            mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>> +        };
>> +    };
>> +
>>       gic500: interrupt-controller@1800000 {
>>           compatible = "arm,gic-v3";
>>           #address-cells = <2>;
>> @@ -745,6 +759,34 @@
>>           };
>>       };
>>   +    usbss0: cdns-usb@4104000 {
> 
> Since this cannot be used without additional pinmux information in the
> board level dtb files, this can be set disabled in this include file. Then
> set back to "okay" where you add the pinmux. Same for the OSPI and PCIe patches.
> 
> Andrew

Sure. I will do so and post the next series.

Ravi

> 
>> +        compatible = "ti,j721e-usb";
>> +        reg = <0x00 0x04104000 0x00 0x100>;
>> +        clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
>> +        clock-names = "ref", "lpm";
>> +        assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
>> +        assigned-clock-parents = <&k3_clks 360 17>;
>> +        power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +        dma-coherent;
>> +
>> +        usb0: usb@6000000 {
>> +            compatible = "cdns,usb3";
>> +            reg = <0x00 0x06000000 0x00 0x10000>,
>> +                  <0x00 0x06010000 0x00 0x10000>,
>> +                  <0x00 0x06020000 0x00 0x10000>;
>> +            reg-names = "otg", "xhci", "dev";
>> +            interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "host", "peripheral", "otg";
>> +            maximum-speed = "super-speed";
>> +            dr_mode = "otg";
>> +        };
>> +    };
>> +
>>       main_mcan0: can@2701000 {
>>           compatible = "bosch,m_can";
>>           reg = <0x00 0x02701000 0x00 0x200>,
