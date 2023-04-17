Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8600B6E4142
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDQHhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDQHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:37:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F195273;
        Mon, 17 Apr 2023 00:36:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33H7al2K051967;
        Mon, 17 Apr 2023 02:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681717007;
        bh=l7ffDMMwPqAVTwsIwTWk9VVAZG/DLY6FJ3yFqfZ/gxI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=m8IGM+xizhmBm9zXbcjpvZOwGSnGvrhzjjP5NOxgF13kgGyWkab3fcvWUcmyqP55T
         IyJxMpzXfL+RZAX8PverSKIbhvJ2Ae7q2U2shve+zhRORTU+gKu4c+ESCi5r5JobeK
         OE+uu1etHQX82dMgbgr972mk6VzbKS5H4o3Zc3gs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33H7aleJ065929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 02:36:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 02:36:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 02:36:46 -0500
Received: from [172.24.145.7] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33H7ahoc086172;
        Mon, 17 Apr 2023 02:36:44 -0500
Message-ID: <bb8378f0-31cf-0880-9849-37d747f761d1@ti.com>
Date:   Mon, 17 Apr 2023 13:06:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/5] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY
 nodes
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230414151553.339599-1-j-choudhary@ti.com>
 <20230414151553.339599-4-j-choudhary@ti.com>
 <db7daf64-6f1e-0053-1042-306f2058d1fb@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <db7daf64-6f1e-0053-1042-306f2058d1fb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/04/23 10:10, Vignesh Raghavendra wrote:
> 
> 
> On 14/04/23 20:45, Jayesh Choudhary wrote:
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index aef6f53ae8ac..b1445b7c2aa8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -301,3 +301,7 @@ &main_cpsw1_port1 {
>>   	phy-mode = "rgmii-rxid";
>>   	phy-handle = <&main_phy0>;
>>   };
>> +
>> +&serdes_refclk {
>> +	clock-frequency = <100000000>;
>> +};
> 
> Can we move this to 5/5 along with rest of -evm.dts changes?

Sure. Will move it to last patch in next revision.

Thanks.
