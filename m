Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894A685F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjBAFoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAFo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:44:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424453E4E;
        Tue, 31 Jan 2023 21:44:27 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114ppdE019207;
        Wed, 1 Feb 2023 05:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yyrvuqIAayvmV3kjDmLIH/MLDWztKQ2tswffEB2Aw6c=;
 b=NhWSU4lIei+ZoVKatpRzQlrwMal6D2NMWqKsazwMlWmIYAXK00ChIEoTBtIuw+DRQtul
 Ap0RVg9ds8s6OAwoie+0SvBX5JdKKaDBvqkXoILIkSaKhsdmWRKphWdoa9ySAmMUI4lQ
 xVL9h/OYmyayw9NFtMz1C2Mf9ZU6H23xI+Tbwv91u+m5emUiz49sDBNK3TgM+3r/A45R
 jW41vMRB+qsyV1Jrb5PdfoAaSCKqzaeWVtF/XtdOIFvXC0vU2SEi+4WKcuAP32zwp32o
 +tvfHMGvrjpRF+hO/FA6S4Px2XDVUrg4Reagq6faSb0FSFFQ6jbuhSO592t32Hhb7Nv4 2w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nexn8jhtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 05:44:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3115i5l8006932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 05:44:05 GMT
Received: from [10.50.28.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 21:43:58 -0800
Message-ID: <f463564a-5ac4-8ef0-30c8-2e4b3580b5d8@quicinc.com>
Date:   Wed, 1 Feb 2023 11:13:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 0/9] Add minimal boot support for IPQ5332
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
 <cf41cb9f-e633-c0e5-95cc-98b2a4312886@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <cf41cb9f-e633-c0e5-95cc-98b2a4312886@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nOqB_B2vyEgOJg99S6acB6PPYO3I9RrB
X-Proofpoint-ORIG-GUID: nOqB_B2vyEgOJg99S6acB6PPYO3I9RrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=781 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010048
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 12:57 AM, Krzysztof Kozlowski wrote:
> On 30/01/2023 12:46, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> The IPQ5332 is Qualcomm's 802.11ax SoC for Routers, Gateways and
>> Access Points.
>>
>> This series adds minimal board boot support for ipq5332-mi01.2 board.
>>
>> Also, this series depends on the below patch
>> https://lore.kernel.org/linux-arm-msm/20230120082631.22053-1-quic_kathirav@quicinc.com/
> You sent it even before answering to me in old thread, so even before
> giving me a chance to read your answer... Don't send v2 before we finish
> discussing previous one.


Got it, I have responded to your queries in V2. I will wait for couple 
of days to see if any other comments are coming in.


>
> Best regards,
> Krzysztof
>
