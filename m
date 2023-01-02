Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0364865B837
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjABXgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABXgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:36:45 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55EF224
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672702604; x=1704238604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wulzcQ+TvPmOXHbzTNAgLrZOMI8+oI1+KtOG1TSNV9g=;
  b=CBlRWC8kDry4/0ne9ls+Pjb/d3jlpwlweL/+linWUDBuQH7zC4X/mf7j
   jNm2cfmdOT6bWsGTvlX3oiE/nfuaWOw0ifZmnRXrdcWVYpWX818+6SXNH
   sQwgjB30UuLciLLuE9dRvb6As8KpQ4lYgcw4GunPQey4j3TZYuUH5o4TD
   IlYvBdLM8QQWOo15C7uL9snOUKedR+ozxCD+Or9oCqunGA52n2mD5vBG0
   keYSN3m2wD/lyQ1qYXo/qaXqrSDNqBIZNPeLL4Ku85X/b5RGLH8NRqvxR
   us7+feUoNof/XRlrjhUZAhjCPLWksvwiFySVdynbxPDv8oE4J44lHfypI
   A==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219780400"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 07:36:43 +0800
IronPort-SDR: 271LFA4SZvLHlrqov346YQDTix0vSo8N8BM7K2wcuEreLeaLYMIbWAQy4+kNw4k7X/Lk43yd2b
 6ROCu8KcHECl4pzlA8T2srD8QrlTLjbUKhujctoPFAyrt0KLYv7l37apIRIgFfPdqrE0TprIbB
 r6toIVH3Sus/mxRbgzUHRdSwctCzS10j/IBHxtpjLCPq9IhMbnr+P33pn4bRVhfDvSyAFDrkE8
 mHZeepPex0SIRLf1ttL5rqiAbJmpwZF7HIIGqw/OVOau8bwT5lheWsSAFZ8kuHxmxgFVQhCnJe
 A2E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 14:48:57 -0800
IronPort-SDR: 16rFIUeAqDTJ4A/CPugLmG8sQ29U918AhIZG7gF790yeQaghikUq+31Ssr9+KDkOdLdJ1+jxZb
 V5sxh8aVOd9gBjMTqFyWOkj2m+iRf+c2HvFKF5GisOYVBiyvYJmxP4L+cHQH03C/nGa+ukP3OP
 AFtX0ex1+04cxAxcXtTPX/6a7e44VhdxR1i6rmWpR7ATrjylrgHVGlyvdSnWgPeOPwl/W+bfL3
 1khU9aHxCET2MzMUhViBCWVCjg1ExiJ/7Iwzpjp5mvLc9VFzpnK2UDokcvCn6EyO+kP897Rsu9
 T5c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 15:36:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmC1k5gWvz1RvTr
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:36:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672702602; x=1675294603; bh=wulzcQ+TvPmOXHbzTNAgLrZOMI8+oI1+KtO
        G1TSNV9g=; b=UC/JbcjOE3kP076MKGmcHc3tF98oiTOyT8KF6P/np1tybqTdb2G
        GLILKArwWA2/tdP463ZAAtLNdV3Pu8ETmRo90YziWj/lpoLPjQsiSDWfo6hgYIGN
        ehhMl4tlC0096wCbainDCbSWUixEhZxclbW1WDhAMOlcnD8mHC/jv7VTj7Alhybg
        mwDj7mOQESr0z0C/yMVyuEpagxxQvXKYLO+Tm+uef4/9jVtze8MS/y2N+qiIHrME
        uiGICstC63YSCPG7r9o4PdOq3ACNKkrmMW6U0nCrl75c/mIIDQAgWzJlTYgCn6OJ
        QsvoM+0q+wBwEVJUjz93riWaT2VT4DAz2pg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id swPBYMFPbPlq for <linux-kernel@vger.kernel.org>;
        Mon,  2 Jan 2023 15:36:42 -0800 (PST)
Received: from [10.225.163.3] (unknown [10.225.163.3])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmC1j1r7jz1RvLy;
        Mon,  2 Jan 2023 15:36:41 -0800 (PST)
Message-ID: <3bdf330c-8930-af2b-ef95-f0c10ae75814@opensource.wdc.com>
Date:   Tue, 3 Jan 2023 08:36:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215153749.1947570-1-haowenchao@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221215153749.1947570-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/22 00:37, Wenchao Hao wrote:
> If ap->ops->error_handler is NULL just return. This patch also
> fixes some comment style issue.
> 

Missing a Signed-off-by tag... Please resend with one.

> ---
> v3:
> - Start with a "/*" empty line for multi-line comments.
> - Correct the commit subject
> 
> v2:
> - Check ap->ops->error_handler without taking the spin lock
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 101 +++++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce67c14..56820b8e953a 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -565,13 +565,19 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
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
> -	/* For new EH, all qcs are finished in one of three ways -
> +	/*
> +	 * For new EH, all qcs are finished in one of three ways -
>  	 * normal completion, error completion, and SCSI timeout.
>  	 * Both completions can race against SCSI timeout.  When normal
>  	 * completion wins, the qc never reaches EH.  When error
> @@ -584,62 +590,59 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
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
> +	/*
> +	 * This must occur under the ap->lock as we don't want
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
> +	/*
> +	 * If we have timed out qcs.  They belong to EH from
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

