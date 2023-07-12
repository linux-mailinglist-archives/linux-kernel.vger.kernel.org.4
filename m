Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D6750184
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjGLI3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjGLI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:29:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16252688;
        Wed, 12 Jul 2023 01:24:14 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C70G38001653;
        Wed, 12 Jul 2023 08:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ST3kHIjWR2FCKglmIIjkBGh/Mzwd05a/izvjUr8jmXI=;
 b=QxV6zU+Xhryu+LiKhay0sN8I1mmgVTpGJhIP3A4B407IDyRNaH9LWpCRMawfW05ZtumI
 5kBwQsV52ZAwCOd+SSV2tLNRmvWorEdaeA6HozKlQsN4ulWMnma/+F7KijvSFH2sOp3W
 LqijGazSnCl9JLmXZxJlh9rPJJ6jYUqAHhm6WC4HntNg8P/dmHIKa88YvfFtzpxBPzhx
 Q+XWs78ZB1tf2TP0bCsLuTurmPZ+DrJHexVKO3LQOCGQ8DE+6zfhEcHVffhvqY6uX2uu
 zzQe63f8b0Q567zuDCk38IS6sXw/L1L+DFUq4wUa3Ev2xq0LpG0sR+czzOWvBCJPp914 VA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf4s8ywr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:24:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C8OBxc010792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:24:11 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 01:24:07 -0700
Message-ID: <77991119-a200-fbfe-5dba-580a0b0d3228@quicinc.com>
Date:   Wed, 12 Jul 2023 13:54:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <6746ceb6-dac4-ee8e-411f-8de0ff8f12e0@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <6746ceb6-dac4-ee8e-411f-8de0ff8f12e0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QcBSYRNAae83QpAs7pN_PqOvb4mEVBsU
X-Proofpoint-ORIG-GUID: QcBSYRNAae83QpAs7pN_PqOvb4mEVBsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=686 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120073
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 8:41 PM, Dmitry Baryshkov wrote:
> On 11/07/2023 08:42, Rohit Agarwal wrote:
>> Add Generic RPMh Power Domain indexes that can be used
>> for all the Qualcomm SoC henceforth.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   include/dt-bindings/power/qcom-rpmhpd.h | 30 
>> ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>
>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h 
>> b/include/dt-bindings/power/qcom-rpmhpd.h
>> new file mode 100644
>> index 0000000..4da2e04
>> --- /dev/null
>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>> +
>> +/* Generic RPMH Power Domain Indexes */
>> +#define CX               0
>> +#define MX               1
>> +#define CX_AO            2
>> +#define MX_AO            3
>> +#define GFX              4
>> +#define MSS              5
>> +#define EBI              6
>> +#define LCX              7
>> +#define LMX              8
>> +#define MMCX             9
>> +#define MMCX_AO          10
>> +#define MXC              11
>> +#define MXC_AO           12
>> +#define NSP              13
>> +#define NSP0             14
>> +#define NSP1             15
>> +#define QPHY             16
>> +#define DDR              17
>> +#define XO               18
>
> I went through the existing defines. If we adopt the order of defines 
> for sm8550, we can migrate that platform and all of sm8[234]50 without 
> breaking ABI. This would be a minor gain, but still something.
>
Actually, I added them in the sequence based on the frequency with which 
they occur in the driver, so that there are less NULL entries created 
for any target additions. Shouldnt we keep it this way and ignore for 
previous targets then?

Thanks,
Rohit.
>> +
>> +#endif
>
