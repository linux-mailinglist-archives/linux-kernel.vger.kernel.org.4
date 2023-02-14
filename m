Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8269692E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBNQTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjBNQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:19:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655AF20D14;
        Tue, 14 Feb 2023 08:19:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EDjOxm022845;
        Tue, 14 Feb 2023 16:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XdKgDDanY3q/UeLlA80gCU43iHWPPgGJXgFxI4JN8RQ=;
 b=LnN8mJEyWEECR8gzj3T6IIWQWEmk7s5+ACNcm2PJNqopLlbYwkaeCHXhbkMgAKpzw1wd
 ztkbesCnh4PWWKE4oslVrcFipm2RwuqOockOhqC1ksGGbiIJNS447Vb9wmOxbkBwfaPW
 lU/CypFpA/yXC06W9K21QgMALWtZlt+MSvMvVsqmnkqk42HZl+IzM2ENAzzBhYsjozt3
 nsXcf/zyyvpSA7INYx2J+ai4P2CuqjSbmO+qkE4fgzxLSNmmWgzVYJMbrVmxVFbldIXo
 BXk3DM4x5B5Apzl4mH9MHWdAxnWqHYqPaOy5co3rqyuAqqtXI5wrElRxoddztHqeRz2T FA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0ap8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:19:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGJQkd010675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:19:26 GMT
Received: from [10.50.22.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 08:19:22 -0800
Message-ID: <faaecb6c-4710-d26d-b992-388ae29907f7@quicinc.com>
Date:   Tue, 14 Feb 2023 21:49:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2] clk: qcom: ipq5332: mark GPLL4 as critical temporarily
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230206073101.14796-1-quic_kathirav@quicinc.com>
 <6fa247b53740ca760a608e1446f95c95.sboyd@kernel.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <6fa247b53740ca760a608e1446f95c95.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cr8Hdl27YA357zHAed2BUlOjouR2SJH7
X-Proofpoint-ORIG-GUID: cr8Hdl27YA357zHAed2BUlOjouR2SJH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=952 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140139
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/2023 3:44 AM, Stephen Boyd wrote:
> Quoting Kathiravan T (2023-02-05 23:31:01)
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
>> index c8a5fa1bafca..2e043d2d0598 100644
>> --- a/drivers/clk/qcom/gcc-ipq5332.c
>> +++ b/drivers/clk/qcom/gcc-ipq5332.c
>> @@ -127,6 +127,16 @@ static struct clk_alpha_pll gpll4_main = {
>>                          .parent_data = &gcc_parent_data_xo,
>>                          .num_parents = 1,
>>                          .ops = &clk_alpha_pll_stromer_ops,
>> +                       /*
>> +                        * There are no consumers for this GPLL in kernel yet,
>> +                        * (will be added soon), so the clock framework
>> +                        * disables this source. But some of the clocks
>> +                        * initialized by boot loaders uses this source. So we
>> +                        * need to keep this clock ON. Add the CRITICAL flag
>> +                        * so the clock will not be disabled. Once the consumer
>> +                        * in kernel is added, we can get rid off this flag.
> s/off/of/
>
> Does CLK_IGNORE_UNUSED work the same? It doesn't sound like a critical
> clk from the description of the comment.


Sorry, somehow I missed this response. Will update to CLK_IGNORE_UNUSED 
in V3.


>> +                        */
>> +                       .flags = CLK_IS_CRITICAL,
>>                  },
>>          },
