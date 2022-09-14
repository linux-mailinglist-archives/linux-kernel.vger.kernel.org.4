Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EAE5B8563
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiINJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiINJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:43:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4BC61D8B;
        Wed, 14 Sep 2022 02:43:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E4gude005697;
        Wed, 14 Sep 2022 09:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W9ogH6yWZzI6pO9moW/Ol1LFly3iMe6WYkYJh3ynBp8=;
 b=Y3w64crHhiQnQnD4HDzCmmG0QJoNysIzeIW3BMksMi2HgkGNHnQQLkfLm8mapXzTDOzY
 iO66wNb1uznsnqd6Dj5coLLkUxs2BZ8365P05GgTzKG+4Jeh8OvMkK/PavkxyVVd9s11
 w4J3XGxXOvuyRPpQ+3rcOi8rbddF2ffNhELgcwO1UcLWD8eDh2JwOs1iiB3Tle3evcFX
 F2dowA7y6V+PANxt2PZj4lmYQCrGjtqgz9jGw2yFIjGS96did3rO+ETQ2k2b0KcFbQlJ
 9JeUZ9BgyeeY7fmWEgEXLrWxYDNje/H9s9m2tPIn0O+760qpX0kFmdFbdEMMyjGh4Ynw SA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyva3pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:42:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E9gLH4021547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:42:21 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:42:16 -0700
Subject: Re: [PATCH v6 6/8] remoteproc: qcom: Add efuse evb selection control
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
 <1662643422-14909-7-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <48a6c7ef-1aa1-fd1e-5dc5-83adda5f581a@quicinc.com>
Date:   Wed, 14 Sep 2022 15:12:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-7-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XNGhtiO5ArlziM5mfW772XRB8qA-hCsu
X-Proofpoint-ORIG-GUID: XNGhtiO5ArlziM5mfW772XRB8qA-hCsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140047
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
> Add efuse evb selection control and enable it for starting ADSP.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> Changes since V5:
> 	-- Split devm_platform_ioremap_resource_byname function.
> 
>   drivers/remoteproc/qcom_q6v5_adsp.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 389b2c0..ccb5592 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -56,6 +56,7 @@
>   
>   #define LPASS_BOOT_CORE_START	BIT(0)
>   #define LPASS_BOOT_CMD_START	BIT(0)
> +#define LPASS_EFUSE_Q6SS_EVB_SEL 0x0
>   
>   struct adsp_pil_data {
>   	int crash_reason_smem;
> @@ -86,6 +87,7 @@ struct qcom_adsp {
>   	struct clk_bulk_data *clks;
>   
>   	void __iomem *qdsp6ss_base;
> +	void __iomem *lpass_efuse;
>   
>   	struct reset_control *pdc_sync_reset;
>   	struct reset_control *restart;
> @@ -368,6 +370,9 @@ static int adsp_start(struct rproc *rproc)
>   	/* Program boot address */
>   	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
>   
> +	if (adsp->lpass_efuse)
> +		writel(LPASS_EFUSE_Q6SS_EVB_SEL, adsp->lpass_efuse);
> +
>   	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
>   	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
>   
> @@ -513,6 +518,7 @@ static int adsp_init_reset(struct qcom_adsp *adsp)
>   static int adsp_init_mmio(struct qcom_adsp *adsp,
>   				struct platform_device *pdev)
>   {
> +	struct resource *efuse_region;
>   	struct device_node *syscon;
>   	int ret;
>   
> @@ -522,6 +528,17 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
>   		return PTR_ERR(adsp->qdsp6ss_base);
>   	}
>   
> +	efuse_region = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!efuse_region) {
> +		adsp->lpass_efuse = NULL;
> +		dev_dbg(adsp->dev, "failed to get efuse memory region\n");
> +	} else {
> +		adsp->lpass_efuse = devm_ioremap_resource(&pdev->dev, efuse_region);
> +		if (IS_ERR(adsp->lpass_efuse)) {
> +			dev_err(adsp->dev, "failed to map efuse registers\n");
> +			return PTR_ERR(adsp->lpass_efuse);
> +		}
> +	}
>   	syscon = of_parse_phandle(pdev->dev.of_node, "qcom,halt-regs", 0);
>   	if (!syscon) {
>   		dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");
> 
