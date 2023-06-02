Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72472082F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjFBRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:11:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9831A4;
        Fri,  2 Jun 2023 10:11:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352ECb1Q032733;
        Fri, 2 Jun 2023 17:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FVEixRlR8jvJDNKMaAZQsJwdlgbarwIFloHWwfSG8Lo=;
 b=XGM8D300dnbqIFPUi3lgKv4c1r8LLYEvowCqJuU3nzvIUiEtnsYqqolz/SokWBX93jtZ
 qLYrXtRwszh73+m37MUwZ0ytjhPchW7lZYVcTW0iXaE7F9yTdn3V+n+psUQsgRNgonqE
 ssaAt+81TEWqWtBez9yjjFT/zIlcOG94cwJP2qqFq4TyeyqLsEvHz7950hy0cMxxviqb
 p10OEiE9ZtJIbVbwKSKj1d8P7sEQFy2DpD63Ic5ncq6ng5nM+nTa0rEbxPrcAkKuocGY
 6Aqgf7cUrgcZX6ceSWEm5912yzfyF+hEBIzSirZCLo6UwTu3IoGHIf26Y1xPMnpGNm23 Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyb5f9cx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 17:10:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352HAkmp024795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 17:10:46 GMT
Received: from [10.216.26.36] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 2 Jun 2023
 10:10:39 -0700
Message-ID: <36788c66-a93d-9f80-ae5b-44ec1bd27b31@quicinc.com>
Date:   Fri, 2 Jun 2023 22:40:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V8 2/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <krzysztof.kozlowski@linaro.org>
References: <20230602082325.1445261-1-quic_srichara@quicinc.com>
 <20230602082325.1445261-3-quic_srichara@quicinc.com>
 <CAHp75Vcfa2cbACEPROuOptPM7c9SOp_TudK-4Rx45OhWPf=iiw@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAHp75Vcfa2cbACEPROuOptPM7c9SOp_TudK-4Rx45OhWPf=iiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CNv3Ik2pUxE6RZumgCgRCADuQFU9E5Ha
X-Proofpoint-GUID: CNv3Ik2pUxE6RZumgCgRCADuQFU9E5Ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020130
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/2023 6:41 PM, Andy Shevchenko wrote:
> On Fri, Jun 2, 2023 at 11:24 AM Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
>>
>> Add support for the global clock controller found on IPQ5018
>> based devices.
> 
> ...
> 
>>   config IPQ_GCC_5332
>>          tristate "IPQ5332 Global Clock Controller"
>>          depends on ARM64 || COMPILE_TEST
>>          help
>>            Support for the global clock controller on ipq5332 devices.
>> -         Say Y if you want to use peripheral devices such as UART, SPI,
>> -         i2c, USB, SD/eMMC, etc.
> 
> Nothing in the commit message about this. Please, elaborate.
> 
> ...

  oops, unintended change. Not sure how this crept in.
  Thanks for catching it, will remove this.

> 
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
> 
> Why not keep this ordered?
> 
> Missing bits.h and maybe others, but in an unordered list it's harder to check.
> 

  sure, will order it.

> ...
> 
>> +                       &gpll4_main.clkr.hw
> 
> Can we keep trailing comma here and in similar cases, like
> 
>> +                       &ubi32_pll_main.clkr.hw
>> +                       &gpll0_main.clkr.hw
> 
> (and many others)?
> 

  ok, will fix it.

Regards,
  Sricharan
