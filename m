Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9282762B15E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKPCgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiKPCgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:36:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86B31EE3;
        Tue, 15 Nov 2022 18:36:04 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG2M3LR006378;
        Wed, 16 Nov 2022 02:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/wZDpuE91CllGHxN7CVleKANvN3PHHDtLtCAsPlzH90=;
 b=aY5CljOJzHuRN56luzluHbZ+wA/pyiwHsO8GmTGCDKkQ4xhffnwRo+BtVoZxuYh8U+V8
 4GolIPVeqUoNT19cuUWnWUhL94jWvD/zwAiWIynv5Zv0Ms4JERDZGKQLteS/rlgkWy9Z
 N5jyYlzi/Ky7FrAHVSuNsUnP8RKo+HSI6nYr/J2hySvcGJ4chH7oCHGy5XcXQo6RATnO
 tBUVBDFUzsBXanNBdQMHyGzQIi98WSk2hRqeaDE3/Xgm55Zo4bhqlrfq2Yhux9UdTxr8
 H2xsBJHOYJLYybppy07Jk5Mx4kTxBWb03g8Zc43VaNZ/SOJ0mlyf1uh4xCVgo/t7+UuH 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvkw1rc9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 02:35:58 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AG2UUFT008128;
        Wed, 16 Nov 2022 02:35:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3kt4jm6d6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 02:35:57 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG2Zte5013677;
        Wed, 16 Nov 2022 02:35:57 GMT
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 2AG2ZvUt013698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 02:35:57 +0000
Received: from [10.216.30.230] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 15 Nov
 2022 18:35:52 -0800
Message-ID: <4a27136e-a6e3-a932-a063-cbcdebb9485e@quicinc.com>
Date:   Wed, 16 Nov 2022 08:05:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
To:     Bjorn Andersson <andersson@kernel.org>, <sboyd@kernel.org>
CC:     <johan@kernel.org>, <bmasney@redhat.com>, <agross@kernel.org>,
        <mturquette@baylibre.com>, <ahalaney@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221115152956.21677-1-quic_shazhuss@quicinc.com>
 <20221115171342.v37vq4cqe7pxatlk@builder.lan>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20221115171342.v37vq4cqe7pxatlk@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 815sP-xyYAK5Pw4MOzQBRd_D8Savvjm3
X-Proofpoint-GUID: 815sP-xyYAK5Pw4MOzQBRd_D8Savvjm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2022 10:43 PM, Bjorn Andersson wrote:
> On Tue, Nov 15, 2022 at 08:59:56PM +0530, Shazad Hussain wrote:
>> The three UFS reference clocks, gcc_ufs_ref_clkref_clk for external
>> UFS devices, gcc_ufs_card_clkref_clk and gcc_ufs_1_card_clkref_clk for
>> two PHYs are all sourced from CXO.
>>
>> Added parent_data for all three reference clocks described above to
>> reflect that all three clocks are sourced from CXO to have valid
>> frequency for the ref clock needed by UFS controller driver.
>>
>> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
>> Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
>> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>> Tested-by: Andrew Halaney <ahalaney@redhat.com>
>> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>> Reviewed-by: Reviewed-by: Brian Masney <bmasney@redhat.com>
> 
> Really-really-reviewed-by?  >
My bad, thanks for pointing it Bjorn :)
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> 
> @Stephen, could you please pick this for clk-fixes?
> 
> Thanks,
> Bjorn
> 
>> ---
>> Changes since v2:
>> -  Tweaked commit message and added R-b T-b from v2
>>
>> v2 of this patch can be found at
>> https://lore.kernel.org/all/20221115102217.6381-1-quic_shazhuss@quicinc.com/
>>
>> v1 of this patch can be found at
>> https://lore.kernel.org/all/20221030142333.31019-1-quic_shazhuss@quicinc.com/
>>
>> used below patches for verification on next-20221114
>> https://lore.kernel.org/lkml/20221104092045.17410-2-johan+linaro@kernel.org/
>> https://lore.kernel.org/lkml/20221104092045.17410-3-johan+linaro@kernel.org/
>> https://lore.kernel.org/lkml/20221111113732.461881-1-thierry.reding@gmail.com/
>>
>>   drivers/clk/qcom/gcc-sc8280xp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
>> index a18ed88f3b82..b3198784e1c3 100644
>> --- a/drivers/clk/qcom/gcc-sc8280xp.c
>> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
>> @@ -5364,6 +5364,8 @@ static struct clk_branch gcc_ufs_1_card_clkref_clk = {
>>   		.enable_mask = BIT(0),
>>   		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_ufs_1_card_clkref_clk",
>> +			.parent_data = &gcc_parent_data_tcxo,
>> +			.num_parents = 1,
>>   			.ops = &clk_branch2_ops,
>>   		},
>>   	},
>> @@ -5432,6 +5434,8 @@ static struct clk_branch gcc_ufs_card_clkref_clk = {
>>   		.enable_mask = BIT(0),
>>   		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_ufs_card_clkref_clk",
>> +			.parent_data = &gcc_parent_data_tcxo,
>> +			.num_parents = 1,
>>   			.ops = &clk_branch2_ops,
>>   		},
>>   	},
>> @@ -5848,6 +5852,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
>>   		.enable_mask = BIT(0),
>>   		.hw.init = &(const struct clk_init_data) {
>>   			.name = "gcc_ufs_ref_clkref_clk",
>> +			.parent_data = &gcc_parent_data_tcxo,
>> +			.num_parents = 1,
>>   			.ops = &clk_branch2_ops,
>>   		},
>>   	},
>> -- 
>> 2.38.0
>>
