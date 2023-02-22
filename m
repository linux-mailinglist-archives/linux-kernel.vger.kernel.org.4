Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1392E69EE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBVEx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBVExz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:53:55 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AF16321;
        Tue, 21 Feb 2023 20:53:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31M4rgJk107514;
        Tue, 21 Feb 2023 22:53:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677041622;
        bh=QB0XP9XfmihvYIMMIuynd2NYDr300/WAENcdrhIulV4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bbv7QXFYFTT1BIr4YEMKtVTF7bARAW1ywZPQdkl3hbsZwqK6nmUtqgPDhKbXqVw5D
         pTG8F0DreVZpxSqA36stM0OZPrc6n31mHzMhums8cUZLc17S107eziy1ktjKnPWe/e
         ETeydX/hPczXAWYqYxUO6RqLqHpTINLkd0mM1DTc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31M4rgrf024621
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 22:53:42 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 22:53:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 22:53:42 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31M4rd2q011240;
        Tue, 21 Feb 2023 22:53:39 -0600
Message-ID: <f84c0795-8430-0502-1fad-b644aafdbe80@ti.com>
Date:   Wed, 22 Feb 2023 10:23:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 3/9] arm64: dts: ti: k3-j721s2-main: Add SERDES and
 WIZ device tree node
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-4-r-gunasekaran@ti.com>
 <20230221140156.ml6dlhqg3a7cxvac@squishy>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230221140156.ml6dlhqg3a7cxvac@squishy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 21/02/23 7:31 pm, Nishanth Menon wrote:
> On 17:36-20230221, Ravi Gunasekaran wrote:
>> From: Matt Ranostay <mranostay@ti.com>
>>
>> Add dt node for the single instance of WIZ (SERDES wrapper) and
>> SERDES module shared by PCIe, eDP and USB.
> 
> [...]
> 
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 84e5689fff9f..af6c93f0a055 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> [...]
>> @@ -33,11 +44,18 @@
>>  		#size-cells = <1>;
>>  		ranges = <0x00 0x00 0x00104000 0x18000>;
>>  
>> -		usb_serdes_mux: mux-controller@0 {
>> +		usb_serdes_mux: mux-controller-0 {
> 
> was'nt this just introduced in the patch just prior, if so, NAK,
> do the changes where they are introduced.

Noted. I will fix this.
Thanks for reviewing.

> 
>>  			compatible = "mmio-mux";
>>  			#mux-control-cells = <1>;
>>  			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>>  		};

-- 
Regards,
Ravi
