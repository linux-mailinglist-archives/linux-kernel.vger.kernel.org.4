Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3901A6F7F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjEEJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEEJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:03:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185218860;
        Fri,  5 May 2023 02:03:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3457inYD020612;
        Fri, 5 May 2023 09:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=74mGx6giKbWdRN8nfSAqZDCC8vlmrxk/WzeQd3WiVco=;
 b=iCqmLfUBqWMyfXuU/cIlTTOW8Qe2SEc14o9uXxgme7eHtRZRBqTVP3St1ZgHtlR6Shkt
 MWlhk+/mBHTNTJZI22Nt/KeKHuPdoUYiqnbPmwyHJcVPOZeo8apFdyOnwowRvHBn1lN+
 Wgz1RCjQHCiIVbwnkzBDP1EVtiynFq1Wps6eBH1kX0Z2Q3xFV13T5oV5isi5RR+iOHk/
 vMsnB8ZuHEL3O3aRVx31LS8/oVEpmdx8ypIgsHz4umPyvEVVA8KknpGfd7Cto9aPkLgT
 t1WSyTe5WHhkGrR3DzdPOz6LwCqU6r4z2wIXi3iWyENfb3kvIC8TgzeFI5a3GSUIatyT bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcmm393p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 09:03:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34593XTU018315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 09:03:33 GMT
Received: from [10.50.39.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 02:03:30 -0700
Message-ID: <b5fa8e0a-1663-e386-cffe-e7feb16d8733@quicinc.com>
Date:   Fri, 5 May 2023 14:33:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] venus: return P010 as preferred format for 10 bit
 decode
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <1683196599-3730-5-git-send-email-quic_dikshita@quicinc.com>
 <02f5d449-a64b-8f5e-6b72-2fdf8d9bafbe@linaro.org>
Content-Language: en-US
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <02f5d449-a64b-8f5e-6b72-2fdf8d9bafbe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x5EAaqSF3P65jWAk0qpoxT0PiX3AGHPR
X-Proofpoint-GUID: x5EAaqSF3P65jWAk0qpoxT0PiX3AGHPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050074
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2023 10:50 PM, Konrad Dybcio wrote:
>
> On 4.05.2023 12:36, Dikshita Agarwal wrote:
>> If bit depth is detected as 10 bit by firmware, return
>> P010 as preferred decoder format to the client.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/venus/vdec.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index 69f7f6e..ed11dc2 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -1468,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
>>   	inst->out_width = ev_data->width;
>>   	inst->out_height = ev_data->height;
>>   
>> -	if (inst->bit_depth != ev_data->bit_depth)
>> +	if (inst->bit_depth != ev_data->bit_depth) {
>>   		inst->bit_depth = ev_data->bit_depth;
>> +		if (inst->bit_depth == VIDC_BITDEPTH_10)
>> +			inst->fmt_cap = &vdec_formats[3];
>> +		else
>> +			inst->fmt_cap = &vdec_formats[0];
> This doesn't scale and is very error-prone, please enumerate the
> entries and assign it using the enumerator, like:
>
> enum {
> 	VDEC_FORMAT_FOO,
> 	...
> };
>
> ... vdec_formats[] = {
> 	[VDEC_FORMAT_FOO] = { foo, bar, baz }
> }
>
> Konrad

I agree, this can be improved but I would prefer making that change as 
separate patch.

As this is not only related to HDR 10 decoding, there are other places 
in the code which will require similar change.

Thanks,

Dikshita

>> +	}
>>   
>>   	if (inst->pic_struct != ev_data->pic_struct)
>>   		inst->pic_struct = ev_data->pic_struct;
