Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83785604F58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiJSSIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJSSIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:08:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F71A20B1;
        Wed, 19 Oct 2022 11:08:16 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFC1uu018469;
        Wed, 19 Oct 2022 18:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6WnqjbJAO/6valsx5RO1sZPNWQfismPO2gI+SfAWaOI=;
 b=OX5KBWjCnJwI2efyDQxF3PRr0PtHXBDYkJlgn6nZDNNqHeOW1avAmpWORFvcMEYy8ilH
 EnQRcfIECLmtcXLgwGtmfxc7lk2aLam1H913PNAxQCsgRTp/6QlkKpVpXh2K9aEUfWfm
 tu+DM5N4H9bfVOLK7Xq4nzfXwMF747auXF43V7xTq6QdUHuY1dZMsINisVhqlUGSh6B4
 eneiIXr6OM/wzYAu+eSh7i2+1eCKKt404LABW2WuC2qKSZtPDThrLZdhyM7SFMn2SEI4
 zXfbOeloRiJqj1PJN+jcr5S+nuncm1pPqekDmauFfsSSeTmSN5i9f0djwotNasWbwaU6 lg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kaknjgpyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 18:08:12 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29JI8B23016480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 18:08:11 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 11:08:11 -0700
Message-ID: <4d680e5a-16eb-f68b-ac6a-e11580104c23@quicinc.com>
Date:   Wed, 19 Oct 2022 11:08:11 -0700
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
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <55d026c0-9c54-f5d6-bf5e-da71856f0698@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sOIuJrB-CiOjZvutImNRXRy2vqE-b-rb
X-Proofpoint-ORIG-GUID: sOIuJrB-CiOjZvutImNRXRy2vqE-b-rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2022 6:34 AM, Krzysztof Kozlowski wrote:
> On 14/10/2022 18:11, Melody Olvera wrote:
>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../devicetree/bindings/firmware/qcom,scm.yaml   | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index c5b76c9f7ad0..47083f47f109 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -38,6 +38,8 @@ properties:
>>            - qcom,scm-msm8994
>>            - qcom,scm-msm8996
>>            - qcom,scm-msm8998
>> +          - qcom,scm-qdu1000
>> +          - qcom,scm-qru1000
> Why exactly we are no using qdu1000 as fallback? That was the
> recommendation in previous discussion.
Will use only qdu; I think I misunderstood the outcome of that discussion.
>
> Patch is still incomplete - you still do no have proper changes in allOf
> for the clocks. If you want to say that this SoC does not take any
> clocks as input, then they should not be allowed.
That is what I'm trying to say; it seems most of our most recent SoCs (sm8*) don't have any
clocks associated with the scm. Does it make sense to remove the minItems earlier
in the binding, or is there something else that would communicate this in allOf better?

Thanks,
Melody
