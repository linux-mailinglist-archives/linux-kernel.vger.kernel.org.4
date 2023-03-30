Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC326D026F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjC3LDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjC3LDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:03:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179946A71;
        Thu, 30 Mar 2023 04:03:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UAs7PV015381;
        Thu, 30 Mar 2023 11:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vul7olHZLizn9mFsl0sHisxIJ3GgAM9Zuxm0tboBoGo=;
 b=WNZ1qDQJZRPkz5ySK+JTGPRwNSupM46dkaoWfgRB1FJYrVZtbPS9eGz/8uQA+uRQfVgu
 0SnUuTCoirpNqbn+SWWxXWbxEpn19N0Tv8YtWwCNunt1KP9Tmdsb9EWQluV3S2X3riog
 HNZgS64vyFRaRHGrs07Ba9MfUYJOhNQYp+nz4No7g/narfEk1UbEpgpYbqFkjz0gSZxz
 M6SLj8pytZuXZ0IEpLVmNw6nD5wKAfprQ4Dt+1IlPPgVx2wxPitbgPuAqHy6wpio5JgO
 DxZrVwEBoMuhOY74AWLfp6/py/A0vG0nGkKOIb872La+KFjJE5nkOT4rlUgzcP4IaxhP IQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn51ygpg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 11:03:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32UB31VK032743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 11:03:01 GMT
Received: from [10.216.26.177] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 30 Mar
 2023 04:02:55 -0700
Message-ID: <0e85caec-f6ec-fbd4-1815-8df9769bffcf@quicinc.com>
Date:   Thu, 30 Mar 2023 16:32:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/18] media: venus: Introduce VPU version distinction
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Vikash Garodia" <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-2-58c2c88384e9@linaro.org>
 <cf2eee18-a6c9-2a9b-84fa-3e2351c413e8@quicinc.com>
 <f8833364-854e-3f04-db7a-82a29682b0c9@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <f8833364-854e-3f04-db7a-82a29682b0c9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mX4hA1DBL7Tow3_Bk7jTu7ZtGJXwdTL7
X-Proofpoint-GUID: mX4hA1DBL7Tow3_Bk7jTu7ZtGJXwdTL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_06,2023-03-30_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300090
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/2023 5:07 PM, Konrad Dybcio wrote:
>
> On 2.03.2023 08:12, Dikshita Agarwal wrote:
>> On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
>>> The Video Processing Unit hardware version is the differentiator,
>>> based on which we should decide which code paths to take in hw
>>> init. Up until now, we've relied on HFI versions, but that was
>>> just a happy accident between recent SoCs. Add a field in the
>>> res struct and add correlated definitions that will be used to
>>> account for the aforementioned differences.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>>> index 32551c2602a9..4b785205c5b1 100644
>>> --- a/drivers/media/platform/qcom/venus/core.h
>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>> @@ -48,6 +48,14 @@ struct bw_tbl {
>>>        u32 peak_10bit;
>>>    };
>>>    +enum vpu_version {
>>> +    VPU_VERSION_AR50, /* VPU4 */
>>> +    VPU_VERSION_AR50_LITE, /* VPU4.4 */
>>> +    VPU_VERSION_IRIS1, /* VPU5 */

There was Venus3X, followed by a different generation of video hardware. 
Driver just extended the versions for next generation incrementally.

Existing versions in driver are not the VPU versions, so we can drop 
them from comments.

>>> +    VPU_VERSION_IRIS2,
>>> +    VPU_VERSION_IRIS2_1,
>>> +};
>>> +
>>>    struct venus_resources {
>>>        u64 dma_mask;
>>>        const struct freq_tbl *freq_tbl;
>>> @@ -71,6 +79,7 @@ struct venus_resources {
>>>        const char * const resets[VIDC_RESETS_NUM_MAX];
>>>        unsigned int resets_num;
>>>        enum hfi_version hfi_version;
>>> +    enum vpu_version vpu_version;
>>>        u8 num_vpp_pipes;
>>>        u32 max_load;
>>>        unsigned int vmem_id;
>>> @@ -473,6 +482,12 @@ struct venus_inst {
>>>    #define IS_V4(core)    ((core)->res->hfi_version == HFI_VERSION_4XX)
>>>    #define IS_V6(core)    ((core)->res->hfi_version == HFI_VERSION_6XX)
>>>    +#define IS_AR50(core)        ((core)->res->vpu_version == VPU_VERSION_AR50)
>>> +#define IS_AR50_LITE(core)    ((core)->res->vpu_version == VPU_VERSION_AR50_LITE)
>>> +#define IS_IRIS1(core)        ((core)->res->vpu_version == VPU_VERSION_IRIS1)
>>> +#define IS_IRIS2(core)        ((core)->res->vpu_version == VPU_VERSION_IRIS2)
>>> +#define IS_IRIS2_1(core)    ((core)->res->vpu_version == VPU_VERSION_IRIS2_1)
>>> +
>>>    #define ctrl_to_inst(ctrl)    \
>>>        container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
>>>    
>> Adding VPU version check seems a good idea to me. Can we remove HFI Version checks now?
> If all implementations using VPU x.y *always* use the
> same HFI generation for given x, y, we could.

HFIs generally does not change, so we can be sure that they would always 
use the same HFI.

We might add a new interface (HFI) for a feature requirement, but always 
support the existing ones.

>
> That said, I think keeping it as-is would be convenient
> from the maintainability standpoint if nothing else.. For
> example functions that only appear in ancient msm-3.10
> releases can be easily guarded with IS_V1 or what have you
> without having to dig up all n VPU revisions.
>
> Konrad
