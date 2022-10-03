Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5355F35F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJCSz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJCSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:55:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9F93643D;
        Mon,  3 Oct 2022 11:55:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293IEuIF019759;
        Mon, 3 Oct 2022 18:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KH45amWFv7IeZ46koWu4eQ7zDDe6y9lEwtwMmyRXECY=;
 b=BbRhM5G5Nc27U3eXczTxbP147XgiNQW96OySuZs5wqxJ3+kvIv8E9kaR3CaL0bHxY1mG
 tcOU7wCXy324lpTiU0uHczz/wf7AaXKPw13bRxzVPlzN+NFjls0feAR5vDNtTTnCShGY
 XFiWM8gLMYIV2FBp3MWBansX5RVGsQyC1aMgXM0Jw/JpSKEX/KymAUX97VaqD75optQW
 nOAKFIlcOpj4PijjJFxGkWtyPdA6+kmqJne3IYhPBZc3aj8z032FNSOhIVArOr1RNlAq
 xhNDVsqwkyQD7n154bjFhTT/ngAKaFc+zCiobbYrpfTYNcgmRnnd1K9QuwPNadzrZ7QL hg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxdxfvar8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 18:55:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293ItTXv007555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 18:55:29 GMT
Received: from [10.110.93.213] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 11:55:28 -0700
Message-ID: <d9bcb762-0f24-5d13-0478-237a77742c84@quicinc.com>
Date:   Mon, 3 Oct 2022 13:55:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] dt-bindings: clock: Add RPMHCC bindings for QDU1000
 and QRU1000
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-3-quic_molvera@quicinc.com>
 <CAA8EJpr2ZnEC3=WMns8AGNY1DwARM9xnadtaBkzctOyNLv3=Zg@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpr2ZnEC3=WMns8AGNY1DwARM9xnadtaBkzctOyNLv3=Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kxx0_4tS0IBCFXofQLTnurNgJIcwi3Qn
X-Proofpoint-ORIG-GUID: Kxx0_4tS0IBCFXofQLTnurNgJIcwi3Qn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030113
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 1:59 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:05, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add compatible strings for RPMHCC for QDU1000 and QRU1000.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
>> index 8fcaf418f84a..d613156eadb0 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
>> @@ -29,6 +29,8 @@ properties:
>>        - qcom,sm8250-rpmh-clk
>>        - qcom,sm8350-rpmh-clk
>>        - qcom,sm8450-rpmh-clk
>> +      - qcom,qdu1000-rpmh-clk
>> +      - qcom,qru1000-rpmh-clk
> Alphabetic sorting please. Q comes before s.
Will do.
>>    clocks:
>>      maxItems: 1
>> --
>> 2.37.3
>>

Thanks,

Melody

