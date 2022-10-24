Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDA60B72B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJXTVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiJXTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:20:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924FDAC71;
        Mon, 24 Oct 2022 10:56:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFYa94016047;
        Mon, 24 Oct 2022 17:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LnvzKq7dpO44VMtAlkmSvW4YqURDoxvDFoPsNbIvK3o=;
 b=OWc56O+nt5NWqIstIV0GUvWqXYnL9DAnm7//S2vci0Gnzffno/2kxfHlpCLaNNoZptUG
 jUiLKQp3O8sD1TAXXjvA7Kh/FCkch6FUvg9/WbBL+XObLkH0cGFWl4CzJuMqKDcrQYEL
 DmgxrHAwz6m/PsmdKsE3xfHfFLbn4sSwj8HJCYb9upTFErTMqn/YBlPmC41sODmRW27F
 7XPrYOixXKpFgmmGV/TZpBgfxDKp6/bkOLFUCKM6iuM4BJ+xVd/xUlKd8wuVbaDqNvs9
 Ccg8NclE1CSUfHoNxoFI9BgOaxGR3zjGpYKfI/3NpPO+KNjtY3FRW3o9kdPVy2fQvljf rg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kc5vwmc93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 17:55:28 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29OHtRHq006850
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 17:55:27 GMT
Received: from [10.110.127.91] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 24 Oct
 2022 10:55:27 -0700
Message-ID: <99c79c5f-bb6a-13ae-0f83-e4c176c9c94f@quicinc.com>
Date:   Mon, 24 Oct 2022 10:55:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/4] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014221121.7497-1-quic_molvera@quicinc.com>
 <20221014221121.7497-2-quic_molvera@quicinc.com>
 <55d026c0-9c54-f5d6-bf5e-da71856f0698@linaro.org>
 <4d680e5a-16eb-f68b-ac6a-e11580104c23@quicinc.com>
 <a8d38406-6294-581a-9677-ff2e686eca50@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <a8d38406-6294-581a-9677-ff2e686eca50@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JnMiWI9bgplNBF7IMximrDRMx1E2harW
X-Proofpoint-ORIG-GUID: JnMiWI9bgplNBF7IMximrDRMx1E2harW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2022 5:35 AM, Krzysztof Kozlowski wrote:
> On 19/10/2022 14:08, Melody Olvera wrote:
>>
>> On 10/15/2022 6:34 AM, Krzysztof Kozlowski wrote:
>>> On 14/10/2022 18:11, Melody Olvera wrote:
>>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>>>  .../devicetree/bindings/firmware/qcom,scm.yaml   | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>> index c5b76c9f7ad0..47083f47f109 100644
>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>> @@ -38,6 +38,8 @@ properties:
>>>>            - qcom,scm-msm8994
>>>>            - qcom,scm-msm8996
>>>>            - qcom,scm-msm8998
>>>> +          - qcom,scm-qdu1000
>>>> +          - qcom,scm-qru1000
>>> Why exactly we are no using qdu1000 as fallback? That was the
>>> recommendation in previous discussion.
>> Will use only qdu; I think I misunderstood the outcome of that discussion.
> Actually, I think I commented about this in wrong patch. I think the
> outcome was to use two compatibles for most of the cases, but as a
> fallback, so:
>
> QDU: "qcom,qdu1000-rpmhpd"
> QRU: "qcom,qru1000-rpmhpd", "qcom,qdu1000-rpmhpd"
> (or skip entirely second if you do not customize QRU in DTSI)
>
> However here we already have a fallback, so these are fine:
>
> "qcom,scm-qdu1000", "qcom,scm"
> "qcom,scm-qru1000", "qcom,scm"
>
> Still assuming you customize them in DTSI... which does not seem the
> case, right?
Yeah dtsi is largely shared between RU and DU. It probably makes more sense to
drop RU compat string all together unless there is a significant difference.
>>> Patch is still incomplete - you still do no have proper changes in allOf
>>> for the clocks. If you want to say that this SoC does not take any
>>> clocks as input, then they should not be allowed.
>> That is what I'm trying to say; it seems most of our most recent SoCs (sm8*) don't have any
>> clocks associated with the scm. Does it make sense to remove the minItems earlier
>> in the binding, or is there something else that would communicate this in allOf better?
>>
>
> Then disallow clocks for your variant:
>
>   - if:
>      ....
>     then:
>      ...
>       clocks: false
>       clock-names: false
Got it; thanks.

Thanks,
Melody
