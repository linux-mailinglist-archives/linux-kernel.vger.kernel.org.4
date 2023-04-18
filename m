Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9986E5DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDRJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDRJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:48:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137B1729;
        Tue, 18 Apr 2023 02:48:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9XAAD001326;
        Tue, 18 Apr 2023 09:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mHulj2Ob+GdGkscMtZVzzLeB8JaNeTCSgpDhRS0mUxc=;
 b=YMduP6L8UEDVxDmfw5aoQ+NCpRV7YFglfgco27+jngqZoa1mFn9hogw1vCNSrzSraCun
 XzkuLZ1/LaqOiAFAJwz+/WPLyEJ++y0Nom+Vie3jXVUOsOofvBOrfXd0h7RqiFp5aANS
 IfGfk2+vwrYrxJpsnPitbyVKXj+9JVIUlR1sEdmHOz61mLh3OYhP5ieGRxzRNCCU7FBQ
 tnV21Bp+dwVaKaRY/RXuUADe6D+DRlbdqYgxR9MBfJJlEfHAoGJ15TWA89So/YZL56JV
 PX5oCJRlDKwE4fK0yRY/vx/D5qjOz/WrEWW25b/ZMLVkMqv2ONXluzP2wrpYeHWYDBap Ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1bvksgkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:48:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9mBVn019118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:48:11 GMT
Received: from [10.50.61.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:48:07 -0700
Message-ID: <23695782-3343-0a15-4446-2922f27a4cf9@quicinc.com>
Date:   Tue, 18 Apr 2023 15:17:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] venus: add firmware version based check
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Viswanath Boma" <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
 <514c5c33-df0a-8b4b-a5a2-67abff538efa@linaro.org>
Content-Language: en-US
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <514c5c33-df0a-8b4b-a5a2-67abff538efa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HMFvkxfZe0fNz8y63ovD2FdNy_E9ku8D
X-Proofpoint-ORIG-GUID: HMFvkxfZe0fNz8y63ovD2FdNy_E9ku8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180083
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/2023 12:45 PM, Konrad Dybcio wrote:
>
> On 7.04.2023 08:25, Dikshita Agarwal wrote:
>> Add firmware version based checks to enable/disable
>> features for different SOCs.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> One extra question: some firmware builds have a TYPE-n suffix like
> PROD-1 in:
>
> 14:VIDEO.VE.6.0-00042-PROD-1
>
> Is the -1 a sign of an incremental build, or some "point release" of a
> given fw revision? Does it matter as far as this checking function
> goes?

this part of string gets added based on the tool version used to build 
the firmware.

this doesn't matter and can be ignored.

Thanks,

Dikshita

> Konrad
>>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>>   2 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2..9d1e4b2 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -202,6 +202,11 @@ struct venus_core {
>>   	unsigned int core0_usage_count;
>>   	unsigned int core1_usage_count;
>>   	struct dentry *root;
>> +	struct venus_img_version {
>> +		u32 major;
>> +		u32 minor;
>> +		u32 rev;
>> +	} venus_ver;
>>   };
>>   
>>   struct vdec_controls {
>> @@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>>   	return NULL;
>>   }
>>   
>> +static inline int
>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +	return ((core)->venus_ver.major == vmajor &&
>> +		(core)->venus_ver.minor == vminor &&
>> +		(core)->venus_ver.rev >= vrev);
>> +}
>> +
>> +static inline int
>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +	return ((core)->venus_ver.major == vmajor &&
>> +		(core)->venus_ver.minor == vminor &&
>> +		(core)->venus_ver.rev <= vrev);
>> +}
>>   #endif
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> index df96db3..07ac0fc 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>>   }
>>   
>>   static void
>> -sys_get_prop_image_version(struct device *dev,
>> +sys_get_prop_image_version(struct venus_core *core,
>>   			   struct hfi_msg_sys_property_info_pkt *pkt)
>>   {
>> +	struct device *dev = core->dev;
>>   	u8 *smem_tbl_ptr;
>>   	u8 *img_ver;
>>   	int req_bytes;
>> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>>   		return;
>>   
>>   	img_ver = pkt->data;
>> +	if (IS_V4(core))
>> +		sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
>> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>> +	else if (IS_V6(core))
>> +		sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
>> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>>   
>>   	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>>   
>> @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>>   
>>   	switch (pkt->property) {
>>   	case HFI_PROPERTY_SYS_IMAGE_VERSION:
>> -		sys_get_prop_image_version(dev, pkt);
>> +		sys_get_prop_image_version(core, pkt);
>>   		break;
>>   	default:
>>   		dev_dbg(dev, VDBGL "unknown property data\n");
