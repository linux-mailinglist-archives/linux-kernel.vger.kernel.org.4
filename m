Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563265B84D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiINJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiINJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:18:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE94792FC;
        Wed, 14 Sep 2022 02:08:56 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8VNGu001667;
        Wed, 14 Sep 2022 09:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6kFVICJ6jtew+3rXDnaR4PptRyZuceTadVnuNa0iKHA=;
 b=BTL4oP5NvIADiQ1ivZ3ezjIUGfhUotu3xzPc450+vkR+1JcE9dkIRozqbInMhCuPFQ4K
 mqfGGZxTJh2ISvv2lrD/sf7WpInxYdsCcEpSNyYSiyv1uaA+R/QAooEsNxL0PHrXrtCu
 zgS9E5/tElD8Mn/dTD9iEd09TIOul/sua3iRX2kh2XgTSZBJWTliRydErbH1+vu8+q1z
 qpYBPUC7bfp5cOz2+TpOhRDjYrdwSs9mYAsT4lgF9ur2/ED3kVbB8G/1XHrAeh+N4kUb
 s6TNQx8LKFzWl8MHMhJF1AeUHOEZHMbGfzINjdXMTL92MZP2dTMidAvfTOOJ+BytkkPn GA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0c9pua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:06:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E96ig6020032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:06:44 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:06:39 -0700
Subject: Re: [PATCH v6 2/8] remoteproc: qcom: Add flag in adsp private data
 structure
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-3-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <9a483cbc-f90a-65c8-5edf-95fa9016ce6b@quicinc.com>
Date:   Wed, 14 Sep 2022 14:36:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L5iTt_yBFld5wBfQbdRVnxufNqTspuly
X-Proofpoint-GUID: L5iTt_yBFld5wBfQbdRVnxufNqTspuly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140044
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 6:53 PM, Srinivasa Rao Mandadapu wrote:
> Add flag in qcom_adsp private data structure and initialize
> it to distinguish ADSP and WPSS modules for using iommu selectively.

There are other flags available to distinguish between ADSP and WPSS
like 'is_wpss'. So you probably want to tweak your commit message to
just say if it has a iommu in front of it or not and skip referencing
WPSS.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes since V5:
> 	-- Rename adsp_sandbox_needed to has_iommu.
> Changes since V3:
> 	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
> Changes since V2:
> 	-- Add is_adsp_sb_needed flag instead of is_wpss.
> 
>   drivers/remoteproc/qcom_q6v5_adsp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 2f3b9f5..fa2ccac 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -62,6 +62,7 @@ struct adsp_pil_data {
>   	const char *sysmon_name;
>   	int ssctl_id;
>   	bool is_wpss;
> +	bool has_iommu;
>   	bool auto_boot;
>   
>   	const char **clk_ids;
> @@ -99,6 +100,7 @@ struct qcom_adsp {
>   	phys_addr_t mem_reloc;
>   	void *mem_region;
>   	size_t mem_size;
> +	bool has_iommu;
>   
>   	struct device *proxy_pds[QCOM_Q6V5_RPROC_PROXY_PD_MAX];
>   	size_t proxy_pd_count;
> @@ -596,12 +598,15 @@ static int adsp_probe(struct platform_device *pdev)
>   	}
>   
>   	rproc->auto_boot = desc->auto_boot;
> +	rproc->has_iommu = desc->has_iommu;
>   	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>   
>   	adsp = (struct qcom_adsp *)rproc->priv;
>   	adsp->dev = &pdev->dev;
>   	adsp->rproc = rproc;
>   	adsp->info_name = desc->sysmon_name;
> +	adsp->has_iommu = desc->has_iommu;
> +
>   	platform_set_drvdata(pdev, adsp);
>   
>   	if (desc->is_wpss)
> 
