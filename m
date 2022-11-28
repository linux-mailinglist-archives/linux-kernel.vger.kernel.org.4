Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC79463AE52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiK1RCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiK1RCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:02:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C12BEE;
        Mon, 28 Nov 2022 09:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDBFBB80DFA;
        Mon, 28 Nov 2022 17:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35659C433D6;
        Mon, 28 Nov 2022 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669654951;
        bh=88tiwV7KqMALQmXijvfYy8vAWhVtY8jbniyJXCeRsAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQec0818Gp/z3fvFabAH7r3p551c3n29W2DDeeqFiyWn2qu/azzRO3+9gO9671yn0
         e5EafAqq5eKyKJq3z7rtEKJ1X8DbSV4eQ2IYe4+aZL9NSMtD/B+utlgYay5nc8khCR
         m2vYlYPkqyGvLVehHXAMGpVlGKlEqSbgo9JQYKDFX9+RIhOazNJVxgCWWTB6Dzkt8m
         B9TbuAo0HHM0VutwH6zV3CRC4xZceDiZd1mjsNBlwZ+Z0dGPg14SlzQicqyphlESLZ
         iJW/L9zk+m6V3RMRX7qepVLxemeiW854uAxy+a6QdYojWLMWGGaFXgrwjlXFK7ypZz
         KPwdWeIv88Pig==
Date:   Mon, 28 Nov 2022 22:32:19 +0530
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 15/16] ufs: core: mcq: Add completion support in poll
Message-ID: <20221128170219.GN62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <9d638d7921db39e48de30d4913b28076fe86b6dd.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d638d7921db39e48de30d4913b28076fe86b6dd.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:28PM -0800, Asutosh Das wrote:
> Complete cqe requests in poll. Assumption is that
> several poll completion may happen in different CPUs
> for the same completion queue. Hence a spin lock
> protection is added.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 13 +++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |  2 ++
>  drivers/ufs/core/ufshcd.c      |  7 +++++++
>  include/ufs/ufshcd.h           |  2 ++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 365ad98..5311857 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -387,6 +387,18 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
>  	return completed_reqs;
>  }
>  
> +unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
> +				       struct ufs_hw_queue *hwq)
> +{
> +	unsigned long completed_reqs;
> +
> +	spin_lock(&hwq->cq_lock);
> +	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
> +	spin_unlock(&hwq->cq_lock);
> +
> +	return completed_reqs;
> +}
> +
>  void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
>  {
>  	struct ufs_hw_queue *hwq;
> @@ -483,6 +495,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>  		hwq = &hba->uhq[i];
>  		hwq->max_entries = hba->nutrs;
>  		spin_lock_init(&hwq->sq_lock);
> +		spin_lock_init(&hwq->cq_lock);
>  	}
>  
>  	/* The very first HW queue serves device commands */
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index c5b5bf3..73ce8a2 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -75,6 +75,8 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
>  					 struct ufs_hw_queue *hwq);
>  struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
>  					   struct request *req);
> +unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
> +				       struct ufs_hw_queue *hwq);
>  
>  #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
>  #define SD_ASCII_STD true
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7fb7c5f..8416d42 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5453,6 +5453,13 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
>  	struct ufs_hba *hba = shost_priv(shost);
>  	unsigned long completed_reqs, flags;
>  	u32 tr_doorbell;
> +	struct ufs_hw_queue *hwq;
> +
> +	if (is_mcq_enabled(hba)) {
> +		hwq = &hba->uhq[queue_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
> +
> +		return ufshcd_mcq_poll_cqe_lock(hba, hwq);
> +	}
>  
>  	spin_lock_irqsave(&hba->outstanding_lock, flags);
>  	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index d5fde64..a709391 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1069,6 +1069,7 @@ struct ufs_hba {
>   * @sq_lock: serialize submission queue access
>   * @cq_tail_slot: current slot to which CQ tail pointer is pointing
>   * @cq_head_slot: current slot to which CQ head pointer is pointing
> + * @cq_lock: Synchronize between multiple polling instances
>   */
>  struct ufs_hw_queue {
>  	void __iomem *mcq_sq_head;
> @@ -1086,6 +1087,7 @@ struct ufs_hw_queue {
>  	spinlock_t sq_lock;
>  	u32 cq_tail_slot;
>  	u32 cq_head_slot;
> +	spinlock_t cq_lock;
>  };
>  
>  static inline bool is_mcq_enabled(struct ufs_hba *hba)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
