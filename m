Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BC715452
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjE3D7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3D7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:59:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9144494;
        Mon, 29 May 2023 20:59:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U2X6uw000824;
        Tue, 30 May 2023 03:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fQim3q8iOjpLNRj2uSbSbhxVGXrNRMfRVaKA9f/ozBk=;
 b=FuWxvZHkT2h7mQXM5XSOUBzo4yuO6KwEzuusyXZ613e7xiNE6pBf5XP1XBQ4c91WV1ja
 jM4cUeSIqqCiPmGMg4RboVVTFIofOJUQbuqXKIwgy94W0wZnGleHFwzCK5RL1jh6V21I
 yg6vGfBChLlEPGm9s+yM1JWKUfOo/5z6wb3vQZMlV5bRnGB9b4f5dKO5PHLYHdmBNdKY
 6Nex70F6rMht5QwFycq0wtjs9/8xh8s9AuyX/2O84k6FDJSjj3uAZKN91tD3k8bKRdV5
 2DCcM61Q5wzc9Q8ZGmHkH50O4lfLl2WV0bLIT+42I1l8MrrCcmUtUS/YKMN34vEg/NMy ZA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw7rtr5qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 03:59:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34U3x9NQ003442
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 03:59:09 GMT
Received: from [10.216.48.5] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 29 May
 2023 20:59:01 -0700
Message-ID: <c19122ca-58b7-a407-0ce3-41dab4218c81@quicinc.com>
Date:   Tue, 30 May 2023 09:28:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: (subset) [PATCH V3 0/5] Add APSS clock controller support for
 IPQ9574
To:     Bjorn Andersson <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>, <arnd@arndb.de>,
        <catalin.marinas@arm.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <jassisinghbrar@gmail.com>,
        <nfraprado@collabora.com>, <geert+renesas@glider.be>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <rafal@milecki.pl>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <broonie@kernel.org>
CC:     <quic_arajkuma@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230406061314.10916-1-quic_devipriy@quicinc.com>
 <168512991479.248818.11621497605486086318.b4-ty@kernel.org>
Content-Language: en-US
In-Reply-To: <168512991479.248818.11621497605486086318.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8g5kwYEPPjTnIhW8SIU3jAlS04W-2qzV
X-Proofpoint-ORIG-GUID: 8g5kwYEPPjTnIhW8SIU3jAlS04W-2qzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_01,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300031
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2023 1:08 AM, Bjorn Andersson wrote:
> On Thu, 6 Apr 2023 11:43:09 +0530, Devi Priya wrote:
>> APSS PLL found in IPQ9574 platform is of type Huayra.
>> This series adds support for the APSS clock to bump the CPU frequency
>> above 800MHz.
>>
>> DTS patch is based on the below series
>> https://lore.kernel.org/linux-arm-msm/20230404164828.8031-1-quic_devipriy@quicinc.com/
>>
>> [...]
> 
Thanks! To update on the dependency, This series does not hold any 
dependencies as the DTS patch cleanly applies on [1] which has already 
been picked up for linux-next.

[PATCH V3 4/5] arm64: dts: qcom: ipq9574: Add support for APSS clock 
controller

[1] - 
https://lore.kernel.org/linux-arm-msm/20230517072806.13170-1-quic_kathirav@quicinc.com/

> Applied, thanks!
> 
> [5/5] arm64: defconfig: Enable ipq6018 apss clock and PLL controller
>        commit: 3098f34977480c9aa75cf328501f1b47ec49fec7
> 
> Best regards,
