Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C56C69E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjCWNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCWNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:49:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29931BF3;
        Thu, 23 Mar 2023 06:49:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N9c7VF012773;
        Thu, 23 Mar 2023 13:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tiJIvhSMcmuYRxWaz3r/96shZ0YPRflIp+RPKVv0cgk=;
 b=SQsaqvpXZISeuUhweleScm5ohD3Ux+e2rJ9K9+/yhNuovgi8aDdH3zEj7VSuAJ+ii9xa
 Sz2myH+25VkxrITPyXj+9IjXMDh/ioLEuXL/lKFmyKW9A7YqQ3JY2PtVkRL4lWzYsyJq
 dauv2yNrimyvD3UVuQVRU02mL7GUgx9haGgIfleyerv1D30mASX+B/rciUZaBXH3HgZa
 d49kmGeMziTjhm2PyOqVuL2CUoS6VrOB0FWkR0VUQf39qfGlre88kuprC3rPLS+KlWCj
 LGnosdY66fXHy/waxbx2URceYOvIRoMa7fs11IZTvzQfcitMk5hQ4ll+FvuIrgjcUfkX yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgm9x8jsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:49:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NDnZAJ013552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:49:35 GMT
Received: from [10.50.6.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 06:49:31 -0700
Message-ID: <d1dae530-bd44-577c-e317-b1c09b0301a4@quicinc.com>
Date:   Thu, 23 Mar 2023 19:19:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
 <fc46c48d-2de0-ba3a-08b0-a09526bd9e26@linaro.org>
 <e88d9482-4858-7042-7148-142ed9ebb6ad@quicinc.com>
 <859ec5d4-4cb6-1d8a-33b6-91df071e07a1@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <859ec5d4-4cb6-1d8a-33b6-91df071e07a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6moZO2YWwhlDV0CpwPloEUSrwI998dKx
X-Proofpoint-ORIG-GUID: 6moZO2YWwhlDV0CpwPloEUSrwI998dKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=984 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230105
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2023 9:59 PM, Krzysztof Kozlowski wrote:
> On 22/03/2023 14:46, Souradeep Chowdhury wrote:
>>>> +      - const: qcom,mpm2-sleep-counter
>>>
>>> SoC specific compatible.
>>>
>>
>> This is a generic Module Power Manager Sleep Counter which is present in
>> all Qcom Socs, so SoC specific compatible is not given here.
> 
> Not really a good reason and it is actually very difficult to verify
> this. If I understand correctly any moment FW can change and this will
> stop being valid, so no.

Ack
> 
>>
>>>> +
>>>> +  reg:
>>>> +    items:
>>>> +      - description: MPM Sleep Counter Base
>>>
>>> just maxItems: 1
>>>
>>
>> Ack
>>>> +
>>>> +  clock-frequency:
>>>> +    description: Frequency for the sleep counter
>>>
>>> Since this does not have clocks, what frequency you are setting here?
>>
>> Module Power Manager(MPM) Sleep Counter is a clock that starts ticking
>> from Primary Boot Loader(PBL) Stage. This is usually a 32 Khz clock and
>> the frequency for the same is stored here.
> 
> You just said all devices have the same MPM, so I would argue that all
> devices have the same clock.
> 
> Anyway, this is a legacy property.

Ack. Will drop clock frequency.
> 
> Best regards,
> Krzysztof
> 
