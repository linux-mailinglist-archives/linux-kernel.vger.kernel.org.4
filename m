Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5576E2EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 06:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDOEGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 00:06:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76C85594;
        Fri, 14 Apr 2023 21:06:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33F46LVc127207;
        Fri, 14 Apr 2023 23:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681531581;
        bh=pd0Qa8fePEV2iiQW8OcIjWy9cCAQwF2FbB1zdYHuJ9M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UvEvAzHMlNhr2fMn4uu8rWv0f9cUcp6BEAaZUcqpXELtV5w6kxtG4io7f5LBr5g5A
         eXWM2tgfAGrJrrEjtw27YJuvyBOSo9Q8UzWJu2CNfpERSSgGjxBpPh7S76Of4IVhht
         eylpU1x4k4KH2YEfvbcS9ynX60NC5mK+tbyigwqM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33F46L94015602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 23:06:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 23:06:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 23:06:20 -0500
Received: from [10.249.130.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33F46HhF092764;
        Fri, 14 Apr 2023 23:06:17 -0500
Message-ID: <b360dfd0-3dd3-996c-a9b6-1af770c4015b@ti.com>
Date:   Sat, 15 Apr 2023 09:36:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Enable
 I2C
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20230414181434.2046049-1-u-kumar1@ti.com>
 <20230414181434.2046049-3-u-kumar1@ti.com>
 <20230414182401.2yfpwjug3naiwesi@quicksand>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230414182401.2yfpwjug3naiwesi@quicksand>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 4/14/2023 11:54 PM, Nishanth Menon wrote:
> On 23:44-20230414, Udit Kumar wrote:
>> All I2C nodes were disabled in SOC dts file and in board
>> dts needed nodes were enabled.
> redundant.

ok


>
>> This patch enables wkup_i2c0 node in board dts file.
>>
>> Fixes: a9ed915cd55c ("arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level")
>
> This should'nt be fixing the commit - the commit is correct in the sense
> that if the board does'nt describe a node with pinmux, the i2c is'nt
> functional in the first place.

well, how i look at before this patch each i2c was functional.

this fix is making needed i2c as disabled, however this fix is correct

I am ok to remove Fixes

>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 63633e4f6c59..e66bbfe65ff2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -254,6 +254,10 @@ exp3: gpio@20 {
>>   	};
>>   };
>>   
>> +&wkup_i2c0 {
>> +	status = "okay";
> How about the pinmux? speed? what peripheral is on the wakeup i2c?
>
> 	Do we have an eeprom or something here?


This got eeprom and PMIC,

eeprom read is ok with pin mux and speed.

if you want to specify, let me know

>> +};
>> +
>>   &main_sdhci0 {
>>   	/* eMMC */
>>   	non-removable;
>> -- 
>> 2.34.1
>>
