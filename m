Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964006CFFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjC3JTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC3JSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:18:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D3172A;
        Thu, 30 Mar 2023 02:18:37 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U8lhXP013501;
        Thu, 30 Mar 2023 09:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qmGkvGd4ktq1l/QDvk5WbJ3XQOI7H5CxYNwOBRXa/FA=;
 b=W5zcyq4uPZk0yygVF/+epdDqQFvXYdMCmyamBJCG4SooB0oST4HF7mbVkBFI06ePamyE
 F3+ueQXLA5J/shFfXott7a82njNk8q6tfC3tzPLjo3vMcuVzwqCQgUPTIb+FHUGIcovh
 JUo68XFNHZRnO0rbxFbcvwQTrm2ZeXBK4pT8exYBwzc+/v+7Zw4+c1Ps2iOoAOPJR9Kt
 U0R6cotpORl2hjmDrysbpGgfPed7bIEmCufwkCLTPnWppa+kMjxHyPW+VnNi+mVPvUf4
 b+5YAZ/a1PdCzIRQKp0YKhns0ajGzvqJWbuJVQsYWPJaMfx25wv8hsqKbRVS609BRROg PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn51ygg01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 09:18:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32U9IDal010154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 09:18:13 GMT
Received: from [10.50.5.192] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 30 Mar
 2023 02:18:04 -0700
Message-ID: <4be7554b-eba7-5c72-f040-9b9f12bfb3d9@quicinc.com>
Date:   Thu, 30 Mar 2023 14:47:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V10 2/4] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <arnd@arndb.de>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel.ziswiler@toradex.com>, <mturquette@baylibre.com>,
        <nfraprado@collabora.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <shawnguo@kernel.org>, <will@kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230327132718.573-1-quic_devipriy@quicinc.com>
 <20230327132718.573-3-quic_devipriy@quicinc.com>
 <0af15083921c5d3c89392209654f0c9b.sboyd@kernel.org>
 <2484518b-bcf6-7fb1-6bfb-b96b3682397b@quicinc.com>
 <1cfd584a48e1bb453596948a0187ecf1.sboyd@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <1cfd584a48e1bb453596948a0187ecf1.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CkK5fHF6YxF7BIdqV0rOIUxMQspOyjII
X-Proofpoint-GUID: CkK5fHF6YxF7BIdqV0rOIUxMQspOyjII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_04,2023-03-30_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=740
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300075
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2023 10:29 PM, Stephen Boyd wrote:
> Quoting Devi Priya (2023-03-27 23:15:35)
>>
>>
>> On 3/27/2023 10:18 PM, Stephen Boyd wrote:
>>> Quoting Devi Priya (2023-03-27 06:27:16)
>>>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
>>>> new file mode 100644
>>>> index 000000000000..b2a2d618a5ec
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>>>> @@ -0,0 +1,4248 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +/*
>>>> + * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_device.h>
>>>
>>> What is this include for?
>> This include actually don't seem necessary. But, I see that of.h &
>> platform_device.h are being included via of_device.h
>> Would you suggest to drop of_device.h or the other two
>> headers instead?
> 
> Include headers for things you use. Don't try to omit includes if you
> see that a header includes other headers that you're using.
Sure, got it!

Regards,
Devi Priya
