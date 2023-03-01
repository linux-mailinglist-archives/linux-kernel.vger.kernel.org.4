Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1D6A6804
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCAHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCAHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:12:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BC39292;
        Tue, 28 Feb 2023 23:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D409B80E05;
        Wed,  1 Mar 2023 07:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE9C433D2;
        Wed,  1 Mar 2023 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677654757;
        bh=dc+qbsouFRSJQdCe0kqILs/W2bbgcHad39FmSk9VmIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jqzi5xmM51AYcw2nWxsyhtHT/Cbg9aG+N2JYc2NuX2Wyl1iCPzKHDRz0hrZxXOwr7
         L6l7zCOB/G3JSGyvzwNDqeX+IbvMxbcbY1z50yBoD01/+Jd8hu9xY+DRVO87HHJgm/
         4EOUJXXOWkL7shTmDjzTaxgbl3lzXVEPfz2jhx7/1e4O3R/EEw6OIOnZFkeDhxL17c
         i9nvj4vBqat+AKBPj67C8iSJdt91J3XlPS7lWYB5STugkvRgNhM3U0sDi55QDnJS/s
         yc0xNl+C64BmghRSzonKx9gU2g4A7Ug2cQjGYUI2B+eyfL0z8UVSYP/aZs1QXI6f0v
         yD55hYTrnYvjg==
Date:   Wed, 1 Mar 2023 12:42:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
Subject: Re: [PATCH v3 2/6] scsi: ufs: core: Rename symbols
Message-ID: <20230301071228.GB5409@thinkpad>
References: <20230223152757.13606-1-powen.kao@mediatek.com>
 <20230223152757.13606-3-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223152757.13606-3-powen.kao@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject could mention the actual function that is being renamed:
sizeof_utp_transfer_cmd_desc

On Thu, Feb 23, 2023 at 11:27:52PM +0800, Po-Wen Kao wrote:
> To avoid confusion, sizeof_utp_transfer_cmd_desc() is renamed to
> ufshcd_get_ucd_size().
> 

How about:

"Naming the functions after standard operators like sizeof may cause
confusion. So let's rename it to ufshcd_get_ucd_size()."

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Reviewed-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c | 2 +-
>  drivers/ufs/core/ufshcd.c  | 8 ++++----
>  include/ufs/ufshcd.h       | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 3a27fa4b0024..a39746b2a8be 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>  	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
>  		hba->ucdl_dma_addr;
>  
> -	return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
> +	return div_u64(addr, ufshcd_get_ucd_size(hba));
>  }
>  
>  static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78d3b10..81c9f07ebfc8 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2823,10 +2823,10 @@ static void ufshcd_map_queues(struct Scsi_Host *shost)
>  static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
>  {
>  	struct utp_transfer_cmd_desc *cmd_descp = (void *)hba->ucdl_base_addr +
> -		i * sizeof_utp_transfer_cmd_desc(hba);
> +		i * ufshcd_get_ucd_size(hba);
>  	struct utp_transfer_req_desc *utrdlp = hba->utrdl_base_addr;
>  	dma_addr_t cmd_desc_element_addr = hba->ucdl_dma_addr +
> -		i * sizeof_utp_transfer_cmd_desc(hba);
> +		i * ufshcd_get_ucd_size(hba);
>  	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
>  				       response_upiu);
>  	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
> @@ -3735,7 +3735,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  	size_t utmrdl_size, utrdl_size, ucdl_size;
>  
>  	/* Allocate memory for UTP command descriptors */
> -	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * hba->nutrs;
> +	ucdl_size = ufshcd_get_ucd_size(hba) * hba->nutrs;
>  	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
>  						  ucdl_size,
>  						  &hba->ucdl_dma_addr,
> @@ -3835,7 +3835,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
>  	prdt_offset =
>  		offsetof(struct utp_transfer_cmd_desc, prd_table);
>  
> -	cmd_desc_size = sizeof_utp_transfer_cmd_desc(hba);
> +	cmd_desc_size = ufshcd_get_ucd_size(hba);
>  	cmd_desc_dma_addr = hba->ucdl_dma_addr;
>  
>  	for (i = 0; i < hba->nutrs; i++) {
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index ed9e3d5addb3..8f79cca449e1 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1136,7 +1136,7 @@ static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
>  	({ (void)(hba); BUILD_BUG_ON(sg_entry_size != sizeof(struct ufshcd_sg_entry)); })
>  #endif
>  
> -static inline size_t sizeof_utp_transfer_cmd_desc(const struct ufs_hba *hba)
> +static inline size_t ufshcd_get_ucd_size(const struct ufs_hba *hba)
>  {
>  	return sizeof(struct utp_transfer_cmd_desc) + SG_ALL * ufshcd_sg_entry_size(hba);
>  }
> -- 
> 2.18.0
> 

-- 
மணிவண்ணன் சதாசிவம்
