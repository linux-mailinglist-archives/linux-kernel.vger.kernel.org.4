Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5D76E5DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDRJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDRJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:51:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B410D9;
        Tue, 18 Apr 2023 02:51:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6sxDW018556;
        Tue, 18 Apr 2023 09:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L+eUqA5NJKcBPR51rFZc25ELZ4D8X+qapQd2LFr1bfo=;
 b=jP/O4t2kAJtNZKcLHT/LGCgxFXEaedvZTJXdE2DXq6HpBCIQtmI6URsnDvexBz6AwyP3
 bk6yR+AbMVavTDEIMiCXMaTMASIyv6sMPgppuKC0YWjuIcX/0fxOdYpwfSir34DMo7Bw
 JhfGKDj/1qqMfpk+rfqLCnEytoYKUze/RTrGtNepByq8TU8sC/j6SuBY/Kj5XjboQ/8O
 TGUb69UNBO0fx7q7KpUsS9ojN49RyTjw+TxwVOth6qQB8h3neO/lzEuY9zXTk3VJLDXt
 G3FVVNYswAyAav8nwsaBX3k6ue0Wn0SD5tGxloxU9G5Cg2hiE5tpIBTu9fCzGR690B6F MA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nr5gek0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:51:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9pV1g023589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:51:31 GMT
Received: from [10.50.61.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:51:27 -0700
Message-ID: <bc382695-b619-2c45-8751-2120f8d548ba@quicinc.com>
Date:   Tue, 18 Apr 2023 15:21:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] venus: add firmware version based check
Content-Language: en-US
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        <linux-media@vger.kernel.org>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Viswanath Boma" <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
 <6c3002ad-ff78-8818-0e68-a151d33b0fca@gmail.com>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <6c3002ad-ff78-8818-0e68-a151d33b0fca@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6wxK0hvHMwC-Dh118I8FNbDrsqnhg7xh
X-Proofpoint-ORIG-GUID: 6wxK0hvHMwC-Dh118I8FNbDrsqnhg7xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_06,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=950 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180085
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/9/2023 10:48 AM, Stanimir Varbanov wrote:
> Hi Dikshita,
>
> Thanks for the patch.
>
> On 7.04.23 г. 9:25 ч., Dikshita Agarwal wrote:
>> Add firmware version based checks to enable/disable
>> features for different SOCs.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>>   2 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h 
>> b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2..9d1e4b2 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -202,6 +202,11 @@ struct venus_core {
>>       unsigned int core0_usage_count;
>>       unsigned int core1_usage_count;
>>       struct dentry *root;
>> +    struct venus_img_version {
>> +        u32 major;
>> +        u32 minor;
>> +        u32 rev;
>> +    } venus_ver;
>>   };
>>     struct vdec_controls {
>> @@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 
>> codec, u32 domain)
>>       return NULL;
>>   }
>>   +static inline int
>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, 
>> u32 vrev)
>> +{
>> +    return ((core)->venus_ver.major == vmajor &&
>> +        (core)->venus_ver.minor == vminor &&
>> +        (core)->venus_ver.rev >= vrev);
>> +}
>> +
>> +static inline int
>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, 
>> u32 vrev)
>> +{
>> +    return ((core)->venus_ver.major == vmajor &&
>> +        (core)->venus_ver.minor == vminor &&
>> +        (core)->venus_ver.rev <= vrev);
>> +}
>
> IMO those two should return bool
sure, will update.
>
>>   #endif
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c 
>> b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> index df96db3..07ac0fc 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core 
>> *core, struct venus_inst *inst,
>>   }
>>     static void
>> -sys_get_prop_image_version(struct device *dev,
>> +sys_get_prop_image_version(struct venus_core *core,
>>                  struct hfi_msg_sys_property_info_pkt *pkt)
>>   {
>> +    struct device *dev = core->dev;
>>       u8 *smem_tbl_ptr;
>>       u8 *img_ver;
>>       int req_bytes;
>> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>>           return;
>>         img_ver = pkt->data;
>> +    if (IS_V4(core))
>> +        sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
>> +               &core->venus_ver.major, &core->venus_ver.minor, 
>> &core->venus_ver.rev);
>> +    else if (IS_V6(core))
>> +        sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
>> +               &core->venus_ver.major, &core->venus_ver.minor, 
>> &core->venus_ver.rev);
>
> what about if IS_V1?

the conditional code above is added only for v6 and v4.

The behavior for v1 remain same as before.

img_ver = pkt->data

>
>>       dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>
> this will crash for v1.
I didn't get why would it crash, could you pls explain?
>
>>   @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct 
>> venus_core *core,
>>         switch (pkt->property) {
>>       case HFI_PROPERTY_SYS_IMAGE_VERSION:
>> -        sys_get_prop_image_version(dev, pkt);
>> +        sys_get_prop_image_version(core, pkt);
>>           break;
>>       default:
>>           dev_dbg(dev, VDBGL "unknown property data\n");
>
