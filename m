Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445B72C4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjFLMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjFLMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:49:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E6E51
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:49:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so875101f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686574152; x=1689166152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W77hc+vW/SLtEALpj6kM4e0EwWOEhnh6lTso6VOBO0k=;
        b=vXzbrrV98MN9XtCTKAz1653dVPRsjGbh1cVRwhPJg2ecgdMoMe2KmxibigbsN1WtR2
         6IAQ0Hp5nsMGAphdfMP06HjdEisW0hx/W1MWD22wX8ow/HCsu0y5msJhK+eTHypFeGYc
         C+MF99VGD504oPh/1QYrmlP3+L0OAGZ/rFqGh+DD/8jdVG1Lz0M5TcSVd1wBCGFPK5li
         QVwt90bnUoiDpqn947SvmmAncCdiO3fllcGfSADkGSuYEkLxbmphB3zF/NH4uzlTQjbk
         DRKCqXzcGY26W9hNoUBn0wDOI9RTV6pp0yiPcchFyb07kjZGGCTAKfSS33Dpa0QoQwth
         yrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574152; x=1689166152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W77hc+vW/SLtEALpj6kM4e0EwWOEhnh6lTso6VOBO0k=;
        b=LZ6Tz8VJ/z5oQopsXBqiizwnU4hMs0Pkn28i+7IJNciSEfQhZH+4mBJCtZWDye+6Ce
         VBxSEuITJ5l0OwPiQI0NPKrvRHKlCS5rUcDBdfd0pozWlpMcrhQFg19fcY26y6BZOWeX
         cmselG55hgvBlhFInltMCJDE8Au5GQ54W7SeUOZ5YvBvX6L7oW2IeuYoAoWijkOooJx1
         /ikBp8G/tCx6ugAGTZKdIyx37FyOXXOGXCGqmcvvcgsSJ/z/k7aM/Imdffq2f1O8lpZ+
         LfKqjjSMe6Rf0W8rnOuko33K+I2tJ1VCXeokIkLzfl8vu8bPztEeTcHbb4wK8NSG2eaG
         68HQ==
X-Gm-Message-State: AC+VfDztOr4wG8i86K8IQY4b+BUm25nHAnbp1O9teTcm8cMulNN06Xh8
        li+oeo8rV991ROlPX3kf7uebmoSRb7DKeGGFZAU=
X-Google-Smtp-Source: ACHHUZ6t8inJ47Ew7FRMA6iUbadvwDEvu88VCo/2rv3xQvWZzWYsO4YvB8WOG2ttcLBSv1E1n9gXzQ==
X-Received: by 2002:adf:f0c9:0:b0:307:95c9:c010 with SMTP id x9-20020adff0c9000000b0030795c9c010mr4802811wro.34.1686574151657;
        Mon, 12 Jun 2023 05:49:11 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r17-20020a5d52d1000000b002c71b4d476asm12358871wrv.106.2023.06.12.05.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:49:10 -0700 (PDT)
Message-ID: <fa2b4ed5-64b5-b05b-0eee-6f61c7ba4baa@linaro.org>
Date:   Mon, 12 Jun 2023 13:49:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] misc: fastrpc: detect privileged processes based
 on group ID
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
References: <1686138864-17136-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686138864-17136-3-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1686138864-17136-3-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,
thankyou for your email.

On 07/06/2023 12:54, Ekansh Gupta wrote:
> Get the information on privileged group IDs during rpmsg probing based
> on DT property. Check if the process requesting an offload to remote
> subsystem is privileged by comparing it's group ID with privileged

policy management should be dealt in the user-space not in the kernel.

The patch is not correct approach!

In this particular case the fastrpc library can take the right call 
based on the group id of the process along with system policy and set 
attr with correct flags while sending a invoke request.

--srini

> group ID. Initialization process attributes are updated for a
> privileged process which is sent to remote process for resource
> management.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 124 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..6c7db0b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -21,6 +21,7 @@
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <uapi/misc/fastrpc.h>
>   #include <linux/of_reserved_mem.h>
> +#include <linux/cred.h>
>   
>   #define ADSP_DOMAIN_ID (0)
>   #define MDSP_DOMAIN_ID (1)
> @@ -166,6 +167,11 @@ struct fastrpc_mem_unmap_req_msg {
>   	u64 len;
>   };
>   
> +struct gid_list {
> +	u32 *gids;
> +	u32 gidcount;
> +};
> +
>   struct fastrpc_msg {
>   	int pid;		/* process group id */
>   	int tid;		/* thread id */
> @@ -277,6 +283,7 @@ struct fastrpc_channel_ctx {
>   	struct fastrpc_device *fdevice;
>   	struct fastrpc_buf *remote_heap;
>   	struct list_head invoke_interrupted_mmaps;
> +	struct gid_list gidlist;
>   	bool secure;
>   	bool unsigned_support;
>   	u64 dma_mask;
> @@ -305,6 +312,7 @@ struct fastrpc_user {
>   	spinlock_t lock;
>   	/* lock for allocations */
>   	struct mutex mutex;
> +	struct gid_list gidlist;
>   };
>   
>   static void fastrpc_free_map(struct kref *ref)
> @@ -522,6 +530,31 @@ static void fastrpc_context_put_wq(struct work_struct *work)
>   }
>   
>   #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
> +
> +static u32 sorted_lists_intersection(u32 *listA,
> +		u32 lenA, u32 *listB, u32 lenB)
> +{
> +	u32 i = 0, j = 0;
> +
> +	while (i < lenA && j < lenB) {
> +		if (listA[i] < listB[j])
> +			i++;
> +		else if (listA[i] > listB[j])
> +			j++;
> +		else
> +			return listA[i];
> +	}
> +	return 0;
> +}
> +
> +static int uint_cmp_func(const void *p1, const void *p2)
> +{
> +	u32 a1 = *((u32 *)p1);
> +	u32 a2 = *((u32 *)p2);
> +
> +	return CMP(a1, a2);
> +}
> +
>   static int olaps_cmp(const void *a, const void *b)
>   {
>   	struct fastrpc_buf_overlap *pa = (struct fastrpc_buf_overlap *)a;
> @@ -1230,6 +1263,50 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
>   	return false;
>   }
>   
> +static int fastrpc_get_process_gids(struct gid_list *gidlist)
> +{
> +	struct group_info *group_info = get_current_groups();
> +	int i, num_gids;
> +	u32 *gids = NULL;
> +
> +	if (!group_info)
> +		return -EFAULT;
> +
> +	num_gids = group_info->ngroups + 1;
> +	gids = kcalloc(num_gids, sizeof(u32), GFP_KERNEL);
> +	if (!gids)
> +		return -ENOMEM;
> +
> +	/* Get the real GID */
> +	gids[0] = __kgid_val(current_gid());
> +
> +	/* Get the supplemental GIDs */
> +	for (i = 1; i < num_gids; i++)
> +		gids[i] = __kgid_val(group_info->gid[i - 1]);
> +
> +	sort(gids, num_gids, sizeof(*gids), uint_cmp_func, NULL);
> +	gidlist->gids = gids;
> +	gidlist->gidcount = num_gids;
> +
> +	return 0;
> +}
> +
> +static void fastrpc_check_privileged_process(struct fastrpc_user *fl,
> +				struct fastrpc_init_create *init)
> +{
> +	u32 gid = sorted_lists_intersection(fl->gidlist.gids,
> +			fl->gidlist.gidcount, fl->cctx->gidlist.gids,
> +			fl->cctx->gidlist.gidcount);
> +
> +	/* disregard any privilege bits from userspace */
> +	init->attrs &= (~FASTRPC_MODE_PRIVILEGED);
> +	if (gid) {
> +		dev_info(&fl->cctx->rpdev->dev, "%s: %s (PID %d, GID %u) is a privileged process\n",
> +				__func__, current->comm, fl->tgid, gid);
> +		init->attrs |= FASTRPC_MODE_PRIVILEGED;
> +	}
> +}
> +
>   static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   					      char __user *argp)
>   {
> @@ -1386,6 +1463,8 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>   		goto err;
>   	}
>   
> +	fastrpc_get_process_gids(&fl->gidlist);
> +
>   	inbuf.pgid = fl->tgid;
>   	inbuf.namelen = strlen(current->comm) + 1;
>   	inbuf.filelen = init.filelen;
> @@ -1400,6 +1479,8 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>   			goto err;
>   	}
>   
> +	fastrpc_check_privileged_process(fl, &init);
> +
>   	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
>   		       1024 * 1024);
>   	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
> @@ -1519,6 +1600,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	list_del(&fl->user);
>   	spin_unlock_irqrestore(&cctx->lock, flags);
> +	kfree(fl->gidlist.gids);
>   
>   	if (fl->init_mem)
>   		fastrpc_buf_free(fl->init_mem);
> @@ -2118,6 +2200,43 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>   	return err;
>   }
>   
> +static int fastrpc_init_privileged_gids(struct device *dev, char *prop_name,
> +						struct gid_list *gidlist)
> +{
> +	int err = 0;
> +	u32 len = 0, i;
> +	u32 *gids = NULL;
> +
> +	if (!of_find_property(dev->of_node, prop_name, &len))
> +		return 0;
> +	if (len == 0)
> +		return 0;
> +
> +	len /= sizeof(u32);
> +	gids = kcalloc(len, sizeof(u32), GFP_KERNEL);
> +	if (!gids)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < len; i++) {
> +		err = of_property_read_u32_index(dev->of_node, prop_name,
> +								i, &gids[i]);
> +		if (err) {
> +			dev_err(dev, "%s: failed to read GID %u\n",
> +					__func__, i);
> +			goto read_error;
> +		}
> +		dev_info(dev, "adsprpc: %s: privileged GID: %u\n", __func__, gids[i]);
> +	}
> +	sort(gids, len, sizeof(*gids), uint_cmp_func, NULL);
> +	gidlist->gids = gids;
> +	gidlist->gidcount = len;
> +
> +	return 0;
> +read_error:
> +	kfree(gids);
> +	return err;
> +}
> +
>   static const struct file_operations fastrpc_fops = {
>   	.open = fastrpc_device_open,
>   	.release = fastrpc_device_release,
> @@ -2277,6 +2396,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   	if (!data)
>   		return -ENOMEM;
>   
> +	err = fastrpc_init_privileged_gids(rdev, "qcom,fastrpc-gids", &data->gidlist);
> +	if (err)
> +		dev_err(rdev, "Privileged gids init failed.\n");
> +
>   	if (vmcount) {
>   		data->vmcount = vmcount;
>   		data->perms = BIT(QCOM_SCM_VMID_HLOS);
> @@ -2382,6 +2505,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	if (cctx->remote_heap)
>   		fastrpc_buf_free(cctx->remote_heap);
>   
> +	kfree(cctx->gidlist.gids);
>   	of_platform_depopulate(&rpdev->dev);
>   
>   	fastrpc_channel_ctx_put(cctx);
