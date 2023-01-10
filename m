Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18342664F36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjAJW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjAJW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:56:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72E6338D;
        Tue, 10 Jan 2023 14:55:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AMqhbI021237;
        Tue, 10 Jan 2023 22:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FnslzAltcK2Vf4x7yLy3vGWrYsR9oG+TmGbt1RNiTbA=;
 b=dDvCjD/0jz4NdH1/+fs0mlqd1EWGJtv9dGoEMl4Mv/kQqLFVX8h7WfNEDghYudNNDmD8
 gQpeVHO8jkIwE0NugYZwLGnIgT04I9Jb2XF+AKUZBML5K2IZmULc/o8pjAc3GrP+c9lF
 fiLEGUJMs81yS7PsfkgH7ekKHI+jhF/bbWfQlvh+8L69JxXunV8flEpLWh1eHwsaz8ry
 nnZ1R38n1uA55JE41oF4pmJCSSWy9h/E+cYfdbFVtpaSwKxMDUb5pO/3ScyIuLUhIX2N
 bUTPugpT0EFXJumEMdBEsd9axhvYdfg7gqv3pV6qtEH5+EVcGjPdjCi40GF0/78gJu+6 fA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1dbg8gt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 22:55:10 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AMt9bK020238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 22:55:09 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 14:55:09 -0800
Message-ID: <560526fe-cd7b-575a-96c9-fe4f8d349e89@quicinc.com>
Date:   Tue, 10 Jan 2023 14:55:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 04/28] arm64: smccc: Include alternative-macros.h
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-5-quic_eberman@quicinc.com>
 <f6bf5577-9a3a-e949-62b8-53f5fcdd3fa4@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <f6bf5577-9a3a-e949-62b8-53f5fcdd3fa4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qyhHMAiFyocYQdMtuahXfi9enDBktio1
X-Proofpoint-ORIG-GUID: qyhHMAiFyocYQdMtuahXfi9enDBktio1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=843 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> Fix build error when CONFIG_ARM64_SVE is selected and
>> asm/alternative-macros.h wasn't implicitly included by another header.
>>
>> In file included from arch/arm64/gunyah/gunyah_hypercall.c:6:
>> arch/arm64/gunyah/gunyah_hypercall.c: In function 
>> `gh_hypercall_msgq_send':
>> ./include/linux/arm-smccc.h:387:25: error: expected string literal 
>> before `ALTERNATIVE'
>>    387 | #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl 
>> __arm_smccc_sve_check \n", \
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> If this is correct (and I presume it is), I think this patch should
> be posted separate from (and before) the rest of the series.
> 

Ack, will send this separately.

>                      -Alex
> 
>> ---
>>   include/linux/arm-smccc.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
>> index 220c8c60e021..6a627cdbbdec 100644
>> --- a/include/linux/arm-smccc.h
>> +++ b/include/linux/arm-smccc.h
>> @@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, 
>> unsigned long a1,
>>   /* nVHE hypervisor doesn't have a current thread so needs separate 
>> checks */
>>   #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
>> +#include <asm/alternative-macros.h>
>>   #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl 
>> __arm_smccc_sve_check \n", \
>>                       ARM64_SVE)
> 
