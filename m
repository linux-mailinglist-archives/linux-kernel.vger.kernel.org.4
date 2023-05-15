Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00B7025C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbjEOHNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjEOHNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:13:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529EE6D;
        Mon, 15 May 2023 00:13:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F6Jm4v011633;
        Mon, 15 May 2023 07:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TtMMfLL5nCFr68O0x6kk9AsNmzhF3MX3q5iwKJo0uLg=;
 b=DkX/6/q0mCXyoe2Q8R8cIuGv1/XR7wmJh71lfFbfB8twrQ5TRU3FI+/vgF2tsVjVN8wZ
 bLJ6lPQH7xf7rdj1aIhi6uXmdDTYGF47XOO0Y1LKmsFitJ8QQkmcjuzaD+XbyBq0e8Ki
 WRcZti94U7Kn55knRuMmXBMiptnK9c5X7YLUUGk1QcsJPIkvyut/zneV0qBsnTaOqRsn
 zKs3GcJc/lJXkv/X9fkkcPu+y+fPlQGiOMJtg1N4uwG4JMk6Q01rk/cVU4dC92AEejz1
 1EDKHh/EqJmPjukPl4wT9PhLL9mZ4Acb2WtTuOEd1ynMHPldNBPbfAq3DnlULlkc9Sv/ 6A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj2xdaxmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:13:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F7CbeU026358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:12:37 GMT
Received: from [10.216.63.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 00:12:30 -0700
Message-ID: <b90211ca-acdd-0845-8c44-47a84e747fa4@quicinc.com>
Date:   Mon, 15 May 2023 12:42:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] clk: qcom: gcc-ipq9574: Enable crypto clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230512090134.9811-1-quic_anusha@quicinc.com>
 <20230512090134.9811-2-quic_anusha@quicinc.com>
 <7496f2a8-db87-ffec-8ea8-2f9ff7511a75@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <7496f2a8-db87-ffec-8ea8-2f9ff7511a75@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kEr-t2CWcp0eGOXgnKkYSN9Baw4jB_Fb
X-Proofpoint-GUID: kEr-t2CWcp0eGOXgnKkYSN9Baw4jB_Fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=948 priorityscore=1501 mlxscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150064
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/2023 2:50 PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 11:01, Anusha Rao wrote:
>> Enable the clocks required for crypto operation.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq9574.c               | 72 ++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h |  4 ++
>>   include/dt-bindings/reset/qcom,ipq9574-gcc.h |  2 +-
> Bindings are always separate patches.

Okay, will address in the next spin.

Thanks,

Anusha

>
> Best regards,
> Krzysztof
>
