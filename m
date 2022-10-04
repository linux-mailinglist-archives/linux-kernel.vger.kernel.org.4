Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E35F4A09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJDUCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJDUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:02:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C66B66C;
        Tue,  4 Oct 2022 13:02:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JLowA021316;
        Tue, 4 Oct 2022 20:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uCPs6MKJNbFkSyHzS329eynET+W0UsAO0JmTE+BsIK8=;
 b=NfOikr0rqcGp+7wR0gTQHnURMljeuTEquWtCH47ROW32UB+/RNMR3EPks57YapLrGYUt
 h2UfkYBqZTsE88WWLTTHIcMlJwTkSnXENEKHaVbMeTJDAXdO0Hjzl2147PcH7TUFfhEr
 yzr8PRTiK87J+iuNiRQGR5OLe/WHQSPCAY7MkxuGNeIRoTnXzz+Dlv3V/ISE+cAEyP/7
 n3UD8nZXAmHeWGHGMX8eL3fP+HAiEw2tAJojFY4OGal2bNGfqMhlducN58+Fa9ynYJez
 lPFCpE9PFE0WE4CSYbc1sR6S4mX8wtBp48psIEOaxNG6eD3KESHS305siII0CORszv8P Xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0rhdgb7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 20:02:25 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K2ODw027188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 20:02:24 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:02:23 -0700
Message-ID: <91791c6a-345a-e9d7-cc72-3bd27df5bbf7@quicinc.com>
Date:   Tue, 4 Oct 2022 15:02:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add QDU1000/QRU1000 dt
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030602.28232-1-quic_molvera@quicinc.com>
 <20221001030602.28232-2-quic_molvera@quicinc.com>
 <0bf97760-09e0-e64f-3ef6-2b861131f83e@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <0bf97760-09e0-e64f-3ef6-2b861131f83e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xyKKdhLC3VYgjFUYRGP9u-hALjmfaKsf
X-Proofpoint-GUID: xyKKdhLC3VYgjFUYRGP9u-hALjmfaKsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040130
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 4:31 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Add interconnect IDs for Qualcomm QDU1000 and QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../bindings/interconnect/qcom,rpmh.yaml      |  8 ++
>>  .../dt-bindings/interconnect/qcom,qdru1000.h  | 98 +++++++++++++++++++
>>  2 files changed, 106 insertions(+)
>>  create mode 100644 include/dt-bindings/interconnect/qcom,qdru1000.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
>> index a429a1ed1006..c524d92ee203 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
>> @@ -132,6 +132,14 @@ properties:
>>        - qcom,sm8450-nsp-noc
>>        - qcom,sm8450-pcie-anoc
>>        - qcom,sm8450-system-noc
>> +      - qcom,qdu1000-clk-virt
>> +      - qcom,qdu1000-gem-noc
>> +      - qcom,qdu1000-mc-virt
>> +      - qcom,qdu1000-system-noc
>> +      - qcom,qru1000-clk-virt
>> +      - qcom,qru1000-gem-noc
>> +      - qcom,qru1000-mc-virt
>> +      - qcom,qru1000-system-noc
> Not a correct order.
Will fix to alphabetical.
>
>>  
>>    '#interconnect-cells': true
>>  
>> diff --git a/include/dt-bindings/interconnect/qcom,qdru1000.h b/include/dt-bindings/interconnect/qcom,qdru1000.h
>> new file mode 100644
>> index 000000000000..2bdfa0c15d2c
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom,qdru1000.h
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> Dual license.
Will add second license.
>
>
> Best regards,
> Krzysztof
Thanks,
Melody

