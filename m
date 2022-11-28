Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4563B5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiK1XIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiK1XIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:08:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A12E9F4;
        Mon, 28 Nov 2022 15:08:44 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASMvGEa021185;
        Mon, 28 Nov 2022 23:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RtjpXUfD7wnkUSdf4pyQtT7BvRuTHAfWbHQqa5Tvqbg=;
 b=EctaZAS9oy8GZtf+xU2ZJAwqxyApLbbrq0f2DW/l3BZtV2VsR1TDLJ3VRqxiE6gcSsKY
 wcRDmekvC1IhnOyJQoYj0XgAl4QQ6d8LmSLRAHp+9EO03+nAc2kE0DOifGpeEUbgkCsO
 mJBmunn7e7+Bq+B6SPCs8EC+3Rr7k++6Z64swS8mZtmnIIL4p2YgqzL5dqT2BPVRDv2R
 ZyPha21iQRmDa5gYrhUfKaJoC8yisTSpqG7h/RZE0v48h4e1vGk+SrzncnubJWTbZ6qy
 X00gFIvRlUgO/hsfTwNCb+mmy4s8HJaZyuGuFMs8d5tvmcFfjdma6z9wQv/XREtILFGI hw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3ad958vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 23:08:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ASN8dju016909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 23:08:39 GMT
Received: from [10.110.4.151] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 28 Nov
 2022 15:08:38 -0800
Message-ID: <cb6a434f-9dc1-d24e-4c4a-02a223c12619@quicinc.com>
Date:   Mon, 28 Nov 2022 15:08:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
 <536af0d9-aa00-ddf1-753d-670ec2adef91@linaro.org>
 <3ada611b-96e0-5cf0-d79d-b90ca4202ddb@quicinc.com>
 <b7cc4f5d-c1d6-919c-9604-7855ea802d17@linaro.org>
 <e6ae7c01-47ca-f1da-3b0b-1f17d9e862bf@quicinc.com>
 <333a240a-2c97-8b19-91d1-315d00e1f438@linaro.org>
 <e538affc-5c43-9b40-f6c7-2ceb2fa2fec8@quicinc.com>
In-Reply-To: <e538affc-5c43-9b40-f6c7-2ceb2fa2fec8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: okytTpFuOe06DsYnESsZhyvTemaA7tkF
X-Proofpoint-GUID: okytTpFuOe06DsYnESsZhyvTemaA7tkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211280166
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2022 9:25 AM, Melody Olvera wrote:
>
> On 11/24/2022 2:30 AM, Krzysztof Kozlowski wrote:
>> On 22/11/2022 18:57, Melody Olvera wrote:
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Georgi Djakov <georgi.djakov@linaro.org>
>>>>>>> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
>>>>>>> +
>>>>>>> +description: |
>>>>>>> +   RPMh interconnect providers support system bandwidth requirements through
>>>>>>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>>>>>>> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
>>>>>>> +   associated with each execution environment. Provider nodes must point to at
>>>>>>> +   least one RPMh device child node pertaining to their RSC and each provider
>>>>>>> +   can map to multiple RPMh resources. Virtual interconnect providers are not
>>>>>>> +   controlled by AP and do not support QoS; they should not have associated
>>>>>>> +   register regions.
>>>>>>> +
>>>>>>> +allOf:
>>>>>>> +  - $ref: qcom,rpmh-common.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    enum:
>>>>>>> +      - qcom,qdu1000-clk-virt
>>>>>>> +      - qcom,qdu1000-mc-virt
>>>>>>> +      - qcom,sm8450-clk-virt
>>>>>>> +      - qcom,sm8450-mc-virt
>>>>>> You should also move qcom,sdx65-mc-virt, qcom,sc8280xp-mc-virt,
>>>>>> qcom,sc8280xp-clk-virt and more.
>>>>> Ok. I wasn't sure since some of these entries don't seem to conform to
>>>>> these bindings, even though it seems they should.
>>>> I have impression that devices I listed conform to these bindings, this
>>>> is why I listed them. But if you are sure that they do not, then they
>>>> should not be moved.
>>> You're correct; those you listed do conform to the new bindings and should be moved.
>>> I also caught qcom,sc7280-clk-virt which needs to be moved. I'll add to the new bindings.
>> Actually let's wait a bit with this. For SM8550 we had an idea to move
>> interconnect to their own bindings file, because they will grow a bit
>> with allOf:if:then clauses.
>>
>> Maybe SM8450 and QDU1000 should also go to their own files which will
>> describe all their interconnects (the virt and the ones requiring clocks)?
>>
>> Apologies for bringing it late for your patches, but SM8550 is also
>> happening right now, so new things pop-up :)
> Yeah no worries. I can definitely make this change; if this is how we want to do
> things going forward I'm happy to oblige.
>
> Thanks,
> Melody

I think though for these PS, I'll stick to doing w QDU1000. So I'll have a file qcom,qdu1000-rpmh.yaml
and qcom,qdu1000-rpmh-virt.yaml

Thanks,
Melody

>> Best regards,
>> Krzysztof
>>

