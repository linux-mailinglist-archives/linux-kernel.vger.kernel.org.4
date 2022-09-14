Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915D5B8529
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiINJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiINJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:37:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EE314;
        Wed, 14 Sep 2022 02:36:12 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E9SH3O026120;
        Wed, 14 Sep 2022 09:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P99DFL9RFG9Dhn5X+kTEl7SHgN2RMsqsNHhLlj3BOvY=;
 b=Ip67EnXSsu0OqZvxyCab6StDZCc7eCpCM4KAMHsw2oEYpruz22Grm2jFpNn39A53m9xz
 pfPjqI1O/v4j/YzvqAVuXpXd30T1Jdd0egcFb78RCT28WDFg8l7GNV5IR1VHillExCYk
 PAnGeAwl7vywPl1+P7agEFSUlW6GchCDKQhsuNcprFWoA6ve0/jkpMttB3+YhOHrV9mz
 ttkMjex+JlCB8gyccD9SIFI8qPbQkkfBdZyN4YrjojojfcNxa5IWswj60ZdAvKrJAt9T
 PRTs7CdXxjQB5HZtEbdNFxLpAa4AggYLzVMFnx6S6RwnWr4WKKS3MjIWR7RQ5b+XYbGU WQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy06hr3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:35:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E9ZuSl023166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:35:56 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:35:51 -0700
Subject: Re: [PATCH v6 4/8] remoteproc: qcom: Update rproc parse firmware
 callback
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
 <1662643422-14909-5-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <babd014c-bf8a-bbff-7bc7-fabeeb250d0d@quicinc.com>
Date:   Wed, 14 Sep 2022 15:05:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-5-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lrqwII24AonPRi-0_-ePwr6-l-A-3otU
X-Proofpoint-ORIG-GUID: lrqwII24AonPRi-0_-ePwr6-l-A-3otU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140046
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
> Change parse_fw callback in rproc ops from qcom_register_dump_segments
> to rproc_elf_load_rsc_table, as section header to be parsed for memory
> sandboxing required platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 02d17b4..207270d4 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -447,7 +447,7 @@ static unsigned long adsp_panic(struct rproc *rproc)
>   	return qcom_q6v5_panic(&adsp->q6v5);
>   }
>   
> -static const struct rproc_ops adsp_ops = {
> +static struct rproc_ops adsp_ops = {
>   	.start = adsp_start,
>   	.stop = adsp_stop,
>   	.da_to_va = adsp_da_to_va,
> @@ -590,6 +590,9 @@ static int adsp_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	if (desc->has_iommu)
> +		adsp_ops.parse_fw = rproc_elf_load_rsc_table;
> +

The parse_fw would still need to perform the register_dump_segments
in addition to elf_load_rsc_table, otherwise you'll lose coredump
functionality for ADSP on SC7280. You could perhaps just follow
qcom_q6v5_mss parse_fw i.e. have a static func internal to adsp
doing both and have it assigned to both wpss/adsp with the
pre-existing has_iommu flag to differentiate between the two. With
this you wouldn't need to remove the const in adsp_ops as well.

>   	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
>   			    firmware_name, sizeof(*adsp));
>   	if (!rproc) {
> 
