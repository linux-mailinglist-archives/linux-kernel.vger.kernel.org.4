Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1B63AD26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiK1P7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiK1P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:59:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671FBC03;
        Mon, 28 Nov 2022 07:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDE386121B;
        Mon, 28 Nov 2022 15:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE182C433D6;
        Mon, 28 Nov 2022 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669651183;
        bh=akfvw0+M67xtE/xGx/w3P5r/n0aHIeYw3+hWWny/y3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtKrLxI7dZtrffA9HjWj687axsAcsAwmgrTAQHbSG0ZjHGfxqRBd2UywD6dtepgyI
         +phqRHGpyJHsmpaZlJUcAGu4suUNYfZBXojoERSHkxRrR29JQeHUuAmUzJHuNIR1QO
         w6JIJFornNSCWM7aZ8ou463H/LlBAuF7F3Z6iLNsL3GIWDLLK1dDJ7FXhX/33rGJGD
         ERFWHEjEkVB5kk2Xo9WvgKuj9A0B5ECB6hil6HnzzqNIMsDpI0xO6zqcePnD29a2rZ
         FrJPlFrh7NxEtR9yz7XkmPaP4ULU3rUQbb8bsbX3XeqDQNYizHJ0oPqIEDHvHf7y6Z
         ryV/phMqL4FMQ==
Date:   Mon, 28 Nov 2022 21:29:29 +0530
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
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/16] ufs: core: mcq: Use shared tags for MCQ mode
Message-ID: <20221128155929.GI62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <0b6e722a1376e0811cb1a3b2afe23e4fbc3e5326.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b6e722a1376e0811cb1a3b2afe23e4fbc3e5326.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:23PM -0800, Asutosh Das wrote:
> Enable shared tags for MCQ. For UFS, this should
> not have a huge performance impact. It however
> simplifies the MCQ implementation and reuses most of
> the existing code in the issue and completion path.
> Also add multiple queue mapping to map_queue().
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufs-mcq.c |  2 ++
>  drivers/ufs/core/ufshcd.c  | 28 ++++++++++++++++------------
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index ebecc47..e4ddb90 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -376,6 +376,7 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
>  
>  int ufshcd_mcq_init(struct ufs_hba *hba)
>  {
> +	struct Scsi_Host *host = hba->host;
>  	struct ufs_hw_queue *hwq;
>  	int ret, i;
>  
> @@ -411,6 +412,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>  	/* Give dev_cmd_queue the minimal number of entries */
>  	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
>  
> +	host->host_tagset = 1;
>  	return 0;
>  }
>  
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 042ecf04..d61e99f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2763,24 +2763,28 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
>   */
>  static void ufshcd_map_queues(struct Scsi_Host *shost)
>  {
> -	int i;
> +	struct ufs_hba *hba = shost_priv(shost);
> +	int i, queue_offset = 0;
> +
> +	if (!is_mcq_supported(hba)) {
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = 1;
> +		hba->nr_queues[HCTX_TYPE_READ] = 0;
> +		hba->nr_queues[HCTX_TYPE_POLL] = 1;
> +		hba->nr_hw_queues = 1;
> +	}
>  
>  	for (i = 0; i < shost->nr_maps; i++) {
>  		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
>  
> -		switch (i) {
> -		case HCTX_TYPE_DEFAULT:
> -		case HCTX_TYPE_POLL:
> -			map->nr_queues = 1;
> -			break;
> -		case HCTX_TYPE_READ:
> -			map->nr_queues = 0;
> +		map->nr_queues = hba->nr_queues[i];
> +		if (!map->nr_queues)
>  			continue;
> -		default:
> -			WARN_ON_ONCE(true);
> -		}
> -		map->queue_offset = 0;
> +		map->queue_offset = queue_offset;
> +		if (i == HCTX_TYPE_POLL && !is_mcq_supported(hba))
> +			map->queue_offset = 0;
> +
>  		blk_mq_map_queues(map);
> +		queue_offset += map->nr_queues;
>  	}
>  }
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
