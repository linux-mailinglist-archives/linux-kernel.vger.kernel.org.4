Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C216651A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 06:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLTFBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 00:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiLTFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 00:00:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49FDEAE;
        Mon, 19 Dec 2022 21:00:53 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK4msoD010946;
        Tue, 20 Dec 2022 05:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0VjDmIIsxHVdUV0mFRKdVuG8TziUm5rjIC8UqUun8P0=;
 b=SthCdjNmFrGNJvuQhvC+X68o7KdzDEes53F7cW3+JmhQknV7vH3aHWM/+aqYnGtnYVZ6
 YsMtwmLR9n2cY+RCnuH5vevKwS+f5ilX60JjoHHusaRGFmilhFAKVMKPrgeeeA4IbjFz
 YNzur9vVqpOKFLhNyLlw4WSF8wLKeD1by/Ke3rvZCdzG87K7HjmObvUn0kecqJ79BuWX
 BI+ijyxujfJpLJJ0pRDX+vFjdZEijZwWgCezABk5AVFqt022AJnyjMu8z1weizXP7BR3
 Tr2xjAWTqLJUZhPqMyRb8D1bnaVGIMl5zuEI77nNYggQW9MKyrmF0PuPz5QZihQrQk4I rQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk50qbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 05:00:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BK50lph010084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 05:00:47 GMT
Received: from [10.216.18.69] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 21:00:44 -0800
Message-ID: <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
Date:   Tue, 20 Dec 2022 10:30:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
 <Y5x+WEwTtpoV0gaR@google.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <Y5x+WEwTtpoV0gaR@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7p_zpT4PA3kc7tc875ReVA5_oDle0TwX
X-Proofpoint-ORIG-GUID: 7p_zpT4PA3kc7tc875ReVA5_oDle0TwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=891 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200042
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/2022 7:49 PM, Matthias Kaehlcke wrote:
> On Fri, Dec 16, 2022 at 04:59:17PM +0530, Rajendra Nayak wrote:
>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>> which come with a Pro variant of the qcard.
>> The Pro qcard variant has smps9 from pm8350c ganged up with
>> smps7 and smps8.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> v4 changes:
>> Added the zoglin-sku1536 compatible along with hoglin-sku1536.
>> Zoglin is same as the Hoglin variant, with the SPI Flash reduced
>> from 64MB to 8MB
>>
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 1b5ac6b02bc5..07771d4c91bd 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -558,6 +558,12 @@ properties:
>>             - const: google,hoglin
>>             - const: qcom,sc7280
>>   
>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
>> +        items:
>> +          - const: google,zoglin-sku1536
>> +          - const: google,hoglin-sku1536
> 
> Is there actually such a thing as a 'hoglin-sku1536', i.e. the Pro qcard
> with 64MB of SPI flash, or do they all have 8MB of flash?

The SPI flash is on the CRD mother-board and not on the qcards, so if you replace
the qcards on the CRDs with 64MB flash you would need the hoglin-sku1536 to
boot on those.
