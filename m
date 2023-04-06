Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C56D9500
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjDFLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDFLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:23:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603AF19AF;
        Thu,  6 Apr 2023 04:23:08 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336AWu52004927;
        Thu, 6 Apr 2023 11:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BzMPYlTxxXBfHEULtkkKX2NInG+vQ7gKm/cq+yJMqQU=;
 b=d8eTDB/ZzWmI/eaGP8WVFxS5aZykBrmBMzpMgBn2iBaNuX9OJ2RW5luu+SGUP879JhH8
 SuDwfeyGFzTtHf7HbC7ZuXWOq8/MI0WVu/0H8JFBHvlHyc/oyM9nH9/msi3GFIRJbqSu
 A7/wgCYDYE9A+WVGL1INdKwbxXXNvrKjvSBOcb5lZvfLu0z44s/TimwzMyR3TPdufh+l
 lZmtwRRzdAuBg3lJwyn3zz0zzq8VyJLs5rGcvU8a1ZxG26z+GlMiD8wMonnZIqU4H0Py
 UN2o55IJJCvV4S8usoT7hGcxA36zQWz4KxEMfV9pcGna1yOIB2B4avTvYFi0ITbTU93M /w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psmyx12ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:23:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336BN4rV001928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 11:23:04 GMT
Received: from [10.50.18.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 04:22:54 -0700
Message-ID: <147f58fc-75d2-708c-1392-f76fa380b6ed@quicinc.com>
Date:   Thu, 6 Apr 2023 16:52:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 0/2] Add initial support for RDP468 of IPQ5332 family
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230323093120.20558-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230323093120.20558-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _RNGdXeHSw4o9h9AXcXI9M6N7__s3UxB
X-Proofpoint-ORIG-GUID: _RNGdXeHSw4o9h9AXcXI9M6N7__s3UxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_05,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=887
 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060099
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2023 3:01 PM, Kathiravan T wrote:
> Add the initial device tree support for the RDP(Reference Design
> Platform)468 based on IPQ5332 family of SoCs. This patch carries the
> support for Console UART, SPI NOR, eMMC.
>
> This series depends on the below which adds support the SPI NOR
> https://lore.kernel.org/linux-arm-msm/20230320104530.30411-1-quic_kathirav@quicinc.com/
>
> V1 can be found here
> https://lore.kernel.org/linux-arm-msm/20230323044929.8694-1-quic_kathirav@quicinc.com/


Gentle Reminder...


>
> Kathiravan T (2):
>    dt-bindings: arm: qcom: document MI01.6 board based on IPQ5332 family
>    arm64: dts: qcom: ipq5332: add support for the RDP468 variant
>
>   .../devicetree/bindings/arm/qcom.yaml         |   2 +
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts   | 103 ++++++++++++++++++
>   3 files changed, 106 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
>
