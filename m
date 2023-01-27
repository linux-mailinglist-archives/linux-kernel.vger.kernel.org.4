Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7A67DCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 05:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjA0EQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 23:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjA0EQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:16:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2716336;
        Thu, 26 Jan 2023 20:16:14 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R47J4X020421;
        Fri, 27 Jan 2023 04:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KZUcTgUaTGqseYdC0Kjz9D5vCmq+JhIEgHzdinumt9g=;
 b=KKb4lCNK7zw6IjwbU6bGYMm325Ew+WZuwWxdXgHxuwLg9eeQQDqfre+0qzVTCFdFF0Sz
 vFgu5RFgHXE8uxCu5+DaBXwsVjxxM9NSt1V9E37BavKzHBVcwwpIOyV8dnNmcWGbGumL
 lYEIaEljVlom8s7rgiitA5Bi2pORCBk7YlLynJ827dE5JMp8zzZSavj+Rq4XKcDcyfrz
 wzb6mSTgEes3TqZEdZZOdm6eVMtQTEPXN2MBlcOu/R6r/0HBU9k5PT6n5olF7c6KOAyj
 bLhe/bJNHY+s+us1h3fC+2rFLcOLcORvGqIPyrdXhB3G2XRVD2sfMZvIZ5XHMS2hwwRd LA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb0qrv3xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 04:16:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R4G2XQ004538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 04:16:02 GMT
Received: from [10.214.82.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 20:15:59 -0800
Message-ID: <8c64d4a5-b101-ad3d-0e5e-590f060d0104@quicinc.com>
Date:   Fri, 27 Jan 2023 09:45:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: qcom: socinfo: Add support for new field in revision
 17
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
References: <20230125081407.31833-1-quic_namajain@quicinc.com>
 <59bf1f6e-60df-160a-a343-11a482eec586@quicinc.com>
From:   Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <59bf1f6e-60df-160a-a343-11a482eec586@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g8ErzgeeEvm3nw1D-sj0rFrrNTBFyAjk
X-Proofpoint-ORIG-GUID: g8ErzgeeEvm3nw1D-sj0rFrrNTBFyAjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270038
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 11:58 PM, Trilok Soni wrote:
> On 1/25/2023 12:14 AM, Naman Jain wrote:
>> Add support for new field coming with socinfo structure under v17 to get
>> hardware platform's oem variant id. This is to enable OEMs to have minor
>> changes in the board, but to use the same platform subtype as the one
>> supported by Qualcomm. The new field is to be used in platform overlay
>> file. Default value is 0, reserved for Qualcomm platforms. Also, add
>> debugfs support to read this field for a device.
>>
>> Change-Id: I18f80084bc75466f3fcccd55fd21b37d69245aa6
>
> I don't see SOB line. Please remove Change-ID. Run checkpatch?


SOB line must have been deleted, in place of Change-id, by mistake. I 
run checkscript everytime, but somehow it got missed the last time, and 
I did not catch this. Sorry for the trouble and thanks for reviewing, 
addressed in v2.


>
>> ---
>>   drivers/soc/qcom/socinfo.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index 10efdbcfdf05..10cdd32ce74d 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -174,6 +174,8 @@ struct socinfo {
>>       __le32  pcode;
>>       __le32  npartnamemap_offset;
>>       __le32  nnum_partname_mapping;
>> +    /* Version 17 */
>> +    __le32 oem_variant;
>>   };
>>     #ifdef CONFIG_DEBUG_FS
>> @@ -196,6 +198,7 @@ struct socinfo_params {
>>       u32 nmodem_supported;
>>       u32 feature_code;
>>       u32 pcode;
>> +    u32 oem_variant;
>>   };
>>     struct smem_image_version {
>> @@ -519,6 +522,11 @@ static void socinfo_debugfs_init(struct 
>> qcom_socinfo *qcom_socinfo,
>>                  &qcom_socinfo->info.fmt);
>>         switch (qcom_socinfo->info.fmt) {
>> +    case SOCINFO_VERSION(0, 17):
>> +        qcom_socinfo->info.oem_variant = 
>> __le32_to_cpu(info->oem_variant);
>> +        debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
>> +                   &qcom_socinfo->info.oem_variant);
>> +        fallthrough;
>>       case SOCINFO_VERSION(0, 16):
>>           qcom_socinfo->info.feature_code = 
>> __le32_to_cpu(info->feature_code);
>>           qcom_socinfo->info.pcode = __le32_to_cpu(info->pcode);
