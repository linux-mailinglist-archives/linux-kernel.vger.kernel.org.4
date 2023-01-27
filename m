Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7467DFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjA0JRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjA0JRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:17:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71B1AF;
        Fri, 27 Jan 2023 01:17:46 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R8Ho2H014255;
        Fri, 27 Jan 2023 09:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PZZrsDJiAekdKFxzAR4Kz2RrmS0+8IKQyxlUiHgAGTM=;
 b=pxx71BBbQw204P9m+DnaesD04kYehWQscvI+KPXUu+Ur9X7WkEiKrgfXX0SfAQIVJ/So
 xDmg4wCKiBgvn+yTuMYa5N7KNtmLv4Q9YkGboV/gVEbi6k2boQKOTc2Yfeze2CCak6Yk
 BXboPEnpkm+pccQzkiRyDAq2YZB6wmt8Puf2Bj96WncBXq3Yj+bwvVets9NNu9nYA55V
 HSv1iC2C0LI+dFwvUTRbNFvGD+3U37XcyX22tZY4osxCwjVKZixuNLQrZCY59GWsRfxB
 muf+1Acy+ILXQ+JhWEtidPssWH5Ev3AFe63Z4oj7q9GCntWHtTEz1kK0CpXh/3pWLDf6 lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc9ysr5cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 09:17:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R9H6wt026703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 09:17:06 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 01:16:57 -0800
Message-ID: <3dc2b369-cdb5-f435-4c05-c67ec4ccbcea@quicinc.com>
Date:   Fri, 27 Jan 2023 14:46:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V1 4/8] pinctrl: qcom: Add IPQ9574 pinctrl driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <marcel.ziswiler@toradex.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <tdas@codeaurora.org>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230124141541.8290-1-quic_devipriy@quicinc.com>
 <20230124141541.8290-5-quic_devipriy@quicinc.com>
 <bd788bbd-bc62-4a16-994e-f7b527f58fe5@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <bd788bbd-bc62-4a16-994e-f7b527f58fe5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eDg6WxOiUHpbt8G9eQW0IuujB_UXHxhD
X-Proofpoint-GUID: eDg6WxOiUHpbt8G9eQW0IuujB_UXHxhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_04,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270086
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 5:21 AM, Konrad Dybcio wrote:
> 
> 
> On 24.01.2023 15:15, devi priya wrote:
>> Add pinctrl definitions for the TLMM of IPQ9574
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
> [...]
> 
>> +enum ipq9574_functions {
>> +	msm_mux_atest_char,
>> +	msm_mux_atest_char0,
>> +	msm_mux_atest_char1,
>> +	msm_mux_atest_char2,
>> +	msm_mux_atest_char3,
>> +	msm_mux_audio_pdm0,
>> +	msm_mux_audio_pdm1,
>> +	msm_mux_audio_pri,
>> +	msm_mux_audio_sec,
>> +	msm_mux_blsp0_spi,
>> +	msm_mux_blsp0_uart,
>> +	msm_mux_blsp1_i2c,
>> +	msm_mux_blsp1_spi,
>> +	msm_mux_blsp1_uart,
>> +	msm_mux_blsp2_i2c,
>> +	msm_mux_blsp2_spi,
>> +	msm_mux_blsp2_uart,
>> +	msm_mux_blsp3_i2c,
>> +	msm_mux_blsp3_spi,
>> +	msm_mux_blsp3_uart,
>> +	msm_mux_blsp4_i2c,
>> +	msm_mux_blsp4_spi,
>> +	msm_mux_blsp4_uart,
>> +	msm_mux_blsp5_i2c,
>> +	msm_mux_blsp5_uart,
>> +	msm_mux_cri_trng0,
>> +	msm_mux_cri_trng1,
>> +	msm_mux_cri_trng2,
>> +	msm_mux_cri_trng3,
>> +	msm_mux_cxc0,
>> +	msm_mux_cxc1,
>> +	msm_mux_dbg_out,
>> +	msm_mux_dwc_ddrphy,
>> +	msm_mux_gcc_plltest,
>> +	msm_mux_gcc_tlmm,
>> +	msm_mux_gpio,
> 
>> +	msm_mux_mac00,
>> +	msm_mux_mac01,
>> +	msm_mux_mac10,
>> +	msm_mux_mac11,
> msm_mux_mac?
Okay, will have msm_mux_mac enum instead of the above entries(00, 01, 
10, 11)
> 
>> +	msm_mux_mdc,
>> +	msm_mux_mdio,
>> +	msm_mux_pcie0_clk,
>> +	msm_mux_pcie0_wake,
>> +	msm_mux_pcie1_clk,
>> +	msm_mux_pcie1_wake,
>> +	msm_mux_pcie2_clk,
>> +	msm_mux_pcie2_wake,
>> +	msm_mux_pcie3_clk,
>> +	msm_mux_pcie3_wake,
>> +	msm_mux_prng_rosc0,
>> +	msm_mux_prng_rosc1,
>> +	msm_mux_prng_rosc2,
>> +	msm_mux_prng_rosc3,
> 
>> +	msm_mux_pta1_0,
>> +	msm_mux_pta1_1,
>> +	msm_mux_pta1_2,
>> +	msm_mux_pta20,
>> +	msm_mux_pta21,
> msm_mux_pta?
Okay
> 
>> +	msm_mux_pwm00,
>> +	msm_mux_pwm01,
>> +	msm_mux_pwm02,
>> +	msm_mux_pwm03,
>> +	msm_mux_pwm04,
>> +	msm_mux_pwm10,
>> +	msm_mux_pwm11,
>> +	msm_mux_pwm12,
>> +	msm_mux_pwm13,
>> +	msm_mux_pwm14,
>> +	msm_mux_pwm20,
>> +	msm_mux_pwm21,
>> +	msm_mux_pwm22,
>> +	msm_mux_pwm23,
>> +	msm_mux_pwm24,
>> +	msm_mux_pwm30,
>> +	msm_mux_pwm31,
>> +	msm_mux_pwm32,
>> +	msm_mux_pwm33,
> msm_mux_pwm?
Okay
> 
> [...]
> 
>> +
>> +static const int ipq9574_reserved_gpios[] = {
>> +	59, -1
>> +};
> We know it's necessary and it's good that you take care
> of it, but it would be even nicer if you left a comment
> explaining why the rx0/pwm23/qdss_tracedata_a gpio can
> not be accessed and what it's used for.
> 
Sure, will add comments in V3
Reserving the GPIO as it is used for controlling the QFPROM LDO 
regulator by the security component
> Konrad
>> +
>> +static const struct msm_pinctrl_soc_data ipq9574_pinctrl = {
>> +	.pins = ipq9574_pins,
>> +	.npins = ARRAY_SIZE(ipq9574_pins),
>> +	.functions = ipq9574_functions,
>> +	.nfunctions = ARRAY_SIZE(ipq9574_functions),
>> +	.groups = ipq9574_groups,
>> +	.ngroups = ARRAY_SIZE(ipq9574_groups),
>> +	.reserved_gpios = ipq9574_reserved_gpios,
>> +	.ngpios = 65,
>> +};
>> +
>> +static int ipq9574_pinctrl_probe(struct platform_device *pdev)
>> +{
>> +	return msm_pinctrl_probe(pdev, &ipq9574_pinctrl);
>> +}
>> +
>> +static const struct of_device_id ipq9574_pinctrl_of_match[] = {
>> +	{ .compatible = "qcom,ipq9574-tlmm", },
>> +	{ },
>> +};
>> +
>> +static struct platform_driver ipq9574_pinctrl_driver = {
>> +	.driver = {
>> +		.name = "ipq9574-tlmm",
>> +		.of_match_table = ipq9574_pinctrl_of_match,
>> +	},
>> +	.probe = ipq9574_pinctrl_probe,
>> +	.remove = msm_pinctrl_remove,
>> +};
>> +
>> +static int __init ipq9574_pinctrl_init(void)
>> +{
>> +	return platform_driver_register(&ipq9574_pinctrl_driver);
>> +}
>> +arch_initcall(ipq9574_pinctrl_init);
>> +
>> +static void __exit ipq9574_pinctrl_exit(void)
>> +{
>> +	platform_driver_unregister(&ipq9574_pinctrl_driver);
>> +}
>> +module_exit(ipq9574_pinctrl_exit);
>> +
>> +MODULE_DESCRIPTION("QTI IPQ9574 TLMM driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DEVICE_TABLE(of, ipq9574_pinctrl_of_match);
Best Regards,
Devi Priya
