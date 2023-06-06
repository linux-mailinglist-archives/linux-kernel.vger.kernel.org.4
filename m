Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32E723809
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjFFGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjFFGq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:46:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB97E6E;
        Mon,  5 Jun 2023 23:46:25 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3565Llea029016;
        Tue, 6 Jun 2023 06:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sfnxKqeN6rlAEiTZ1mzOdeejWs11olEug3M+FT/MiNY=;
 b=b0Xe3XKfZHe8zobR76t9D/B7P0fJrgnDhw756zwzVVinZ3SXQs+90upn6faMbQdFdZ2Z
 ia8rCGw+UXS/KPPmlz/FT2mB4u+awrXbHuQTgimvJwCrnMhS6F9aYRs8mTWLusPGg81o
 kjOtDPSVBDFrOdL4sNOVxnhj9Dkk/jchJN3sHvpA/BKaFoqB+CmYscT9C6f8r1JTl2ln
 +tE1SZfH2sWLWt1tT3vLPYMkSd1yKb6QNUTjhCYuUnxn2VG8ro5h+lFruuqLFHIbcpgd
 h1dWVTAM4bwrwW/jQV/As3IYPFQ5bQibdkzr7CtUJ4tTC3JoosIg5zA3m9eFztv7yhJc Fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1arntuq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 06:45:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3566jrdo000595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 06:45:53 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 23:45:46 -0700
Message-ID: <d9b6bdd9-25cd-7db2-f191-0f83dfb83816@quicinc.com>
Date:   Tue, 6 Jun 2023 12:15:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 07/10] arm64: dts: qcom: Add support for GCC and RPMHCC
 for SDX75
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <mani@kernel.org>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, Imran Shaik <quic_imrashai@quicinc.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-8-git-send-email-quic_rohiagar@quicinc.com>
 <CAA8EJpogj0uzQdk-kDqm7Pju7Q5aXJg6FHswkJy+ugawqePWLw@mail.gmail.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <CAA8EJpogj0uzQdk-kDqm7Pju7Q5aXJg6FHswkJy+ugawqePWLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ARtj0sVEzsWWamT4rq2HGVBrnpcGfWug
X-Proofpoint-GUID: ARtj0sVEzsWWamT4rq2HGVBrnpcGfWug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_04,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1011 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060057
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/2023 12:00 AM, Dmitry Baryshkov wrote:
> On Mon, 5 Jun 2023 at 19:30, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>> From: Imran Shaik <quic_imrashai@quicinc.com>
>>
>> Add support for GCC and RPMHCC clock nodes for SDX75 platform.
>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 37 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index 3d1646b..f83eef8 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -7,6 +7,7 @@
>>    */
>>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sdx75-gcc.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>
>> @@ -22,7 +23,21 @@
>>                  reg = <0 0x80000000 0 0>;
>>          };
>>
>> -       clocks { };
>> +       clocks {
>> +               xo_board: xo_board {
> No underscores in node names
>
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <76800000>;
>> +                       clock-output-names = "xo_board";
> Why do you need this?
>
>> +                       #clock-cells = <0>;
>> +               };
>> +
>> +               sleep_clk: sleep_clk {
> No underscores in node names
>
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <32000>;
>> +                       clock-output-names = "sleep_clk";
> Why do you need this?
>
>> +                       #clock-cells = <0>;
>> +               };
>> +       };
>>
>>          cpus {
>>                  #address-cells = <2>;
>> @@ -358,6 +373,18 @@
>>                  ranges = <0 0 0 0 0x10 0>;
>>                  dma-ranges = <0 0 0 0 0x10 0>;
>>
>> +               gcc: clock-controller@80000 {
>> +                       compatible = "qcom,sdx75-gcc";
>> +                       reg = <0x0 0x0080000 0x0 0x1f7400>;
>> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +                                <&sleep_clk>;
>> +                       clock-names = "bi_tcxo",
>> +                                     "sleep_clk";
> As this is a new platform, it should not be using clock-names to bind
> gcc clocks. Please use clock indices instead.
Will update all as suggested,

Thanks,
Rohit.
>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +                       #power-domain-cells = <1>;
>> +               };
>> +
>>                  tcsr_mutex: hwlock@1f40000 {
>>                          compatible = "qcom,tcsr-mutex";
>>                          reg = <0x0 0x01f40000 0x0 0x40000>;
>> @@ -520,6 +547,14 @@
>>                          apps_bcm_voter: bcm_voter {
>>                                  compatible = "qcom,bcm-voter";
>>                          };
>> +
>> +                       rpmhcc: clock-controller {
>> +                               compatible = "qcom,sdx75-rpmh-clk";
>> +                               clocks = <&xo_board>;
>> +                               clock-names = "xo";
>> +                               #clock-cells = <1>;
>> +                       };
>> +
>>                  };
>>          };
>>
>> --
>> 2.7.4
>>
>
