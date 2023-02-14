Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45F0696668
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjBNOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjBNOSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:18:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774772A1;
        Tue, 14 Feb 2023 06:17:46 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E8KCHK015473;
        Tue, 14 Feb 2023 14:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/nCTd7pBuvatiw5+3uUxEm27G6Sx1tzD9Hft3j7OtVM=;
 b=BEBpJwvu+8pjT12u5xgfS1yulu+6V0NzfOX1iZLQjfx70YM1P1OZ66wxfkatDQsIYDlQ
 6iDKinAzSIQ3JSRJtPIy4jTX4U3TdCzra957lvyoeAEZ+WwsRNUPOGPF6vT9qkos2P7p
 pu5j3aNP0DFccYPuBshXJrCAguexYbrDRNFpIHq9K/RUq8EAcXT4cXrb/Z+B4WhG8kRv
 LYruVIr/DgkNuF/pK3FPOS8eKK0oKk0jZ5s5IfwX5TofGR2y8emTrlS3D33RTdI4ncIe
 d4QbOP8yFyLu9bDX1vvbMNXC6Em6iF6r1FV18IDmH3B6FzS5UP6LdgYDCb+dHybIU7NS Tw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6ps0t72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 14:12:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EECUhb005371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 14:12:30 GMT
Received: from [10.216.50.155] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 06:12:27 -0800
Message-ID: <62ffa065-bc85-09bf-0492-7de0bd45ae13@quicinc.com>
Date:   Tue, 14 Feb 2023 19:42:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] remoteproc: qcom: fix sparse warnings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1675180866-16695-1-git-send-email-quic_mojha@quicinc.com>
 <bba9e244-0a02-4d46-8ba8-bc8b11ddf6b4@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <bba9e244-0a02-4d46-8ba8-bc8b11ddf6b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UsWmiX7zLmzlaEVb20jXGkip6SY7Mcyn
X-Proofpoint-GUID: UsWmiX7zLmzlaEVb20jXGkip6SY7Mcyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=947 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140121
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2023 6:25 AM, Dmitry Baryshkov wrote:
> On 31/01/2023 18:01, Mukesh Ojha wrote:
>> This patch try to address below sparse warnings.
>>
>> drivers/remoteproc/qcom_common.c:126:27: warning: restricted __le32 
>> degrades to integer
>> drivers/remoteproc/qcom_common.c:133:32: warning: cast to restricted 
>> __le32
>> drivers/remoteproc/qcom_common.c:133:32: warning: cast from restricted 
>> __le64
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

Thanks for the review.

> Also see below.
> 
>> ---
>>   drivers/remoteproc/qcom_common.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c 
>> b/drivers/remoteproc/qcom_common.c
>> index 020349f..7133c1f 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -123,14 +123,14 @@ static int qcom_add_minidump_segments(struct 
>> rproc *rproc, struct minidump_subsy
>>       for (i = 0; i < seg_cnt; i++) {
>>           memcpy_fromio(&region, ptr + i, sizeof(region));
>> -        if (region.valid == MD_REGION_VALID) {
>> +        if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
>>               name = kstrdup(region.name, GFP_KERNEL);
> 
> While you are at it, please replace this kstrdup() with kstrndup(). 
> There is no guarantee that region.name will be 0-terminated.

Kept it as separate patch in this mail thread itself.

-Mukesh
>>               if (!name) {
>>                   iounmap(ptr);
>>                   return -ENOMEM;
>>               }
>>               da = le64_to_cpu(region.address);
>> -            size = le32_to_cpu(region.size);
>> +            size = le64_to_cpu(region.size);
>>               rproc_coredump_add_custom_segment(rproc, da, size, NULL, 
>> name);
>>           }
>>       }
> 
