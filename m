Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97163AE56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiK1REN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiK1RDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:03:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3361DAD;
        Mon, 28 Nov 2022 09:03:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B796128D;
        Mon, 28 Nov 2022 17:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C545FC433C1;
        Mon, 28 Nov 2022 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669654997;
        bh=CiFfZs0+c8O9f5HN9z4MkX3CAUP6bK2GCOEQqCils8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IB/khCRs7p63rz3twEWVy8a8D/39CnZRW/loaXwnHO+USq86os1zbxEJa/M9OSSNy
         gdjnEqtG+mls6FMGtieG9Cq50DXyR7YWEGlVOnCOwu5hpuZ0+6KsR0/94YN5yQKl8a
         vzrtGDNTLWSAaoRf1DYfcE433wLI5JRi2XCGypgW00l+IgoECwXTjLPOFrcO7EhgeC
         nkyuhm1V4NOGfmeiYH/CKkeMAQXF04VQIXZTjLirstvfATYQxiMfHhblDi2SRT0EwJ
         J5c5n5MaWiqvjtwKpPHDNJY3Cd/lPAl0cEuGNFdjBhkOxP9HKR/G7vZ9QdUPB79CRc
         EbGb0SfYsAAFg==
Date:   Mon, 28 Nov 2022 22:33:05 +0530
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
Subject: Re: [PATCH v5 16/16] ufs: core: mcq: Enable Multi Circular Queue
Message-ID: <20221128170305.GO62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <6a26d01d7362cc70af70a133910cf9ad55a6ec06.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a26d01d7362cc70af70a133910cf9ad55a6ec06.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:29PM -0800, Asutosh Das wrote:
> Enable MCQ in the Host Controller.
> 
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 8416d42..41005b8 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8351,6 +8351,12 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
>  
>  	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
>  	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
> +
> +	/* Select MCQ mode */
> +	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
> +		      REG_UFS_MEM_CFG);
> +	hba->mcq_enabled = true;
> +
>  	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
>  		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
>  		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
