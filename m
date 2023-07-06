Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B318749A33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjGFLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGFLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:04:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580451BDC;
        Thu,  6 Jul 2023 04:04:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3666bM53002320;
        Thu, 6 Jul 2023 11:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OQDcod1PD7tvF8TN1BOeol9FFu+4ByUpek5GCOrZgSU=;
 b=nYczpvM2YFDZhnySE1C3gRLPJ0us1mlE0T6X5wZDaJltjS7UvvWWtypGeLxRp0NPvjLY
 M6aC5Lb3Bi89O3ftzq7/4e0aIRhjWWeXD7nESm5N4O10/mbYKPwkZ3VS527f8KwtoDQQ
 UATjQLIij2DKmxmQGLwWatmgoh0l5AAZsUCK2z4trQyAMgRyFrjqUfuYLDgb8lpKs8Hh
 QnudnRSlHwdBKZc0JeweTloBSZk5o52vhqy58y3j4SVF+7K74Yks/RZ2LxywMkmkkEsQ
 rd12MYwDzIMkpy7IRN+r55uBG9sq37Kd7KZ/3V3SERiBFZUU5Y70QMZqIHgXCvXXgRh4 sA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5mftwfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 11:04:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366B44wn025344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 11:04:04 GMT
Received: from [10.216.13.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 04:04:00 -0700
Message-ID: <00a04f70-b0d2-2ac8-d03d-93f48c036fed@quicinc.com>
Date:   Thu, 6 Jul 2023 16:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Remove the SoC specific
 entries
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688635218-23779-2-git-send-email-quic_rohiagar@quicinc.com>
 <318ab229-f29f-e6aa-16b8-79fa09013794@linaro.org>
 <b994f92c-331b-ca64-01ec-ec285fb2a76e@quicinc.com>
 <529beea3-3f36-3837-35c4-1efa25d8f1f2@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <529beea3-3f36-3837-35c4-1efa25d8f1f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FIcpmynwcOY3YDoB1r3aMpDFhpM_-a4e
X-Proofpoint-ORIG-GUID: FIcpmynwcOY3YDoB1r3aMpDFhpM_-a4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=497 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060098
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 4:27 PM, Krzysztof Kozlowski wrote:
> On 06/07/2023 12:53, Rohit Agarwal wrote:
>> On 7/6/2023 4:15 PM, Krzysztof Kozlowski wrote:
>>> On 06/07/2023 11:20, Rohit Agarwal wrote:
>>>> Remove the SoC specific entries and add a generic set of defines
>>>> that can be used by all the SoCs. This will remove the duplicate
>>>> entries among SoCs.
>>>> The arrangement of the defines is done according to the frequency
>>>> used in SoC specific entries in the driver to avoid wastage of
>>>> memory.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Please compile kernel with this commit and tell us what is wrong... Even
>>> if bindings were not an ABI, but they are, this would not work.
>> Do you mean that individually this commit would fail compilation?
>> Yes, we would need all the patches together for compilation to be
>> successful.
> Yeah, it is not bisectable.
>
> Another problem is ABI impact, but I think Konrad covered it.

Yes, Thanks

>
> Best regards,
> Krzysztof
>
