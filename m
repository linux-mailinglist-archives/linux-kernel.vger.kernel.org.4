Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870855B856F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiINJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiINJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:46:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320F61718;
        Wed, 14 Sep 2022 02:46:03 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E9T8S7002005;
        Wed, 14 Sep 2022 09:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=guhL3O6ImPZ+HTuGT/P6lnT7Op7WWDU+WfpjFmZYUy4=;
 b=DC8c6SAznRFpZ5qi4ZjCd/1S5MWT7BKTAaOGdrMK9ISYW/7q/GRa7PZRf0EQEN2qp44X
 wNtjF4CAJMZV8Tun4wmhlqqu+Nu2UAP17vaITaHOTF9UtZrj/+ilwILpUBqmexqaz6sC
 KeEkzLapqpnwrLy+r94Q2/XF495O0IT5kTHFCgGzxTm1BPSsODIkCadhZ3ixil8u4vHo
 A1oOqDKHV49MyfiJnTGImrBQjU0n2UnwrUGzwa/2Z889Xm2TCV+FXMTqXMG23zwf+GQ/
 qy3R/YPMF/xRhbrpq3SHb8w7PxRT+qRWI1wRJHs6xUoS0VXJMh7AmBAkeMbEamC+GUF6 QA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0ghs6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:45:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E9jMSJ006867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:45:22 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:45:17 -0700
Subject: Re: [PATCH v6 8/8] remoteproc: qcom: Update QDSP6 out-of-reset
 timeout value
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
 <1662643422-14909-9-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <5dbdf924-784d-9cf1-84d5-a03f18f98768@quicinc.com>
Date:   Wed, 14 Sep 2022 15:15:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-9-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fNNkQFqrZNDs09HN57U8kZG3Ab63zVpy
X-Proofpoint-GUID: fNNkQFqrZNDs09HN57U8kZG3Ab63zVpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Update QDSP6 out-of-reset timeout value to 1 second, as sometimes
> ADSP boot failing on SC7280 based platforms with existing value.
> Also add few micro seconds sleep after enabling boot core
> start register.

Please do check if the timeout that you hit is due to lack of
required clock/bus scaling. If so increasing the timeout would
be just an interim hack and might stop working in the future.

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index e55d593..4414e23 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -34,7 +34,7 @@
>   /* time out value */
>   #define ACK_TIMEOUT			1000
>   #define ACK_TIMEOUT_US			1000000
> -#define BOOT_FSM_TIMEOUT		10000
> +#define BOOT_FSM_TIMEOUT		1000000
>   /* mask values */
>   #define EVB_MASK			GENMASK(27, 4)
>   /*QDSP6SS register offsets*/
> @@ -422,13 +422,14 @@ static int adsp_start(struct rproc *rproc)
>   
>   	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
>   	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
> +	usleep_range(100, 110);
>   
>   	/* Trigger boot FSM to start QDSP6 */
>   	writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
>   
>   	/* Wait for core to come out of reset */
>   	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
> -			val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
> +			val, (val & BIT(0)) != 0, 100, BOOT_FSM_TIMEOUT);
>   	if (ret) {
>   		dev_err(adsp->dev, "failed to bootup adsp\n");
>   		goto disable_adsp_clks;
> 
