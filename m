Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C623602403
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJRFtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJRFts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:49:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C0624943;
        Mon, 17 Oct 2022 22:49:45 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I3w35i016105;
        Tue, 18 Oct 2022 05:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fJfDFAA+VkZcauFclmvuweR7Ne6agmYmmlDfo+pFAT8=;
 b=nHPHa4lxt6HHCt5yMll8Ejwm8sx05q/nFB0080v2NBOKmYPuwEYR/fmFFYsUyMwKdf9z
 jAbzX2tMdB5tAZ7W36WI8iIJ+pABk1keoOsdxl8D+n40RD3FMsDwLjbQJvhitq3xGCRT
 gTuB3c3ZYBg4Re0bOT48rgUMxLbLgQECnA0Le1bH7vlulRVEy0BCybwO8scgWgQ61O4T
 m5jTKYprQQqT82X5Lt40AbO1maOmIWPii2HZbYGq2nELNs5GyCbguXQwhzcZ8JxqgWl5
 268XHX1lyl4kq2/5oUCY1xCeKgirf6Mtbg5GfSfg6YACAYtYQmcnZRxkgQsyCrpo9wxL mg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9jjmrgdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 05:49:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I5nXi3020204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 05:49:33 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 22:49:30 -0700
Subject: Re: [RESEND PATCH v2 3/5] dt-bindings: firmware: qcom-scm: Add
 optional interrupt
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-4-git-send-email-quic_gurus@quicinc.com>
 <c842f6c8-fe7b-1e74-d873-4b674556ec40@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <a42f6664-0f6d-657e-9934-907ebb5408ee@quicinc.com>
Date:   Tue, 18 Oct 2022 11:19:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c842f6c8-fe7b-1e74-d873-4b674556ec40@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uXAUyuvaMm8iScBGau8lRboV9xAfxNVk
X-Proofpoint-ORIG-GUID: uXAUyuvaMm8iScBGau8lRboV9xAfxNVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxlogscore=714 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,
Thanks for taking time to review the series.

On 8/31/22 1:32 PM, Krzysztof Kozlowski wrote:
> On 31/08/2022 01:25, Guru Das Srinagesh wrote:
>> Add an interrupt specification to the bindings to support the wait-queue
>> feature.
>>
>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> Also not CC-ed to proper people and lists.
> 
>> ---
>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index e279fd2..4d6c89f 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -75,6 +75,11 @@ properties:
>>         Specify this flag to remove SCM call serialization. Need to ensure that
>>         the firmware being used supports this feature first.
>>   
>> +  interrupts:
>> +    description:
>> +      The wait-queue interrupt that firmware raises as part of handshake
>> +      protocol to handle sleeping SCM calls.
> 
> Missing constraints.
> 
> Which firmwares support it?
> 

The interrupt property for scm firmware from a binding perspective
is completely optional i.e. not all tz fw running in the wild on sm8450
devices support this feature. The bootloader does the interrupt property
addition on sm8450 devices with support.

-Sibi

>> +
>>     qcom,dload-mode:
>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>       items:
> 
> 
> Best regards,
> Krzysztof
> 
