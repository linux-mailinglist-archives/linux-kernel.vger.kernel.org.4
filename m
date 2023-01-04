Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85F65CC62
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 05:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbjADE3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 23:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjADE3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 23:29:39 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DAA12AAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672806577; x=1704342577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/GIX1fsparj1ywUJMI5wuRyFdxWCwM+xwwoKR6B0A4c=;
  b=bBYXblvcCQY4xMJmY5G61JGUJonGBmmxku3on1dyjml0e4MzGGnEUhn7
   8vphdNRkhFsALTT9MIjYmJkLS2i2akcN51iM6UqDz64bNOYyuZvMN8PHG
   Ud4ntQZPLl9DsDQsUpAUNhzBQTYNTTb0x67PAtVe1TT8fAHNgVb293BtX
   cNyL3GR8UozoHxcE3Q/Zr44tosDGpEYiTiOerGaoprBryolfHG3yx+VKx
   5hfcFCybOdH4hBGcVNfnIKqgItWVmOuNpj8cwTOqVDZZBKMnjsihsDuTn
   hw+kk7O9plcfEEiNX5szHo8NF7ckN2agKoHwXb1MGCk7VvHoCN+eCWKIm
   w==;
X-IronPort-AV: E=Sophos;i="5.96,297,1665417600"; 
   d="scan'208";a="225035661"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2023 12:29:36 +0800
IronPort-SDR: dThY30BEdHeMkNfPHKq86aVKJsGzH2dLJmwG0zLWkEHm0q0folA+XNgEE9OwA97pL8Tx//giZr
 2NjZkjD3X0jkhDwjXzbbQUYPKgZdAEnysf9/2lh98TrpJ5z0buVOU2g03LhGFVusppWqm1G8SC
 rVh1ZOJnmaS3NyzCNEsJw1iJoUN+rw6XNnLwy1n1+ZLvrGHcBJ/I0sZQ3sBUZYOrA74FXICxOo
 qDsSftaCsAzgK4bsVFoWeEoRc2XJf6xEPHaISEaC8Nw4ItT3dspfsBadoXY5xxBt4eLw2A+Yqa
 4eQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2023 19:41:50 -0800
IronPort-SDR: cTo4SASXQePhxlUGBdxVDvKMvy1+FUTw1qbhDhECJmGCc+usNGlnEpyQmt7svWLuipIGdZdef1
 +r3uSxF95Jb4+JMjtmqZiho0/Omc/UJmhaZCMeixQxb56IQ81+FQQrgmy1Cf1irGkxGmQ+WpqY
 xu/YIZrLEKFJkbyfhQ3x9wytOwkSDxcFaLRIMgbsRV7L+QTnFV+LvEfvWcJhCFKR5A6kbYcHgn
 2oF9wOIXLoVqCGgixUPUyms+CTMUf4aKbBj58ZJUXO1sVwgm9icAF/YUU5Q/uw+pihpnSi6o40
 +Fg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2023 20:29:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmxTD60ptz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:29:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672806576; x=1675398577; bh=/GIX1fsparj1ywUJMI5wuRyFdxWCwM+xwwo
        KR6B0A4c=; b=LwQuzwD5rCg1yjL3ZoS5goZYaIXKbojIchx03hDQp+Dr+Y4mi00
        P0vBWsrm1Bkql0WYIbhEuM1FETronr2TyeTBXG+e6fWAcvFkzKZ4R0KwevoeAeh5
        o/YjgxaX3TXTZ7PnLAxT8IchonCaMRDHMx2CKdXNSRWMC44MY0J8gH0zlBPFEwkP
        dGxm/bKyZJJalZUhBYrcdh9rVGl0zYlSi4pQ6f+k2ePqHUZ4xH5ppzPu0AUz0g6T
        Y0NCGafkx0VVZwPEAq1Sf+FMwbCiAS3Z0/ca4jU/pJeRBiGwov3Xath6HE1IsvCh
        8Dz3oKIhXeaDDKFMfu7RauSzRGXITwukdlg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AmKR-ICHF_XN for <linux-kernel@vger.kernel.org>;
        Tue,  3 Jan 2023 20:29:36 -0800 (PST)
Received: from [10.225.163.5] (unknown [10.225.163.5])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmxTC1hdYz1RvLy;
        Tue,  3 Jan 2023 20:29:35 -0800 (PST)
Message-ID: <02d139a3-1886-dd6e-8812-dac4d292f064@opensource.wdc.com>
Date:   Wed, 4 Jan 2023 13:29:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215153749.1947570-1-haowenchao@huawei.com>
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
> ---
> v3:
> - Start with a "/*" empty line for multi-line comments.
> - Correct the commit subject
> 
> v2:
> - Check ap->ops->error_handler without taking the spin lock
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>

Ah, so your SoB is here. Wrong patch format. The changelog needs to go
right below the "---" below here and your SoB above it. You added a "---"
above, which tells git that this is the end of the commit message and so
your SoB below it is ignored. I fixed that up when applying to for-6.3,
together with Niklas suggested edits. In the future, please format your
patches correctly.

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

