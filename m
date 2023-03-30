Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E36D0999
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjC3Pb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjC3PbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:31:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B8DBE5;
        Thu, 30 Mar 2023 08:31:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UBUWHj008825;
        Thu, 30 Mar 2023 15:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gCKhnWFEhd2dmMFgaQAZ3b/AKnYi7MqyuXP/Q+DJ4e4=;
 b=WJqQNEcek4grXYYFc/WRA8O0ueoDFpWbZSVsPCF4VeaCSyGgsBwc1PVOHDJ1Suj9cFwg
 xIPFmXCxpdtGrN+Ke2KUSQNKqXYYZAlgbHEQDen3tvHgst/FLJ5kJv4aQk9tEW/3B3yF
 QHQJg2DCDSiVzUMiP3b6h39mzNuM/FRnmY1GmKV+ZwN0qoJ8+g0N6+tRyaFnXgwA5Z5B
 IDFaUMH0DnzVIY/o6XbDN9cgYvUswRIZ2TxdunFDRwCBpLM+s5E9Uf30n08WOYwW4Bpi
 5j4Esz4dFYdr9DuAYxs5V5CLKTr40PmkYeHqrjxQS4qxKEgZx03uQZ5uH+0JQlw1AJXG Ig== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn9kgrrh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 15:30:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32UFUWFG012754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 15:30:32 GMT
Received: from [10.50.13.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 30 Mar
 2023 08:30:28 -0700
Message-ID: <57a4a970-8e50-c0ac-962a-6bb1ebf337f1@quicinc.com>
Date:   Thu, 30 Mar 2023 21:00:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 0/2] Add few device nodes for IPQ5332 SoC
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230320104530.30411-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230320104530.30411-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z5l5kQf4nWLf5ccqzv--hHIyHOegO5ha
X-Proofpoint-ORIG-GUID: z5l5kQf4nWLf5ccqzv--hHIyHOegO5ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=719 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300123
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2023 4:15 PM, Kathiravan T wrote:
> This series adds the support for QUP peripherals, PRNG, WDT for IPQ5332
> SoC.
>
> This series depends on the below patch, due to the node ordering
> https://lore.kernel.org/linux-arm-msm/20230217083308.12017-6-quic_kathirav@quicinc.com/#t


Gentle Reminder...


>
> Kathiravan T (2):
>    dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq5332 compatible
>    arm64: dts: qcom: ipq5332: add few device nodes
>
>   .../bindings/watchdog/qcom-wdt.yaml           |  1 +
>   arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   | 14 ++++
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 67 +++++++++++++++++++
>   3 files changed, 82 insertions(+)
>
