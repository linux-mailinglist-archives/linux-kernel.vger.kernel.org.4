Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED567B0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjAYLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:12:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06885245;
        Wed, 25 Jan 2023 03:12:13 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P9hNvE021293;
        Wed, 25 Jan 2023 11:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cwPZEAwG3kJNq20afg+KRj0R9I20txiVUCJM6INRiWY=;
 b=eB45XUegccbWvVS0w247+aK505BvgvgN2MnnM/EjMDqEHs6U90h26Ct0E3uM4PRVdyQC
 tBSJrEFfaLT2CvIqv4oDfBs51buc3Opzql7MVnLDZcGnfHCbx6jWNap67mjxVMTwfjOQ
 GjtcZfLM6f+FmLNtw8EI5vtvNtu+Se4yVjQujS7rC5QbbsTUWcFfiISK4uwK/VObx8g5
 5L7nDoCjwkvD2ouMcEyn36ILE6qz5AtZbr/kj5LF/oqHWhv2+ObBuQJ7MHhKkgvPYerS
 PUrvdjK7gE5wXFmPtS/ZLGoUEOnNvSwkkzaY3j/daDuwAWPNDvM2q4ngbXf2cEs0jBoi EQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk6xt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:11:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PBBVue021907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:11:31 GMT
Received: from [10.50.14.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 03:11:22 -0800
Message-ID: <f81e4605-9111-7f70-abb3-72067d68f8e2@quicinc.com>
Date:   Wed, 25 Jan 2023 16:41:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V1 0/8] Add minimal boot support for IPQ9574
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <marcel.ziswiler@toradex.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <tdas@codeaurora.org>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230124141541.8290-1-quic_devipriy@quicinc.com>
 <5331527f-a96c-1c1b-dcf5-8f7e5957814d@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <5331527f-a96c-1c1b-dcf5-8f7e5957814d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HLgW6i7oLREm8pxqnCqZvSUEWLUYAW2A
X-Proofpoint-ORIG-GUID: HLgW6i7oLREm8pxqnCqZvSUEWLUYAW2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=697 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250102
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 8:02 PM, Krzysztof Kozlowski wrote:
> On 24/01/2023 15:15, devi priya wrote:
>> The IPQ9574 is Qualcomm's 802.11ax SoC for Routers,
>> Gateways and Access Points.
>>
>> This series adds minimal board boot support for ipq9574-al02-c7 board
>>
>> [V1]
> 
> You already sent a v1. This should be v2.
> 
>> 	Fixed all the review comments
> 
> That's not specific enough.
> 
Okay, got it. Will add the changelogs, address few minor comments on 
this series and post V3
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
