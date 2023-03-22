Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAA6C4CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCVOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCVOCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:02:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7836130B;
        Wed, 22 Mar 2023 07:02:28 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M43WDI013421;
        Wed, 22 Mar 2023 14:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gYglGWrj0WU1+PdidS9jND1KzDRcKLCuLZ1On8XdKTU=;
 b=g4Y9Qqg7VZsv0I7yZz1SnJRdIxYU4Bno3Sbt6AHwSe/X3j6gVTo1W8vlGby3BHFDLv4+
 xKPgr3jMTszQjR0zpg2Fshl5u3+yywLYrKlLgO4ngqjBAeE+7tLLzcbLxP9R8QIFIH3p
 mGYcX4iRogI4ATnGytSl9jBrfokun+uUBJBy1NgHKL2rKoH9buaJf0GlyngrHfR4vhvp
 pBM32NoPFysUbYVq4Y/bC+VGh0c2IJ12XVURbSP7jvVIr2khK+GxJb4MRn0Tev5xzSpS
 uapajJH1uWa7B8mi4jCTc/BmDBBggotidiWDXfIoAc6bVUBZdY0JbDXNVi7fkdLNitcY ZA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfrk0sgus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:02:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32ME2Heh013049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:02:17 GMT
Received: from [10.50.8.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 07:02:13 -0700
Message-ID: <8efa2296-7136-690a-6e6b-c9b41562ba84@quicinc.com>
Date:   Wed, 22 Mar 2023 19:32:09 +0530
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
 <e845b412-9afa-3d9e-54fc-7f9f04d25c05@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <e845b412-9afa-3d9e-54fc-7f9f04d25c05@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DH5m7H9F0Nafl6koPrLl3M5uS5dmCjTH
X-Proofpoint-ORIG-GUID: DH5m7H9F0Nafl6koPrLl3M5uS5dmCjTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220103
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 11:09 PM, Krzysztof Kozlowski wrote:
> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>> Add the device tree bindings for the module power manager sleep
>> counter.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>> new file mode 100644
>> index 0000000..f9f46b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
> 
> Your code a bit explains this... this is not a device but some memory
> region. Does not look like suitable for bindings as separate device.

Ack. Can you let me know the suitable place to put the bindings for this?

> 
> Best regards,
> Krzysztof
> 
