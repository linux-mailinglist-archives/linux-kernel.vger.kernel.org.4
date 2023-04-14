Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89BF6E27F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDNQFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDNQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:05:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191455BB0;
        Fri, 14 Apr 2023 09:05:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EFR9vE011456;
        Fri, 14 Apr 2023 16:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zmT8OGNRNLDcRI4wX+B2UEr0mwcLGz92og4FZshltnQ=;
 b=antOn+e0QYxY11M/qmPeE5IR7JBm1chVBS7oGTbBzEjjMiGBgw8GyYgRpnPujQeNkBPH
 CCwgJIJyJEB+vBSVebP1dzIcCAr18Nvkg0lGNNHlVRbjC0eAnF1mdIhM12Koc56w1tfs
 XxaniBbWTUhs+Xf4zjMVlJVYdD9Oiu2J2An7NbqSpM6GqW+2+6CJFSXXmXLnkeGIIuLn
 E3CuDfCgKXh2XYUzXckILUyEzIU0ZikYi89UVicHw2MpPDFKYtglLpch9+F0/PoWxI3M
 ibKNnDMuVmaCpYPYq2fDxXJoHAQc4d2AliYoWN8w4PrCu8815zS4d1J++wQZDVXFDkge LA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxdteknet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 16:04:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EG4wGV002787
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 16:04:58 GMT
Received: from [10.216.10.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 09:04:52 -0700
Message-ID: <2c5bbe48-3007-a1d5-73b9-9d2132bff9d4@quicinc.com>
Date:   Fri, 14 Apr 2023 21:34:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V1 1/4] dt-bindings: clock: qcom,ipq9574-gcc: Drop the
 Bias PLL ubi clock source
Content-Language: en-US
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
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <7b4fe58c-9cf8-57ab-8cbc-c5ccf0b2a46d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H18vUg1Fz5dVU1W_YWN3MuQSKPZI4V0I
X-Proofpoint-GUID: H18vUg1Fz5dVU1W_YWN3MuQSKPZI4V0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=597 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140142
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 8:39 PM, Krzysztof Kozlowski wrote:
> On 14/04/2023 16:22, Devi Priya wrote:
>>
>>
>> On 4/14/2023 7:47 PM, Krzysztof Kozlowski wrote:
>>> On 14/04/2023 15:48, Devi Priya wrote:
>>>> Remove bias_pll_ubi_nc_clk from the binding as it has been removed from
>>>> the Device Tree. Also added Bjorn Andersson to the maintainers list.
>>>
>>> Was it really removed? Where?
>>>
>> It has been removed from the Device tree and binding in V11
>> https://lore.kernel.org/linux-arm-msm/20230404101622.5394-1-quic_devipriy@quicinc.com/
> 
> I still see it in current next. Are you sure you refer to something
> already merged?

This change was made in V11 and Currently V9 is merged in linux-next.
So, the delta changes between V9 & V12 is posted in this series.
The device tree change where the clock is removed is added part of this 
incremental patch series and the binding is updated to reflect the same.
Apologies, if the confusion is because of "has been removed from device 
tree" in the commit message.

Thanks,
Devi Priya
> 
> Best regards,
> Krzysztof
> 
