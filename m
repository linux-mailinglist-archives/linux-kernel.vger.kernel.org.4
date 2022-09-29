Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC45EEBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiI2CXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI2CWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:22:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71AA9C31
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664418171; x=1695954171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pt2aH54v9i+iacS/08TVfDzHKkj6DRdkLDfQI/R0fGs=;
  b=car2VrMB2INwC3q6xJ1vsfQJy0bVKcpwfzzGVRuSUkLjTio2x19Kx5Bz
   vsTmzMPNIkYqC7FHxic4aWzZFLTBwh3Z1y1vLsX3DMBetZ37dvQ5EVmo/
   VZtWZ4azFHdhJwVgXFKQcorsz9nV9zOo/KPwXMZ/MR4oBUcFUCRTkwZ9T
   InW3VyGQf0/efPhPTJeUW4O/eyNZCyy04CTh/kqxsa+nwlv1Qv0xNESNh
   Re1lUT0PHxO3jtqJ+beL0Hflhkuv1/KXGhc4hGGbITwMQ+ENcyTKCScAY
   TGu3dbZd4LncfcVv4R7ImIUjLD2fhYQHjzz2krB66l5zHMPDlxM5pTiz2
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,353,1654531200"; 
   d="scan'208";a="212540876"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 10:22:51 +0800
IronPort-SDR: AdxmpHFpz9ZLshWphKDLtFUUmDVRrNhlq122xstWr8sjnEzmydci5uAavch1wcElZkwbGlJJzw
 LN5B4exUWLQZec1PtycnQChPf9QHO2JkoVjoLVcSzPjkKfQjvsF914QpKGjnImxea5/dYl+BvZ
 crgFDWm0pgzbv9vrxefsl7wA9fFDGn32bsxbi3cIdScKmJS8/mM+DkQGGla1nyif//zO1pVxsL
 PGKyJv1OnfpprALgQmYAatcQAOmaI5YoRh8kHj0A02BDEcPDP37YxLBihiHnKs1snOgBfRVeCx
 DZK0u6jt8h+MQtFLTL1aL4lv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 18:42:45 -0700
IronPort-SDR: xHLRNIIF/hK6hOuSYNvkp4YiUAXPGZQxFgTAgotHzQpo1tAOPN4tIb16OiSzVJrBCmS2So/jOM
 2aW0qTT+XEdVoMgNyULo3yQcRSmDM8xVh3STW8kXY9rhI3pOEOqthnUDqjQK8gWUNMrHppmi7D
 aSjIatJigEQXSqCg4Mf6D2IxbpFHUek63mFmGj7MRUDFmpUBU4OgPPDtTWgbYYizV9MCf0SZyx
 fKwbTztOy+zgazuFw52a3fMiTEaiRTHL+WsQSVaDiTtNWwik5sfNBITC0MGyt93WRihVOeDbp0
 8vA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 19:22:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdHFk2jm8z1Rwrq
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:22:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664418169; x=1667010170; bh=Pt2aH54v9i+iacS/08TVfDzHKkj6DRdkLDf
        QI/R0fGs=; b=UaBZKKWu/zMAKVNtwwB9h28/nsfi9yCcNOax11OZ5Xycph/agG4
        Y24Q1og9YJI4C1RINHI+OjcD8AJAsKsIZqy2cBgI2sGenkFbc51aBd039AwO3Mp7
        vx8vihAi7fE7oy0p2tn6zPGm4O3hJ5b+AYDWp+NTWAF0SA7+yg44jEIcJhhQ2q/e
        41Fxe28nzz27fYCfVGd7o7AqvuNYqxNpNRx9ngPFwu1zz3BuEosY8DORUtsNNAaQ
        sP0+Lw3+rcw4+rO165kauWeYxu6304DresoUQot8pPNoIasWykWkAvQPkXTSKjqX
        g7LLR+8lUDFJXbJ+4+NQT6oRyCZWY05yk8A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FYqPuTjyY0Wn for <linux-kernel@vger.kernel.org>;
        Wed, 28 Sep 2022 19:22:49 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdHFf6vmMz1RvLy;
        Wed, 28 Sep 2022 19:22:46 -0700 (PDT)
Message-ID: <53e304b4-c025-e884-c8f5-6c2e96cc0052@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 11:22:45 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1664368034-114991-7-git-send-email-john.garry@huawei.com>
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

On 9/28/22 21:27, John Garry wrote:
> The request associated with a scsi command coming from the block layer
> has a unique tag, so use that when possible for getting a slot.
> 
> Unfortunately we don't support reserved commands in the SCSI midlayer yet.
> As such, SMP tasks - as an example - will not have a request associated, so
> in the interim continue to manage those tags for that type of sas_task
> internally.
> 
> We reserve an arbitrary 4 tags for these internal tags. Indeed, we already
> decrement MVS_RSVD_SLOTS by 2 for the shost can_queue when flag
> MVF_FLAG_SOC is set. This change was made in commit 20b09c2992fef
> ("[PATCH] [SCSI] mvsas: add support for 94xx; layout change; bug fixes"),
> but what those 2 slots are used for is not obvious.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/mvsas/mv_defs.h |  1 +
>  drivers/scsi/mvsas/mv_init.c |  4 ++--
>  drivers/scsi/mvsas/mv_sas.c  | 22 +++++++++++++++++-----
>  drivers/scsi/mvsas/mv_sas.h  |  1 -
>  4 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
> index 7123a2efbf58..8ef174cd4d37 100644
> --- a/drivers/scsi/mvsas/mv_defs.h
> +++ b/drivers/scsi/mvsas/mv_defs.h
> @@ -40,6 +40,7 @@ enum driver_configuration {
>  	MVS_ATA_CMD_SZ		= 96,	/* SATA command table buffer size */
>  	MVS_OAF_SZ		= 64,	/* Open address frame buffer size */
>  	MVS_QUEUE_SIZE		= 64,	/* Support Queue depth */
> +	MVS_RSVD_SLOTS		= 4,
>  	MVS_SOC_CAN_QUEUE	= MVS_SOC_SLOTS - 2,
>  };
>  
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index c85fb812ad43..d834ed9e8e4a 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -284,7 +284,7 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>  			printk(KERN_DEBUG "failed to create dma pool %s.\n", pool_name);
>  			goto err_out;
>  	}
> -	mvi->tags_num = slot_nr;
> +	mvi->tags_num = MVS_RSVD_SLOTS;

Same comment as for pm8001: do you really need this field if the value
is always MVS_RSVD_SLOTS ?

>  
>  	return 0;
>  err_out:
> @@ -367,7 +367,7 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
>  	mvi->sas = sha;
>  	mvi->shost = shost;
>  
> -	mvi->tags = kzalloc(MVS_CHIP_SLOT_SZ>>3, GFP_KERNEL);
> +	mvi->tags = kzalloc(MVS_RSVD_SLOTS, GFP_KERNEL);

Field name ? reserved_tags ?
Also, the alloc seems wrong. This will allocate 4 bytes, but you only
need 4 bits. You could make this an unsigned long and not allocate
anything. Same remark for pm8001 by the way.

That would cap MVS_RSVD_SLOTS to BITS_PER_LONG maximum, but that is easy
to check at compile time with a #if/#error.


>  	if (!mvi->tags)
>  		goto err_out;
>  
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index 0810e6c930e1..549d2ec89f60 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -20,7 +20,7 @@ static int mvs_find_tag(struct mvs_info *mvi, struct sas_task *task, u32 *tag)
>  	return 0;
>  }
>  
> -void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
> +static void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
>  {
>  	void *bitmap = mvi->tags;
>  	clear_bit(tag, bitmap);
> @@ -28,6 +28,11 @@ void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
>  
>  void mvs_tag_free(struct mvs_info *mvi, u32 tag)
>  {
> +	if (tag < mvi->shost->can_queue)
> +		return;
> +
> +	tag -= mvi->shost->can_queue;
> +
>  	mvs_tag_clear(mvi, tag);
>  }
>  
> @@ -47,6 +52,7 @@ inline int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
>  	if (tag >= mvi->tags_num)
>  		return -SAS_QUEUE_FULL;
>  	mvs_tag_set(mvi, tag);
> +	tag += mvi->shost->can_queue;
>  	*tag_out = tag;
>  	return 0;
>  }
> @@ -696,6 +702,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
>  	struct mvs_task_exec_info tei;
>  	struct mvs_slot_info *slot;
>  	u32 tag = 0xdeadbeef, n_elem = 0;
> +	struct request *rq;
>  	int rc = 0;
>  
>  	if (!dev->port) {
> @@ -760,9 +767,14 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
>  		n_elem = task->num_scatter;
>  	}
>  
> -	rc = mvs_tag_alloc(mvi, &tag);
> -	if (rc)
> -		goto err_out;
> +	rq = sas_task_find_rq(task);
> +	if (rq) {
> +		tag = rq->tag;
> +	} else {
> +		rc = mvs_tag_alloc(mvi, &tag);
> +		if (rc)
> +			goto err_out;
> +	}
>  
>  	slot = &mvi->slot_info[tag];
>  
> @@ -857,7 +869,7 @@ int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  static void mvs_slot_free(struct mvs_info *mvi, u32 rx_desc)
>  {
>  	u32 slot_idx = rx_desc & RXQ_SLOT_MASK;
> -	mvs_tag_clear(mvi, slot_idx);
> +	mvs_tag_free(mvi, slot_idx);
>  }
>  
>  static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
> diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
> index fe57665bdb50..e6c70786ded9 100644
> --- a/drivers/scsi/mvsas/mv_sas.h
> +++ b/drivers/scsi/mvsas/mv_sas.h
> @@ -424,7 +424,6 @@ struct mvs_task_exec_info {
>  
>  /******************** function prototype *********************/
>  void mvs_get_sas_addr(void *buf, u32 buflen);
> -void mvs_tag_clear(struct mvs_info *mvi, u32 tag);
>  void mvs_tag_free(struct mvs_info *mvi, u32 tag);
>  void mvs_tag_set(struct mvs_info *mvi, unsigned int tag);
>  int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out);

-- 
Damien Le Moal
Western Digital Research

