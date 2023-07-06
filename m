Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDBB7494DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjGFFH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjGFFHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:07:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8021BDC;
        Wed,  5 Jul 2023 22:07:15 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3664YPK1016968;
        Thu, 6 Jul 2023 05:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5075ivWjn7+CeYd5xn8n2qxVQmk/qDsu8E702IVUmFs=;
 b=glRPDddQcvVY/TqxUz0Firs24XHqMkH8kqAdHDpMUYUdsZztQFnGo/1KHsHu+k8rt5f7
 +8YbL2uyyGtX7+Gom3oeNBQcv9HpoJCSUi52jNgbu7SpsuCRxexWh9jqmZws2gnWtoZ9
 jULNi7Nc6QeuZXIY2ItiqgMkHzm+u55UUCItaKF4ai6tDbKa0eDJaCBdvMxGTugOEh9O
 5k3oSTkSJNHFdM/CTPX2SOEi8DaVrCBGZtXbZlPuHlPLicU+DP3sx2DcIU+mi7FG2YZl
 GKA66BuJXORAhEMOlan9s7N5ag9E1p1XVLxETr7vVvifRrQIAFgUb0TC5+IJRm1VYu8i DQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmxy92vt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 05:07:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366579JL011115
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 05:07:09 GMT
Received: from [10.110.95.239] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 22:07:04 -0700
Message-ID: <c9307794-c270-dc63-e9ae-329733fb5bdc@quicinc.com>
Date:   Thu, 6 Jul 2023 10:37:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: qcom,spi-geni-qcom: Add SPI
 device mode support for GENI based QuPv3
To:     Conor Dooley <conor@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_vnivarth@quicinc.com>,
        <quic_arandive@quicinc.com>
References: <20230622135955.941-1-quic_ptalari@quicinc.com>
 <20230622135955.941-3-quic_ptalari@quicinc.com>
 <20230622-sustained-marauding-5c6c8a76c834@spud>
Content-Language: en-US
From:   Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20230622-sustained-marauding-5c6c8a76c834@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3EzByZUEqgzEPNGOwmQHUV2bEv5d_4_f
X-Proofpoint-ORIG-GUID: 3EzByZUEqgzEPNGOwmQHUV2bEv5d_4_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307060044
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/23/2023 12:35 AM, Conor Dooley wrote:
> On Thu, Jun 22, 2023 at 07:29:54PM +0530, Praveen Talari wrote:
>> Add a property to configure QUPv3 SE as SPI Device mode.
>>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>> ---
>> v2 -> v3:
>> - modified commit message to use device mode instead of slave mode
> Suitability or w/e of the property aside, I don't understand this.
> Why not change the *property*, which has far more visibility than the
> commit message, to use device rather than slave?
We are going use existing property spi-slave
>
> Chers,
> Conor.
>
>> ---
>>   Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
>> index 2e20ca313ec1..5c7d0293bbf7 100644
>> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
>> @@ -66,6 +66,10 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  qcom,slv-ctrl:
>> +    description: configure QUPv3 SE as Device mode
>> +    type: boolean
>> +
>>   required:
>>     - compatible
>>     - clocks
>> -- 
>> 2.17.1
>>
