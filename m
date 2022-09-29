Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B75EEFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiI2IDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiI2ICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:02:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4BB27A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664438549; x=1695974549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YshxXDMKEqJOIsgscRPPwus5X09Feg6t1SyxNOe9VoM=;
  b=dPmbc0e3ckvugIu91/Zn3Xy4C/7MUGhj1xJSsjTavutZL09W+aMKyD4I
   AlHP+VZ9b96Yyf4q8Gp241jAbheQ6z8hXukIEH5BwsmSo9rAF7PK2o1aP
   +/AaSCdQYsyPasR1FTyKeBl4+761X/JaObd+N9nWsLAL10PjOQgt+2GKO
   h45HhfuEBaZwM+teuoa5yciwtKABJ+sbKovpNZYVbn6f1NYrDlrGnaOxM
   UIBd4w57LDtZs6wG/gzvlIWzrCJFCgxIM+uk7JJn25ikEyf1BqGPCa9pz
   VJlBc0JgLuLcLpMWrfKvo+JDe8QhBRlQskciplFUZrsNbEp95tC6awcw9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="324662859"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 16:02:26 +0800
IronPort-SDR: bW1j+aO897BQFD/NWZ3XZjLMXp/uIJnXU79fL/66DZGagI0Sz0jjMrtQXumEubxEZe7G0j25wA
 aw2vvttWQa0YR5OlPgwbTygqU3hHhtCwmfbIWET7WXzNUw5GQQWqau3x5IXSZtxl+Xxg0VJPVV
 /8fX7IYN9nn2a6lisxak2PKA2dVduBwuDoAFHtkmfrL5l3XZSqXScD1UZvvGqA9v4R82jHkrFN
 UdJLLuVV+lwl5tCYRDk2fRk3rbultvzpOM/uqh0OdlxqTOBk/lapkjbaM4uopak2R8IpFzLaIZ
 x7KkU/YPstnB9cls8IhgQ0c2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 00:16:49 -0700
IronPort-SDR: GT+oglLuk0Rq9vSv2qGmGH0hDpgrjzDceyIMiLSOCH/LAO9A9fpgmwAu4Y/CEoGGb3zIcj451D
 JGJJSfs6GVUNYGyA0ZeYKvC1bbByWg9mXFr8Oj4IHtuaJOpw2JCsYetFJbkfSk39/tP6D1+jZA
 Uj9CrXZ9Qz2yd5oB5A3LE2Z87+hWAzq7PWQw5ovOj64r2LWr19qw2kUzbDwCukPPzBYpaldszH
 VQj44+yHJKp2AXKCytz4QkmiyAMEbhXTM9f4ca2TVWK+WUyCczOj+dMvEjgTM7HaPRJ9JPDS3D
 lV4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 01:02:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdQnZ18j1z1RwvL
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:02:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664438545; x=1667030546; bh=YshxXDMKEqJOIsgscRPPwus5X09Feg6t1Sy
        xNOe9VoM=; b=X+WGGr+UjsiYMFJegjoEUMdtZhxiqPoCJmmvjzOf+xfkLdu4Vad
        58Z4S365gtjJHvftn16Lg21Q1arzXtTPYtZu3p/eLBgtDTp0aX/IyiKZfT5sfVp1
        NOKdFa2rDONRcEOeOPeVHRs34zSxG0mPbZiuTeE5glW7cpQYyYE2dbJ++PH/iAWF
        uKJGqrY3TaEYyqFccnKobQO/Rsk4/QZDSwSF4aWFiP0Go8NOWHfKmjuCOs2hJzZZ
        U4454obB+3Ijvv/h1R6X7xXkANFCw0kyDwdIAwangAuI2LEAnP4t+Ml5ditXx/pG
        kJyRFGF8c4wEg0QK2q1dkLiwx9XXJ5vup5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rK1SGqrHv_jz for <linux-kernel@vger.kernel.org>;
        Thu, 29 Sep 2022 01:02:25 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdQnV6W2Vz1RvLy;
        Thu, 29 Sep 2022 01:02:22 -0700 (PDT)
Message-ID: <e8d20a5d-8ca6-b1ff-20be-fb0c782345ca@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 17:02:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 6/6] scsi: mvsas: Use sas_task_find_rq() for tagging
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        ipylypiv@google.com, changyuanl@google.com, hch@lst.de
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-7-git-send-email-john.garry@huawei.com>
 <53e304b4-c025-e884-c8f5-6c2e96cc0052@opensource.wdc.com>
 <e4aa7b2b-3fab-14f9-8af5-8b4c37afb13f@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e4aa7b2b-3fab-14f9-8af5-8b4c37afb13f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 16:49, John Garry wrote:
> On 29/09/2022 03:22, Damien Le Moal wrote:
>> On 9/28/22 21:27, John Garry wrote:
>>> The request associated with a scsi command coming from the block layer
>>> has a unique tag, so use that when possible for getting a slot.
>>>
>>> Unfortunately we don't support reserved commands in the SCSI midlayer yet.
>>> As such, SMP tasks - as an example - will not have a request associated, so
>>> in the interim continue to manage those tags for that type of sas_task
>>> internally.
>>>
>>> We reserve an arbitrary 4 tags for these internal tags. Indeed, we already
>>> decrement MVS_RSVD_SLOTS by 2 for the shost can_queue when flag
>>> MVF_FLAG_SOC is set. This change was made in commit 20b09c2992fef
>>> ("[PATCH] [SCSI] mvsas: add support for 94xx; layout change; bug fixes"),
>>> but what those 2 slots are used for is not obvious.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/scsi/mvsas/mv_defs.h |  1 +
>>>   drivers/scsi/mvsas/mv_init.c |  4 ++--
>>>   drivers/scsi/mvsas/mv_sas.c  | 22 +++++++++++++++++-----
>>>   drivers/scsi/mvsas/mv_sas.h  |  1 -
>>>   4 files changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
>>> index 7123a2efbf58..8ef174cd4d37 100644
>>> --- a/drivers/scsi/mvsas/mv_defs.h
>>> +++ b/drivers/scsi/mvsas/mv_defs.h
>>> @@ -40,6 +40,7 @@ enum driver_configuration {
>>>   	MVS_ATA_CMD_SZ		= 96,	/* SATA command table buffer size */
>>>   	MVS_OAF_SZ		= 64,	/* Open address frame buffer size */
>>>   	MVS_QUEUE_SIZE		= 64,	/* Support Queue depth */
>>> +	MVS_RSVD_SLOTS		= 4,
>>>   	MVS_SOC_CAN_QUEUE	= MVS_SOC_SLOTS - 2,
>>>   };
>>>   
>>> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
>>> index c85fb812ad43..d834ed9e8e4a 100644
>>> --- a/drivers/scsi/mvsas/mv_init.c
>>> +++ b/drivers/scsi/mvsas/mv_init.c
>>> @@ -284,7 +284,7 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>>>   			printk(KERN_DEBUG "failed to create dma pool %s.\n", pool_name);
>>>   			goto err_out;
>>>   	}
>>> -	mvi->tags_num = slot_nr;
>>> +	mvi->tags_num = MVS_RSVD_SLOTS;
>>
>> Same comment as for pm8001: do you really need this field if the value
>> is always MVS_RSVD_SLOTS ?
> 
> Right, I don't need this struct member. Again I can just use this macro 
> directly.
> 
>>
>>>   
>>>   	return 0;
>>>   err_out:
>>> @@ -367,7 +367,7 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
>>>   	mvi->sas = sha;
>>>   	mvi->shost = shost;
>>>   
>>> -	mvi->tags = kzalloc(MVS_CHIP_SLOT_SZ>>3, GFP_KERNEL);
>>> +	mvi->tags = kzalloc(MVS_RSVD_SLOTS, GFP_KERNEL);
>>
>> Field name ? reserved_tags ?
>> Also, the alloc seems wrong. This will allocate 4 bytes, but you only
>> need 4 bits. You could make this an unsigned long and not allocate
>> anything. 
> 
> Well spotted. I should have questioned more why they had >>3 previously.
> 
> But I would rather keep as a bitmap, i.e. *unsigned long for simplicity.>
>> Same remark for pm8001 by the way.
> 
> I think it's ok as it uses bitmap_zalloc()

Yes !

> 
>>
>> That would cap MVS_RSVD_SLOTS to BITS_PER_LONG maximum, but that is easy
>> to check at compile time with a #if/#error.
>>
> 
> As above, I'd rather keep as a bitmap. It's a little inefficient, but is 
> a one off in the driver.
> 
> Thanks,
> John
> 
> 

-- 
Damien Le Moal
Western Digital Research

