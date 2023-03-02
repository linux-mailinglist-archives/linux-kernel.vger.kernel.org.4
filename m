Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC76B6A819A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCBLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCBLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:55:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFD24110;
        Thu,  2 Mar 2023 03:55:18 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229Yv2i007194;
        Thu, 2 Mar 2023 11:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0WbtI1igmcDLDsoR0cc1cMw0tkT52vpGFE1SLMFU8Mg=;
 b=m9bhzMU0aFHdGLst1U2bx5lIwVHpqVLRtrY6e9BdyFI04C1oIsRewLvJepRYTjSWFZ16
 eim6ce9CK5VxrtMuXBtT8jgoLBgDby6WBbdztsV1dnWBkN53OaNLKpvJKi2R8PPT5u4s
 8HwWRcwRWRHtz5g0jKqmfuaJe+oNOD+a1vyEQCf62rn2ewtO7MWGWMResUNldBgIaVuh
 cdHfBEgd8NX7Kre7ZMzM6E3nB1R2EeR8T3TMayW8uRwlOkZhAILupVVJavFPhqT3tg4o
 Vn1t9WxqAQRBaak9BiWhYYz75+GbSrePF4Lk71V7CXJCFmoSDOoFLlA+f/A5xaLfOfrU vA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p25jwke70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 11:54:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322Bseh3027507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 11:54:40 GMT
Received: from [10.50.55.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 03:54:34 -0800
Message-ID: <1d9515e5-c1e7-13c9-0f80-fb4b249ccb0e@quicinc.com>
Date:   Thu, 2 Mar 2023 17:24:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Vikash Garodia" <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
 <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
 <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
 <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
 <b7f0c568-72b7-3342-decc-784cd5f68b1a@linaro.org>
 <1091d8b4-3dd3-427b-2fcb-c3e0d32b0a3b@linaro.org>
 <aa8db9a1-ac11-acbe-1a05-b60c39989bc1@nexus-software.ie>
 <28b0eed5-6e80-e424-70bb-ba984fdbc1ac@quicinc.com>
 <e95ce32e-60cb-f892-804f-686472657376@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <e95ce32e-60cb-f892-804f-686472657376@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Sg-ZW8z3v8iA9zC8moD95oMZsB5auBL-
X-Proofpoint-ORIG-GUID: Sg-ZW8z3v8iA9zC8moD95oMZsB5auBL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020104
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/2023 5:03 PM, Konrad Dybcio wrote:
>
> On 2.03.2023 07:39, Dikshita Agarwal wrote:
>> On 2/28/2023 10:23 PM, Bryan O'Donoghue wrote:
>>> On 28/02/2023 15:41, Konrad Dybcio wrote:
>>>>> Can you test it and make sure ?
>>>> As I mentioned in the cover letter, 8250 still seems to work with this
>>>> patchset. I have no idea how one would go about validating the
>>>> functionality enabled through this call.
>>> We offlined about this.
>>>
>>> I think it is correct to say you don't have access to a display to test this on sm8250.
>>>
>>> I do so, I will try this out for you, though I'll wait for your V2 for this series.
>>>
>>> ---
>>> bod
>> Hi Konrad,
>>
>> I understand from your commit text, setting this indicator for AR50L is causing issue with suspend.
>>
>> Ideally it shouldn't cause any such issue. I checked with FW team and got to know that this property is not supported on AR50LT so if you set it there should be some property not supported error.
>>
>> In my opinion it would be good to replace these versions checks with VPU version check you have introduced in your other patch and keep this setting for current targets and not set wherever not needed eg AR50LT.
> Okay, I have two questions then:
>
> 1. Can the firmware team confirm it shouldn't crash on a fw tag
>     that's close to VIDEO.VE.6.0-00042-PROD-1?
>
> 2. Are there any other SoCs that SYS_IDLE is not supported on?
>     It hasn't been sent to the hardware by the vidc driver for
>     any SoC using the downstream vidc (NOT the legacy vidc_3x)
>     driver starting with msm-4.14, AFAICS.. check out this link:
>
> https://github.com/sonyxperiadev/kernel/commit/8889a7d26943e96eae2f318f87b15efa4b907f28
>
> Konrad

Yes, that's correct, I have already confirmed from FW team that this 
idle check is always enabled in FW now.

so driver doesn't have to set itexplicitly, that's why it works for you 
on 8250 I believe. So removing this setting seems fine.

My only concern is that why we see a crash when setting it on AR50LT.

Thanks,

Dikshita


>> Thanks,
>>
>> Dikshita
>>
