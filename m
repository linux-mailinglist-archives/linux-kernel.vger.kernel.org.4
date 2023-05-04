Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B06F6A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEDLqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjEDLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:46:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B75B5;
        Thu,  4 May 2023 04:46:10 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34498m3d032692;
        Thu, 4 May 2023 11:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Nf4c9Og72daQDWgkpR5A9lhPav7w/eUDPVAWmRm8YkY=;
 b=atq2eSOuYHZfxX2xwBzH704U1gapAGkCv74q+NnadB9a6lqeGBaHRaqkt+tWjSQdvm5O
 YIHjOnjA9Y/mI2rgPY3vTDNklO556kpfHMyTCQCVV502wIOFBqX1NquV+ROv1kzbpjUP
 3K9yCdnGQGUEG+ynpgJlYTR2VVH8vPNgvvl5VY2WYMTrniYachbDUleJkwxDQ3YRV4k0
 EUPSTm62UE2yziYzeFJ/mITJo36r/IFAg2664Z2xWxH7BjJUc4LrLBJKezD/nYDNLqjI
 BwGl2n3nHFAl+WB7Xoq9f1MSYe30n95cw27ssPyJsKEq39W/zgJvIy0aDfIJj+/DoroI Yg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbvghhudw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 11:45:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344Bjg23030930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 11:45:42 GMT
Received: from [10.216.46.158] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 04:45:35 -0700
Message-ID: <4325c2e7-8ca1-7e45-db14-5ba8bc83f5d7@quicinc.com>
Date:   Thu, 4 May 2023 17:15:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 07/18] arm64: defconfig: Enable Qualcomm minidump
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-8-git-send-email-quic_mojha@quicinc.com>
 <ad9915b2-56ff-3f95-7c92-fae597d6ed43@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ad9915b2-56ff-3f95-7c92-fae597d6ed43@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GGvA8TmoKC62bpzlSbUqBgM5tdkQqwzE
X-Proofpoint-GUID: GGvA8TmoKC62bpzlSbUqBgM5tdkQqwzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_07,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040096
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 4:53 PM, Krzysztof Kozlowski wrote:
> On 03/05/2023 19:02, Mukesh Ojha wrote:
>> Previous patches add the Qualcomm minidump driver support, so
>> lets enable minidump config so that it can be used by kernel
>> clients.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> This patchset is split too much. Defconfig change is one change. Not two
> or three.
> 
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index a24609e..831c942 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1250,6 +1250,7 @@ CONFIG_QCOM_STATS=m
>>   CONFIG_QCOM_WCNSS_CTRL=m
>>   CONFIG_QCOM_APR=m
>>   CONFIG_QCOM_ICC_BWMON=m
>> +CONFIG_QCOM_MINIDUMP=y
> 
> This must be a module.

Why do you think this should be a module ?

Is it because, it is lying here among others '=m' ?

Or you have some other reasoning ? like it is for qcom specific
soc and can not be used outside ? but that is not true for
all configs mentioned here.

The reason behind making it as '=y' was, to collect information from 
core kernel data structure as well as the information like percpu data, 
run queue, irq stat kind of information on kernel crash on a target 
running some perf configuration(android phone).

-- Mukesh

> 
> Best regards,
> Krzysztof
> 
