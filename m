Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2606A709786
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjESMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjESMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:49:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64110D;
        Fri, 19 May 2023 05:49:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCfMEd010937;
        Fri, 19 May 2023 12:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tW7XMojtMQEt6J2v4a7YF/Eq8TagwToKFnCh3vS4BH8=;
 b=eBctXOCA1Uhu1uEGzjE+lau5pstP2LB/3pHxiOUQW+l8qDm13GT2AI351XRPyC9FfBn+
 BlvwD313CIAqn7xVblfdrQIia8Jvq96iXTFrzWHj7Mxzus8ESNH3HRyAsvNLEv+g3UKy
 7GsayqXtvw+gzpVNzy3rAH4DxJIum1BltuVJxleOOIMOrocZLixfGXbDkX6qHXNdC60W
 UZFuO6z4KK+v7qswvly46V4dlJ1KaxB3wmJoijw3iUmSu7RKY2DT0+sxZStn4nQPBDQ1
 J2Z/kgOlFSMdWhSaXFmIp+MlhXtuRIssYbglRTjp8sT1XFOH/octV10SQjy0ajU9Piih Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp2e98w4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:49:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JCnUSu025704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:49:30 GMT
Received: from [10.217.216.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 05:49:26 -0700
Message-ID: <55fc32df-f01b-1ba3-3813-26a5f8c7f730@quicinc.com>
Date:   Fri, 19 May 2023 18:19:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] clk: qcom: clk-alpha-pll: Add support for lucid ole
 pll ops
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-2-quic_jkona@quicinc.com>
 <019999fd-3c86-8c85-76c7-8d0206e60f4d@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <019999fd-3c86-8c85-76c7-8d0206e60f4d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qt6FBufyzYh-ebuM7P0JDht_1Q3S74zD
X-Proofpoint-ORIG-GUID: Qt6FBufyzYh-ebuM7P0JDht_1Q3S74zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=961
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190108
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Konrad for your review!

On 5/10/2023 1:36 AM, Konrad Dybcio wrote:
> 
> 
> On 9.05.2023 18:12, Jagadeesh Kona wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Add support for lucid ole pll ops to configure and control the
>> lucid ole pll. The lucid ole pll has an additional test control
>> register which is required to be programmed, add support to
>> program the same.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
> Isn't this commit "write to PLL_TEST_CTL_U2 on LUCID_EVO" instead?
> 
> Meaninglessly duplicating ops does not seem useful.
> 
> Konrad

Though we are reusing same ops for EVO and OLE, PLL_TEST_CTL_U2 register 
programming is applicable only to OLE PLL type. And PLL type is useful 
to properly refer respective hardware datasheets. Hence added separate 
ops for OLE PLL type.


>>   drivers/clk/qcom/clk-alpha-pll.c | 2 ++
>>   drivers/clk/qcom/clk-alpha-pll.h | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index b9f6535a7ba7..f81c7c561352 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -55,6 +55,7 @@
>>   #define PLL_TEST_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
>>   #define PLL_TEST_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
>>   #define PLL_TEST_CTL_U1(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U1])
>> +#define PLL_TEST_CTL_U2(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U2])
>>   #define PLL_STATUS(p)		((p)->offset + (p)->regs[PLL_OFF_STATUS])
>>   #define PLL_OPMODE(p)		((p)->offset + (p)->regs[PLL_OFF_OPMODE])
>>   #define PLL_FRAC(p)		((p)->offset + (p)->regs[PLL_OFF_FRAC])
>> @@ -2096,6 +2097,7 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>>   	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
>>   	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
>>   	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
>> +	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U2(pll), config->test_ctl_hi2_val);
>>   
>>   	/* Disable PLL output */
>>   	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
>> index d07b17186b90..4d9b6d5b7062 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.h
>> +++ b/drivers/clk/qcom/clk-alpha-pll.h
>> @@ -125,6 +125,7 @@ struct alpha_pll_config {
>>   	u32 test_ctl_val;
>>   	u32 test_ctl_hi_val;
>>   	u32 test_ctl_hi1_val;
>> +	u32 test_ctl_hi2_val;
>>   	u32 main_output_mask;
>>   	u32 aux_output_mask;
>>   	u32 aux2_output_mask;
>> @@ -171,6 +172,7 @@ extern const struct clk_ops clk_alpha_pll_zonda_ops;
>>   #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
>>   
>>   extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
>> +#define clk_alpha_pll_lucid_ole_ops clk_alpha_pll_lucid_evo_ops
>>   extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
>>   #define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
>>   extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
>> @@ -196,6 +198,8 @@ void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   			     const struct alpha_pll_config *config);
>>   void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   				 const struct alpha_pll_config *config);
>> +#define clk_lucid_ole_pll_configure(pll, regmap, config) \
>> +			clk_lucid_evo_pll_configure(pll, regmap, config)
>>   void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   				  const struct alpha_pll_config *config);
>>   void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,

Thanks & Regards,
Jagadeesh
