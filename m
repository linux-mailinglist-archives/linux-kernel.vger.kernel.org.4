Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D517488D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjGEQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjGEQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:02:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4A1731;
        Wed,  5 Jul 2023 09:02:17 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365ELIeq007738;
        Wed, 5 Jul 2023 18:02:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=W8QKUVhYDjYfxEq3hbVph2SyFTnHqVpGE4GYkCClLUw=;
 b=N1Sfon227lQhLTWwKqR930OaSo6+9K0z+UjUB2N5veXEgyOXzfunYiMhk6ivfS1QKrzX
 1HJL+WYR3uyG5m/ildtD0dUdmOVed2C1bdFqfCylZfm/QOBABwg6x8eyaLXDLUSlRhpq
 A0IMYfiuuADXH8B5jPnp20JmthKegD1Ja57B0tY90BeBcDLhd/3UaGjD2mW+GGRmnon8
 w8y9Hb2HOqIAdpQHnAtz+xvcspt+/l9O1bE7C0mMVFvYGZ49Gv2eiha7rMrUnmPZcwmB
 Inoy0PAQVIEPkxbU49m+3N0tmmg08KB1SUM5Enz9b9O6MiUn2ic6AHNsoCl4PIqMN3HP gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rna75gnhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 18:02:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC1F8100057;
        Wed,  5 Jul 2023 18:02:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4DDF923153A;
        Wed,  5 Jul 2023 18:02:03 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 18:02:02 +0200
Message-ID: <b0627883-d764-e951-ead8-f5a047ce66e3@foss.st.com>
Date:   Wed, 5 Jul 2023 18:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/7] rtc: stm32: fix unnecessary parentheses
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230615092753.323844-1-valentin.caron@foss.st.com>
 <20230615092753.323844-7-valentin.caron@foss.st.com>
 <202306252316063d08f43c@mail.local>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <202306252316063d08f43c@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_07,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/26/23 01:16, Alexandre Belloni wrote:
> Hello,
>
> On 15/06/2023 11:27:52+0200, Valentin Caron wrote:
>> Fix a few style issues reported by checkpatch.pl:
>> - Unnecessary parentheses
>> - Lines should not end with a '('
>>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>>   drivers/rtc/rtc-stm32.c | 29 ++++++++++++++---------------
>>   1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
>> index 17e549806784..30c5004d6902 100644
>> --- a/drivers/rtc/rtc-stm32.c
>> +++ b/drivers/rtc/rtc-stm32.c
>> @@ -160,10 +160,9 @@ static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
>>   		 * slowest rtc_ck frequency may be 32kHz and highest should be
>>   		 * 1MHz, we poll every 10 us with a timeout of 100ms.
>>   		 */
>> -		return readl_relaxed_poll_timeout_atomic(
>> -					rtc->base + regs->isr,
>> -					isr, (isr & STM32_RTC_ISR_INITF),
>> -					10, 100000);
>> +		return readl_relaxed_poll_timeout_atomic(rtc->base + regs->isr, isr,
>> +							 (isr & STM32_RTC_ISR_INITF),
>> +							 10, 100000);
>>   	}
>>   
>>   	return 0;
>> @@ -448,16 +447,16 @@ static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
>>   	 *	M-D-Y H:M:S < alarm <= (M+1)-D-Y H:M:S
>>   	 * with a specific case for December...
>>   	 */
>> -	if ((((tm->tm_year > cur_year) &&
>> -	      (tm->tm_mon == 0x1) && (cur_mon == 0x12)) ||
>> -	     ((tm->tm_year == cur_year) &&
>> -	      (tm->tm_mon <= cur_mon + 1))) &&
>> -	    ((tm->tm_mday > cur_day) ||
>> -	     ((tm->tm_mday == cur_day) &&
>> -	     ((tm->tm_hour > cur_hour) ||
>> -	      ((tm->tm_hour == cur_hour) && (tm->tm_min > cur_min)) ||
>> -	      ((tm->tm_hour == cur_hour) && (tm->tm_min == cur_min) &&
>> -	       (tm->tm_sec >= cur_sec))))))
>> +	if (((tm->tm_year > cur_year &&
>> +	      tm->tm_mon == 0x1 && cur_mon == 0x12) ||
>> +	     (tm->tm_year == cur_year &&
>> +	      tm->tm_mon <= cur_mon + 1)) &&
>> +	    (tm->tm_mday > cur_day ||
>> +	     (tm->tm_mday == cur_day &&
>> +	     (tm->tm_hour > cur_hour ||
>> +	      (tm->tm_hour == cur_hour && tm->tm_min > cur_min) ||
>> +	      (tm->tm_hour == cur_hour && tm->tm_min == cur_min &&
>> +	       tm->tm_sec >= cur_sec)))))
> This change is dropped in the following patch. I guess you can remove
> the unnecessary churn.

Yes absolutely ! Let's go for a v2.

Thanks,
Valentin

>
>>   		return 0;
>>   
>>   	return -EINVAL;
>> @@ -666,7 +665,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
>>   	 * Can't find a 1Hz, so give priority to RTC power consumption
>>   	 * by choosing the higher possible value for prediv_a
>>   	 */
>> -	if ((pred_s > pred_s_max) || (pred_a > pred_a_max)) {
>> +	if (pred_s > pred_s_max || pred_a > pred_a_max) {
>>   		pred_a = pred_a_max;
>>   		pred_s = (rate / (pred_a + 1)) - 1;
>>   
>> -- 
>> 2.25.1
>>
