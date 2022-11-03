Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C97618BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKCWgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCWgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:36:36 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FE205D1;
        Thu,  3 Nov 2022 15:36:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3MaRTt080177;
        Thu, 3 Nov 2022 17:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667514987;
        bh=J8PyCu9ZwRLdwKBIqbV6Foz08xtfSAC7XRmjHJxgnLc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Jzzuubm+wJW6QNgrso4WMyCVOtXOOcLB+Zvz5gul6/TDjI3MNROIpwreCMFs/1Dzw
         1zT6KktUba8vkGie9iNXa85hY+PliSNLEupfZqKNZpYxUaAZUhKpSfBdMcE1Iko9yU
         uNodnNPoyohSZdVmEH96MzLQf8ItDjpN5sXMncAA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3MaRQe124068
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 17:36:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 17:36:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 17:36:27 -0500
Received: from [10.250.32.80] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3MaQ07001865;
        Thu, 3 Nov 2022 17:36:26 -0500
Message-ID: <35284213-db06-8b6d-8c94-4279f61d6296@ti.com>
Date:   Thu, 3 Nov 2022 17:36:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: mark MCU and WKUP
 watchdogs as reserved
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221103181440.232727-1-jpanis@baylibre.com>
 <20221103181440.232727-3-jpanis@baylibre.com>
 <20221103214754.5feylk5sfem2lvhf@magnetize>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221103214754.5feylk5sfem2lvhf@magnetize>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 4:47 PM, Nishanth Menon wrote:
> On 19:14-20221103, Julien Panis wrote:
>> MCU wdt is typically used by M4F.
>> Wake up wdt is typically used by DM (R5) firmware.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am625-sk.dts | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> index 93a5f0817efc..9ade591ef563 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> @@ -503,6 +503,16 @@ &main_mcan0 {
>>   	status = "disabled";
>>   };
>>   
>> +&mcu_rti0 {
>> +	/* MCU RTI0 is used by M4F firmware */
>> +	status = "reserved";
>> +};
>> +
>> +&wkup_rti0 {
>> +	/* WKUP RTI0 is used by DM firmware */
>> +	status = "reserved";
>> +};
>> +
> 
> If this is the typical usage, should'nt we do this in soc.dtsi than
> sprinkle this through various boards?
> 
> Andrew: ?

These are only "reserved" for certain firmware, you choose your RPROCs
and firmware down at the bottom level in board DTs. So I'd say these
statuses should be set at this same level here.

DM firmware might be the exception as it should always be present,
but for M4F firmware, meh, leave it here.

Andrew

>>   &epwm0 {
>>   	status = "disabled";
>>   };
>> -- 
>> 2.37.3
>>
> 
