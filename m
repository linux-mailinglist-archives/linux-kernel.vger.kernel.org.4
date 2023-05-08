Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C56D6FB267
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEHOQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:16:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B57127;
        Mon,  8 May 2023 07:16:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348BOPQ2017030;
        Mon, 8 May 2023 14:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3rqXwkrD6ehlNN97QDzAG+jEL4x7VQEcavwTxpacJL0=;
 b=kx282jOI/pcKNCsEY71kK7nu96c1VcnskTxNjEBZhib6rS2xqRXUM+dftqHYoa5v3UZY
 1XKca7s0lk6lm9nXowPJu8YyaobOtU6ov6plUsRYsBgzeK2xU5pTel0IENHoJDNLakbm
 xyW7XxgfxsGWk2rnCFPFXx/nSr9gpYvnQsOqtKYtk68iM7QqbrkGY1h2jqXbtyEoB/NB
 ewoWwWXcLEVldLHRmFQ1suAHBXk3FvcHvD/Wd10YytAE0Zs3BnJqvhw2FNH1dnxQ3myL
 2Zo6GslJxbbOA2YLECf30cZvZq7w/7QFYT/eDZGWA3x1XsyLWaqXM1Jcra4AVJ+f4jek 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qesg8940t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 14:16:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348EG8NO026896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 14:16:08 GMT
Received: from [10.242.242.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 07:16:00 -0700
Message-ID: <be1d5449-b5f5-9248-98e0-e25b57daf0c5@quicinc.com>
Date:   Mon, 8 May 2023 19:45:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 02/11] dt-bindings: mailbox: qcom: Add IPQ5018 APCS
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-3-git-send-email-quic_mmanikan@quicinc.com>
 <19d5ce31-284c-4028-bf9e-190b97dca906@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <19d5ce31-284c-4028-bf9e-190b97dca906@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pm5idBmormyOae31ew9lgk1V1S-zydg-
X-Proofpoint-ORIG-GUID: pm5idBmormyOae31ew9lgk1V1S-zydg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=644 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080096
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 8:51 PM, Krzysztof Kozlowski wrote:
> On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
>> Add compatible for the Qualcomm IPQ5018 APCS block.
> 
> Is it compatible with ipq6018 or ipq8074? Your driver tells it is...
> 
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml      | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> 
> 
> 
> Best regards,
> Krzysztof
> 
Yeah, it's compatible. I will use fallback mechanism available here
https://lore.kernel.org/linux-arm-msm/20230217083308.12017-5-quic_kathirav@quicinc.com/

Thanks & Regards,
Manikanta.
