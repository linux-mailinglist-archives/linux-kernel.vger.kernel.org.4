Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7175F6C505C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCVQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCVQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:19:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131056E96;
        Wed, 22 Mar 2023 09:19:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBnQJ3007798;
        Wed, 22 Mar 2023 16:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=emt2nFclvijCJPmzUPqyfZAG/M+5FrVGUpsJxVKKHuI=;
 b=DuWkTse+FJMx1qKG1XCwsJTKpdn8sc2nXX0Ki1510MQ+8wwZecExtR/91q6MShFvklhP
 4UvWmPTRFbXpTYOYwUjriKkDFC7ucu3E4/JTBAbjOKRSRET66YnQ93g/bI4BtgfXGyQk
 BFVNe6OtKbBlcqNvGmJfLYvblU4l3zavclzDwguiPkrzyARMOKFdydZVmMndUwpHoi5f
 Xp0hWbKdbSr1DBmfHV08jtBJ7sUkcawveuOTP+h6DLGK+WaXL3PH7icoRRxNRCj6qToO
 q7KURp4sQANSmU00shaIrfz0Rs5vioxqwr0cuRQ5xe7MQjxaNcrSYS8wAIv06M7XZYi8 og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfhnv2p1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 16:19:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MGJMrd020204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 16:19:22 GMT
Received: from [10.50.28.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 09:19:17 -0700
Message-ID: <52967ff4-0ca7-463e-1b62-df455584f199@quicinc.com>
Date:   Wed, 22 Mar 2023 21:49:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 0/5] Add APSS clock driver support for IPQ5332
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230217083308.12017-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230217083308.12017-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3LcisabJFNk_pKSgd78I04FWdTR_z4Ya
X-Proofpoint-ORIG-GUID: 3LcisabJFNk_pKSgd78I04FWdTR_z4Ya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=837 clxscore=1011 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220115
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/2023 2:03 PM, Kathiravan T wrote:
> This series adds support for the APSS clock to bump the CPU frequency
> above 800MHz.
>
> APSS PLL found in the IPQ5332 is of type Stromer Plus. However the
> existing IPQ targets uses the Huayra PLL. So the driver has to
> refactored to accommodate the different PLL types. The first patch in
> the series does the refactoring, which can be independenty merged.
>
> For the Stromer PLL separate function clk_stromer_pll_configure is
> introduced, so the 3rd patch in the series depends on the below patch
> https://lore.kernel.org/linux-arm-msm/20230120082631.22053-1-quic_kathirav@quicinc.com/
>
> DTS patch depends on the IPQ5332 baseport series
> https://lore.kernel.org/linux-arm-msm/20230130114702.20606-1-quic_kathirav@quicinc.com/
>
> Changes since V2:
> 	- Pick up R-b tags and sort the node in DTS
> 	- V2 can be found at
> 	   https://lore.kernel.org/linux-arm-msm/20230208042850.1687-1-quic_kathirav@quicinc.com/
>
> Changes since V1:
> 	- Dropped the patch 5/6, since the fallback mechanism for compatible
> 	  is introduced to avoid bloating the of_device_id table
> 	- V1 can be found at
> 	  https://lore.kernel.org/linux-arm-msm/20230202145208.2328032-1-quic_kathirav@quicinc.com/


Gentle Reminder ...


>
>
> Kathiravan T (5):
>    clk: qcom: apss-ipq-pll: refactor the driver to accommodate different
>      PLL types
>    dt-bindings: clock: qcom,a53pll: add IPQ5332 compatible
>    clk: qcom: apss-ipq-pll: add support for IPQ5332
>    dt-bindings: mailbox: qcom: add compatible for the IPQ5332 SoC
>    arm64: dts: qcom: ipq5332: enable the CPUFreq support
>
>   .../bindings/clock/qcom,a53pll.yaml           |   1 +
>   .../mailbox/qcom,apcs-kpss-global.yaml        |  18 ++-
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  37 ++++++
>   drivers/clk/qcom/apss-ipq-pll.c               | 116 +++++++++++++++---
>   4 files changed, 147 insertions(+), 25 deletions(-)
>
