Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0D60D5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJYVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJYVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:03:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF225A8FA;
        Tue, 25 Oct 2022 14:03:50 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PL0KpX008719;
        Tue, 25 Oct 2022 21:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6ANxO3FG04XfjlFDKn1rFO+qMY4ZOEYGEf9X9sJVsmk=;
 b=cxqQhj8AtgsMXHoG8pQT1eqouYm7U32ZahN+UEnr5aX8Wp6AiDrlUSSDP7feOtgjm48o
 UQ1Y/38LJEsCc4bnTfU43BLne4kKHHfKGBNTpGFPEZLrLOW5Tgf2Y+I1tzr1/V8Wnru1
 xNxdpMpBKa3GmuY4CwEMN53oaEiNsup2bwUTJTSBRaUukXTmqvnqVdFbNuHSEVnlK8DG
 H/+NK//15hmTSllP3XMHuxjlpiEjghPjmww91By5QFFf8ZGB2mBF4GJwg3lbA2FLl8/z
 qgb2+O7/SZQAZUPaCWypxZF3H5wdVzUn/axbbVhdBk3XylbdItuefxHqAi4bsovZSBIh ng== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3keaf0hqgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 21:03:40 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29PL3dCt010905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 21:03:39 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 25 Oct
 2022 14:03:38 -0700
Message-ID: <05474921-eb21-968c-ed92-34769517cf31@quicinc.com>
Date:   Tue, 25 Oct 2022 14:03:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221025.7372-1-quic_molvera@quicinc.com>
 <20221014221025.7372-3-quic_molvera@quicinc.com>
 <498ea0a0-24c2-c9c0-3a5d-150ba32b3c4c@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <498ea0a0-24c2-c9c0-3a5d-150ba32b3c4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6IoC9bP1KQH-dwbJq4dVclCY2YJWicb7
X-Proofpoint-ORIG-GUID: 6IoC9bP1KQH-dwbJq4dVclCY2YJWicb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=787
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2022 6:40 AM, Krzysztof Kozlowski wrote:
> On 14/10/2022 18:10, Melody Olvera wrote:
>> Add pin control driver for the TLMM block found in the QDU1000
>> and QRU1000 SoC.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/pinctrl/qcom/Kconfig           |    9 +
>>  drivers/pinctrl/qcom/Makefile          |    1 +
>>  drivers/pinctrl/qcom/pinctrl-qdu1000.c | 1274 ++++++++++++++++++++++++
>>  3 files changed, 1284 insertions(+)
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdu1000.c
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index 9dc2d803a586..4ab857dc2847 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -248,6 +248,15 @@ config PINCTRL_QCOM_SSBI_PMIC
>>  	 which are using SSBI for communication with SoC. Example PMIC's
>>  	 devices are pm8058 and pm8921.
>>  
>> +config PINCTRL_QDU1000
>> +	tristate "Qualcomm Tehcnologies Inc QDU1000/QRU1000 pin controller driver"
>> +	depends on GPIOLIB && OF
> depends on ARM64 || COMPILE_TEST
Will add.
>> +	depends on PINCTRL_MSM
>> +	help
>> +	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
>> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
>> +	  Technologies Inc QDU1000 and QRU1000 platforms.
>> +
> (...)
>
>> +	PINCTRL_PIN(138, "GPIO_138"),
>> +	PINCTRL_PIN(139, "GPIO_139"),
>> +	PINCTRL_PIN(140, "GPIO_140"),
>> +	PINCTRL_PIN(141, "GPIO_141"),
>> +	PINCTRL_PIN(142, "GPIO_142"),
>> +	PINCTRL_PIN(143, "GPIO_143"),
>> +	PINCTRL_PIN(144, "GPIO_144"),
>> +	PINCTRL_PIN(145, "GPIO_145"),
>> +	PINCTRL_PIN(146, "GPIO_146"),
>> +	PINCTRL_PIN(147, "GPIO_147"),
>> +	PINCTRL_PIN(148, "GPIO_148"),
>> +	PINCTRL_PIN(149, "GPIO_149"),
>> +	PINCTRL_PIN(150, "GPIO_150"),
> Your bindings said you have GPIOs 0-149, not 0-150.
Updated bindings.
>
>> +	PINCTRL_PIN(151, "SDC1_RCLK"),
>> +	PINCTRL_PIN(152, "SDC1_CLK"),
>> +	PINCTRL_PIN(153, "SDC1_CMD"),
>> +	PINCTRL_PIN(154, "SDC1_DATA"),
> This also does not match bindings.
Updated bindings.

Thanks,
Melody
