Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B85723FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjFFKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjFFKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:43:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B13010D4;
        Tue,  6 Jun 2023 03:42:04 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3564kK7F002364;
        Tue, 6 Jun 2023 10:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dF34zJbVGByvGf10DbPd83RSLyLsIWls7Zo3AXCHmZ4=;
 b=PhPOr4DJTY0dmXhP34uGSbqB6Y5zlkI7z8mofhQOdt//kk8NHScrlxnpJnqMb2PnvsBk
 aimV+fm9+Mt8A6hg+YQE41R4pp/yT9vBGniu0KJAJZe5s9gDFRt9i7zwsap2I1xKefK5
 q1uhnFiZWuKWtB8zibltpKE24R8F5UnNPx+IKd4/h1uM/1VeeVDEZo9POvcP/qSEqn/+
 6xx0yOl7GehJcBdtI/A7DqJa14cQXQE5OEg0ysQq1BgRGEdwdq371yxzE8wIWCU56aHU
 CJkLS4Yqy0M1YzSZdkvvbb5Oz9+DJaV9b1CGntLHPAr1zFYo8cPDsDzSD7s8/2fHazNu pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1uvv0w9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 10:41:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356AfuX7018618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 10:41:56 GMT
Received: from [10.214.82.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 03:41:53 -0700
Message-ID: <ad970175-fd78-f7b9-c7f0-d88d35a6e413@quicinc.com>
Date:   Tue, 6 Jun 2023 16:11:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] soc: qcom: socinfo: Add support for new fields in
 revision 18
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>
References: <20230602032600.14790-1-quic_namajain@quicinc.com>
 <955b8b78-eb50-7ee2-f5f7-6b66a2daa963@gmail.com>
From:   Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <955b8b78-eb50-7ee2-f5f7-6b66a2daa963@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4piw5nJ8R8i0LWenMOW52lsp_rV_rtRB
X-Proofpoint-GUID: 4piw5nJ8R8i0LWenMOW52lsp_rV_rtRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060091
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/2023 4:03 PM, Robert Marko wrote:
>
> On 02. 06. 2023. 05:25, Naman Jain wrote:
>> Add support for below fields coming in socinfo structure under v18:
>> * num_kvps: number of key value pairs (KVP)
>> * kvps_offset: the offset of the KVP table from the base address of
>>    socinfo structure in SMEM
>> KVP table has boolean values for certain feature flags, used to 
>> determine
>> hardware configuration.
>>
>> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
>
> Hi,
> The socinfo struct itself was moved into a separate header[1] so it 
> can be reused,
> so this patch series needs to be rebased on top of linux-next.
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/soc/qcom/socinfo.h?h=next-20230606&id=ec001bb71e4476f7f5be9db693d5f43e65b9d8cb
>
> Regards,
> Robert
>
>> ---
>>   drivers/soc/qcom/socinfo.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index c2e4a57dd666..a76006ea8a37 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -181,6 +181,9 @@ struct socinfo {
>>       __le32  nnum_partname_mapping;
>>       /* Version 17 */
>>       __le32 oem_variant;
>> +    /* Version 18 */
>> +    __le32 num_kvps;
>> +    __le32 kvps_offset;
>>   };
>>     #ifdef CONFIG_DEBUG_FS
>> @@ -620,6 +623,7 @@ static void socinfo_debugfs_init(struct 
>> qcom_socinfo *qcom_socinfo,
>>                  &qcom_socinfo->info.fmt);
>>         switch (qcom_socinfo->info.fmt) {
>> +    case SOCINFO_VERSION(0, 18):
>>       case SOCINFO_VERSION(0, 17):
>>           qcom_socinfo->info.oem_variant = 
>> __le32_to_cpu(info->oem_variant);
>>           debugfs_create_u32("oem_variant", 0444, 
>> qcom_socinfo->dbg_root,
>>

HI Robert,

Thanks for pointing it out. Will rebase and send it in v2.


Regards,

Naman

