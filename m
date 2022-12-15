Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828D64DA67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLOLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLOLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:33:47 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D628715
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671104004; x=1702640004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YHvfPcgbEg5SdVofoWBXfcRaaAc3DVVLJlvf2+rQYXI=;
  b=kE+FVJsrr57kNrSVxESr3rKboJS1pUZ5lSRzKIy256IoytEIpgLCQnw1
   Irr4HJeQshKW2Fy2dmSlrfhZtJXjwDcotuM9sPVK8cyyzWQR5FpyRu9Mi
   s2jvZEfAYk1yquQk+GmV1YJGi8I5lZKEPbSGVSDdUBDnGkmvRaEea/l9j
   1AXksshBlxfPN6vIN6UJmHrbbSl/t6y7WRxQWWfP1U4SM82whcxWePxpe
   dGBt+kHQPkJrhE/PiUCUqQCcrd4MYgHmxoSqE3VvqRecRdgclZS+cH7E2
   W1p+VB0AJdD99RCgkMdlhWA/KnmQz9sJxiQdH9lC4D2BxCzDyP/GH46NZ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,247,1665417600"; 
   d="scan'208";a="323083600"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2022 19:33:23 +0800
IronPort-SDR: tiKF1Y7Fw7kVXIOWBVy9+gX/jX0E3GY7fkfTECy1XdhxrgrftiXGrwuZs0b5Z/c85EaqaCBE4/
 Dnvqjfj0Ip/g6/tQFyWYD7F34Q9yNpGWSy/QNL0GdLcJnWSaqQdgrXacJWQhIFglfrmYbPWHoq
 zWBS/QCWHb/3+DhpsqsA37LfHL9mKU1YsXxnYwCa7o7VLi65bLx9l+We7sRKSOVvD9jQDMx4hj
 TnXwLUA2UXgbCw4a5uG2QurT2PGOCy5DwajB5+FGE6HGDMyYIZ29MzabZBJsrOXz3DlgGlG2Hm
 8uc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 02:45:57 -0800
IronPort-SDR: r/Gug26FZfmGKiT0B7lBajTKFfsm4fDNgNaPU9OvVOgyuDzm1rjndajhDbzJ/lxqAwZuNsWLiN
 zkCgeshrCPKJ5Djioap7TNcqkjIBDqSW2ie4hkbEdIimGw6RnrbeWdROqyGcSG3gaiJCJkHwKk
 l3+fEISJBPO0vGlxgn4FliG+5pUQgvkWpBat2kLZ6utXtYW+jWQ5wNsA0e10UphOZH2ljuM3zn
 JIScShksZf0UlXziASXyTFmW6/6n5O6VC2Rr/W3rhA0M+agfg4C9sbTcdw9oOS5ouvIazObXuu
 MNg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 03:33:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NXqqN6Vz8z1RvTp
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:33:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671104000; x=1673696001; bh=YHvfPcgbEg5SdVofoWBXfcRaaAc3DVVLJlv
        f2+rQYXI=; b=cuQFHKYoNGGowcPl4O/fsTnJpEgFSUqC7UFz9QqY5K1ryUlfXCO
        Rr+8ftrx2X7D2SBHxxAle6cPITH4iU4CN20L66rXfJDeV8766edPXpE075RHX1Lf
        VtD9HYbUcIsWaBQu/RgguFSyGRUt2e5Hq12ecK7DuLBhQMh/juYsADl1FtB5nGpx
        9kyXQI5F7NeUkrUzIEMfM3TRVntFbL8/g7w7nn/bdG1T+eDeW3BWyThq2i5Sd3ka
        Na9F7/fXNt5o7q8VTC0x9bwkkoztWRgYtZj/sbkAkUy0wYbvzjZXe9gtwByS6OHc
        WXcCCy8aMV5gQ8FKjGEaKt91onTR4k4uvqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I1Wz4oDqH54a for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 03:33:20 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NXqqM3gqVz1RvLy;
        Thu, 15 Dec 2022 03:33:19 -0800 (PST)
Message-ID: <3767474a-a87c-19d5-8dd2-4f5907d1fab5@opensource.wdc.com>
Date:   Thu, 15 Dec 2022 20:33:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215105747.1927412-1-haowenchao@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221215105747.1927412-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 19:57, Wenchao Hao wrote:
> If ap->ops->error_handler is NULL, just return.
> 
> V2:
> - Check ap->ops->error_handler without taking the spin lock

Changelog needs to go after the "---" below your SoB.

> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce67c14..c445c272e77f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -565,10 +565,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  {
>  	int i;
>  	unsigned long flags;
> +	struct scsi_cmnd *scmd, *tmp;
> +	int nr_timedout = 0;
>  
>  	/* make sure sff pio task is not running */
>  	ata_sff_flush_pio_task(ap);
>  
> +	if (!ap->ops->error_handler)
> +		return;
> +
>  	/* synchronize with host lock and sort out timeouts */
>  
>  	/* For new EH, all qcs are finished in one of three ways -
> @@ -584,62 +589,57 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  	 * timed out iff its associated qc is active and not failed.
>  	 */
>  	spin_lock_irqsave(ap->lock, flags);
> -	if (ap->ops->error_handler) {
> -		struct scsi_cmnd *scmd, *tmp;
> -		int nr_timedout = 0;
> -
> -		/* This must occur under the ap->lock as we don't want
> -		   a polled recovery to race the real interrupt handler
> -
> -		   The lost_interrupt handler checks for any completed but
> -		   non-notified command and completes much like an IRQ handler.
>  
> -		   We then fall into the error recovery code which will treat
> -		   this as if normal completion won the race */
> -
> -		if (ap->ops->lost_interrupt)
> -			ap->ops->lost_interrupt(ap);
> +	/* This must occur under the ap->lock as we don't want

While at it, please fix the comment style. Multi-line comments should
start with a "/*" empty line.

> +	 * a polled recovery to race the real interrupt handler
> +	 *
> +	 * The lost_interrupt handler checks for any completed but
> +	 * non-notified command and completes much like an IRQ handler.
> +	 *
> +	 * We then fall into the error recovery code which will treat
> +	 * this as if normal completion won the race
> +	 */
> +	if (ap->ops->lost_interrupt)
> +		ap->ops->lost_interrupt(ap);
>  
> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> -			struct ata_queued_cmd *qc;
> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> +		struct ata_queued_cmd *qc;
>  
> -			ata_qc_for_each_raw(ap, qc, i) {
> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
> -				    qc->scsicmd == scmd)
> -					break;
> -			}
> +		ata_qc_for_each_raw(ap, qc, i) {
> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> +			    qc->scsicmd == scmd)
> +				break;
> +		}
>  
> -			if (i < ATA_MAX_QUEUE) {
> -				/* the scmd has an associated qc */
> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> -					/* which hasn't failed yet, timeout */
> -					qc->err_mask |= AC_ERR_TIMEOUT;
> -					qc->flags |= ATA_QCFLAG_FAILED;
> -					nr_timedout++;
> -				}
> -			} else {
> -				/* Normal completion occurred after
> -				 * SCSI timeout but before this point.
> -				 * Successfully complete it.
> -				 */
> -				scmd->retries = scmd->allowed;
> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> +		if (i < ATA_MAX_QUEUE) {
> +			/* the scmd has an associated qc */
> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> +				/* which hasn't failed yet, timeout */
> +				qc->err_mask |= AC_ERR_TIMEOUT;
> +				qc->flags |= ATA_QCFLAG_FAILED;
> +				nr_timedout++;
>  			}
> +		} else {
> +			/* Normal completion occurred after
> +			 * SCSI timeout but before this point.
> +			 * Successfully complete it.
> +			 */
> +			scmd->retries = scmd->allowed;
> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>  		}
> +	}
>  
> -		/* If we have timed out qcs.  They belong to EH from
> -		 * this point but the state of the controller is
> -		 * unknown.  Freeze the port to make sure the IRQ
> -		 * handler doesn't diddle with those qcs.  This must
> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
> -		 */
> -		if (nr_timedout)
> -			__ata_port_freeze(ap);
> -
> +	/* If we have timed out qcs.  They belong to EH from

Same here. Fix the comment style please.

> +	 * this point but the state of the controller is
> +	 * unknown.  Freeze the port to make sure the IRQ
> +	 * handler doesn't diddle with those qcs.  This must
> +	 * be done atomically w.r.t. setting QCFLAG_FAILED.
> +	 */
> +	if (nr_timedout)
> +		__ata_port_freeze(ap);
>  
> -		/* initialize eh_tries */
> -		ap->eh_tries = ATA_EH_MAX_TRIES;
> -	}
> +	/* initialize eh_tries */
> +	ap->eh_tries = ATA_EH_MAX_TRIES;
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
>  }

-- 
Damien Le Moal
Western Digital Research

