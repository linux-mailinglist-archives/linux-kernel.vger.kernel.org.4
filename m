Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68756F68AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjEDJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEDJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:49:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516DCF;
        Thu,  4 May 2023 02:49:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34497SP8013584;
        Thu, 4 May 2023 09:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UQPUlmPmNanPg8OKy+iGNIWO7846v755QPw/YyYIMJ4=;
 b=f8pzcjSBmHTO0eFBnbpwKFI13fX9For8Zf/qjw1hPMAn7z6gPB0MLRnsYvTWIBbNQ7jR
 TqfULSlk+uFz/BLgKFy2lqSGT1/P5IA43o3NpHVyENsNAQOaNmqb8FHn4S6Qmno14w2f
 /vnDUH+PkG5BN46tzMwA+cidUELdZ17C76T4p9Anxscq62hJN5MKtz2x4JwkFJjd/y1z
 lv9rNTa/63alH262KZwkIpabzvCGFkdv40pXrQGz+qDnVS5ZRz26aif9lqTawcAOm+EO
 Ghym2I3rpblP4t37+tTbUqdWWpHBZ6pDHp6pI1xs+DGAT0UN+3IP4AuuuyFZZMCQa81h Ig== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc2aj0wch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:49:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3449ndif030467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 09:49:39 GMT
Received: from [10.50.19.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 02:49:35 -0700
Message-ID: <2a8e6199-179d-ac66-5ce6-d014d5534819@quicinc.com>
Date:   Thu, 4 May 2023 15:19:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] venus: add firmware version based check
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Viswanath Boma" <quic_vboma@quicinc.com>
References: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
 <1683193152-5808-2-git-send-email-quic_dikshita@quicinc.com>
 <966416d1-3ddd-26ba-63ec-2323062dfda5@linaro.org>
Content-Language: en-US
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <966416d1-3ddd-26ba-63ec-2323062dfda5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 23Ve5pRgRD6nFpppVn3y-fN_GdqJRiCu
X-Proofpoint-GUID: 23Ve5pRgRD6nFpppVn3y-fN_GdqJRiCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040079
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2023 3:12 PM, Konrad Dybcio wrote:
>
> On 4.05.2023 11:39, Dikshita Agarwal wrote:
>> Add firmware version based checks to enable/disable
>> features for different SOCs.
>>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_msgs.c | 27 +++++++++++++++++++++++++--
>>   2 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2..2f2176f 100644
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
>> +static inline bool
>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +	return ((core)->venus_ver.major == vmajor &&
>> +		(core)->venus_ver.minor == vminor &&
>> +		(core)->venus_ver.rev >= vrev);
>> +}
>> +
>> +static inline bool
>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
>> +{
>> +	return ((core)->venus_ver.major == vmajor &&
>> +		(core)->venus_ver.minor == vminor &&
>> +		(core)->venus_ver.rev <= vrev);
>> +}
>>   #endif
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> index df96db3..4854863 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> @@ -248,13 +248,16 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
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
>>   	size_t smem_blk_sz;
>> +	int ret;
>> +	u8 *ver_str;
>>   
>>   	req_bytes = pkt->hdr.size - sizeof(*pkt);
>>   
>> @@ -263,6 +266,26 @@ sys_get_prop_image_version(struct device *dev,
>>   		return;
>>   
>>   	img_ver = pkt->data;
>> +	if (IS_V6(core) && core->res->num_vpp_pipes == 1) {
>> +		ret = sscanf(img_ver, "14:video-firmware.%u.%u-%u",
>> +			     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> This is still not perfect, 8350 has 4 vpp pipes and its firmware is
> also denominated with "video-firmware".. perhaps we can just try
> each variant until we reach ret == 3?

sc7280 onward firmware have image string as "video-firmware".

Support for 8350 is not yet added in venus driver, any required change 
for the same can be done

when support will be added for the same.

>> +		if (ret != 2) {
> 3?

this image version string doesn't return valid revision hence checking 
against 2 (major and minor versions)

Thanks,

Dikshita

>
> Konrad
>> +			dev_dbg(dev, VDBGL "error reading F/W version\n");
>> +			return;
>> +		}
>> +	} else {
>> +		if (IS_V6(core))
>> +			ver_str = "14:VIDEO.VPU.%u.%u-%u";
>> +		else
>> +			ver_str = "14:VIDEO.VE.%u.%u-%u";
>> +
>> +		ret = sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u",
>> +			     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>> +		if (ret != 3) {
>> +			dev_dbg(dev, VDBGL "error reading F/W version\n");
>> +			return;
>> +		}
>> +	}
>>   
>>   	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>>   
>> @@ -286,7 +309,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>>   
>>   	switch (pkt->property) {
>>   	case HFI_PROPERTY_SYS_IMAGE_VERSION:
>> -		sys_get_prop_image_version(dev, pkt);
>> +		sys_get_prop_image_version(core, pkt);
>>   		break;
>>   	default:
>>   		dev_dbg(dev, VDBGL "unknown property data\n");
