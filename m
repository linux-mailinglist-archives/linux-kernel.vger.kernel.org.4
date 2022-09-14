Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210A5B8535
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiINJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiINJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:38:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217518B21;
        Wed, 14 Sep 2022 02:38:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E9FMYd011454;
        Wed, 14 Sep 2022 09:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qu4GLI/njJfKV0SI3uET3HyX+CffqV0m05wMLvzRqEM=;
 b=L7J4s4CTqqn3Hf24PqCpCvpajIRDsB6CgIDeb+f9+4FO3nn4L1J7rjrCjlbazAbaKMyu
 1xMCHKDT2crJBZlOc8l5F7XUYH9DbknLjfMlhkwvkD2MvufV0G577e4GDFV0Vb/HunDd
 3992H1oQbh0fXOZ5Jgk7xjmEpH//B21ZjvaCuILBVg9mLOgFSDLYIoUaGWX0vSm6zFE7
 kFh3aOo4YRtMxBHzxO0oBsVmkr9+CmN5Do3KhTU+uFxa/4lcx6+5bbX2zbbw9JycWgdH
 Tx84ng8LxdsjW7HiK5A5Fei/O+AnEE5uQRszlysHMVwnkiuzNK7F4aQ0ZKXAUJ0MX9y2 Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxymj2fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:37:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E9bR9f016195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:37:27 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:37:22 -0700
Subject: Re: [PATCH v6 5/8] remoteproc: qcom: Replace hard coded values with
 macros
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
 <1662643422-14909-6-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <34b232a7-6f94-8f72-dde5-0a2dc2320ebb@quicinc.com>
Date:   Wed, 14 Sep 2022 15:07:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-6-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9Zc2hkvspJ6jsLysYZQSvI1DEm7HW9IB
X-Proofpoint-GUID: 9Zc2hkvspJ6jsLysYZQSvI1DEm7HW9IB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
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
> Replace hard coded values of QDSP6 boot control reg params
> with appropriate macro names.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 207270d4..389b2c0 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -54,6 +54,9 @@
>   
>   #define QCOM_Q6V5_RPROC_PROXY_PD_MAX	3
>   
> +#define LPASS_BOOT_CORE_START	BIT(0)
> +#define LPASS_BOOT_CMD_START	BIT(0)
> +
>   struct adsp_pil_data {
>   	int crash_reason_smem;
>   	const char *firmware_name;
> @@ -366,10 +369,10 @@ static int adsp_start(struct rproc *rproc)
>   	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
>   
>   	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
> -	writel(0x1, adsp->qdsp6ss_base + CORE_START_REG);
> +	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
>   
>   	/* Trigger boot FSM to start QDSP6 */
> -	writel(0x1, adsp->qdsp6ss_base + BOOT_CMD_REG);
> +	writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
>   
>   	/* Wait for core to come out of reset */
>   	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
> 
