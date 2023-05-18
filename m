Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1170872B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjERRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjERRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:46:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D884A9;
        Thu, 18 May 2023 10:46:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IGivGk029217;
        Thu, 18 May 2023 17:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3xSP10bNXu97RicDPv8IfOJME5zzMDni62CNoTI1894=;
 b=kMcnwCP2Rc52m4xTT0yA5u6qrx6Cf9qmnibFPMQI84nCrkqWoX3ivq9igiNJUjHoh3FU
 02kC7N2cVGvwNkG+ubo+FkXLHGg3TbjnwTDQe0DeYH/VFanbnS8QIFWa5LzjHrtGgHlp
 c22/jI9HkOKb6qpEqb7QDLky9Au0XTqmWPzz6Q9MavK4a4Vxhp9g8PZym0BvKm4wfq+g
 O3n1uxLhUGKoXeWS4uVnxk9s+mvcMDqJj4iDltgKBoMu3SAxCbqpd1+FvtrZN31Ks3WM
 fYDWdQldXHM3p885FjzM3WMV18GSA4WhxCSMlur/6YOQrNf1x4EvoqoZ4i1dcYx+suuN vQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn8d2j5hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 17:46:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IHkkO8002062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 17:46:46 GMT
Received: from [10.216.41.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 10:46:38 -0700
Message-ID: <c7bf19ed-6c9f-7073-97fe-329eb1c88ba1@quicinc.com>
Date:   Thu, 18 May 2023 23:16:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 07/11] mailbox: qcom-apcs-ipc: Add IPQ5018 APCS IPC
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-8-git-send-email-quic_mmanikan@quicinc.com>
 <ec7af3f9-5feb-0785-278c-209eeefd0aac@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <ec7af3f9-5feb-0785-278c-209eeefd0aac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q5VYWFnnKF5zHJkJQl5L6NHLWyv8S3Tk
X-Proofpoint-GUID: q5VYWFnnKF5zHJkJQl5L6NHLWyv8S3Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180144
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 8:50 PM, Krzysztof Kozlowski wrote:
> On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
>> Enable IPQ5018 APCS IPC support by adding the compatible.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> index 6bbf87c6d60b..0b873c76fd7e 100644
>> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> @@ -141,6 +141,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>>   
>>   /* .data is the offset of the ipc register within the global block */
>>   static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>> +	{ .compatible = "qcom,ipq5018-apcs-apps-global", .data = &ipq6018_apcs_data },
> 
> Why do you need new entry with same driver data?
> 
> Best regards,
> Krzysztof
> 
Yeah it's not required. Since i already updated bindings, i will drop 
this patch.

Thanks & Regards,
Manikanta.
