Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7509365E5C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjAEG5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAEG5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:57:23 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345A5274A;
        Wed,  4 Jan 2023 22:57:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3056v22j125663;
        Thu, 5 Jan 2023 00:57:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672901822;
        bh=lApiIuTNjR6+fOleqQdOeGBS8C+PUb0O1jZIgzhKcrE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=auuS9WTGga4p1i9YsEa+8DLocA2OZD/+jcOR9RlMzYCfvRUyyBOLe4UMPX4QEnAVN
         ZPkWW6N9B4s28Mudy467gN1hxxjrWOOjQHboAci5TLDt/Y3rHecwKpQ+Fs7i5QYZaZ
         t8S/bgVYnmLThe+HxXtlR5Tfiyl4/NRbOT0us8do=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3056v2QQ030420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jan 2023 00:57:02 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 5
 Jan 2023 00:57:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 5 Jan 2023 00:57:02 -0600
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3056uwuq014589;
        Thu, 5 Jan 2023 00:56:58 -0600
Message-ID: <49f03742-82a4-7748-0b4a-c557006b04cc@ti.com>
Date:   Thu, 5 Jan 2023 12:26:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH v12 2/6] remoteproc: pru: Add enum for PRU
 Core Identifiers.
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221216053313.2974826-1-danishanwar@ti.com>
 <20221216053313.2974826-3-danishanwar@ti.com> <20230105002240.GE2112402@p14s>
Content-Language: en-US
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20230105002240.GE2112402@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 05/01/23 05:52, Mathieu Poirier wrote:
> On Fri, Dec 16, 2022 at 11:03:09AM +0530, MD Danish Anwar wrote:
>> Introducing enum pruss_pru_id for PRU Core Identifiers.
>> PRUSS_PRU0 indicates PRU Core 0.
>> PRUSS_PRU1 indicates PRU Core 1.
>> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/remoteproc/pru_rproc.c |  7 ++++---
>>  include/linux/pruss.h          | 32 ++++++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+), 3 deletions(-)
>>  create mode 100644 include/linux/pruss.h
>>
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> index 128bf9912f2c..a1a208b31846 100644
>> --- a/drivers/remoteproc/pru_rproc.c
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_irq.h>
>> +#include <linux/pruss.h>
>>  #include <linux/pruss_driver.h>
>>  #include <linux/remoteproc.h>
>>  
>> @@ -438,7 +439,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>>  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>>  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>>  	/* PRU1 has its local RAM addresses reversed */
>> -	if (pru->id == 1)
>> +	if (pru->id == PRUSS_PRU1)
>>  		swap(dram0, dram1);
>>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>>  
>> @@ -747,14 +748,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
>>  	case RTU0_IRAM_ADDR_MASK:
>>  		fallthrough;
>>  	case PRU0_IRAM_ADDR_MASK:
>> -		pru->id = 0;
>> +		pru->id = PRUSS_PRU0;
>>  		break;
>>  	case TX_PRU1_IRAM_ADDR_MASK:
>>  		fallthrough;
>>  	case RTU1_IRAM_ADDR_MASK:
>>  		fallthrough;
>>  	case PRU1_IRAM_ADDR_MASK:
>> -		pru->id = 1;
>> +		pru->id = PRUSS_PRU1;
>>  		break;
>>  	default:
>>  		ret = -EINVAL;
>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
>> new file mode 100644
>> index 000000000000..fbe4fbb45807
>> --- /dev/null
>> +++ b/include/linux/pruss.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/**
>> + * PRU-ICSS Subsystem user interfaces
>> + *
>> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
>> + *	Suman Anna <s-anna@ti.com>
>> + */
>> +
>> +#ifndef __LINUX_PRUSS_H
>> +#define __LINUX_PRUSS_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/types.h>
>> +
>> +#define PRU_RPROC_DRVNAME "pru-rproc"
>> +
>> +/**
>> + * enum pruss_pru_id - PRU core identifiers
>> + * @PRUSS_PRU0: PRU Core 0.
>> + * @PRUSS_PRU1: PRU Core 1.
>> + * @PRUSS_NUM_PRUS: Total number of PRU Cores available.
>> + *
>> + */
>> +
>> +enum pruss_pru_id {
>> +	PRUSS_PRU0 = 0,
>> +	PRUSS_PRU1,
>> +	PRUSS_NUM_PRUS,
>> +};
>> +
>> +
>> +#endif /* __LINUX_PRUSS_H */
>> \ No newline at end of file
> 
> I fixed the checkpatch warning associated with this patch but it has a cascading
> effect on the other patches.  Please address and send a new revision.  Aside
> from this I am good with this patchset.
> 
> Thanks,
> Mathieu
> 

Sure Mathieu.
I will fix the checkpatch warning associated with this patch and send a new
revision.

Thanks,
Danish.

>> -- 
>> 2.25.1
>>
