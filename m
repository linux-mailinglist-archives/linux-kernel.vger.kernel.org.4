Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1186B0376
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCHJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCHJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:53:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB9559E0;
        Wed,  8 Mar 2023 01:53:17 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288d2LG022442;
        Wed, 8 Mar 2023 09:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8oebTeTKDyeaBIwyVQzKAe4CPmsTzGBPARq3wHx9ILY=;
 b=U34dQPN/dCBvNBkesEbkglDTzuxIBFVQ5XQzfGtvKAyGDmbBnbVcbUspfblHrD9njYpy
 haLpYqRoMnVRuTAzyJnrbiN+rTkuyclHNJss4RxXDYY+851FB+xLomGHO7xM/HuMhljl
 gq+3Tuy7kuVeOEklKBLv6CtzV7v3jxAYxBbrbsyNIEWNEpq7Abdf14nJ6Wxko8pOH7rF
 8IafBtjRwPPxwL1tBDcsIEYw8qozJHa/3z8eOOJcGsuSF5ZpfR4EEcZ0OSxuajWNXVaE
 AGVmoQVIEuHvln9cF8xMGay4ClEvrC4bMSqca6rkybwSn4FlB6iKpKDFb4b3VOEACGNe jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fga168y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 09:52:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3289qiWj025606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 09:52:44 GMT
Received: from [10.216.47.125] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 01:52:33 -0800
Message-ID: <15d270ca-1068-b926-efc9-a14ddfc90a54@quicinc.com>
Date:   Wed, 8 Mar 2023 15:22:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V8 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230214163116.9924-1-quic_devipriy@quicinc.com>
 <20230214163116.9924-5-quic_devipriy@quicinc.com>
 <ZAZ+GeGu8mW1XqpG@surfacebook>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <ZAZ+GeGu8mW1XqpG@surfacebook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H6DlS9AVU91hcb93wXAT9V4qIem80vOV
X-Proofpoint-ORIG-GUID: H6DlS9AVU91hcb93wXAT9V4qIem80vOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 5:28 AM, andy.shevchenko@gmail.com wrote:
> Tue, Feb 14, 2023 at 10:01:13PM +0530, Devi Priya kirjoitti:
>> Add pinctrl definitions for the TLMM of IPQ9574
> 
> ...
> 
>> +	depends on OF
> 
> No compile test on non-OF configurations?
Hi Andy,
As per the generic convention followed in other
SoCs, we do not have compile test on non-OF configurations
> 
>> +	depends on ARM64 || COMPILE_TEST
> 
> ...
> 
>> +#define FUNCTION(fname)			                \
> 
> PINCTRL_PINFUNCTION() ?
I see that there are quite a bunch of files that has to
be modified for using the generic data type and
macro for the pin function definition
We shall post a separate series to accommodate the changes
> 
>> +	[msm_mux_##fname] = {		                \
>> +		.name = #fname,				\
>> +		.groups = fname##_groups,               \
>> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
>> +	}
> 
> ...
> 
>> +#define REG_SIZE 0x1000
>> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
>> +	{					        \
>> +		.name = "gpio" #id,			\
>> +		.pins = gpio##id##_pins,		\
>> +		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\
> 
> Can you embed struct pingroup?
Will take care of this in a separate series
> 
>> +		.funcs = (int[]){			\
>> +			msm_mux_gpio, /* gpio mode */	\
>> +			msm_mux_##f1,			\
>> +			msm_mux_##f2,			\
>> +			msm_mux_##f3,			\
>> +			msm_mux_##f4,			\
>> +			msm_mux_##f5,			\
>> +			msm_mux_##f6,			\
>> +			msm_mux_##f7,			\
>> +			msm_mux_##f8,			\
>> +			msm_mux_##f9			\
>> +		},				        \
>> +		.nfuncs = 10,				\
>> +		.ctl_reg = REG_SIZE * id,			\
>> +		.io_reg = 0x4 + REG_SIZE * id,		\
>> +		.intr_cfg_reg = 0x8 + REG_SIZE * id,		\
>> +		.intr_status_reg = 0xc + REG_SIZE * id,	\
>> +		.intr_target_reg = 0x8 + REG_SIZE * id,	\
>> +		.mux_bit = 2,			\
>> +		.pull_bit = 0,			\
>> +		.drv_bit = 6,			\
>> +		.oe_bit = 9,			\
>> +		.in_bit = 0,			\
>> +		.out_bit = 1,			\
>> +		.intr_enable_bit = 0,		\
>> +		.intr_status_bit = 0,		\
>> +		.intr_target_bit = 5,		\
>> +		.intr_target_kpss_val = 3,	\
>> +		.intr_raw_status_bit = 4,	\
>> +		.intr_polarity_bit = 1,		\
>> +		.intr_detection_bit = 2,	\
>> +		.intr_detection_width = 2,	\
>> +	}
> 
> ...
> 
>> +	PINGROUP(62, blsp1_spi, audio_sec, audio_pdm1, audio_sec, pta, prng_rosc2, gcc_plltest,
>> +		 _, _),
> 
> Can be one line.
Okay
> 
> ...
> 
>> +static const struct of_device_id ipq9574_pinctrl_of_match[] = {
>> +	{ .compatible = "qcom,ipq9574-tlmm", },
> 
>> +	{ },
> 
> No comma for terminator line.
Okay
> 
>> +};
> 
> No MODULE_DEVICE_TABLE()?
The MODULE_DEVICE_TABLE(of, ipq9574_pinctrl_of_match) entry has
been added at the end of the file
> 
Best Regards,
Devi Priya
