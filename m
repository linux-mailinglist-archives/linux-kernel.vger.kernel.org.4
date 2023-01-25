Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5067B65C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjAYPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjAYPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:54:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C110A89;
        Wed, 25 Jan 2023 07:54:10 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PCP3WX028423;
        Wed, 25 Jan 2023 15:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hw3zcTuDyMd5scO9x5zuX4zGXQyudZZPUJ0wsPJHE4E=;
 b=IdCBXjPPki9t4AuKpzsqax/alGmpnzRiPwSyH+AOtABfXSZFJM7WieLpCitnI9rnZTjS
 nYKIZtaxXRROtSz7RrtXKzaZoHxr756m6+smAxQG0w7E5jTSgpgWQ71VajbgC7vY6iKs
 XGr93AjCl64JMVJ5Feav15vAIOQSeYaAbq9yNDMaJKV5hxa1GINwYOrFel0yVe3p/qUf
 Rvl9rhnTPPri2IjvuNnt0CMBmV8yVO8l/JjM88d1ndARQ++mqPk9yV6wscPFZ6JuuNX2
 0LAMm6yldR8d5kHqsxVfT/fZjN+fSqKH6is0GH3Vm6HjyxTUkNYK7yto23qlRH0roWvU YQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nar2n9d1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:53:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PFrufs007997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:53:56 GMT
Received: from [10.50.43.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 07:53:47 -0800
Message-ID: <c1373f6c-8f26-864e-c011-b0bff0402054@quicinc.com>
Date:   Wed, 25 Jan 2023 21:23:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/10] clk: qcom: add Global Clock controller (GCC) driver
 for IPQ5332 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-6-quic_kathirav@quicinc.com>
 <4dc231f5-fad4-6093-851d-afcc0f68e045@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <4dc231f5-fad4-6093-851d-afcc0f68e045@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gx0_AN8YkL37TLaBF8c2G1H5OouOETC2
X-Proofpoint-GUID: Gx0_AN8YkL37TLaBF8c2G1H5OouOETC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_09,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=947
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250140
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 4:44 PM, Krzysztof Kozlowski wrote:
> On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> Add support for the global clock controller found on IPQ5332 SoC.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig       |    7 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/gcc-ipq5332.c | 3954 ++++++++++++++++++++++++++++++++
>>   3 files changed, 3962 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 70d43f0a8919..1d300c89ecfc 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -141,6 +141,13 @@ config IPQ_GCC_4019
>>   	  Say Y if you want to use peripheral devices such as UART, SPI,
>>   	  i2c, USB, SD/eMMC, etc.
>>   
>> +config IPQ_GCC_5332
>> +	tristate "IPQ5332 Global Clock Controller"
> depends on ARM64 || COMPILE_TEST


Ack.


>
>
>
> Best regards,
> Krzysztof


Thanks,

Kathiravan T.

