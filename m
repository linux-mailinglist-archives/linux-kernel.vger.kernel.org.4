Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9049737A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFUFaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjFUFaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:30:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418019A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:29:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L5TPiT104238;
        Wed, 21 Jun 2023 00:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687325365;
        bh=gteDy6F7zeGKznpsB7BflV0bnQJGqfADZ4Hj9FpsLxQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=yApvPK282MOTq5kDLN4vB3JlvX5P8MzGNGR8BUJX7aw0VnoZN9GhBHy3qo6KIM+In
         oqjavdgZTN0A+uctwzegdJa0SWXbb1O6UbXNW3zyNtCay2YTeR3LAUMOi1VmfMrY9F
         V9G7JMe/z0tphrtfBITrlxYGxjFoU74hlQmsGe40=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L5TPMa018323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jun 2023 00:29:25 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Jun 2023 00:29:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Jun 2023 00:29:25 -0500
Received: from [172.24.217.66] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L5TK19006814;
        Wed, 21 Jun 2023 00:29:21 -0500
Message-ID: <498ccb75-03f0-9a8b-3626-11da47908ee0@ti.com>
Date:   Wed, 21 Jun 2023 10:59:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: defconfig: Enable K3 RTI Watchdog
To:     Nishanth Menon <nm@ti.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_bjorande@quicinc.com>,
        <arnd@arndb.de>, <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
References: <20230621051358.3905149-1-u-kumar1@ti.com>
 <20230621051544.mvxz5hjxhi37eakw@precinct>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230621051544.mvxz5hjxhi37eakw@precinct>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/2023 10:45 AM, Nishanth Menon wrote:
> On 10:43-20230621, Udit Kumar wrote:
>> K3 Family has RTI watchdog. This patch is
> For the benefit of others, please provide context of what K3 and RTI
> watchdog is.

ok


>
>> needed to enable WDT functions.
> Why not a module?

For ease of use, i used as part of kernel.

No issues having as module

>
> Also please indicate specific products that can benefit with the change.

Sure.


>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 57c6b7bb88d4..4567645abe35 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -686,6 +686,7 @@ CONFIG_UNIPHIER_WATCHDOG=y
>>   CONFIG_PM8916_WATCHDOG=m
>>   CONFIG_BCM2835_WDT=y
>>   CONFIG_BCM7038_WDT=m
>> +CONFIG_K3_RTI_WATCHDOG=y
>>   CONFIG_MFD_ALTERA_SYSMGR=y
>>   CONFIG_MFD_BD9571MWV=y
>>   CONFIG_MFD_AXP20X_I2C=y
>> -- 
>> 2.34.1
>>
