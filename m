Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331805F4C17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJDWoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJDWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:44:21 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988276E2D7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664923460; x=1696459460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8B8DayQYztnQfX7cBdJ3VMLiDN0ENGwam9eFXKcYEWo=;
  b=df3FwM0piQn49lDg7Mo0/90avlbgGHZ6os2CgdzyYNWcNPkIEuUjAtQT
   ndrpk7NiJUXt2mHXGhN7ikcMqBlgk/5gp71d3fFhGBp4gBOqh979E+0f3
   ivhEkNoDGYW2um1OqaWgHxog+oGrIFIPljj326eUeIqTNrFDuIhWz7hWo
   Bh5qkInpD+jUh/WMtjZQpW0QFCXkjgYF/5NxPEJKbdeo6IOH1NCHM+xvD
   L8/Mq6ZCLrWoU5sAUB4lqso784BvZyKXyooK8xq5+EQW42/GRLVQYa15H
   5tygohC07FVjIc7Ep6uKGXtjdIXnZfK7cQrcRGYAUFy+Zlyz1F2oCAQjk
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="325094468"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 06:44:20 +0800
IronPort-SDR: BoNAPs832MzkY5+hF1099x1EMtsBZNHVJWcBLkUH4Rlzchf5QqVsPSLuFO+Fv63pdbANS+4LRd
 1GACM/nlw4xqh3PHBx+5y9JZ+PvaVQiqi9T1leDF8HuCoV/1+YYfyz8ZdN4uDXRbhaUx2H8vXd
 MIPOqxOCRD3ZwPhqty+g45UH7XExXOxLK5A++psi9Fk1lPHbiDYvah1RRISlMh14dP/lnoUpwj
 ldsxWFpXmfsHVrJ1ttQwQNfO0WlplfU0DbboEnsedJqZYkikWS47oClx0gTzyMeY7oNFS0A+NF
 Q2LAahCRx5Pm4eVVdxqIN5h2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 14:58:33 -0700
IronPort-SDR: q5Ltk5tKwr/8gWU5oOJ2KSi9HLfzplWM9UD6QuTXl8pBccG7W2ONRzKhwBt5ThHFmgDjK9eR3B
 87TtbHu6u0ebwljaOgBlpOFhSq9XzNeC+88BrgtiDh3pklg06wTwQaV43n29hL7ZC5WJxK94Kw
 UVfZtJCPHesGxuWwqjxEjT5Ic1LIZljWyVuQ0OlGccewWCCOzje33ZFPcS480DD5W6QLenANlf
 hLp7gX6Tbqtwi8b76yGgk3tXZL0qhmubZThH/33ev0SZlVn3XR4nD8Pyqf+KzvdNcBG94ytcSB
 wkk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:44:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mht6q5wQ8z1Rwrq
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:44:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664923458; x=1667515459; bh=8B8DayQYztnQfX7cBdJ3VMLiDN0ENGwam9e
        FXKcYEWo=; b=fTrsdRGdl5M0PBK/QJKEu1+fhmcjh9rVoDjyYiuFZbYcHuPF0FJ
        3SvemXC9wSXL2hgvGYMbtAb3sPZobd8kZd7CL9V55OSDvnZLgfMKBnHoi4buGpbW
        xiHgSKQULTqnlvLX7GebhrWzFaI8lSWmmXEkGxGQ5i+2aeG6sBf97++hv/wFR3Fd
        6OF/g6PGlNoQRufV4scCSNHG/IDPKIYuGLNGV/zyDFEtX0jClGCbUk/nOTKkGNN8
        2pHm4C8DRu83pBjA2ecBRNZ8kb8aEltHEwTfphykvTDt9QzulhLKVbBm3amTkDqe
        BzGWPRdZUmpUmiLXr+8wkHtBugNpmUB/GAA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GdpVtob4ZfTp for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 15:44:18 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mht6m2TR2z1RvLy;
        Tue,  4 Oct 2022 15:44:16 -0700 (PDT)
Message-ID: <1c10c66e-0b9d-4a62-15e1-f535898cad5c@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 07:44:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 5/7] scsi: pm8001: Use sas_task_find_rq() for tagging
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        ipylypiv@google.com, changyuanl@google.com, yanaijie@huawei.com
References: <1664882833-39804-1-git-send-email-john.garry@huawei.com>
 <1664882833-39804-6-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1664882833-39804-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 20:27, John Garry wrote:
> The request associated with a scsi command coming from the block layer
> has a unique tag, so use that when possible for getting a CCB.
> 
> Unfortunately we don't support reserved commands in the SCSI midlayer yet,
> so in the interim continue to manage those tags internally (along with
> tags for private commands).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

(see the end for a nit)

> ---
>  drivers/scsi/pm8001/pm8001_init.c | 12 ++++--------
>  drivers/scsi/pm8001/pm8001_sas.c  | 13 +++++++++----
>  drivers/scsi/pm8001/pm8001_sas.h  | 11 ++++++++---
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 17 +++--------------
>  4 files changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 0edc9857a8bd..abb884ddcaf9 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -196,7 +196,7 @@ static void pm8001_free(struct pm8001_hba_info *pm8001_ha)
>  	}
>  	PM8001_CHIP_DISP->chip_iounmap(pm8001_ha);
>  	flush_workqueue(pm8001_wq);
> -	bitmap_free(pm8001_ha->tags);
> +	bitmap_free(pm8001_ha->rsvd_tags);
>  	kfree(pm8001_ha);
>  }
>  
> @@ -1208,18 +1208,15 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
>  	struct Scsi_Host *shost = pm8001_ha->shost;
>  	struct device *dev = pm8001_ha->dev;
>  	u32 max_out_io, ccb_count;
> -	u32 can_queue;
>  	int i;
>  
>  	max_out_io = pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io;
>  	ccb_count = min_t(int, PM8001_MAX_CCB, max_out_io);
>  
> -	/* Update to the scsi host*/
> -	can_queue = ccb_count - PM8001_RESERVE_SLOT;
> -	shost->can_queue = can_queue;
> +	shost->can_queue = ccb_count - PM8001_RESERVE_SLOT;
>  
> -	pm8001_ha->tags = bitmap_zalloc(ccb_count, GFP_KERNEL);
> -	if (!pm8001_ha->tags)
> +	pm8001_ha->rsvd_tags = bitmap_zalloc(PM8001_RESERVE_SLOT, GFP_KERNEL);
> +	if (!pm8001_ha->rsvd_tags)
>  		goto err_out;
>  
>  	/* Memory region for ccb_info*/
> @@ -1244,7 +1241,6 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
>  		pm8001_ha->ccb_info[i].task = NULL;
>  		pm8001_ha->ccb_info[i].ccb_tag = PM8001_INVALID_TAG;
>  		pm8001_ha->ccb_info[i].device = NULL;
> -		++pm8001_ha->tags_num;
>  	}
>  
>  	return 0;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 066dfa9f4683..f46588cd5c73 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -65,9 +65,12 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
>    */
>  void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>  {
> -	void *bitmap = pm8001_ha->tags;
> +	void *bitmap = pm8001_ha->rsvd_tags;
>  	unsigned long flags;
>  
> +	if (tag >= PM8001_RESERVE_SLOT)
> +		return;
> +
>  	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
>  	__clear_bit(tag, bitmap);
>  	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
> @@ -80,18 +83,20 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>    */
>  int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
>  {
> -	void *bitmap = pm8001_ha->tags;
> +	void *bitmap = pm8001_ha->rsvd_tags;
>  	unsigned long flags;
>  	unsigned int tag;
>  
>  	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
> -	tag = find_first_zero_bit(bitmap, pm8001_ha->tags_num);
> -	if (tag >= pm8001_ha->tags_num) {
> +	tag = find_first_zero_bit(bitmap, PM8001_RESERVE_SLOT);
> +	if (tag >= PM8001_RESERVE_SLOT) {
>  		spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>  		return -SAS_QUEUE_FULL;
>  	}
>  	__set_bit(tag, bitmap);
>  	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
> +
> +	/* reserved tags are in the lower region of the tagset */
>  	*tag_out = tag;
>  	return 0;
>  }
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 9acaadf02150..b584e68664d8 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -510,8 +510,7 @@ struct pm8001_hba_info {
>  	u32			chip_id;
>  	const struct pm8001_chip_info	*chip;
>  	struct completion	*nvmd_completion;
> -	int			tags_num;
> -	unsigned long		*tags;
> +	unsigned long		*rsvd_tags;
>  	struct pm8001_phy	phy[PM8001_MAX_PHYS];
>  	struct pm8001_port	port[PM8001_MAX_PHYS];
>  	u32			id;
> @@ -737,9 +736,15 @@ pm8001_ccb_alloc(struct pm8001_hba_info *pm8001_ha,
>  		 struct pm8001_device *dev, struct sas_task *task)
>  {
>  	struct pm8001_ccb_info *ccb;
> +	struct request *rq = NULL;
>  	u32 tag;
>  
> -	if (pm8001_tag_alloc(pm8001_ha, &tag)) {
> +	if (task)
> +		rq = sas_task_find_rq(task);
> +
> +	if (rq) {
> +		tag = rq->tag + PM8001_RESERVE_SLOT;
> +	} else if (pm8001_tag_alloc(pm8001_ha, &tag)) {
>  		pm8001_dbg(pm8001_ha, FAIL, "Failed to allocate a tag\n");
>  		return NULL;
>  	}
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 4484c498bcb6..ed2d65d3749a 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4247,24 +4247,13 @@ static int check_enc_sat_cmd(struct sas_task *task)
>  
>  static u32 pm80xx_chip_get_q_index(struct sas_task *task)
>  {
> -	struct scsi_cmnd *scmd = NULL;
> +	struct request *rq = sas_task_find_rq(task);
>  	u32 blk_tag;
>  
> -	if (task->uldd_task) {
> -		struct ata_queued_cmd *qc;
> -
> -		if (dev_is_sata(task->dev)) {
> -			qc = task->uldd_task;
> -			scmd = qc->scsicmd;
> -		} else {
> -			scmd = task->uldd_task;
> -		}
> -	}
> -
> -	if (!scmd)
> +	if (!rq)
>  		return 0;
>  
> -	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
> +	blk_tag = blk_mq_unique_tag(rq);
>  	return blk_mq_unique_tag_to_hwq(blk_tag);

Nit: You could simplify:

	return blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(rq));

No need for blk_tag variable I think.

>  }
>  

-- 
Damien Le Moal
Western Digital Research

