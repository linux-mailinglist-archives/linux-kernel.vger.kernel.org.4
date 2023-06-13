Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4272DEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbjFMKAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbjFMJ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:59:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C281701;
        Tue, 13 Jun 2023 02:59:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D9wFh6003963;
        Tue, 13 Jun 2023 09:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ufUPbiatUXptd6DIdwAP3dnQZDjpTKViqvSPQwOlxfY=;
 b=efPv+J726zLy04AjXMbJInbK2jlr+h481+rAIRCXnT975ko1FYgob9TgBE50REP2OYcB
 XVb9K91zCmjSNnJxU3wcwD5JduzPBPbljTsAYvmjBkzFrVWKRFS/BVV42E4DgbHCrGu6
 tkY/u6zY7mladxaVBi2clr5K7tf3/pA7oDF3ErpSj/sC7TceLYpOB1uGwgLrzwMg6tPY
 Igwpxha6QhFuE9VNBxA9id3k401mwmzZfFIWrHOrO8eC1joOWGfXnVePCW9zDebsq9HI
 O8OFUYZ7k4xfbpXVCMvE10XA1rqHOJRZFGpfrRw57/6wjHU9f+XeELd7ml1k2Ait5xla ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r690q1c35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 09:59:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35D9xVdP012700
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 09:59:31 GMT
Received: from [10.218.22.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 02:59:25 -0700
Message-ID: <cc4e1339-f1d5-58e5-ba41-7bd5085f3c89@quicinc.com>
Date:   Tue, 13 Jun 2023 15:29:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V4 0/4] Add camera clock controller support for SM8550
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230609115058.9059-1-quic_jkona@quicinc.com>
 <09ccfa54-5ada-8dff-03a2-b2ffb07a58c1@linaro.org>
 <feebd8cd-7713-f086-356b-cc2657a9708e@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <feebd8cd-7713-f086-356b-cc2657a9708e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _ikaCyHA4kUCNX8BpdkQ7iSBoggDETUa
X-Proofpoint-GUID: _ikaCyHA4kUCNX8BpdkQ7iSBoggDETUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130087
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2023 2:07 PM, Krzysztof Kozlowski wrote:
> On 12/06/2023 04:25, Bryan O'Donoghue wrote:
>> On 09/06/2023 12:50, Jagadeesh Kona wrote:
>>> Add bindings, driver and devicetree node for camera clock controller on
>>> SM8550.
>>
>> This is very confusing.
>>
>> Your cover letter doesn't detail any changes and your individual patches
>> all say "no changes since v3", "no changes since v2"
>>
>> If this is a RESEND then mark it as a RESEND.
> 
> That's indeed odd. Three versions without changes...
> 
> Best regards,
> Krzysztof
> 

This is not a RESEND, actually there were changes from each version to 
next version and change details were updated in respective patches. But 
the patches in which changes were present were dropped in v4 based on 
review comments. Will take care of updating cover letter as well with 
changes across versions if we push the next series.

Please find the summary of changes across versions till v4.

Changes in v4:
  - Dropped the extra patches added in v2, since the review comments on 
v3 recommended an alternate solution.

Changes in v3:
  - Squashed 2 extra patches added in v2 into single patch as per review 
comments
  - Link to v3: 
https://patchwork.kernel.org/project/linux-clk/list/?series=753150

Changes in v2:
  - Took care of review comments from v1
  - Added 2 extra patches updating L configuration value across chipsets 
to include CAL_L and RINGOSC_CAL_L fields and removed setting CAL_L 
field in clk_lucid_evo_pll_configure().
  - Link to v2: 
https://patchwork.kernel.org/project/linux-clk/list/?series=751058

v1:
  - Initial CAMCC changes for SM8550
  - Link to v1: 
https://patchwork.kernel.org/project/linux-clk/list/?series=749294

Thanks,
Jagadeesh
