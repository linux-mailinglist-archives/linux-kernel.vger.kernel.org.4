Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0DC6FC426
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjEIKol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjEIKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:44:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772A4ECB;
        Tue,  9 May 2023 03:44:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349AiQuM038472;
        Tue, 9 May 2023 05:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683629066;
        bh=brW6qq64lo8T90mzL6db2C3UWARKcso94AHe4Od7SYU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kUA542d0WyewJLXuYsrpbk3UEV2/je3szNM+2FUU7z1fTZG/onQY3alEXvPaRCFej
         26iGHrhzEBQbQ7k5B8vjz5tt2i2HjUk9QU9MrJGOhhIi1b2Oo27YKSQBxX0U9AFjw+
         ZkM0qiUj+8jIX1TCHDf2r1SJSscqYQar4cpGpQy4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349AiQeH074218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 05:44:26 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 05:44:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 05:44:25 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349AiMBW029553;
        Tue, 9 May 2023 05:44:23 -0500
Message-ID: <8aae9af7-22ea-4b2b-563c-0f01e361775c@ti.com>
Date:   Tue, 9 May 2023 16:14:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: defconfig: Enable UBIFS
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Vaishnav Achath <vaishnav.a@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230417092243.967871-1-d-gole@ti.com>
 <a25ce95e-126e-7a1a-1bb0-2a3d73ea4aee@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <a25ce95e-126e-7a1a-1bb0-2a3d73ea4aee@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/23 13:13, Dhruva Gole wrote:
> Hi,
> 
> On 17/04/23 14:52, Dhruva Gole wrote:
>> UBIFS is a file system for flash devices which works on top of UBI.
>>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> ---
>>   arch/arm64/configs/defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 4f59fa575b47..a632d2a1db93 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -267,6 +267,8 @@ CONFIG_MTD_NAND_BRCMNAND=m
>>   CONFIG_MTD_NAND_FSL_IFC=y
>>   CONFIG_MTD_NAND_QCOM=y
>>   CONFIG_MTD_SPI_NOR=y
>> +CONFIG_MTD_UBI=m
>> +CONFIG_UBIFS_FS=m
> 
> Gentle ping on this patch, can we please pull this in since nobody has
> raised any objections since over 3 weeks?

I am planning to queuing this via TI arch tree, if there no objections.

Unfortunately, your patch landed post v6.4-rc1 PRs were sent out. And
thus will only be part of v6.5 cycle. Note that v6.4-rc1 was tagged last
Monday, so you may have to wait a while for folks to catch up

> 
>>   CONFIG_BLK_DEV_LOOP=y
>>   CONFIG_BLK_DEV_NBD=m
>>   CONFIG_VIRTIO_BLK=y
> 

-- 
Regards
Vignesh
