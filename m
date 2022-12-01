Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0A63F1EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLANoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiLANn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:43:59 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC8BF92A;
        Thu,  1 Dec 2022 05:43:56 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B1DhmvJ044178;
        Thu, 1 Dec 2022 07:43:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669902228;
        bh=wQU2wCefajvXNpsJPjUOfFnnZIcYY26KeStzZSXqUaA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qOCp3MObKXkhUKo2H1FWzFrrHvYomuqF08gMRJXMWYNGc3JlvwZuQySKMgzJJ75Qp
         QP23jfTtTE/cPRc66XnZgtcEVVrPHqyz6FY+D+BnBwcn0quNvGscoJwDr6prhvnPmU
         nQEfyx2cactpAumrMAg8jjF82O0FcsxV9pARanyA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B1Dhm9D049402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Dec 2022 07:43:48 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 1
 Dec 2022 07:43:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 1 Dec 2022 07:43:47 -0600
Received: from [10.250.235.35] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B1DhgE9092395;
        Thu, 1 Dec 2022 07:43:43 -0600
Message-ID: <15846a05-acb7-126e-eb4f-4057c77ce696@ti.com>
Date:   Thu, 1 Dec 2022 19:13:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [EXTERNAL] Re: [PATCH v10 3/6] remoteproc: pru: Add enum for PRU
 Core Indentifiers.
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <srk@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221201110500.4017889-1-danishanwar@ti.com>
 <20221201110500.4017889-4-danishanwar@ti.com>
 <a32f817e-6b61-7666-94f9-cf11f1f2e0a8@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <a32f817e-6b61-7666-94f9-cf11f1f2e0a8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 01/12/22 5:28 pm, Roger Quadros wrote:
> Danish,
> 
> On 01/12/2022 13:04, MD Danish Anwar wrote:
>> Introducing enum pruss_pru_id for PRU Core Identifiers.
>> PRUSS_PRU0 indicates PRU Core 0.
>> PRUSS_PRU1 indicates PRU Core 1.
>> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>   drivers/remoteproc/pru_rproc.c | 16 ++++++++++++----
>>   include/linux/pruss.h          | 19 +++++++++++++++++--
>>   2 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> index b4498a505108..7d4ed39b3772 100644
>> --- a/drivers/remoteproc/pru_rproc.c
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -186,6 +186,7 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>>    * pru_rproc_get() - get the PRU rproc instance from a device node
>>    * @np: the user/client device node
>>    * @index: index to use for the ti,prus property
>> + * @pru_id: optional pointer to return the PRU remoteproc processor id
>>    *
>>    * This function looks through a client device node's "ti,prus" property at
>>    * index @index and returns the rproc handle for a valid PRU remote processor if
>> @@ -193,13 +194,17 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>>    * time. Caller must call pru_rproc_put() when done with using the rproc, not
>>    * required if the function returns a failure.
>>    *
>> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
>> + * returned.
>> + *
>>    * Return: rproc handle on success, and an ERR_PTR on failure using one
>>    * of the following error values
>>    *    -ENODEV if device is not found
>>    *    -EBUSY if PRU is already acquired by anyone
>>    *    -EPROBE_DEFER is PRU device is not probed yet
>>    */
>> -struct rproc *pru_rproc_get(struct device_node *np, int index)
>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>> +			    enum pruss_pru_id *pru_id)
> 
> You just introduced pru_rproc_get() in the previous patch and are
> now updating it here.
> 

That's because there is dependency between these two patches. The enum 
pruss_pru_id is declared inside linux/pruss.h file which is introduced 
in pru_rproc_get() patch. But pru_rproc_get() and pru_rproc_put() APIs 
use the enum as function argument. So I decided to keep pru_rproc_get() 
patch as second patch of this series(as it introduces <linux/pruss.h> 
where eventually the enum will be introduced).

Then I kept the enum introduction patch as third patch of the series and 
with this patch I modified pru_rproc_get() API by adding pru_id field in 
the function argument.

> Instead, what you need to do is, first introduce enum pruss_pru_id
> and make any changes to code using hardcoded values for PRU ID.
> This patch will have to introduce <linux/pruss.h> as it doesn't exist yet.

This also came to my mind. But I thought introduction of enum 
pruss_pru_id patch should just introduce the enum and modify APIs which 
uses the enum accordingly. I wanted to keep the introduction of 
<linux/pruss.h> file with the pru_rproc_get() patch as it was. That's 
why I kept pru_rproc_get() patch ahead of enum patch.

> Hopefully this clears the chicken/egg situation.
> 
> Then introduce pru_rproc_get() patch with the final desired arguments.
> 
>>   {
>>   	struct rproc *rproc;
>>   	struct pru_rproc *pru;
>> @@ -226,6 +231,9 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
>>   
>>   	mutex_unlock(&pru->lock);
>>   
>> +	if (pru_id)
>> +		*pru_id = pru->id;
>> +
>>   	return rproc;
>>   
>>   err_no_rproc_handle:
>> @@ -556,7 +564,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>>   	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>>   	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>>   	/* PRU1 has its local RAM addresses reversed */
>> -	if (pru->id == 1)
>> +	if (pru->id == PRUSS_PRU1)
>>   		swap(dram0, dram1);
>>   	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>>   
>> @@ -865,14 +873,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
>>   	case RTU0_IRAM_ADDR_MASK:
>>   		fallthrough;
>>   	case PRU0_IRAM_ADDR_MASK:
>> -		pru->id = 0;
>> +		pru->id = PRUSS_PRU0;
>>   		break;
>>   	case TX_PRU1_IRAM_ADDR_MASK:
>>   		fallthrough;
>>   	case RTU1_IRAM_ADDR_MASK:
>>   		fallthrough;
>>   	case PRU1_IRAM_ADDR_MASK:
>> -		pru->id = 1;
>> +		pru->id = PRUSS_PRU1;
>>   		break;
>>   	default:
>>   		ret = -EINVAL;
>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
>> index 5c5d14b1249d..efe89c586b4b 100644
>> --- a/include/linux/pruss.h
>> +++ b/include/linux/pruss.h
>> @@ -14,17 +14,32 @@
>>   
>>   #define PRU_RPROC_DRVNAME "pru-rproc"
>>   
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
>>   struct device_node;
>>   
>>   #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
>>   
>> -struct rproc *pru_rproc_get(struct device_node *np, int index);
>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>> +			    enum pruss_pru_id *pru_id);
>>   void pru_rproc_put(struct rproc *rproc);
>>   
>>   #else
>>   
>>   static inline struct rproc *
>> -pru_rproc_get(struct device_node *np, int index)
>> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
>>   {
>>   	return ERR_PTR(-EOPNOTSUPP);
>>   }
> 
> --
> cheers,
> -roger

Thanks,
Danish.
