Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726A5719FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjFAOVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjFAOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:21:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80519F;
        Thu,  1 Jun 2023 07:21:34 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Ccfnw013844;
        Thu, 1 Jun 2023 14:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lJPdbz7A/B8+30UyfEG0+4oTiCnmLB62xHI9CLsg4z4=;
 b=ZJe3XiTcNkxRL90vgrf9hhw8X2yDJeqWtJYz++GgyqCji0N+aoKsqXrwKfYQdmJuKvsg
 t8K62lUnMQdDVi0FmF5XrhJ8vmsO01mgHAqGxBtHrzS8HX5JoViRIUKYdZ2ZnrnEOfl7
 Y3xSjTLPDCUbmXiK3oMux+1Zj6hc1iuTgvMV0A2IdVYLWLPe8ayLpNh9D979zHtzVWAe
 W8MnPbsiRwovt1voPsFnSankdV0FSS1QI4X1vs8I8536+5/IfOHZOBmHtQ7fkk/axS4c
 Xz/aZ0lRJTAM+fH/Ox2aq92urWkjWRMUniRkPQo9kPlunUEl8ZPGT5IQl+J7hvVY3iDs bA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr88uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:21:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351ELSiw027023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:21:28 GMT
Received: from [10.217.216.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 07:21:23 -0700
Message-ID: <a97da679-7ac8-78f8-9b3d-5df8f690287f@quicinc.com>
Date:   Thu, 1 Jun 2023 19:51:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2 3/6] clk: qcom: clk-alpha-pll: Remove explicit CAL_L
 configuration for EVO PLL
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-4-quic_jkona@quicinc.com>
 <240fa683-afb1-eb60-c24f-2b3f1d7f1339@linaro.org>
 <58310306-2d70-eab4-4564-e77e1fb638a1@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <58310306-2d70-eab4-4564-e77e1fb638a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6RF3Uf2koquMTvwMtElwIQ5q3f3L0cal
X-Proofpoint-ORIG-GUID: 6RF3Uf2koquMTvwMtElwIQ5q3f3L0cal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=635 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010126
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thanks for your review!

On 5/26/2023 9:27 PM, Bryan O'Donoghue wrote:
> On 26/05/2023 16:54, Bryan O'Donoghue wrote:
>> On 25/05/2023 18:21, Jagadeesh Kona wrote:
>>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL 
>>> configuration interfaces")
>>
>> Is this a "Fixes" without the previous patch to stuff the CAL_L_VAL 
>> and VAL_L fields ?
>>
>> [PATCH V2 3/6] clk: qcom: clk-alpha-pll: Remove explicit CAL_L 
>> configuration for EVO PLL
>>
>> Surely you need _both_ with this patch depending on the previous, per 
>> your comment ?
>>
>> -    .l = 0x3e,
>> +    /* .l includes CAL_L_VAL, L_VAL fields */
>> +    .l = 0x0044003e,
>>
>> ---
>> bod
> 
> i.e. if you pick up this patch on its own you won't populate 
> CAL_L_VAL... right ?
> 
> It would make more sense to squash the two patches.
> 
Sure, will squash both the patches in next series.
> ---
> bod

Thanks & Regards,
Jagadeesh
