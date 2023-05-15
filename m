Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8170275D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjEOIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEOIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:38:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941C11F;
        Mon, 15 May 2023 01:38:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F6Bg1E025364;
        Mon, 15 May 2023 08:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=30vfg2gUjXCO7Iilww/cuZYL0d/96lf2URufFIPhtJk=;
 b=MMcR2Ti/PAPiSA5mdx/1vfkb6huZRiTkAJRDKhW6YLYWUgbBxorB4OsccoGVpFcgvYyy
 1Vl19HySVGhqV+kIQlXreqwXTHI5QoKwpm/L84bV0XqjHJoKfqLVWxSPNjm4EkeX1IYS
 w8vmakqRAolQfKBsFgMwLD/GMcM24w4TIRR9XmxpJoSCV4AuJlePECYz9MyMsViF5JwQ
 NJVQrpeB7fJNmVhRgVI+Ds1XgvCGp7h7s8aqeIh57lCCGNSixCDRr4LUEZTY2FZ/rcvr
 ajNwHbXg8fKeZ3cx12yR12uL/gKeK/LqvJgMcUTLZDp5jZ3CwSBMp9EvN6QiZm6aqy1K mQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj1vr35ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:38:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F8crIH013977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:38:53 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 01:38:49 -0700
Message-ID: <10136d1e-8ac7-45b8-caa5-3a9aed523ab3@quicinc.com>
Date:   Mon, 15 May 2023 14:08:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 07/10] dt-bindings: arm: msm: Add LLCC compatible for
 QDU1000/QRU1000
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-8-quic_kbajaj@quicinc.com>
 <c9e37cb2-75f7-e335-05ac-01197a9ba14c@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <c9e37cb2-75f7-e335-05ac-01197a9ba14c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ys1yC9ITtZVzF8aVkRJrH1jeCsC_SzLc
X-Proofpoint-ORIG-GUID: ys1yC9ITtZVzF8aVkRJrH1jeCsC_SzLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=670
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150074
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2023 2:59 PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 14:21, Komal Bajaj wrote:
>> Add LLCC compatible for QDU1000/QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching). In this case - cache: qcom,llcc: - and drop
> redundant parts in subject.
>
> With subject fixes:
Okay, will do that.

Thanks,
Komal
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

