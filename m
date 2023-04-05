Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9862B6D76BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjDEIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjDEIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:21:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942161BDF;
        Wed,  5 Apr 2023 01:21:51 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3357a11k016980;
        Wed, 5 Apr 2023 08:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Znd2THus0gV/rskbpX70e3SYsL/BTOeudvUuRxaShXA=;
 b=USWhFhefbcP/4jR2ingU89qkOqsHRMhva57+R0213v4zC1+mfaF+HPKhvmqfeU62AMnp
 cbsc6funpJMtmBCJrrB0kQl4M1uDwrl7RuOtAKwyIfKGvfEzZcj4EDq+nhBT9pTXJRS7
 u0A+i3dqrIbDO0Ct4DfyKL3qDQJ8YdXfpgLdOsFX3VPy6uIgyCnfWu/bmothqCaraafA
 9DxLIdGNoJLZI75no7OtnadmGcxALC/XD+QINeiHukSawXcp/TZj9FC2XLPZ1rOXZx5o
 boMUNzvoYyUV7ybubwtZeVMct1xykkCOpHASUkCiYGBTTSdHGl7RNmfd1acbikQxpi+x mg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prwc78xyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 08:21:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3358LlhS002450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 08:21:47 GMT
Received: from [10.50.42.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 5 Apr 2023
 01:21:43 -0700
Message-ID: <3b3e4cba-645a-f5b1-5efa-fb5932c78563@quicinc.com>
Date:   Wed, 5 Apr 2023 13:51:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] venus: enable sufficient sequence change support for
 vp9
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Viswanath Boma" <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-3-git-send-email-quic_dikshita@quicinc.com>
 <2c3a823c-4620-1557-39ff-1db169aeb7aa@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <2c3a823c-4620-1557-39ff-1db169aeb7aa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9SfX_oYDkWrTn4gB4s0_Uwj-Jp3ChKNX
X-Proofpoint-ORIG-GUID: 9SfX_oYDkWrTn4gB4s0_Uwj-Jp3ChKNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_04,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050076
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2023 12:35 AM, Konrad Dybcio wrote:
>
> On 4.04.2023 08:17, Dikshita Agarwal wrote:
>> VP9 supports resolution change at interframe.
>> Currenlty, if sequence change is detected at interframe and
>> resources are sufficient, sequence change event is not raised
>> by firmware to driver until the next keyframe.
>> This change add the HFI to notify the sequence change in this
>> case to driver.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_cmds.c   | 1 +
>>   drivers/media/platform/qcom/venus/hfi_helper.h | 2 ++
>>   drivers/media/platform/qcom/venus/vdec.c       | 8 ++++++++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> index 930b743..e2539b5 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>>   		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
>>   		break;
>>   	}
>> +	case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
>>   	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
>>   		struct hfi_enable *in = pdata;
>>   		struct hfi_enable *en = prop_data;
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
>> index d2d6719..20516b4 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>> @@ -469,6 +469,8 @@
>>   #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
>>   #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
>>   #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
>> +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
>> +								0x0100300b
> Also, nit: this one has a leading zero, whereas other properties don't
>
> Konrad

Sure, Will fix in next version.

Thanks,

Dikshita

>>   
>>   /*
>>    * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index 4ceaba3..f0394b9 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -671,6 +671,14 @@ static int vdec_set_properties(struct venus_inst *inst)
>>   			return ret;
>>   	}
>>   
>> +	/* Enabling sufficient sequence change support for VP9 */
>> +	if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
>> +		ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
>> +		ret = hfi_session_set_property(inst, ptype, &en);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>>   	conceal = ctr->conceal_color & 0xffff;
>>   	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
