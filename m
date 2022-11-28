Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6963AD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiK1QGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiK1QGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:06:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6321F2E2;
        Mon, 28 Nov 2022 08:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 178A2B80DF3;
        Mon, 28 Nov 2022 16:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AC0C433D6;
        Mon, 28 Nov 2022 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669651558;
        bh=0kzwrOua8/HJMp1Df9x4NGZYEBlynd1J+yaXo+CFaMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDuocFiCqwrU740uRKF7Ys54IctDtI2PVaN6wkxWDOCfwuBVFak9EcF9inxoeBGPp
         pfiwsI96fmB63/p3h/fKUrkcPHgC+gd4FqSPuiyvO37DcPQFTfEZuZTpMENjqdCLIF
         z4EPbcRXN2roIfVDMWuHLexS/G6YAGfpWOYo9lPTsFdbntRGI7sCUyXCsa7gBioGUP
         OfDTlFeyBxMEdKS9gBCUvryY8jfgNKDitbwvNiGYCBHDrOBzQyx9wJkZdWO+6hu12k
         wE96I4G4R8XoIldt7JcsXsWW2KlR0xMlzTX8J99+dn04lfKJkDuwKlFvd0WkATOKvG
         iI5r7Q+lkznNQ==
Date:   Mon, 28 Nov 2022 21:35:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 11/16] ufs: core: Prepare ufshcd_send_command for mcq
Message-ID: <20221128160544.GJ62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <833a8c6578d861bccbb2ccdb158bb4c732a6f596.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <833a8c6578d861bccbb2ccdb158bb4c732a6f596.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:24PM -0800, Asutosh Das wrote:
> Add support to send commands using multiple submission
> queues in MCQ mode.
> Modify the functions that use ufshcd_send_command().
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufs-mcq.c     |  1 +
>  drivers/ufs/core/ufshcd-priv.h | 10 ++++++++++
>  drivers/ufs/core/ufshcd.c      | 36 ++++++++++++++++++++++++++----------
>  include/ufs/ufshcd.h           |  5 +++++
>  4 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index e4ddb90..7179f86 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -405,6 +405,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>  	for (i = 0; i < hba->nr_hw_queues; i++) {
>  		hwq = &hba->uhq[i];
>  		hwq->max_entries = hba->nutrs;
> +		spin_lock_init(&hwq->sq_lock);
>  	}
>  
>  	/* The very first HW queue serves device commands */
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 08963e1..5616047 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -324,4 +324,14 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
>  	return lun == UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_supported);
>  }
>  
> +static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
> +{
> +	u32 mask = q->max_entries - 1;
> +	u32 val;
> +
> +	q->sq_tail_slot = (q->sq_tail_slot + 1) & mask;
> +	val = q->sq_tail_slot * sizeof(struct utp_transfer_req_desc);
> +	writel(val, q->mcq_sq_tail);
> +}
> +
>  #endif /* _UFSHCD_PRIV_H_ */
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index d61e99f..93a9e38 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2182,9 +2182,11 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
>   * ufshcd_send_command - Send SCSI or device management commands
>   * @hba: per adapter instance
>   * @task_tag: Task tag of the command
> + * @hwq: pointer to hardware queue instance
>   */
>  static inline
> -void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
> +void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
> +			 struct ufs_hw_queue *hwq)
>  {
>  	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>  	unsigned long flags;
> @@ -2198,12 +2200,24 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>  	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>  		ufshcd_start_monitor(hba, lrbp);
>  
> -	spin_lock_irqsave(&hba->outstanding_lock, flags);
> -	if (hba->vops && hba->vops->setup_xfer_req)
> -		hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
> -	__set_bit(task_tag, &hba->outstanding_reqs);
> -	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> -	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> +	if (is_mcq_enabled(hba)) {
> +		int utrd_size = sizeof(struct utp_transfer_req_desc);
> +
> +		spin_lock(&hwq->sq_lock);
> +		memcpy(hwq->sqe_base_addr + (hwq->sq_tail_slot * utrd_size),
> +		       lrbp->utr_descriptor_ptr, utrd_size);
> +		ufshcd_inc_sq_tail(hwq);
> +		spin_unlock(&hwq->sq_lock);
> +	} else {
> +		spin_lock_irqsave(&hba->outstanding_lock, flags);
> +		if (hba->vops && hba->vops->setup_xfer_req)
> +			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
> +						  !!lrbp->cmd);
> +		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
> +		ufshcd_writel(hba, 1 << lrbp->task_tag,
> +			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
> +		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> +	}
>  }
>  
>  /**
> @@ -2822,6 +2836,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  	int tag = scsi_cmd_to_rq(cmd)->tag;
>  	struct ufshcd_lrb *lrbp;
>  	int err = 0;
> +	struct ufs_hw_queue *hwq = NULL;
>  
>  	WARN_ONCE(tag < 0 || tag >= hba->nutrs, "Invalid tag %d\n", tag);
>  
> @@ -2906,7 +2921,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  		goto out;
>  	}
>  
> -	ufshcd_send_command(hba, tag);
> +	ufshcd_send_command(hba, tag, hwq);
>  
>  out:
>  	rcu_read_unlock();
> @@ -3101,10 +3116,11 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>  		goto out;
>  
>  	hba->dev_cmd.complete = &wait;
> +	hba->dev_cmd.cqe = NULL;
>  
>  	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
>  
> -	ufshcd_send_command(hba, tag);
> +	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
>  	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
>  	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
>  				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
> @@ -6926,7 +6942,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
>  
>  	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
>  
> -	ufshcd_send_command(hba, tag);
> +	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
>  	/*
>  	 * ignore the returning value here - ufshcd_check_query_response is
>  	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 76972fc..853c525 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -222,6 +222,7 @@ struct ufs_dev_cmd {
>  	struct mutex lock;
>  	struct completion *complete;
>  	struct ufs_query query;
> +	struct cq_entry *cqe;
>  };
>  
>  /**
> @@ -1061,6 +1062,8 @@ struct ufs_hba {
>   * @cqe_dma_addr: completion queue dma address
>   * @max_entries: max number of slots in this hardware queue
>   * @id: hardware queue ID
> + * @sq_tp_slot: current slot to which SQ tail pointer is pointing
> + * @sq_lock: serialize submission queue access
>   */
>  struct ufs_hw_queue {
>  	void __iomem *mcq_sq_head;
> @@ -1074,6 +1077,8 @@ struct ufs_hw_queue {
>  	dma_addr_t cqe_dma_addr;
>  	u32 max_entries;
>  	u32 id;
> +	u32 sq_tail_slot;
> +	spinlock_t sq_lock;
>  };
>  
>  static inline bool is_mcq_enabled(struct ufs_hba *hba)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
