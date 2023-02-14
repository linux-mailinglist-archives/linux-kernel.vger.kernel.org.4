Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7D696F30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjBNVVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjBNVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:20:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B526877;
        Tue, 14 Feb 2023 13:20:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL71aw000663;
        Tue, 14 Feb 2023 21:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Xcw0ZlUasRoVO95Q9XmibyBnrngBcN4Pv95xjwnaGkg=;
 b=KU/tDnJQSFzbJjBol5wTDymrODkLrphLMdiqCBE46qAZ0rlze0imq/S4fSy/f5e9hs4A
 403tOzXCJvMnqv2nZlhX2tAZy+zagw7mAz/vMMFjyDLl3Z1vwhJYPsKTqZ6iIpHxz+5U
 5Y595eh5B1DE+uBz/Fduun8nff3Utfhfa/EUQ1l8OcbYHalln0dZsXkAp0tOx9pBGRnt
 RO/+XLWn5B/1dXmVRlVysLuJIUFXBLzMtwahE4A1/6ulXtVPKekzVUXznQPNBCxs142I
 m4O0xN2S6kZJGQShE9qitAzQYP2Gmp7JbzXZcUxEoZVcOlfcg6c50q4B3S8roGtEAHhf tA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrhx3r0r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:20:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELKnSI020053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:20:49 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 13:20:49 -0800
Message-ID: <2495bd07-5322-59d8-e79f-45403a0f9d07@quicinc.com>
Date:   Tue, 14 Feb 2023 13:20:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/9] dt-bindings: soc: qcom: aoss: Document
 power-domain-cells for aoss
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-4-quic_molvera@quicinc.com>
 <20230214175226.e3sstj6pk3naavbr@ripper>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20230214175226.e3sstj6pk3naavbr@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -RXDhl3Rp_HunTeeiuHfjHr-QKdRlxZu
X-Proofpoint-GUID: -RXDhl3Rp_HunTeeiuHfjHr-QKdRlxZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140183
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 9:52 AM, Bjorn Andersson wrote:
> On Mon, Feb 13, 2023 at 10:52:12AM -0800, Melody Olvera wrote:
>> Document "#-power-domain-cells" field for aoss devices as required
>> by power-controller bindings.
>>
> 99512191f4f1 ("soc: qcom: aoss: Drop power domain support") was merged
> in v5.16, so I don't think this is correct. Please let me know if I'm
> misunderstood your intent.

No, you're correct. Upon reviewing the that commit, this change is wrong and should
be dropped. I need to update the device tree accordingly. Thanks for catching that.

Thanks,
Melody
>
> Thanks,
> Bjorn
>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
>> index ab607efbb64c..bcfa8e2e6a04 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
>> @@ -60,6 +60,9 @@ properties:
>>      description:
>>        The single clock represents the QDSS clock.
>>  
>> +  "#power-domain-cells":
>> +    const: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -97,6 +100,7 @@ examples:
>>        mboxes = <&apss_shared 0>;
>>  
>>        #clock-cells = <0>;
>> +      #power-domain-cells = <1>;
>>  
>>        cx_cdev: cx {
>>          #cooling-cells = <2>;
>> -- 
>> 2.25.1
>>

