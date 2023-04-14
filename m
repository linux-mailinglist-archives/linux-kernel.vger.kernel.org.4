Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B76E29D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDNSJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:09:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B18D9EFA;
        Fri, 14 Apr 2023 11:09:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EEpId7025674;
        Fri, 14 Apr 2023 17:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fP0y3ivoleJMzMVSQbyNpJyi0x/okXy9OO/bGDnBZuo=;
 b=pYNXcPekDQ16mTq+D/7EAGIE8BRt1hg7PnruFL1Pbu7KTKrhWFgi0LDJByqJOe2MypuP
 Y3TImWgL9QKuioOjAGyDSRISML8y6fH0GgLl5oQQr/ki2hd52vG7UxiM0V7A56bFkVGM
 ujUVA1ofe1VPxOt8jQ/9ZMo2fSl5iezCNSprhy/5hUEUDxgm/SY6d/X0SP3J/CpfuCH8
 NWHY0j7/odt6qCxx/wM5BSiZycqeubNH0RqYpUEoOYezOViglCEtwLlVC1HdOdSK0kTM
 JUg9nGyz+0zM8KXp3mnsKvphpg9fB2fXbn6eovlgIIGoqmVylQGhVibuQWsZ/mFFBZ7j MA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxked32d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 17:31:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EHVJ2p028545
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 17:31:19 GMT
Received: from [10.216.10.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 10:31:13 -0700
Message-ID: <7abff83f-09ea-5b1b-cbb8-786cc97627d0@quicinc.com>
Date:   Fri, 14 Apr 2023 23:01:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V1 1/4] dt-bindings: clock: qcom,ipq9574-gcc: Drop the
 Bias PLL ubi clock source
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230414134812.16812-1-quic_devipriy@quicinc.com>
 <20230414134812.16812-2-quic_devipriy@quicinc.com>
 <dc48d390-9c8b-d3b7-9c5e-6cbddb0e1306@linaro.org>
 <aca7b808-51ce-1921-2ee2-0e82cf19d960@quicinc.com>
 <7b4fe58c-9cf8-57ab-8cbc-c5ccf0b2a46d@linaro.org>
 <2c5bbe48-3007-a1d5-73b9-9d2132bff9d4@quicinc.com>
 <76237034-7871-c77f-1e32-c0a585d8df86@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <76237034-7871-c77f-1e32-c0a585d8df86@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QQV_QQ5WEzXOyGI-CmQyQ1dyJA7XHiKR
X-Proofpoint-ORIG-GUID: QQV_QQ5WEzXOyGI-CmQyQ1dyJA7XHiKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=669
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140154
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 10:41 PM, Krzysztof Kozlowski wrote:
> On 14/04/2023 18:04, Devi Priya wrote:
>>
>>
>> On 4/14/2023 8:39 PM, Krzysztof Kozlowski wrote:
>>> On 14/04/2023 16:22, Devi Priya wrote:
>>>>
>>>>
>>>> On 4/14/2023 7:47 PM, Krzysztof Kozlowski wrote:
>>>>> On 14/04/2023 15:48, Devi Priya wrote:
>>>>>> Remove bias_pll_ubi_nc_clk from the binding as it has been removed from
>>>>>> the Device Tree. Also added Bjorn Andersson to the maintainers list.
>>>>>
>>>>> Was it really removed? Where?
>>>>>
>>>> It has been removed from the Device tree and binding in V11
>>>> https://lore.kernel.org/linux-arm-msm/20230404101622.5394-1-quic_devipriy@quicinc.com/
>>>
>>> I still see it in current next. Are you sure you refer to something
>>> already merged?
>>
>> This change was made in V11 and Currently V9 is merged in linux-next.
>> So, the delta changes between V9 & V12 is posted in this series.
>> The device tree change where the clock is removed is added part of this
>> incremental patch series and the binding is updated to reflect the same.
>> Apologies, if the confusion is because of "has been removed from device
>> tree" in the commit message.
> 
> Your commit indicated that removal from DTS happened. If it did not
> happen, you need to come with proper reason (and fix the tense not to
> confuse).
Got it, will update the commit message.

Thanks,
Devi Priya
> 
> Best regards,
> Krzysztof
> 
