Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42965FFE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAFMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAFMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:02:29 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84E3225A;
        Fri,  6 Jan 2023 04:02:28 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 306C2DMs066080;
        Fri, 6 Jan 2023 06:02:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673006533;
        bh=7q3SGj3F/tCY6enixxVoRGsdpeMIFq0XYzuubYHLrZc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WuflFvl7pISP2M/5kUhHCHV1iWYQrh+flKoRhpRZUx18WDwLYmUq7o/wO8hmJSPLy
         zYAqWFz9/QVp45aya+6N4QCYwMqXlBqCMOp0gnuqiHS23Kwte/4SxWyd48jNxy6tv3
         2+0GNlUj+WUDmb/ouazjHpKQduaWDqOxQSadb9FE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 306C2Dfa114784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jan 2023 06:02:13 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 6
 Jan 2023 06:02:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 6 Jan 2023 06:02:13 -0600
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 306C28Ip013534;
        Fri, 6 Jan 2023 06:02:09 -0600
Message-ID: <4c93d5b2-ce15-afac-ccb8-384a366b0eae@ti.com>
Date:   Fri, 6 Jan 2023 17:32:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH v13 2/6] remoteproc: pru: Add enum for PRU
 Core Identifiers.
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230105092149.686201-1-danishanwar@ti.com>
 <20230105092149.686201-3-danishanwar@ti.com> <20230105202356.GA2281956@p14s>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20230105202356.GA2281956@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 06/01/23 01:53, Mathieu Poirier wrote:
> On Thu, Jan 05, 2023 at 02:51:45PM +0530, MD Danish Anwar wrote:
>> Introducing enum pruss_pru_id for PRU Core Identifiers.
>> PRUSS_PRU0 indicates PRU Core 0.
>> PRUSS_PRU1 indicates PRU Core 1.
>> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/remoteproc/pru_rproc.c |  7 ++++---
>>  include/linux/pruss.h          | 31 +++++++++++++++++++++++++++++++
> 
> Please add this under include/linux/remoteproc/ to avoid adding an orphan file
> under include/linux/.
> 
> Thanks,
> Mathieu
> 

Sure, I will remove this header file from here and add it under
include/linux/remoteproc/ .

Thanks,
Danish.

>>  2 files changed, 35 insertions(+), 3 deletions(-)
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
>> index 000000000000..e94a81e97a4c
>> --- /dev/null
>> +++ b/include/linux/pruss.h
>> @@ -0,0 +1,31 @@
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
>> +#endif /* __LINUX_PRUSS_H */
>> -- 
>> 2.25.1
>>
