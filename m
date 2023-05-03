Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17E86F5777
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjECLzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:55:40 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D2198E;
        Wed,  3 May 2023 04:55:38 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 343BtVmZ030833;
        Wed, 3 May 2023 06:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683114931;
        bh=8JlE9yalpV3u/aozeCheT4uMh+zsvHV9fsp9+UYGgQE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=yiB9Eg+ZJBiZYR5qay2oDLSAb0enzhn1SlvjG36AIxrUzAOMBAe6ntLtwmX9de3l6
         0E+0lishQ/KkiFWEVbU/LwE8c0ezk3CmegrzeGakILEO3PF00LI26BuBk9IgslvJwp
         SzENsOFVvEE3F8IDYCtKSbovLfmivO3xVSHQGdF4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 343BtVcv021547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 06:55:31 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 06:55:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 06:55:31 -0500
Received: from [172.24.145.195] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 343BtRBE048188;
        Wed, 3 May 2023 06:55:28 -0500
Message-ID: <82a39b8e-96ad-faa2-714f-c8c6bfbcc5d6@ti.com>
Date:   Wed, 3 May 2023 17:25:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-j721e: Add ESM support
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20230503093310.85779-1-n-francis@ti.com>
 <20230503093310.85779-3-n-francis@ti.com>
 <20230503114827.lutd2ebygxczvali@argue>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230503114827.lutd2ebygxczvali@argue>
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

Hi Nishanth,

On 03/05/23 17:18, Nishanth Menon wrote:
> On 15:03-20230503, Neha Malcom Francis wrote:
>> Add address entry mapping ESM on J721E.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> index b912143b6a11..52bcde601eb8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> 
> Why is'nt esm node introduced here?
> 

As it stands esm node is already in 
arch/arm/dts/k3-j721e-r5-common-proc-board.dts in u-boot and since this 
patch is motivated to keep the u-boot and kernel dts in sync, I haven't 
added it here.

Although... I could add it here similar to j7200 and take action to move 
to the same in u-boot... maybe that is better route.

>> @@ -131,6 +131,7 @@ cbass_main: bus@100000 {
>>   		#size-cells = <2>;
>>   		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
>>   			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
>> +			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
>>   			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
>>   			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
>>   			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
