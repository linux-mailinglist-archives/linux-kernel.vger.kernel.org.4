Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C7750B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjGLOoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjGLOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:44:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1EAE6F;
        Wed, 12 Jul 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Cl8ZlZiRFcpCnQDdALLt0daQ8db1oTNHsErrm3r9t1Y=; b=FymAXj62zEYXrd8MbUppdm1Ys7
        3YIzUyGiQIHWY0eIhzA2dcGwxuHLYBKah0/Nh5b0IYD1oIw/3pemTCJ0WKhaLC04wa9ulyBIY4wmY
        AsE+6Yj1PUb6XLwcKBnz3xJOaTZ356HEa6P/YP4F2AUv3tQHFthwVZkX97r364iMjv0eW4Ke7bpgn
        RaGAIf+EgHlxcadKyCqBS/gvZSRarktUnw3C/AwmSZeySh81oHveVyjmOqTF9D2ZzdAL5VMp5T1A2
        zT6WXNmTnTjFm6hmMkrmaueaIJoMRZqN/unWlinxejCNxVbjH/qr8qHDcWVgthzhn7JlDXw26YhXu
        Gi4R9Mxw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJb4S-000EMI-3C;
        Wed, 12 Jul 2023 14:44:01 +0000
Message-ID: <46ed999e-f6b5-3087-20a2-5505c7c9845b@infradead.org>
Date:   Wed, 12 Jul 2023 07:43:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] scsi: ufs: core: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230712075836.15375-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712075836.15375-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 00:58, Yang Li wrote:
> Use colons to separate parameter names from their specific meanings.
> silencethe warnings:
> 
> drivers/ufs/core/ufs-mcq.c:499: warning: Function parameter or member 'hba' not described in 'ufshcd_mcq_sq_cleanup'
> drivers/ufs/core/ufs-mcq.c:499: warning: Function parameter or member 'task_tag' not described in 'ufshcd_mcq_sq_cleanup'
> drivers/ufs/core/ufs-mcq.c:560: warning: Function parameter or member 'utrd' not described in 'ufshcd_mcq_nullify_sqe'
> drivers/ufs/core/ufs-mcq.c:583: warning: Function parameter or member 'hba' not described in 'ufshcd_mcq_sqe_search'
> drivers/ufs/core/ufs-mcq.c:583: warning: Function parameter or member 'hwq' not described in 'ufshcd_mcq_sqe_search'
> drivers/ufs/core/ufs-mcq.c:583: warning: Function parameter or member 'task_tag' not described in 'ufshcd_mcq_sqe_search'
> drivers/ufs/core/ufs-mcq.c:630: warning: Function parameter or member 'cmd' not described in 'ufshcd_mcq_abort'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5850
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/ufs/core/ufs-mcq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index e8bad5e9518e..1e23ba3e2bdf 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -490,8 +490,8 @@ static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
>  /**
>   * ufshcd_mcq_sq_cleanup - Clean up submission queue resources
>   * associated with the pending command.
> - * @hba - per adapter instance.
> - * @task_tag - The command's task tag.
> + * @hba: per adapter instance.
> + * @task_tag: The command's task tag.
>   *
>   * Returns 0 for success; error code otherwise.
>   */
> @@ -554,7 +554,7 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
>   * Write the sqe's Command Type to 0xF. The host controller will not
>   * fetch any sqe with Command Type = 0xF.
>   *
> - * @utrd - UTP Transfer Request Descriptor to be nullified.
> + * @utrd: UTP Transfer Request Descriptor to be nullified.
>   */
>  static void ufshcd_mcq_nullify_sqe(struct utp_transfer_req_desc *utrd)
>  {
> @@ -571,9 +571,9 @@ static void ufshcd_mcq_nullify_sqe(struct utp_transfer_req_desc *utrd)
>   * If the command is in the submission queue and not issued to the device yet,
>   * nullify the sqe so the host controller will skip fetching the sqe.
>   *
> - * @hba - per adapter instance.
> - * @hwq - Hardware Queue to be searched.
> - * @task_tag - The command's task tag.
> + * @hba: per adapter instance.
> + * @hwq: Hardware Queue to be searched.
> + * @task_tag: The command's task tag.
>   *
>   * Returns true if the SQE containing the command is present in the SQ
>   * (not fetched by the controller); returns false if the SQE is not in the SQ.
> @@ -622,7 +622,7 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
>  
>  /**
>   * ufshcd_mcq_abort - Abort the command in MCQ.
> - * @cmd - The command to be aborted.
> + * @cmd: The command to be aborted.
>   *
>   * Returns SUCCESS or FAILED error codes
>   */

-- 
~Randy
