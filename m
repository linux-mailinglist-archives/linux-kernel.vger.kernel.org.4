Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1C5B8504
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiINJcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiINJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:32:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A8786E5;
        Wed, 14 Sep 2022 02:23:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E4eaCi031819;
        Wed, 14 Sep 2022 09:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=khRktGo8KDIaoO0/9D+gloBG8TjQU8wXhHec6gF9UIU=;
 b=PVNSDKKwSaBPbhgSxR4taoTkwDl6REPO5VG7Ju8DUpjt6fYyMXmLOuEAhgeu1I1DcrWz
 uYZSyxutdpwNwTc4bobNza2idd9VEFUkgp6dQxWeUFyCZOF3oNs2EG+qRWAmKjr4SDUQ
 HRDUP4XKH5mAekNlryzIbFnSblShUJUU2VuH6gK+K+5Q3Kb5yyqx1Rk7lZdZjfiBTAKd
 hBAelQScrDbvenBGP8fkfj1QeSATfBe2Hkojsd9NpcB/nttfaXBy0XVnDkqX4WvZq59+
 Ge/Kv7IuRs9rqDr0mdolmxTXt6XlROQ903i1zZZ+WPVB/7f6o/VhMaAopK2boZ0lp5ll aA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxymj13r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:22:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E9MPo8005192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:22:25 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:22:20 -0700
Subject: Re: [PATCH v6 3/8] remoteproc: qcom: Add compatible name for SC7280
 ADSP
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
 <1662643422-14909-4-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <cd745794-6325-e291-042d-f53f72abc5bf@quicinc.com>
Date:   Wed, 14 Sep 2022 14:52:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-4-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EBeRvWhkkZCNh108YLbEaH1fyUlU2ZuN
X-Proofpoint-GUID: EBeRvWhkkZCNh108YLbEaH1fyUlU2ZuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140045
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
> Update adsp pil data and compatible name for loading ADSP
> binary on SC7280 based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes since V5:
> 	-- Rename adsp_sandbox_needed to has_iommu.
> 	-- Change adsp binary extention name.
> Changes since V3:
> 	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
> 	-- Update sc7280 compatible name entry in sorted order.
> Changes since V2:
> 	-- Initialize is_adsp_sb_needed flag.
> 	-- Remove empty proxy pds array.
> 
>   drivers/remoteproc/qcom_q6v5_adsp.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index fa2ccac..02d17b4 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -702,6 +702,21 @@ static const struct adsp_pil_data adsp_resource_init = {
>   	},
>   };
>   
> +static const struct adsp_pil_data adsp_sc7280_resource_init = {
> +	.crash_reason_smem = 423,
> +	.firmware_name = "adsp.pbn",
> +	.load_state = "adsp",

given that you mention load_state info please make sure you
mention qcom,qmp as a required property in the bindings.

> +	.ssr_name = "lpass",
> +	.sysmon_name = "adsp",
> +	.ssctl_id = 0x14,
> +	.has_iommu = true,
> +	.auto_boot = true,
> +	.clk_ids = (const char*[]) {
> +		"gcc_cfg_noc_lpass", NULL
> +	},
> +	.num_clks = 1,

bindings seem to mention 6 other required clocks any reason why
they were skipped?

AFAIK you'll also need lmx so you'll have to mention proxy_pd_names
as well.

> +};
> +
>   static const struct adsp_pil_data cdsp_resource_init = {
>   	.crash_reason_smem = 601,
>   	.firmware_name = "cdsp.mdt",
> @@ -740,6 +755,7 @@ static const struct adsp_pil_data wpss_resource_init = {
>   
>   static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,qcs404-cdsp-pil", .data = &cdsp_resource_init },
> +	{ .compatible = "qcom,sc7280-adsp-pil", .data = &adsp_sc7280_resource_init },
>   	{ .compatible = "qcom,sc7280-wpss-pil", .data = &wpss_resource_init },
>   	{ .compatible = "qcom,sdm845-adsp-pil", .data = &adsp_resource_init },
>   	{ },
> 
