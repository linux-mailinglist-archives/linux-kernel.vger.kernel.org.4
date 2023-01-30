Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A14680819
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjA3JCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjA3JCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:02:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386072CFC2;
        Mon, 30 Jan 2023 01:02:15 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U6MZx0022015;
        Mon, 30 Jan 2023 09:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xKtZx1PvWVMSYwvF3G8Rfh6Hg16qCtA/1CnGxqUfAsM=;
 b=QYwlZLpctEHTHicfAz7Kf2mRmAV2gt3ixAWCNTPQteQiYDHeU+c8h+hhZudrQY2bD4zR
 mTYFE617T870eNtqPkel5AtM0BEL8Gd5lo2JNuLTrhIwM5e4KYta3AFoahzSPIHkkHQj
 gSDXsgyEz/wVosMq2YUp4WUd4pwmYJY/5nYDUYnbCi8V08tJ+zHIcWVfcm8HEGqT1hQ6
 arXtQptu9T3lvzPztBxUyEJlCgEOCrL/1D1Sx2a731emQu7d86jVvDzsvMNWWXicacUQ
 mVP7A1LjjNGcIyKH2L8UQMNf79o1KkMxvkvuNojTFJ+k3o6OYRBDbMELNqPQR3bAAu5P fw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnyk6xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:02:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U929U7025399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:02:09 GMT
Received: from [10.216.24.235] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 01:02:05 -0800
Message-ID: <72285901-29a4-1491-6df5-1f0315cb99ee@quicinc.com>
Date:   Mon, 30 Jan 2023 14:32:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] remoteproc: qcom: pas: Add sm6115 remoteprocs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mani@kernel.org>, <mathieu.poirier@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhupesh.linux@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5G9aKFGHDwbLAJrAymIhAc2WkMtvqs-5
X-Proofpoint-ORIG-GUID: 5G9aKFGHDwbLAJrAymIhAc2WkMtvqs-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300085
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2023 11:05 AM, Bhupesh Sharma wrote:
> Among the subsystems in the Qualcomm sm6115 platform we find
> audio, compute and modem DSPs.
> 
> Add support for controlling these using the peripheral
> authentication service (PAS) remoteproc driver.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 4e1d9b08def4..9eb5a92bf5f6 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -1184,6 +1184,9 @@ static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,sdm845-adsp-pas", .data = &sdm845_adsp_resource_init},
>   	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &sdm845_cdsp_resource_init},
>   	{ .compatible = "qcom,sdx55-mpss-pas", .data = &sdx55_mpss_resource},
> +	{ .compatible = "qcom,sm6115-adsp-pas", .data = &adsp_resource_init},
> +	{ .compatible = "qcom,sm6115-cdsp-pas", .data = &cdsp_resource_init},
> +	{ .compatible = "qcom,sm6115-mpss-pas", .data = &sc8180x_mpss_resource},
>   	{ .compatible = "qcom,sm6350-adsp-pas", .data = &sm6350_adsp_resource},
>   	{ .compatible = "qcom,sm6350-cdsp-pas", .data = &sm6350_cdsp_resource},
>   	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
