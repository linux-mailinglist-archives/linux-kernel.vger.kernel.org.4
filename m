Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5C6E177C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDMWcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDMWcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:32:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86586A9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:32:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z9so14109820ejx.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681425128; x=1684017128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9L8tYYDKjHSQReGzmtMFXvGbvY7EYYVxpxKS7dXKNo=;
        b=NUMlpInTsiaZkcsWcvkcKmtfHKuAwRbbbcmBduiX7PxlzMJoxEBi6ntfBNjafwJWoM
         gFjLpY3wCQsp+inAdEZzlHrofabiy4tT0V+Anr/PbIjkKY+aJ4cTCvFFqCdmEK7m60Sh
         g6rLHBXIjMBceh7AxpYizZozyK1Rp5mNB7qm+pN17SwcHNlET8i5K3ZGr+m6JAGs3oDK
         sAqaOP6y+wtNmLzzh0OOpa+Lg7ILcHMFhqtK5NtfKRroSAFIl18IxB4XpMXpEYXw9CT3
         FHSd0RA+21dHkMzMDkzB/aMTGUxyyZ68nsOH84EmaobTGoBlQcO6+VVtpJqyQgJP/SIF
         T5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681425128; x=1684017128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9L8tYYDKjHSQReGzmtMFXvGbvY7EYYVxpxKS7dXKNo=;
        b=ahi6ocTF1oxW82ZF39TfLLVuaHxFM8GRjc3Fo9NStRpGgvsgnDOs8eq9bjjgPLaKGO
         VWfbOetDW67orEe9LWwz0gJZ+TG9/gMTgWTdUN/40J7grKhddNTkRIiRxamsAYIkdWna
         me4n2VvlbiECGRgVb75hK0/goiev4eQV63SG22+WPxKxbmE0mdUMFnzwjLPyHdyL47UH
         mQStGVrSHI7S98pHm8rh0kcpdcUuUf7CbM5+ezLzQkpt466jz2wrapel5iYiC/R4Othm
         BuXRlRapEti68WY7m7r50W6VBTfBeJpDjApBu/sO56iZCTblprLWCtyoPwnhdNZdRe3x
         e/vw==
X-Gm-Message-State: AAQBX9fsFajpOwl0pyPiTCdOcrWkpUiGhlg4X0w1TkZ2iLED4+WmON1g
        v7NiEW5OvJaOgf32HJPja4eqEA==
X-Google-Smtp-Source: AKy350Yy95MU6ymMXBfdoUzvXczL7NB3u1Ku2n1nJfzBRl7LG4KzH69EMBs/RB5ypqmLO3ckzmGIOg==
X-Received: by 2002:a17:906:6855:b0:930:6e31:3c11 with SMTP id a21-20020a170906685500b009306e313c11mr4393262ejs.70.1681425128140;
        Thu, 13 Apr 2023 15:32:08 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f17-20020a170906495100b009334219656dsm1567607ejt.56.2023.04.13.15.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 15:32:07 -0700 (PDT)
Message-ID: <e74fb30d-4268-86b1-cdf7-ad3d104c6c40@linaro.org>
Date:   Thu, 13 Apr 2023 23:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/6] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-3-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1679491817-2498-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2023 13:30, Mukesh Ojha wrote:
> Move minidump specific data types and macros to a separate internal
> header(qcom_minidump.h) so that it can be shared among different

minidump.h should be good as we are already in include/soc/qcom/

--srini

> Qualcomm drivers.
> 
> There is no change in functional behavior after this.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/remoteproc/qcom_common.c | 56 +---------------------------------
>   include/soc/qcom/qcom_minidump.h | 66 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+), 55 deletions(-)
>   create mode 100644 include/soc/qcom/qcom_minidump.h
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 805e525..88fc984 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -18,6 +18,7 @@
>   #include <linux/slab.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   #include <linux/soc/qcom/smem.h>
> +#include <soc/qcom/qcom_minidump.h>
>   
>   #include "remoteproc_internal.h"
>   #include "qcom_common.h"
> @@ -26,61 +27,6 @@
>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>   
> -#define MAX_NUM_OF_SS           10
> -#define MAX_REGION_NAME_LENGTH  16
> -#define SBL_MINIDUMP_SMEM_ID	602
> -#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> -#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> -#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> -
> -/**
> - * struct minidump_region - Minidump region
> - * @name		: Name of the region to be dumped
> - * @seq_num:		: Use to differentiate regions with same name.
> - * @valid		: This entry to be dumped (if set to 1)
> - * @address		: Physical address of region to be dumped
> - * @size		: Size of the region
> - */
> -struct minidump_region {
> -	char	name[MAX_REGION_NAME_LENGTH];
> -	__le32	seq_num;
> -	__le32	valid;
> -	__le64	address;
> -	__le64	size;
> -};
> -
> -/**
> - * struct minidump_subsystem - Subsystem's SMEM Table of content
> - * @status : Subsystem toc init status
> - * @enabled : if set to 1, this region would be copied during coredump
> - * @encryption_status: Encryption status for this subsystem
> - * @encryption_required : Decides to encrypt the subsystem regions or not
> - * @region_count : Number of regions added in this subsystem toc
> - * @regions_baseptr : regions base pointer of the subsystem
> - */
> -struct minidump_subsystem {
> -	__le32	status;
> -	__le32	enabled;
> -	__le32	encryption_status;
> -	__le32	encryption_required;
> -	__le32	region_count;
> -	__le64	regions_baseptr;
> -};
> -
> -/**
> - * struct minidump_global_toc - Global Table of Content
> - * @status : Global Minidump init status
> - * @md_revision : Minidump revision
> - * @enabled : Minidump enable status
> - * @subsystems : Array of subsystems toc
> - */
> -struct minidump_global_toc {
> -	__le32				status;
> -	__le32				md_revision;
> -	__le32				enabled;
> -	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
> -};
> -
>   struct qcom_ssr_subsystem {
>   	const char *name;
>   	struct srcu_notifier_head notifier_list;
> diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
> new file mode 100644
> index 0000000..84c8605
> --- /dev/null
> +++ b/include/soc/qcom/qcom_minidump.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Qualcomm minidump shared data structures and macros
> + *
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _QCOM_MINIDUMP_H_
> +#define _QCOM_MINIDUMP_H_
> +
> +#define MAX_NUM_OF_SS           10
> +#define MAX_REGION_NAME_LENGTH  16
> +#define SBL_MINIDUMP_SMEM_ID	602
> +#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> +#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> +#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> +
> +/**
> + * struct minidump_region - Minidump region
> + * @name		: Name of the region to be dumped
> + * @seq_num:		: Use to differentiate regions with same name.
> + * @valid		: This entry to be dumped (if set to 1)
> + * @address		: Physical address of region to be dumped
> + * @size		: Size of the region
> + */
> +struct minidump_region {
> +	char	name[MAX_REGION_NAME_LENGTH];
> +	__le32	seq_num;
> +	__le32	valid;
> +	__le64	address;
> +	__le64	size;
> +};
> +
> +/**
> + * struct minidump_subsystem - Subsystem's SMEM Table of content
> + * @status : Subsystem toc init status
> + * @enabled : if set to 1, this region would be copied during coredump
> + * @encryption_status: Encryption status for this subsystem
> + * @encryption_required : Decides to encrypt the subsystem regions or not
> + * @region_count : Number of regions added in this subsystem toc
> + * @regions_baseptr : regions base pointer of the subsystem
> + */
> +struct minidump_subsystem {
> +	__le32	status;
> +	__le32	enabled;
> +	__le32	encryption_status;
> +	__le32	encryption_required;
> +	__le32	region_count;
> +	__le64	regions_baseptr;
> +};
> +
> +/**
> + * struct minidump_global_toc - Global Table of Content
> + * @status : Global Minidump init status
> + * @md_revision : Minidump revision
> + * @enabled : Minidump enable status
> + * @subsystems : Array of subsystems toc
> + */
> +struct minidump_global_toc {
> +	__le32				status;
> +	__le32				md_revision;
> +	__le32				enabled;
> +	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
> +};
> +
> +#endif  /* _QCOM_MINIDUMP_H_ */
