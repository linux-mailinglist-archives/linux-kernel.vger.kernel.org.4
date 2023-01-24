Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1186791D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjAXHVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjAXHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:21:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5A7ED6;
        Mon, 23 Jan 2023 23:21:06 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O6xe2l023429;
        Tue, 24 Jan 2023 07:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8g7RbTttaL7ha3Ce8e9aBztnaF3yrIRQQJN0M0h3IvA=;
 b=G2Kh8PT/pALW6C8575DGfB6y4lxUpIOLhb5wNgGESgF8dHxCNgjtd+sA8Vci/UjnsqmH
 jcyZrlTA6ZZNpik8DMlXDuwTH7tU3PhdQGEKFf4z4j49+sWsbcOQs8q5H4q+JkwQDUBy
 OdVMsjvGb+3e1nsiKqrpUqwkTW6cd0lcFSRTDWKygk1ASkl+wAHcgdf7BPg9Ds/cDMwD
 TsG1k5FU7wfxsRuyqlM2PFMqYGRu09XsMm6N4gM/zP1YDJyrX2ojSlliz4hsZrlE4Ios
 kE869tJbNQSrg6+NLkz42pLzAc+Fki/LlePksE64Bij53kfIvIvowefiqh+Mms1KDXKa 2w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89k9cj2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 07:20:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O7K7C3003086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 07:20:07 GMT
Received: from [10.216.24.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 23:19:56 -0800
Message-ID: <278a2e6e-69e0-81b0-f476-571edea950ff@quicinc.com>
Date:   Tue, 24 Jan 2023 12:49:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <f6ef1834-b629-b76c-9cde-55af56320665@linaro.org>
 <7f157b73-f856-04d2-1b39-e1f8861d0439@quicinc.com>
 <84aa79c3-b793-0d0e-d6a5-035aff5a17b4@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <84aa79c3-b793-0d0e-d6a5-035aff5a17b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p3i6Ue8nP7RVr6YJKd1ainlBOXIIHVIl
X-Proofpoint-GUID: p3i6Ue8nP7RVr6YJKd1ainlBOXIIHVIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=700 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240066
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 7:50 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 14:29, Devi Priya wrote:
>>>> +
>>>> +	soc: soc@0 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		ranges = <0 0 0 0xffffffff>;
>>>> +		compatible = "simple-bus";
>>>> +
>>>> +		tlmm: pinctrl@1000000 {
>>>> +			compatible = "qcom,ipq9574-tlmm";
>>>> +			reg = <0x01000000 0x300000>;
>>>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			gpio-controller;
>>>> +			#gpio-cells = <2>;
>>>> +			gpio-ranges = <&tlmm 0 0 65>;
>>>> +			gpio-reserved-ranges = <59 1>;
>>>
>>> Hm, why reserved ranges are in SoC?
>> As the gpio is forbidden on all ipq9574 boards, we have added it in SoC
> 
> Why it is forbidden on all boards? I guess it depends on the firmware
> and this can differ, can't it?
> 
This GPIO is protected and used by the TZ firmware and is forbidden on 
all the boards & firmware
> Best regards,
> Krzysztof
> 
Regards,
Devi Priya
