Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49E6EF56C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbjDZNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbjDZNVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:21:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D1BC3;
        Wed, 26 Apr 2023 06:21:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QDLkW4096750;
        Wed, 26 Apr 2023 08:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682515306;
        bh=QdepxYuSwTdOmEf8k5cCZjOM29OP5/kofyPKcNTFUVo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=k7thEKT9zPmrKcNVux/rKwIuW3iqOkvhengLrEOwOaV5GtVzjPD7gSEj+rMVe6KRZ
         QGF4D57JMY5EdrCSumYXs2M2kBqd0+iviDOj+jAtx2fiWvFRE32q6Y4l8dfHUHK2es
         yMYzjbH8BSG52dU74Z7vtxg9jr89NDVennyHlkPU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QDLku7022065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 08:21:46 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 08:21:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 08:21:45 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QDLjfG001825;
        Wed, 26 Apr 2023 08:21:45 -0500
Message-ID: <163cfe60-4b14-fe5c-29d9-323e7ea495d5@ti.com>
Date:   Wed, 26 Apr 2023 08:21:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/2] arm64: dts: ti: k3-j721s2-main: Add main CPSW2G
 devicetree node
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20230426105718.118806-1-s-vadapalli@ti.com>
 <20230426105718.118806-2-s-vadapalli@ti.com>
 <20230426125927.itfd76cpvy32zur7@scrimmage>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230426125927.itfd76cpvy32zur7@scrimmage>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 7:59 AM, Nishanth Menon wrote:
> On 16:27-20230426, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> TI's J721S2 SoC has a MAIN CPSW2G instance of the CPSW Ethernet Switch.
>> Add devicetree node for it.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 69 ++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 6629b2989180..14dfef7b0758 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -51,6 +51,12 @@ usb_serdes_mux: mux-controller@0 {
>>   			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>>   		};
>>   
>> +		phy_gmii_sel_cpsw: phy@34 {
>> +			compatible = "ti,am654-phy-gmii-sel";
>> +			reg = <0x34 0x4>;
>> +			#phy-cells = <1>;
>> +		};
> 
> 
> See this thread: https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
> 

"ti,am654-phy-gmii-sel" already has "reg", so this DT is good as is.
Adding the driver fallback to use that when the parent is not a "syscon"
node should be as easy as this:

--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -435,9 +435,12 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
  
         priv->regmap = syscon_node_to_regmap(node->parent);
         if (IS_ERR(priv->regmap)) {
-               ret = PTR_ERR(priv->regmap);
-               dev_err(dev, "Failed to get syscon %d\n", ret);
-               return ret;
+               priv->regmap = device_node_to_regmap(node);
+               if (IS_ERR(priv->regmap)) {
+                       ret = PTR_ERR(priv->regmap);
+                       dev_err(dev, "Failed to get syscon %d\n", ret);
+                       return ret;
+               }
         }


I'll send this patch when the window opens.

Andrew
