Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26297621E98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKHVeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiKHVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:34:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD526168;
        Tue,  8 Nov 2022 13:34:08 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8J91BI014736;
        Tue, 8 Nov 2022 21:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xk0/gATUfPCz2Pcwg7YMbzT4uwfmlpFfnt8M/+kKiyc=;
 b=fdAVOg4itfXAcZ906bVb/dJRzl5NvMs1U8CptsBY30yl6Jz3jZqv7ry0Ogo6VO1Lst+s
 H+JEcvi+8I7KQoZH2fAfgWXq2lbdUJman2p0vJbl0JgKxHczJgxlmtbdFhZEhn18e3TT
 Hk6L6Hx2AeyveVQmin9eVMazbCjQixn59lxf9Z/LFht9A9Q2OX/cfDnvlNJBPsyhWci+
 gDGQf868Ch6dL+6pJRTkoTeZSW/i52LonsM9i5eFGNO7TCic0iqmiapYOK1acs6ml4xb
 tgA3yo+09VjKS39CekL90gLnuV350w+V6tPLDqAG8QtGV0pgy/+1hPGJXCE6GuSWcwvN Ew== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqugb8nu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 21:34:04 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8LY3Ui011288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 21:34:03 GMT
Received: from [10.110.77.231] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 13:34:02 -0800
Message-ID: <d13d5638-67b1-218b-c16d-505a389ccc42@quicinc.com>
Date:   Tue, 8 Nov 2022 13:34:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: qcom,rpmh-rsc: Update to allow
 for generic nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-2-quic_molvera@quicinc.com>
 <ad1d4135-031e-9393-07af-7b81c9ecffb5@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <ad1d4135-031e-9393-07af-7b81c9ecffb5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LeYmsa06Q8sqFs6GPGTNMM_ZBIu1qAUy
X-Proofpoint-ORIG-GUID: LeYmsa06Q8sqFs6GPGTNMM_ZBIu1qAUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=778 clxscore=1015 phishscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 8:08 AM, Krzysztof Kozlowski wrote:
> On 26/10/2022 16:04, Melody Olvera wrote:
>> Update the bindings to allow for generic regulator nodes instead of
>> device-specific node names.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
>> index 4a50f1d27724..0e7e07975f3a 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
>> @@ -109,7 +109,7 @@ properties:
>>      $ref: /schemas/power/qcom,rpmpd.yaml#
>>  
>>  patternProperties:
>> -  '-regulators$':
>> +  'regulators$':
> This should be rather fixed like:
> https://lore.kernel.org/linux-devicetree/20220926092104.111449-1-krzysztof.kozlowski@linaro.org/

Got it.

Thanks,
Melody
>
> I don't know why there is such a popularity of adding specific model
> names as device node names...

