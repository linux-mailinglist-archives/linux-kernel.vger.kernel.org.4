Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF18B750304
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjGLJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:25:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0CFB;
        Wed, 12 Jul 2023 02:25:46 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C91E9k014518;
        Wed, 12 Jul 2023 09:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J/Zh7uenU8KbczbDBlAdiCTIASLzTQsQdjx5cJkR2uk=;
 b=AFsiqYgyANsfgdwojetx+ezgtrck3lw5dCxCy9Uo31uvpadlDZ1HvWd/v6BcWNOPLVpN
 82o4NiVOdG6H8ApRfWlnbIDg5nuo2Bwboii8wdOEDnr9JQvWB3aAltnDDeQZBZviF+Tp
 /xz7lhx8Ks93WleN72APsG05h2tLAv3I9DTk6r7n2jyTX6dx5SztOhYcRUaF5QaQcwWb
 TtScqrgFpaVDbfcOUHKALWtY3pLjBk/wEXznbr/XqR02CCq0MXvuxdaBtXSO45LdUAfR
 eZnReFEIs6ph7pTJDPotwefsy7lxnJnGLvqB/hwyOWyQ9W3KqGsOvqgZeSpBooPKDS35 JA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsfeq11ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 09:25:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C9PgBd000630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 09:25:42 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 02:25:39 -0700
Message-ID: <ecbdfce8-0647-1622-b6e6-cb04a15e9923@quicinc.com>
Date:   Wed, 12 Jul 2023 14:55:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <6746ceb6-dac4-ee8e-411f-8de0ff8f12e0@linaro.org>
 <77991119-a200-fbfe-5dba-580a0b0d3228@quicinc.com>
 <af0e1e5f-c284-a33a-7626-f143b1a4b30e@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <af0e1e5f-c284-a33a-7626-f143b1a4b30e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bUy5PaGvs-7-j97CfMkzsgyCkfD3ttyJ
X-Proofpoint-GUID: bUy5PaGvs-7-j97CfMkzsgyCkfD3ttyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=654 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2023 2:52 PM, Konrad Dybcio wrote:
> On 12.07.2023 10:24, Rohit Agarwal wrote:
>> On 7/11/2023 8:41 PM, Dmitry Baryshkov wrote:
>>> On 11/07/2023 08:42, Rohit Agarwal wrote:
>>>> Add Generic RPMh Power Domain indexes that can be used
>>>> for all the Qualcomm SoC henceforth.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 30 insertions(+)
>>>>    create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>>>
>>>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
>>>> new file mode 100644
>>>> index 0000000..4da2e04
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>>>> @@ -0,0 +1,30 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>>> +
>>>> +/* Generic RPMH Power Domain Indexes */
>>>> +#define CX               0
>>>> +#define MX               1
>>>> +#define CX_AO            2
>>>> +#define MX_AO            3
>>>> +#define GFX              4
>>>> +#define MSS              5
>>>> +#define EBI              6
>>>> +#define LCX              7
>>>> +#define LMX              8
>>>> +#define MMCX             9
>>>> +#define MMCX_AO          10
>>>> +#define MXC              11
>>>> +#define MXC_AO           12
>>>> +#define NSP              13
>>>> +#define NSP0             14
>>>> +#define NSP1             15
>>>> +#define QPHY             16
>>>> +#define DDR              17
>>>> +#define XO               18
>>> I went through the existing defines. If we adopt the order of defines for sm8550, we can migrate that platform and all of sm8[234]50 without breaking ABI. This would be a minor gain, but still something.
>>>
>> Actually, I added them in the sequence based on the frequency with which they occur in the driver, so that there are less NULL entries created for any target additions. Shouldnt we keep it this way and ignore for previous targets then?
> Don't bother yourself with this, we've already dragged you through
> some bindings mess ;)
>
> Dmitry just noticed that a happy coincidence occured and we could
> swap out SM8[234]_50 indices with these ones and they would still
> match. It'd be a separate patch though.
Yes sure. Will make a separate patch updating entries for these targets.

Thanks,
Rohit.
> Konrad
>> Thanks,
>> Rohit.
>>>> +
>>>> +#endif
