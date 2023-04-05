Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA36D76B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbjDEIUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbjDEIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:20:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5611BDA;
        Wed,  5 Apr 2023 01:20:48 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3356maXP005583;
        Wed, 5 Apr 2023 08:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DpWRcHTut3Eqr+N7BM7vRf6RA0fhHVhn6lBJCf9tJck=;
 b=Fdr3Qt3LTRkTOnLIYbb8+nPtxkY13+R63TaMB7CCKE5Td0rt+G1Xx7TCifqYaJnPcn+m
 odO43hl7H9quw3xd9ftT+C0HyCe2SX3+1ZmgrYlCx7uXN6qyoADfuEVx5wmdFAuWppTb
 TvIbSPtIKrDdT7wTsKm9AsT88M8uoM1fsfFpPu3h+ORFAmFJ1DV/NC3tJ+QcHsKkSHTA
 PzEeIESMIuKxpghO3zBkjXXBC6o56Pt3xhxmugc8G1BksdmRYy2AjyYNaUwzVAGFf0Gz
 S3XkuNTuA8MhySSQphesM5oGa45NpBzrazfEzmAGLjWo6AQokNf4iHlIhZLQmtIBZ/2m 7Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnbt2bcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 08:20:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3358Kh64006261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 08:20:43 GMT
Received: from [10.50.42.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 5 Apr 2023
 01:20:39 -0700
Message-ID: <ccecf11f-e3ec-d328-173b-ebba4a4bb6c4@quicinc.com>
Date:   Wed, 5 Apr 2023 13:50:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] venus: add firmware version based check
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Viswanath Boma" <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-2-git-send-email-quic_dikshita@quicinc.com>
 <7511d03b-5b88-d1c2-d756-4781b12d5296@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <7511d03b-5b88-d1c2-d756-4781b12d5296@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CNq3D5AqcXAQPdYp1vNsXoG3ACDz-f2j
X-Proofpoint-GUID: CNq3D5AqcXAQPdYp1vNsXoG3ACDz-f2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_04,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050076
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2023 11:48 PM, Konrad Dybcio wrote:
>
> On 4.04.2023 08:17, Dikshita Agarwal wrote:
>> Add firmware version based checks to enable/disable
>> features for different SOCs.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h     | 18 ++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>>   2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2..ee8b70a 100644
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
>> @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>>   	return NULL;
>>   }
>>   
>> +static inline int
>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> So this is trying to find the revision of a MAJ.MIN firmware release..
>
> Is the MAJ.MIN part supposed to stay constant for a specific version of
> a Venus block (say idk, IRIS2) and only the VREV part is supposed to
> be updated with both feature and security developments?

Yes Major and minor numbers will be constant for a SPC and only the

revision will be updated with any new release.

>> +{
>> +	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
>> +			vminor && (core)->venus_ver.rev >= vrev);
> return ((core)->venus_ver.major == vmajor &&
> 	(core)->venus_ver.minor == vminor &&
> 	(core)->venus_ver.rev >= vrev);
>
> for readability
Sure, will take care of this in next version.
> Konrad
>> +}
>> +
>> +static inline int
>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
>> +			vminor && (core)->venus_ver.rev <= vrev);
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
