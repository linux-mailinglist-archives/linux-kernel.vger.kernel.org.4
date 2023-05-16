Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1570500B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjEPN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjEPN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:57:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987A524D;
        Tue, 16 May 2023 06:57:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G8ZC9c006803;
        Tue, 16 May 2023 13:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v61rcOi3KNj5WsTzaVTHYwKLSjF1cOcY4GOZ0UTMp4s=;
 b=njFgNDjzI+kk8fMHt5BBlJ3GXJ+VY/xlNg/eNwPI/ywCdCdQqlLNiEa41JLp/bJlOQmP
 MrnNiUMicrVvficB13hOkzQ1SEaSRT7YV33sNwTX+oMsnDUxwWCyIa2uZyGfShGNqhB8
 R8mEfuu4V9jGhrrijDUrWpx0b+VP43REG8XZUx0o6+NNVAmLgPc/YIFjn5axfpaA9JJt
 e3CrelGt67jVzjR29KrwsOEzHYU4BEJSsjJPoTrQOvPTayS+HZaMBXi6uX5ERu9kcydk
 +LqobzarBhaO1R6LA4naH70HJT4H0qOWg/IfXY3PGJ0/teUy/kPJJEsau9jlKm1Ghx+l lg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjscucqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:57:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GDvLsZ020868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:57:21 GMT
Received: from [10.50.13.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 06:57:15 -0700
Message-ID: <950096ec-5a2b-a07e-e604-f3f7bd3a0117@quicinc.com>
Date:   Tue, 16 May 2023 19:27:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Add initial support for RDP418 of IPQ9574 family
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230510104359.16678-1-quic_devipriy@quicinc.com>
In-Reply-To: <20230510104359.16678-1-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: esb4lFbAjW5BuopSJ0jpOZbKyZsF6huz
X-Proofpoint-ORIG-GUID: esb4lFbAjW5BuopSJ0jpOZbKyZsF6huz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=817 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160117
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 4:13 PM, Devi Priya wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 418 based on IPQ9574 family of SoC. This patch series adds
> support for Console UART, SPI NOR, eMMC and SMPA1 regulator node.
>
This series depends on the below patch sets which adds support for
SPI NOR and SMPA1 regulator nodes.
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/

Thanks,
Devi Priya
> Devi Priya (2):
>    dt-bindings: arm: qcom: document AL02-C2 board based on IPQ9574 family
>    arm64: dts: qcom: ipq9574: add support for RDP418 variant
> 
>   .../devicetree/bindings/arm/qcom.yaml         |   2 +
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts   | 124 ++++++++++++++++++
>   3 files changed, 127 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
> 
> 
> base-commit: 52025ebbb518a2d876b8aba191b348ffb1cf368b
