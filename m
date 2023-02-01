Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92208685F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBAGEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBAGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9C75C0F1;
        Tue, 31 Jan 2023 22:03:46 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114gsJQ016664;
        Wed, 1 Feb 2023 06:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ULvukXogcVn9wE3EN8BR4B6ir8Z3u1/ddTBkjvA/3lI=;
 b=KOTJdOZXzsiPsfnwuNTUr1ABT+0l3I/lqn95uqfPWNL794mH/J5oaDs+fNUNykBcJCBm
 0oMaI9q2OTlD5u3lEWHsdvP/7bNxaBAtYmqaldCcQYzKfiIy9edEnnZ+JJtCJC23kM+9
 1jACUHqe10yA2siaZiWffgxKWCxr6e/U6NHHUAKXKjuOCnm2+7cL9ERSUTAv3CReQ0lm
 VbTZfM0x5EfiIyIeswFEShkzmebpSvW0lMhdc78Z79l+pQfWoRZNUedY3NHxmMLUSwcp
 0N5GRlRho5X0pzpyloXPj+0pASNUWA0Xn9YVRCU/ITpdFqNmJRjCbgnj+/+sleG8tLBZ ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3netc4bekr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:03:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31163fQB002760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:03:41 GMT
Received: from [10.50.28.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 22:03:38 -0800
Message-ID: <f14522e0-a29d-e8d2-ab4c-9936b560f2bf@quicinc.com>
Date:   Wed, 1 Feb 2023 11:33:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] clk: qcom: ipq5332: mark GPLL4 as critical temporarily
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
References: <20230130120959.9457-1-quic_kathirav@quicinc.com>
 <1ce59ea1c33c4983a9c3c82be078d8be.sboyd@kernel.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1ce59ea1c33c4983a9c3c82be078d8be.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V92utemS3gLqcDygXsubrloe1b6vv5Dx
X-Proofpoint-ORIG-GUID: V92utemS3gLqcDygXsubrloe1b6vv5Dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=753 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010051
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 2:47 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2023-01-30 04:09:59)
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
>> index a8ce618bb81b..6159d0e1e43f 100644
>> --- a/drivers/clk/qcom/gcc-ipq5332.c
>> +++ b/drivers/clk/qcom/gcc-ipq5332.c
>> @@ -127,6 +127,7 @@ static struct clk_alpha_pll gpll4_main = {
>>                          .parent_data = &gcc_parent_data_xo,
>>                          .num_parents = 1,
>>                          .ops = &clk_alpha_pll_stromer_ops,
>> +                       .flags = CLK_IS_CRITICAL,
> Please add a comment above this line that indicates why this is
> critical. What clk needs to be added that will actually use this? If
> nothing is ever going to use the PLL then maybe we should simply not
> register this PLL with the clk framework?
Sure, will add the comment in the code also.

There are bunch of WCSS, Q6, QDSS, PCIE clocks uses the GPPL4 as source. 
Few of them are getting disabled by clock framework since there are no 
consumers yet (which will added soon) and few of them are yet to be 
added. So we cannot leave out this PLL. If any one of the consumer is 
enabled, this patch can be reverted.

