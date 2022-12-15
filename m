Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBFB64DA75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiLOLfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiLOLeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:34:25 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3072B247
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671104053; x=1702640053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vG2CZTetzJqodNdGSRFaORhay86YlyQQZ/e8Z731P40=;
  b=n4YIONsLnfQLA3fFSHA8+/Fbno6TWE34OiN/1evprWFU0XmZDPkX2xGY
   hSRr3mi1mwv3WSKgSVs7CjbtO+fpKWsr5HD815GXvl43i86cY6qRyePGG
   xJqesNcQmnZSX6nmwXSfbwjdyUjPEXkCJGuD9aKQriVdu5fBoGKUUNPX4
   /UZXlYYo+btn0FyTnsKxB2XpI6CNCNyLO5SI8lSEzAQ3iL8y3JwByB6cg
   Z6XeeHtCo4wXbFoB7xthBTmM0R3IHn2qr0kuqGbKxbNku/kaD8pCLhBMa
   TWAvFbF0Hkjc+58535GkV5gVa06CM+v+hFm13ojFqPCvcoSdi8PonjeCw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,247,1665417600"; 
   d="scan'208";a="218718099"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2022 19:34:12 +0800
IronPort-SDR: GsGU8td6rsDgQNg+lUwNxj3Tg9eURHJc4+MUhsh08q1Ze7KKFobe9O6+m8NlDNThDUUxtoKouG
 POVpZ4Be3kHGxdyiHReetQt5JgF2zXsYe2uyfa+qX/VhXjuoKxPf6ELUL6/2SaAUMiF8fr7N7W
 4bVFhF/Yszc4RPpHXxGQ01FoGd5lHj4OSTFUk6zkugQ7KA8MpJJxVZCHtCvr3r9sv/PAMIdpEF
 ShcxmjYCV2iQPwejpI3UoA2kbzquQlUyIutWa97Ulc352OSXeYA1cUbb5tkCUuzizx6yF+U4mf
 C6k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 02:52:33 -0800
IronPort-SDR: ZCNjqxJSGblhtf9bqvVuPah0tDWUAg13IF7iIc1k4twCVl4Tq1GCZS5qTzlA+vRmUKbqLKAIeB
 cGAD32FX6gUG8CmFfwTlat8xIgF9XCJWvsZ4ANzppIqZX2aqt72BN+uRKt5oC8ap1mJQxMi+PH
 wPrJa1/bsYPK2XmSN5/ftZh6XaS0Lw3SRQpqeHd0Fuf9HxlPMfZ8zNqB2G2+r8GpGhfpwsQPet
 TR0wVke1lyNKjKqL8BOuSab0VERMrzCzq0u06pa0FyCdHIbn6yYPoYJLAMlf4zdh9cnJb2Pbwf
 qHM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 03:34:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NXqrM5jjHz1Rwt8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:34:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671104051; x=1673696052; bh=vG2CZTetzJqodNdGSRFaORhay86YlyQQZ/e
        8Z731P40=; b=SUCqnBoSyxXzwrObu+NiwLDm6z+8/tKRSnzbAu+pfd+2BgbgtS+
        iuHG9lSZ+MZsSLIfc0Vz4g+rSaeJU+ad91HCvovFAwuiSVkxD9pMOa8dSeEMuLKc
        LfsZzs8xwORcrhQ7BZtgibNP0nnHl/GmKkSDhD6oIl/9g7PdPN6CAvUSz5wEW6L1
        PLfKxRJqPmYcFhArMZHyRqzHw2n5iqzwXdElxWW4voeS3vrS1m/8+FK+NwCn8v3L
        YJl36XJGceWrqjqHlOt5qPZD9qy0eCYxY1cAxSU6A12c6ZQlA71B/XRKz03JhFwc
        q2VEqpqk/F3Pjq84yXMoOGMul7E63YeC5Gw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ddpugOgHxSJ for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 03:34:11 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NXqrL0z9vz1RvLy;
        Thu, 15 Dec 2022 03:34:10 -0800 (PST)
Message-ID: <d991d4fd-3b5f-f0ef-5c96-2352a08e1262@opensource.wdc.com>
Date:   Thu, 15 Dec 2022 20:34:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215105747.1927412-1-haowenchao@huawei.com>
 <f552f2ab-895a-14dd-d391-a7b1c9930c88@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f552f2ab-895a-14dd-d391-a7b1c9930c88@gmail.com>
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

On 12/15/22 20:30, Sergei Shtylyov wrote:
> Hello!
> 
>   The subject should really look like "ata: libata-eh: Cleanup
> ata_scsi_cmd_error_handler()"...
> 
> On 12/15/22 1:57 PM, Wenchao Hao wrote:
> 
>> If ap->ops->error_handler is NULL, just return.
>>
>> V2:
>> - Check ap->ops->error_handler without taking the spin lock
> 
>    This normally belongs under ---...

I should read all emails before replying. I commented exactly the same :)

> 
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>>  1 file changed, 48 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 34303ce67c14..c445c272e77f 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
> [...]
>> @@ -584,62 +589,57 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>  	 * timed out iff its associated qc is active and not failed.
>>  	 */
>>  	spin_lock_irqsave(ap->lock, flags);
>> -	if (ap->ops->error_handler) {
>> -		struct scsi_cmnd *scmd, *tmp;
>> -		int nr_timedout = 0;
>> -
>> -		/* This must occur under the ap->lock as we don't want
>> -		   a polled recovery to race the real interrupt handler
>> -
>> -		   The lost_interrupt handler checks for any completed but
>> -		   non-notified command and completes much like an IRQ handler.
>>  
>> -		   We then fall into the error recovery code which will treat
>> -		   this as if normal completion won the race */
>> -
>> -		if (ap->ops->lost_interrupt)
>> -			ap->ops->lost_interrupt(ap);
>> +	/* This must occur under the ap->lock as we don't want
> 
>    The multi-line comments should start with /* on its own line...
> 
>> +	 * a polled recovery to race the real interrupt handler
>> +	 *
>> +	 * The lost_interrupt handler checks for any completed but
>> +	 * non-notified command and completes much like an IRQ handler.
>> +	 *
>> +	 * We then fall into the error recovery code which will treat
>> +	 * this as if normal completion won the race
>> +	 */
>> +	if (ap->ops->lost_interrupt)
>> +		ap->ops->lost_interrupt(ap);
>>  
>> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>> -			struct ata_queued_cmd *qc;
>> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>> +		struct ata_queued_cmd *qc;
>>  
>> -			ata_qc_for_each_raw(ap, qc, i) {
>> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> -				    qc->scsicmd == scmd)
>> -					break;
>> -			}
>> +		ata_qc_for_each_raw(ap, qc, i) {
>> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> +			    qc->scsicmd == scmd)
>> +				break;
>> +		}
>>  
>> -			if (i < ATA_MAX_QUEUE) {
>> -				/* the scmd has an associated qc */
>> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>> -					/* which hasn't failed yet, timeout */
>> -					qc->err_mask |= AC_ERR_TIMEOUT;
>> -					qc->flags |= ATA_QCFLAG_FAILED;
>> -					nr_timedout++;
>> -				}
>> -			} else {
>> -				/* Normal completion occurred after
>> -				 * SCSI timeout but before this point.
>> -				 * Successfully complete it.
>> -				 */
>> -				scmd->retries = scmd->allowed;
>> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>> +		if (i < ATA_MAX_QUEUE) {
>> +			/* the scmd has an associated qc */
>> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>> +				/* which hasn't failed yet, timeout */
>> +				qc->err_mask |= AC_ERR_TIMEOUT;
>> +				qc->flags |= ATA_QCFLAG_FAILED;
>> +				nr_timedout++;
>>  			}
>> +		} else {
>> +			/* Normal completion occurred after
> 
>    Here as well...
> 
>> +			 * SCSI timeout but before this point.
>> +			 * Successfully complete it.
>> +			 */
>> +			scmd->retries = scmd->allowed;
>> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>>  		}
>> +	}
>>  
>> -		/* If we have timed out qcs.  They belong to EH from
>> -		 * this point but the state of the controller is
>> -		 * unknown.  Freeze the port to make sure the IRQ
>> -		 * handler doesn't diddle with those qcs.  This must
>> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
>> -		 */
>> -		if (nr_timedout)
>> -			__ata_port_freeze(ap);
>> -
>> +	/* If we have timed out qcs.  They belong to EH from
> 
>    And here...
> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

