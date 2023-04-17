Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444556E3F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDQGOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDQGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:14:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44D35A4;
        Sun, 16 Apr 2023 23:14:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H2LaNi004212;
        Mon, 17 Apr 2023 06:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E6nLR0rFwUDzoQMQrzv+Mu4OzOmNlQ+3PcHqn8dIZAg=;
 b=iv1WuE7JalUl0UG1NZ5OmjKf0QvXseAMTAI/66P/2i2j6hm767ZNYGi7A8HFRwCnq1gG
 DKdzzSFlHGuA7vPXvRFp3WyAJScU30S39oripDzSuAV4LdF30bmY1SQmhkJTxxBQagkW
 aVwaT6o4xGZwzjjEssIVbSbt9vSWA0nw1fddfTCGISMJXBWyRRsNk9EknkzolLfHgSCp
 1uIOKJf12JRBmHe/Ye33AwVuhhzG1DO47Qh0fz7aN6KaZ+DGexzd1hM3MaN9czehjESr
 RkkXhbbLeO182DD64WG9dRGO2dXNT9NqSn0if/090gu1DDCkrx1HFupsMP95d5OSGnDO wA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymkj2qk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:14:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H6E8LG018114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:14:08 GMT
Received: from [10.216.30.175] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 23:14:02 -0700
Message-ID: <1c972732-4270-763c-14c5-9f0e2c00a7d8@quicinc.com>
Date:   Mon, 17 Apr 2023 11:43:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 5/9] dt-bindings: qcom: Add ipq5018 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
 <4b3ce97d-a134-290d-e762-46d6a91caee1@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <4b3ce97d-a134-290d-e762-46d6a91caee1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v49Y7iUfoU5IxYJAO8mlmGSCNDCKa8vj
X-Proofpoint-ORIG-GUID: v49Y7iUfoU5IxYJAO8mlmGSCNDCKa8vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=896
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170056
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/2023 2:35 PM, Krzysztof Kozlowski wrote:
> On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
>> Document the new ipq5018 SOC/board device tree bindings.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v3] Fixed board name
>>
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 785b969..350f9f6 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -30,6 +30,7 @@ description: |
>>           apq8084
>>           apq8096
>>           ipq4018
>> +        ipq5018
>>           ipq5332
>>           ipq6018
>>           ipq8074
>> @@ -95,6 +96,7 @@ description: |
>>           hk10-c2
>>           idp
>>           liquid
>> +        rdp432-c1
> 
> Keep proper order, not random.

  ok.

Regards,
  Sricharan
