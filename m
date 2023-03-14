Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AC6B8E23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCNJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCNJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:06:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B99AFC4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:05:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32E95cv2084769;
        Tue, 14 Mar 2023 04:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678784738;
        bh=vDcrFBg8/NQ+JHpt8Q4sUVNlVK9JSdbITom/SavqcqQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LgBfveBlkIRwk0A8AfwVTJKgkWThXSd/vWucqRooiZrXV1X+ML67hDPWuZEWIA06L
         2LNQKGnNYnbS7/kUE6DtxBQGpN9VgMXc/kMBmoNvmcy04HnoacWtMYQjuGmTd0X0/g
         9Sa89gKBHddpKmeNGW8gs/ABPx4T91nYG13PPcJA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32E95cbK035629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 04:05:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 04:05:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 04:05:37 -0500
Received: from [172.24.145.215] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32E95Ze4054604;
        Tue, 14 Mar 2023 04:05:36 -0500
Message-ID: <be5b5cc2-8063-2acd-31a6-eabed65ee3fc@ti.com>
Date:   Tue, 14 Mar 2023 14:35:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J784S4 SOC
To:     Nishanth Menon <nm@ti.com>
CC:     <ssantosh@kernel.org>, <s-vadapalli@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230313065025.185320-1-j-choudhary@ti.com>
 <20230313161939.ortphyo3ntu2dl3b@bully>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230313161939.ortphyo3ntu2dl3b@bully>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/23 21:49, Nishanth Menon wrote:
> On 12:20-20230313, Jayesh Choudhary wrote:
>> J784S4 SoC's JTAG PARTNO is 0xBB80.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> ^^ is that Co-developed-by ?

The authorship is incorrect. I have fixed it in v2.

> 
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   drivers/soc/ti/k3-socinfo.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
>> index d15764e19d96..ad97e08a25f6 100644
>> --- a/drivers/soc/ti/k3-socinfo.c
>> +++ b/drivers/soc/ti/k3-socinfo.c
>> @@ -43,6 +43,7 @@ static const struct k3_soc_id {
>>   	{ 0xBB38, "AM64X" },
>>   	{ 0xBB75, "J721S2"},
>>   	{ 0xBB7E, "AM62X" },
>> +	{ 0xBB80, "J784S4" },
>>   	{ 0xBB8D, "AM62AX" },
>>   };
>>   
>> -- 
>> 2.25.1
>>
> 
