Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4D63AD5D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiK1QMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiK1QLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:11:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E2E62DF;
        Mon, 28 Nov 2022 08:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AF461053;
        Mon, 28 Nov 2022 16:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE9FC433D6;
        Mon, 28 Nov 2022 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669651911;
        bh=/AfMrRO3Gs++Irv+cSQmDnR4JW658Sic77CmiYl5VTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SnpeCGRT89ht/EL42vkGT98ucBHJcFrSOQ+mtt9ix1rVW7MqA/gct5mvfce25bpR/
         ZAfLBWVx2VSYAdzcUqEcCink0vxW34Rnhz0hp96cPO8B9gdSLIbYIa6y18NwuK5JLB
         Q15uiUejDU6SoIFJSp2K8aTzBim4Ke0vHpeiygOu3sE5hDWCXfJ2D1AJ/HJCnKLmvm
         YO+rhT/+w/LNdtNtXyBvyr/yMeoeYnZ6SAH7Rv8m0m7qFtU1NvLu9l+rRnRr/965i3
         R5EiErAJ2msu3wNOwVvjv6vSMx6fhymx8uFip8BkYEVnZ+h2Jy3pJVHCjVziIEhrm2
         8neFpdDvJrRdQ==
Date:   Mon, 28 Nov 2022 21:41:34 +0530
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/16] ufs: core: Prepare for completion in mcq
Message-ID: <20221128161134.GL62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <d076c0b5bfa9c34eed9038d36677853ea042bb78.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d076c0b5bfa9c34eed9038d36677853ea042bb78.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:26PM -0800, Asutosh Das wrote:
> Modify completion path APIs and add completion queue
> entry.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd-priv.h |  2 ++
>  drivers/ufs/core/ufshcd.c      | 80 ++++++++++++++++++++++++++----------------
>  2 files changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 14df7ce..6453449 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -61,6 +61,8 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
>  int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  	enum flag_idn idn, u8 index, bool *flag_res);
>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
> +void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
> +			  struct cq_entry *cqe);
>  int ufshcd_mcq_init(struct ufs_hba *hba);
>  int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
>  int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 52c0386..f16d02c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -784,12 +784,17 @@ static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
>  /**
>   * ufshcd_get_tr_ocs - Get the UTRD Overall Command Status
>   * @lrbp: pointer to local command reference block
> + * @cqe: pointer to the completion queue entry
>   *
>   * This function is used to get the OCS field from UTRD
>   * Returns the OCS field in the UTRD
>   */
> -static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp)
> +static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp,
> +				      struct cq_entry *cqe)
>  {
> +	if (cqe)
> +		return le32_to_cpu(cqe->status) & MASK_OCS;
> +
>  	return le32_to_cpu(lrbp->utr_descriptor_ptr->header.dword_2) & MASK_OCS;
>  }
>  
> @@ -3048,7 +3053,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>  		 * not trigger any race conditions.
>  		 */
>  		hba->dev_cmd.complete = NULL;
> -		err = ufshcd_get_tr_ocs(lrbp);
> +		err = ufshcd_get_tr_ocs(lrbp, hba->dev_cmd.cqe);
>  		if (!err)
>  			err = ufshcd_dev_cmd_completion(hba, lrbp);
>  	} else {
> @@ -5214,18 +5219,20 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
>   * ufshcd_transfer_rsp_status - Get overall status of the response
>   * @hba: per adapter instance
>   * @lrbp: pointer to local reference block of completed command
> + * @cqe: pointer to the completion queue entry
>   *
>   * Returns result of the command to notify SCSI midlayer
>   */
>  static inline int
> -ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
> +ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
> +			   struct cq_entry *cqe)
>  {
>  	int result = 0;
>  	int scsi_status;
>  	enum utp_ocs ocs;
>  
>  	/* overall command status of utrd */
> -	ocs = ufshcd_get_tr_ocs(lrbp);
> +	ocs = ufshcd_get_tr_ocs(lrbp, cqe);
>  
>  	if (hba->quirks & UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR) {
>  		if (be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_1) &
> @@ -5390,42 +5397,53 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
>  }
>  
>  /**
> - * __ufshcd_transfer_req_compl - handle SCSI and query command completion
> + * ufshcd_compl_one_cqe - handle a completion queue entry
>   * @hba: per adapter instance
> - * @completed_reqs: bitmask that indicates which requests to complete
> + * @task_tag: the task tag of the request to be completed
> + * @cqe: pointer to the completion queue entry
>   */
> -static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
> -					unsigned long completed_reqs)
> +void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
> +			  struct cq_entry *cqe)
>  {
>  	struct ufshcd_lrb *lrbp;
>  	struct scsi_cmnd *cmd;
> -	int index;
> -
> -	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
> -		lrbp = &hba->lrb[index];
> -		lrbp->compl_time_stamp = ktime_get();
> -		lrbp->compl_time_stamp_local_clock = local_clock();
> -		cmd = lrbp->cmd;
> -		if (cmd) {
> -			if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
> -				ufshcd_update_monitor(hba, lrbp);
> -			ufshcd_add_command_trace(hba, index, UFS_CMD_COMP);
> -			cmd->result = ufshcd_transfer_rsp_status(hba, lrbp);
> -			ufshcd_release_scsi_cmd(hba, lrbp);
> -			/* Do not touch lrbp after scsi done */
> -			scsi_done(cmd);
> -		} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
> -			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
> -			if (hba->dev_cmd.complete) {
> -				ufshcd_add_command_trace(hba, index,
> -							 UFS_DEV_COMP);
> -				complete(hba->dev_cmd.complete);
> -				ufshcd_clk_scaling_update_busy(hba);
> -			}
> +
> +	lrbp = &hba->lrb[task_tag];
> +	lrbp->compl_time_stamp = ktime_get();
> +	cmd = lrbp->cmd;
> +	if (cmd) {
> +		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
> +			ufshcd_update_monitor(hba, lrbp);
> +		ufshcd_add_command_trace(hba, task_tag, UFS_CMD_COMP);
> +		cmd->result = ufshcd_transfer_rsp_status(hba, lrbp, cqe);
> +		ufshcd_release_scsi_cmd(hba, lrbp);
> +		/* Do not touch lrbp after scsi done */
> +		scsi_done(cmd);
> +	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
> +		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
> +		if (hba->dev_cmd.complete) {
> +			hba->dev_cmd.cqe = cqe;
> +			ufshcd_add_command_trace(hba, task_tag, UFS_DEV_COMP);
> +			complete(hba->dev_cmd.complete);
> +			ufshcd_clk_scaling_update_busy(hba);
>  		}
>  	}
>  }
>  
> +/**
> + * __ufshcd_transfer_req_compl - handle SCSI and query command completion
> + * @hba: per adapter instance
> + * @completed_reqs: bitmask that indicates which requests to complete
> + */
> +static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
> +					unsigned long completed_reqs)
> +{
> +	int tag;
> +
> +	for_each_set_bit(tag, &completed_reqs, hba->nutrs)
> +		ufshcd_compl_one_cqe(hba, tag, NULL);
> +}
> +
>  /*
>   * Returns > 0 if one or more commands have been completed or 0 if no
>   * requests have been completed.
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
