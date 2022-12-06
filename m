Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3C643E9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiLFI3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiLFI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:29:47 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694713F93
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670315386; x=1701851386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cdyC1a0qwRBQniEmLvGy2bo9XStixIWTp8wQcxB/s4k=;
  b=K6XM5lBwdsuY2bkRzgSKvBdKrEBmQF3OhyS0xYZ59447KPWMPCl/YvH8
   slzZ95coOgfkDPWxEmTJCflZPf19txkHw0GqQJod2LKiQjutLzmqfO0tQ
   y7NhBiYgxUGQtBZyOFrs+oC5Va9ZrpGvbmVYS6J5WIUcIO9J2xM7hfLWQ
   w6KDCL6GUh7gLrGSkuNLN9iBfwwGF2NoJYeLuqGbIpuvCYG5VEFCdmNO+
   d0M/6dS8B4vB35Yo+oB86gqqxWfQ/IgtrL2fAuq7llREvGqc1jquChHGa
   7O5xI12iL7Vv/b6aDLdRLaiRCqFCmwLD6SJXM5/QJb8N4MB/ApwwzNv5S
   g==;
X-IronPort-AV: E=Sophos;i="5.96,220,1665417600"; 
   d="scan'208";a="218258771"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 16:29:45 +0800
IronPort-SDR: 1A5XNCU5Gwi+6rjHvSzG0S93ixefuR4Y797x9ksocYpQ+EGJADjn8m/cpvHeyj1jiQ5/DZCeXm
 pBFwwbkXfApVTm+4OZai1t0gECkh9bbFvCoHdIL5uehkBz+8bYMnfrKGXbCkZChdxI3ffgHipf
 Nbvvw3mWjvB5XnkIEJ8UkABWASRHsNCT7JBiKst6ek0rJnI5cFZdeVHoeDmLZ+XxyPhUJ3totc
 3KlVGT7CXgquMtzc1R2Pb0kLjWfDDuYKQuOpcYYQyWRN1MLMyw84lRxEeN2Zrt74cjLXD+qGRy
 oy0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 23:48:17 -0800
IronPort-SDR: WDk3tcx3J7Fwq/nyUZvJdC4wgX1ppnUpf3mdTUuibelaurt4YzkGZiztJTVYnuGAhxOd12f39h
 bnZ9XxX0DxdVEUknpxzof1TWIxuVmR3yQv0kyeJ+P5XzMgKIOtJdjXkdrz8813UWLuzxfMoQxu
 chf8PKAGXpfFxfg0GvpW4DaiOLQXgc08k052jOC/JtvNN+4gMWyjBn4xkcJBbLcPquUa+A0o/R
 mISpRLrkPnk2S2o7jL2JfiLMlPq5imJ0DhWrrBbml6pQ00k89lMsGZxbH8opD1FF0DHDJzocn8
 BPY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 00:29:45 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRD9j1Nh2z1Rwrq
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:29:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670315384; x=1672907385; bh=cdyC1a0qwRBQniEmLvGy2bo9XStixIWTp8w
        QcxB/s4k=; b=mxzaNg6by6iVaLVXekHDkPEXWlsmURQQq/Y5dxQ+QMDjQrXkvyn
        p7w65o0OSV3FAUDyM8UEW1eHprrxC0FrPUQnD/r9xoxn9jqquSyAz91ODPAkeNzP
        sVHZ8XzGfG59C/LF1mg5az61QMpklcKIlO0bXOF8WJgjRWoWBLXuI7RrGNagNXBK
        6GgH2z+6dPECpUDDBoraj1fveNKJEyatEfrTLbLjh4Or0VnIYIyxM7/WA32HuBrt
        9Zcd9qMZ3lbMMZ+5U/lrDmgJlHh+Gr+uYv8opXR1MFoHQzNwrmAx9lhjvJwBPhs/
        32VWKLyvBijy454tgHfiMmpagqm2CIHlxIw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hxHg_48jZ5Td for <linux-kernel@vger.kernel.org>;
        Tue,  6 Dec 2022 00:29:44 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRD9g27Kdz1RvLy;
        Tue,  6 Dec 2022 00:29:43 -0800 (PST)
Message-ID: <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 17:29:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
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

On 12/6/22 17:06, Paolo Valente wrote:
> 
> 
>> Il giorno 21 nov 2022, alle ore 02:01, Damien Le Moal <damien.lemoal@opensource.wdc.com> ha scritto:
>>
> 
> ...
> 
>>
>>> }
>>>
>>> static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>>> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>> {
>>> 	struct bfq_data *bfqd;
>>> 	struct elevator_queue *eq;
>>> +	unsigned int i;
>>> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>>>
>>> 	eq = elevator_alloc(q, e);
>>> 	if (!eq)
>>> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>> 	bfqd->queue = q;
>>>
>>> 	/*
>>> -	 * Multi-actuator support not complete yet, default to single
>>> -	 * actuator for the moment.
>>> +	 * If the disk supports multiple actuators, we copy the independent
>>> +	 * access ranges from the request queue structure.
>>> 	 */
>>> -	bfqd->num_actuators = 1;
>>> +	spin_lock_irq(&q->queue_lock);
>>> +	if (ia_ranges) {
>>> +		/*
>>> +		 * Check if the disk ia_ranges size exceeds the current bfq
>>> +		 * actuator limit.
>>> +		 */
>>> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
>>> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
>>> +				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
>>> +			pr_crit("Falling back to single actuator mode.\n");
>>> +			bfqd->num_actuators = 0;
>>> +		} else {
>>> +			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
>>> +
>>> +			for (i = 0; i < bfqd->num_actuators; i++)
>>> +				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
>>> +		}
>>> +	} else {
>>> +		bfqd->num_actuators = 0;
>>
>> That is very weird. The default should be 1 actuator.
>> ia_ranges->nr_ia_ranges is 0 when the disk does not provide any range
>> information, meaning it is a regular disk with a single actuator.
> 
> Actually, IIUC this assignment to 0 seems to be done exactly when you
> say that it should be done, i.e., when the disk does not provide any
> range information (ia_ranges is NULL). Am I missing something else?

No ranges reported means no extra actuators, so a single actuator an
single LBA range for the entire device. In that case, bfq should process
all IOs using bfqd->ia_ranges[0]. The get range function will always
return that range. That makes the code clean and avoids different path for
nr_ranges == 1 and nr_ranges > 1. No ?

> 
> Once again, all other suggestions applied. I'm about to submit a V7.
> 
> Thanks,
> Paolo
> 

-- 
Damien Le Moal
Western Digital Research

