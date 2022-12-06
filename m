Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A17643F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiLFJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiLFJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:02:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E71B1C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670317340; x=1701853340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tDgDQqNirCT+e73E+conxaN1lIGJ4ehCQJa0Vcez7E8=;
  b=kaXNZWpvH6AMFfZAyPq0gihYlQvPYBg91vPmydqiq6scQbQG+QLhocL+
   7YQUybJoGKebGCLQKEUnPVTOr3p+jPZzwSNoE2y8vazxgrjCJQlMq95lk
   +2zwAuhju2saZNiiW+R9OGoxiBwqcXdVb0zw3mKKUv0z8WF/I4eUwIQc6
   Q8mLHQryeCR82AXaSgBUr1/HBwf+kL/jAjiWb2eq/Rk1+hEOT4z6TXjq2
   i3OM4dCB0yfCC3skOXC+A7yLKzE2uoZy+BpcufZxCq1GpKk9pMTeRhbIh
   7nm4i0SeSWU9F6LLerMTSTmv18jzkIAZNKr7crmNbxKENv15P1rz8lSNQ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,220,1665417600"; 
   d="scan'208";a="218260827"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 17:02:19 +0800
IronPort-SDR: TV0qYMOjn0AjimLvCoaYvlcqqjzEsAo4xkcF+UcY7EAUSJmsfZ6J3j8g/whCmf65c/ABn5cu4a
 mUkXGcfkFU1Gmii/zPOTL0Tjue6ZVrgZNE3eVJGlNbVAxaY8PT4ctBwb602tT1zuN5l5BFhwRu
 T5khg2qWoBQwtkXLF4tQPHYIbi8bDXPNob8NmRE5eoKNBgti1UUlyB0eq28wZD4+omZSQgyndY
 1ZuARxknqXeFaAFqu518DljAAS8cphN65jNy3NMZ7WZcoD1JQuRI5+1ywMrMjbwZHjyfv81gzZ
 qe8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 00:20:52 -0800
IronPort-SDR: WkBhhK/1qO/gieJMvhAVGn5fSVLW2wJJZ7EA+ZuuQbgw0E2qc7npkJBgqbFM/EDf1H4sbYV24K
 3+kZO9IFyAkJ4+LofejCu5xQt8xGeo0Z6+eMBqBXiNirFtvK3eiWYCH4BYMWmuR2LcUpNoH1iJ
 XXFXSe1iHBK7zMKJSAQNcI7frf3/zkaNJjkPJ8M4lH77lpI72PaxsAfOgaDCc/YSYmwopwczOa
 agUhj3oq6OK+dtm/lSm6Iq5mNaNz9592qwjBo8+4r0sM6e6l6dDJUv6+FzcWuCRluN4XWFzav2
 xcs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 01:02:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRDvH5p6Gz1RvTr
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:02:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670317338; x=1672909339; bh=tDgDQqNirCT+e73E+conxaN1lIGJ4ehCQJa
        0Vcez7E8=; b=SJNsWdTUp4zb3n59Sjijv82P5C4Ax1p8NYTIimQJpIcuucK22AX
        cWQ+bHzcLxreoY6/6P09kU0vMdVrNlAbsuFS3927VR5Cjfgy7ZMWWceXzBx8h4Zb
        qec6l+7PnQIH+8DbfW7h6XGN/qoEUHKLVymhbR9TZNyvDSz60DpDXVXsi+LbjigO
        Lw1gkBTRBSxc/UDKuYBgYtRNkkJmpL9xtBELDr8EqnAbqbX0uF4VcNXt/Vj1Mbqs
        lJUv1vmzVtULcFt5mAuUo9VLFQ650SmRWZ2FJ8Zzp0yb+1w7J72ZbHaFWJDUIT0H
        oCNd69ZscpZwO+xoYg6i14fG78NVAYOCXoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zzf6HGPd9LzW for <linux-kernel@vger.kernel.org>;
        Tue,  6 Dec 2022 01:02:18 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRDvF5q95z1RvLy;
        Tue,  6 Dec 2022 01:02:17 -0800 (PST)
Message-ID: <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 18:02:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 17:41, Paolo Valente wrote:
> 
> 
>> Il giorno 6 dic 2022, alle ore 09:29, Damien Le Moal <damien.lemoal@opensource.wdc.com> ha scritto:
>>
>> On 12/6/22 17:06, Paolo Valente wrote:
>>>
>>>
>>>> Il giorno 21 nov 2022, alle ore 02:01, Damien Le Moal <damien.lemoal@opensource.wdc.com> ha scritto:
>>>>
>>>
>>> ...
>>>
>>>>
>>>>> }
>>>>>
>>>>> static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>>>>> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>>>> {
>>>>> 	struct bfq_data *bfqd;
>>>>> 	struct elevator_queue *eq;
>>>>> +	unsigned int i;
>>>>> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>>>>>
>>>>> 	eq = elevator_alloc(q, e);
>>>>> 	if (!eq)
>>>>> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>>>> 	bfqd->queue = q;
>>>>>
>>>>> 	/*
>>>>> -	 * Multi-actuator support not complete yet, default to single
>>>>> -	 * actuator for the moment.
>>>>> +	 * If the disk supports multiple actuators, we copy the independent
>>>>> +	 * access ranges from the request queue structure.
>>>>> 	 */
>>>>> -	bfqd->num_actuators = 1;
>>>>> +	spin_lock_irq(&q->queue_lock);
>>>>> +	if (ia_ranges) {
>>>>> +		/*
>>>>> +		 * Check if the disk ia_ranges size exceeds the current bfq
>>>>> +		 * actuator limit.
>>>>> +		 */
>>>>> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
>>>>> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
>>>>> +				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
>>>>> +			pr_crit("Falling back to single actuator mode.\n");
>>>>> +			bfqd->num_actuators = 0;
>>>>> +		} else {
>>>>> +			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
>>>>> +
>>>>> +			for (i = 0; i < bfqd->num_actuators; i++)
>>>>> +				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
>>>>> +		}
>>>>> +	} else {
>>>>> +		bfqd->num_actuators = 0;
>>>>
>>>> That is very weird. The default should be 1 actuator.
>>>> ia_ranges->nr_ia_ranges is 0 when the disk does not provide any range
>>>> information, meaning it is a regular disk with a single actuator.
>>>
>>> Actually, IIUC this assignment to 0 seems to be done exactly when you
>>> say that it should be done, i.e., when the disk does not provide any
>>> range information (ia_ranges is NULL). Am I missing something else?
>>
>> No ranges reported means no extra actuators, so a single actuator an
>> single LBA range for the entire device.
> 
> I'm still confused, sorry.  Where will I read sector ranges from, if
> no sector range information is available (ia_ranges is NULL)?

start = 0 and nr_sectors = bdev_nr_sectors(bdev).
No ia_ranges to read.

> 
>> In that case, bfq should process
>> all IOs using bfqd->ia_ranges[0]. The get range function will always
>> return that range. That makes the code clean and avoids different path for
>> nr_ranges == 1 and nr_ranges > 1. No ?
> 
> Apart from the above point, for which maybe there is some other
> source of information for getting ranges, I see the following issue.
> 
> What you propose is to save sector information and trigger the
> range-checking for loop also for the above single-actuator case.  Yet
> txecuting (one iteration of) that loop will will always result in
> getting a 0 as index.  So, what's the point is saving data and
> executing code on each IO, for getting a static result that we already
> know we will get?

Surely, you can add an "if (bfqd->num_actuators ==1)" optimization in
strategic places to optimize for regular devices with a single actuator,
which bfqd->num_actuators == 1 *exactly* describes. Having
"bfqd->num_actuators = 0" makes no sense to me.

But if you feel strongly about this, feel free to ignore this.

> 
> Thanks,
> Paolo
> 
>>
>>>
>>> Once again, all other suggestions applied. I'm about to submit a V7.
>>>
>>> Thanks,
>>> Paolo
>>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 

-- 
Damien Le Moal
Western Digital Research

