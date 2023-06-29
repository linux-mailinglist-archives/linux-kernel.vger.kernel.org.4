Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EBB741E82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjF2Cuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjF2Cuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:50:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B1C19C;
        Wed, 28 Jun 2023 19:50:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T24SRr027932;
        Thu, 29 Jun 2023 02:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=IHjvrAZZ2vFqcGZoFB5wbCguNxEyOpwq3+w0MVzF6/c=;
 b=iZGpYfLHpxzbvPjXTusp5G/4TxEUpZhOqONYbRYYpsFYkczGSqApHKEzP1jiBa/HhcmD
 OLo/GG2YQtcDd6kLrm4koUXdcA9YDTx1rso03Hv6aqamM7ZHBguoWkhwH6hNqeQ+rC9E
 /xjfmiCcbOepSFmlvweK/76irtpIfE/+XXQMfD7pIl9aF5H9pkLnicpU81go7RjnpXi7
 /mrONZUoXNbcENJySiuNzRVWX+hHRUDf03IBOmChX+vP4HFIclDzDCDlPkgYLPxbuKIx
 Sr67eQ5gcD8+CA/Y84k+1uoCwuimqUGvSvCKK4rXa6V0paI6TsJSI8zZB5Rl8+NV/R7m Mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgextjdjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 02:49:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T2npEB016922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 02:49:51 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 19:49:44 -0700
Date:   Thu, 29 Jun 2023 08:19:40 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 07/21] soc: qcom: minidump: Add update region support
Message-ID: <b099458b-8e37-43cb-831e-fe7812d11a65@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-8-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1687955688-20809-8-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dl9a09ObcanbRwkFLT70EtpbFSz1yUaB
X-Proofpoint-GUID: dl9a09ObcanbRwkFLT70EtpbFSz1yUaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290024
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:34PM +0530, Mukesh Ojha wrote:
> Add support to update client's region physical/virtual addresses,
> which is useful for dynamic loadable modules, dynamic address
> changing clients like if we want to collect current stack
> information for each core and the current stack is changing on
> each sched_switch event, So here virtual/physical address of
> the current stack is changing. So, to cover such use cases
> add the update region support in minidump driver and the
> corresponding smem backend support.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/qcom_minidump.c          | 55 +++++++++++++++++++++++++++++++
>  drivers/soc/qcom/qcom_minidump_internal.h |  3 ++
>  drivers/soc/qcom/qcom_minidump_smem.c     | 21 ++++++++++++
>  include/soc/qcom/qcom_minidump.h          |  5 +++
>  4 files changed, 84 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
> index cfdb63cc29d6..37d6ceb4d85c 100644
> --- a/drivers/soc/qcom/qcom_minidump.c
> +++ b/drivers/soc/qcom/qcom_minidump.c
> @@ -318,6 +318,61 @@ int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
>  }
>  EXPORT_SYMBOL_GPL(qcom_minidump_region_unregister);
>  
> +/**
> + * qcom_minidump_update_region() - Update region information with new physical
> + * address and virtual address for already registered region e.g, current task
> + * stack for a core keeps on changing on each context switch, there it needs to
> + * change registered region with new updated addresses.
> + *
> + * @region: Should be already registered minidump region.
> + *
> + * Return: On success, it returns 0 and negative error value on failure.
> + */
> +int qcom_minidump_update_region(const struct qcom_minidump_region *region)
> +{
> +	struct minidump_pregion *md_pregion;
> +	struct qcom_minidump_region *tmp;
> +	struct elfhdr *ehdr;
> +	struct elf_shdr *shdr;
> +	struct elf_phdr *phdr;
> +	int idx;
> +	int ret = 0;
> +
> +	if (!qcom_minidump_valid_region(region))
> +		return -EINVAL;
> +
> +	mutex_lock(&md_lock);
> +	if (!md) {
> +		md_pregion = check_if_pending_region_exist(region);
> +		if (!md_pregion) {
> +			ret = -ENOENT;
> +			goto unlock;
> +		}
> +		tmp = &md_pregion->region;
> +		tmp->phys_addr = region->phys_addr;
> +		tmp->virt_addr = region->virt_addr;
> +		goto unlock;
> +	}
> +
> +	ret = md->ops->md_update_region(md, &idx, region);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Skip predefined shdr/phdr header entry at the start */
> +	ehdr = md->elf.ehdr;
> +	shdr = elf_shdr_entry_addr(ehdr, idx + 4);
> +	phdr = elf_phdr_entry_addr(ehdr, idx + 1);
> +
> +	shdr->sh_addr = (elf_addr_t)region->virt_addr;
> +	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
> +	phdr->p_paddr = region->phys_addr;
> +
> +unlock:
> +	mutex_unlock(&md_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_minidump_update_region);
> +

I don't see any use of this API in the series. Do you plan to add one in
the next version?

Thanks,
Pavan
