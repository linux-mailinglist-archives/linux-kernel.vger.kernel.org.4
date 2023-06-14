Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF63372FDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjFNL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjFNL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:57:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38AA7;
        Wed, 14 Jun 2023 04:57:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E71JX9014819;
        Wed, 14 Jun 2023 11:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hS3H+3Aq2/7Xg25+al1ov7djT3yNbMlTalgJCAOotOc=;
 b=jHUn2OQuZPDwO0sqr9hyzNuA/nOakq05WoUkJfPxTUm0fBjGWB+8eHG6sM63M5bJhDo+
 CfUn3ht8KkgJ22ZjvWNzdn1vvlN4q4NuwIpwQ2S/z7hH+4hOxBpmu8zCKU10XBr4nOVJ
 4WVZQ8idUtkk9scecZ7biB9wdoBp1hl/JDfMmhMp5aBotUfnnZyRYVEYRHV7vDrglvNo
 mG0VMjbaeuBzdktwpnnd5EtaRgjQzHYeXPfmHtp0G8iqMx+G16tdPmMxfbse/06+XppO
 RufUbErV64UDWJvOjbU09Ee6fewNXp6eK4hf/UUPiGWRCjZs2tN9D8IBomHYJGP7tTd9 pQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6nqh38q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:57:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EBvpm5014707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:57:51 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 04:57:45 -0700
Message-ID: <65fd51f1-56d9-7b7b-7757-229cbb65051d@quicinc.com>
Date:   Wed, 14 Jun 2023 17:27:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 0/4] Add camera clock controller support for SM8550
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230609115058.9059-1-quic_jkona@quicinc.com>
 <88b41c0f-e515-ce94-e4fd-befbeef53781@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <88b41c0f-e515-ce94-e4fd-befbeef53781@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uD70rnrtJ2NoboKK43Y3rEd16aVgRzkH
X-Proofpoint-ORIG-GUID: uD70rnrtJ2NoboKK43Y3rEd16aVgRzkH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_07,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140102
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 6:24 PM, Konrad Dybcio wrote:
> 
> 
> On 9.06.2023 13:50, Jagadeesh Kona wrote:
>> Add bindings, driver and devicetree node for camera clock controller on
>> SM8550.
>>
>> Jagadeesh Kona (4):
>>    dt-bindings: clock: qcom: Add SM8550 camera clock controller
>>    clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
>>    clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
>>    arm64: dts: qcom: sm8550: Add camera clock controller
> What's the final verdict on RINGOSC_L etc.?
> 
> Konrad

We would like to pass RINGOSC_CAL_L field directly in config->l value 
itself and reuse existing code rather than adding a separate function 
for lucid ole pll configure.

Thanks,
Jagadeesh

>>
>>   .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
>>   drivers/clk/qcom/Kconfig                      |    7 +
>>   drivers/clk/qcom/Makefile                     |    1 +
>>   drivers/clk/qcom/camcc-sm8550.c               | 3585 +++++++++++++++++
>>   include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
>>   6 files changed, 3801 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
>>
