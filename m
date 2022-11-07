Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E561F45C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiKGN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiKGN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:29:21 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F81CB24
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667827759; x=1699363759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xM7DahlPgGKUJt/O+KuLXEt4qp75IJYtNN8R0W0xZRo=;
  b=psuQX0O1BaXhles8JBHSO3cjUhidAv0rhRhFCTjDfBSdykAlXgGZVEsP
   EShAQT9CahU6GMSQzsxloY6ohPNIiZ56PvXTw20J+olNuTNpqINoV2rE8
   rlcB03MszmRFw4Ir1k9Vl41tKx0TBEP8kog0p6iEdZROJtInKrZvYaywq
   WpHRzzrcqypM2x27FIA4NU/3dI1ynDZM5/K33Vy+lvD4AfuZO5dqgqZjM
   I3ZZUO+1n7RFWM/jP4DTYxyjg5VkELk78wexRLkWCfVYG8Ng5QHMubAUn
   mlWs4M7Q8bXCcY3XE84nG+MamOECo8M+leoVKb/+TkN/TJX2Gu+996+5U
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="327766526"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 21:29:18 +0800
IronPort-SDR: /onCX6rKLW3aHoH1OATolHH8n50M0BfXe24nl8Xh2NDBKoKHoq4XXCALsa8BlGldeu1npWCnjn
 UztqV42pnCVbB+qHr1TAF+xYRDzSyYV3Lk6dR2kA2a1ilAAyKnYuodYdkw59jxCy9X4Jai+UAA
 UUtwBrrVK4BOhdEhFFCFqmxyhfmdxMjoJ8AGGH0Z90U6H7lBL2bp8rNhlY0eJwh22YJUaEduGR
 yBQXzJdBXl+8r8II//QabpUl62ArAbqkbTsK1YuDlg41yjlrvEfetV1lpHC2cOVTBjgmgOIrtp
 vNw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 04:42:40 -0800
IronPort-SDR: swNzVnHHapI/ufquIAWQqsd6c8pw3So8iktavqmtgb0NoF4aGNveU2JRAtCyy2BntbGPPXdhpx
 qrF3s65Z0CJtqb59Y3S77K1PDDNLFfPbheZU3cZIkshcGTn69yLClORYUo3AOngRqqr2ADYGf7
 thR3ODVwv0GjYFhbXXxrZ+8TzNhvveFBtSrYZdoxfuZqg5kgeVMEKga88Ig5pnO/sDTKd2mjzw
 gvXq25AX780ftWwd+gfkXcCpxHejxmsFggf3nGIhFoJ9foFjLe4jyjp9W6xTNBo8nMIjx6UNOS
 1EY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 05:29:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5XBj1sRTz1SHjy
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:29:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667827755; x=1670419756; bh=xM7DahlPgGKUJt/O+KuLXEt4qp75IJYtNN8
        R0W0xZRo=; b=uH5gDh+GokyRoYgTYtY/0yR1Ekg2vOZNR/N/dvNQqrsZG3uXFsD
        zLag6FJGsC6aVhjU9ZYTGzERaddUPcirHtt7jK4nHNMUAMeMoVAo9emBlTUWXcEi
        bljdM6xRi6Gt27TvEFiFzA0Zp4wVL6ZTvatNNb75bN0dUN1eCoSF0SJQyyPvGZ1/
        mwUqsrO+tIp6eEfZG8DAR+Cv43k3j03SpGiDklCzJFUbM5ncvynm+3OSontUUosy
        0ENB2pPV3SE5BkEApHENIdNCTOmX9oLGil3fYSf5VwrBF2rBGzJXw6HCTUKMy9lj
        u9/q4bOQ0FiRMiZcuZvC32QOEc4SlHTfqMg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3SbdRjij12NB for <linux-kernel@vger.kernel.org>;
        Mon,  7 Nov 2022 05:29:15 -0800 (PST)
Received: from [10.225.163.31] (unknown [10.225.163.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5XBc5CqLz1RvLy;
        Mon,  7 Nov 2022 05:29:12 -0800 (PST)
Message-ID: <cfb89169-77e5-b208-62e7-4cf1c660ac7a@opensource.wdc.com>
Date:   Mon, 7 Nov 2022 22:29:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        John Garry <john.g.garry@oracle.com>,
        John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org, hch@lst.de,
        ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
 <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
 <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
 <0e4994f7-f131-39b0-c876-f447b71566cd@opensource.wdc.com>
 <05cf6d61-987b-025d-b694-a58981226b97@oracle.com>
 <ff0c2ab7-8e82-40d9-1adf-78ee12846e1f@opensource.wdc.com>
 <39f9afc5-9aab-6f7c-b67a-e74e694543d4@suse.de>
 <0de1c3fd-4be7-1690-0780-720505c3692b@opensource.wdc.com>
 <75aea0e8-4fa4-593c-0024-3c39ac3882f3@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <75aea0e8-4fa4-593c-0024-3c39ac3882f3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 19:12, Hannes Reinecke wrote:
> On 11/2/22 12:25, Damien Le Moal wrote:
>> On 11/2/22 20:12, Hannes Reinecke wrote:
>>> On 11/2/22 11:07, Damien Le Moal wrote:
>>>> On 11/2/22 18:52, John Garry wrote:
>>>>> Hi Damien,
>>>>>
>>> [ .. ] >> So we only need to find a way of 're-using' that tag, then we won't have
>>> to set aside a reserved tag and everything would be dandy...
>>
>> I tried that. It is very ugly... Problem is that integration with EH in
>> case a real NCQ error happens when all that read-log-complete dance is
>> happening is hard. And don't get me started with the need to save/restore
>> the scsi command context of the command we are reusing the tag from.
>>
>> And given that the code is changing to use regular submission path for
>> internal commands, right now, we need a reserved tag. Or a way to "borrow"
>> the tag from a request that we need to check. Which means we need some
>> additional api to not always try to allocate a tag.
>>
>>>
>>> Maybe we can stop processing when we receive an error (should be doing
>>> that anyway as otherwise the log might be overwritten), then we should
>>> be having a pretty good chance of getting that tag.
>>
>> Hmmm.... that would be no better than using EH which does stop processing
>> until the internal house keeping is done.
>>
>>> Or, precisely, getting _any_ tag as at least one tag is free at that point.
>>> Hmm?
>>
>> See above. Not free, but usable as far as the device is concerned since we
>> have at least on command we need to check completed at the device level
>> (but not yet completed from scsi/block layer point of view).
>>
> So, having had an entire weekend pondering this issue why don't we 
> allocate an _additional_ set of requests?
> After all, we had been very generous with allocating queues and requests 
> (what with us doing a full provisioning of the requests for all queues 
> already for the non-shared tag case).
> 
> Idea would be to keep the single tag bitmap, but add eg a new rq state
> MQ_RQ_ERROR. Once that flag is set we'll fetch the error request instead 
> of the normal one:
> 
> @@ -761,6 +763,8 @@ static inline struct request 
> *blk_mq_tag_to_rq(struct blk_mq_tags *tags,
>   {
>          if (tag < tags->nr_tags) {
>                  prefetch(tags->rqs[tag]);
> +               if (unlikely(blk_mq_request_error(tags->rqs[tag])))
> +                       return tags->error_rqs[tag];
>                  return tags->rqs[tag];
>          }
> 
> and, of course, we would need to provision the error request first.
> 
> Rationale here is that this will be primarily for devices with a low 
> number of tags, so doubling the number of request isn't much of an 
> overhead (as we'll be doing it essentially anyway in the error case as 
> we'll have to save the original request _somewhere_), and that it would 
> remove quite some cruft from the subsystem; look at SCSI EH trying to 
> store the original request contents and then after EH restoring them again.

Interesting idea. I like it. It is essentially a set of reserved requests
without reserved tags: the tag to use for these requests would be provided
"manually" by the user. Right ?

That should allow simplifying any processing that needs to reuse a tag,
and currently its request. That is, CDL, but also usb-scsi, scsi EH and
the few scsi LLDs using scsi_eh_prep_cmnd()+scsi_eh_restore_cmnd().
Ideally, these 2 functions could go away too.

> 
> Hmm?
> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

