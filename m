Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E009170FDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjEXSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:18:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DF798;
        Wed, 24 May 2023 11:18:03 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OI33aT017618;
        Wed, 24 May 2023 18:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4Wi0OpwymlLmeUg3P+otgQp0h6aotCD062ARf6rNpGE=;
 b=oFON1pTDXplwQ4a1vX1tKpAIHXEwx2z/D7xfyUtv4BrWqehKo25Muq9OZUA6e8UZS6Dt
 HHjRCm60AgDmgOV8xekI4ioEKERIZ512ihiImQWj3wzVWHOoPE4Nu39HzVh+6z8NDoaK
 w6K5x9SaRMTPQCvtjR74srXI6ozYKnvDUhEEUjQ7+zNnsxVwB+Ph3JmSPeJyAoqCcUvE
 ZPz/IuxdT1UPpnKgfe6jdcup8AoMCBok76/Vam41Pv5tBL0Te3qXq7oLplw5Nspy3spA
 b595SIuLMQ8rNXCLMu09tD1l15j3WTD2tHH87OJd1CFGv6FK8KCbt/YpvLuL7z9bADT6 ZA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsqgyr1af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:17:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OIHv1F005936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:17:57 GMT
Received: from [10.216.58.102] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 11:17:52 -0700
Message-ID: <7c8e76ea-75c9-4821-e962-b15505b82f85@quicinc.com>
Date:   Wed, 24 May 2023 23:47:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] clk: qcom: gpucc-sm8550: Add support for graphics
 clock controller
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
References: <20230519213656.26089-1-quic_jkona@quicinc.com>
 <20230519213656.26089-3-quic_jkona@quicinc.com>
 <0ce92028-d69d-8c4d-c912-a3daf0ce3d33@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <0ce92028-d69d-8c4d-c912-a3daf0ce3d33@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VI0KCCD9zdJ02BTLE6ZYmjDoYp9drHm3
X-Proofpoint-GUID: VI0KCCD9zdJ02BTLE6ZYmjDoYp9drHm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240151
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 5/20/2023 4:35 AM, Dmitry Baryshkov wrote:
> On 20/05/2023 00:36, Jagadeesh Kona wrote:
>> Add support for gpucc driver on SM8550, which provides clocks for the
>> graphics subsystem.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> 
> Jagadeesh, if you are submitting a patch, your sign-off should be the 
> last one. If Taniya participated in development of the driver, you might 
> want to add the "Co-Developed-by" tag in addition to existing ones.
> 
Yes, will take care of this in next series.

>> ---
>>   drivers/clk/qcom/Kconfig        |   8 +
>>   drivers/clk/qcom/Makefile       |   1 +
>>   drivers/clk/qcom/gpucc-sm8550.c | 609 ++++++++++++++++++++++++++++++++
>>   3 files changed, 618 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gpucc-sm8550.c
>>
> 
> [skipped]
> 
>> +static int __init gpu_cc_sm8550_init(void)
>> +{
>> +    return platform_driver_register(&gpu_cc_sm8550_driver);
>> +}
>> +subsys_initcall(gpu_cc_sm8550_init);
> 
> module_device_driver
> 
We need to evaluate if module_init_call works for all our usecases,
we will revisit and post a cleanup patch once we conclude module_init is 
sufficient for all our usecases.

>> +
>> +static void __exit gpu_cc_sm8550_exit(void)
>> +{
>> +    platform_driver_unregister(&gpu_cc_sm8550_driver);
>> +}
>> +module_exit(gpu_cc_sm8550_exit);
>> +
>> +MODULE_DESCRIPTION("QTI GPU_CC SM8550 Driver");
>> +MODULE_LICENSE("GPL");
> 

Thanks & Regards,
Jagadeesh
