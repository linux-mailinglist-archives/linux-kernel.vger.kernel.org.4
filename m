Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB456D73E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjDEFrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDEFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:47:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC0170C;
        Tue,  4 Apr 2023 22:47:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3351tnGo007823;
        Wed, 5 Apr 2023 05:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TLKJHdc3VccYlSywWH1a0S5oQcjXUBe78mOuAGfTabU=;
 b=JEjTogwnXtJ40GUDihd0ZlEiqh3TZWbaqlzlDz1eMpifeb6sZPuXrNtoJ7ZPVTKFcXx+
 8T6ej6o1dQL9OCY5ry8JBRbh0NviAmwWdbHXduCOY7rJ2xKg1JWcen3GBhGM3hWDkfD5
 8XRdoxk+e4nwn/4peRobTGQkf+4Fwie+a3E/3s/tupZjFJIKfsIpcj+ZlQn4H5avtVEq
 of9czsSBx9spY60uNYlW2lzr0sFopUFIOEXyByGG16A8S6VewFhTbGZAcgZytyV9RVxI
 eV5q+EejqZ8zvrzjVlRXU201Shi/ZWuykJBFvD5DyEPz5rF0Zq4DwSEThl+cQS2v9i9J SA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prpg21sfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 05:47:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3355lAW4006120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 05:47:10 GMT
Received: from [10.50.42.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 22:47:06 -0700
Message-ID: <ac3faf07-7974-fb26-2d58-0ddc014fce66@quicinc.com>
Date:   Wed, 5 Apr 2023 11:16:41 +0530
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
 <8f0404d0-659d-0855-15dd-8a45f6fd1871@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <8f0404d0-659d-0855-15dd-8a45f6fd1871@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RKpY77CEjftV9kZosu9ZKOVMtam58ZM9
X-Proofpoint-ORIG-GUID: RKpY77CEjftV9kZosu9ZKOVMtam58ZM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050053
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2023 11:52 PM, Konrad Dybcio wrote:
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
> Does it never have to be turned off? Or does it happen automatically
> at session closure?
>
> Konrad

Any property set to FW is applied for entire video session and it 
doesn't need to change so

there is no need to turn it off or unset it.

Thanks,

Dikshita

>> +
>>   	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>>   	conceal = ctr->conceal_color & 0xffff;
>>   	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
