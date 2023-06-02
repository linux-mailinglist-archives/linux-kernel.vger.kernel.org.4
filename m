Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82071F8E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjFBDVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFBDVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:21:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D89107;
        Thu,  1 Jun 2023 20:21:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3523DM4L010027;
        Fri, 2 Jun 2023 03:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qO4SVk1ZImVpFaqBhVfkmc9Z+Cv6JcVlWb/AZgjdGAY=;
 b=Rt79VxHm9h/JkhR46fQufr4f3kXh7LYUH/bDRenb4KhS4E0IcOPgI1CpDA8E2Naimr1/
 W5HJUdwLczufIP6KCkT57h7gU8S/rbAUuJvXliUVajwpDO+OOhtoNEXi8ANDDBvi9OnB
 sZH+agEqeJ4k6SMHANQh0aG44ZP5jaihxz6bZGmPco2turb22WSknc2OH0DVyuh0cc1r
 6bcfkOBBS15bibFT/nFeUlzJ7Y7fP4H+yBdtbT1AojAcmKE+CDWPZhFNpCtvAM8Lvzny
 /RIQB7P7A1Frqr6VP2pj0vBzgnfvomZQKcCjZbXtWitu+RE2usvv65u2OBfZBMiacDuA Sg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr9nyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:21:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3523LHgK012273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 03:21:17 GMT
Received: from [10.216.26.36] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 20:21:11 -0700
Message-ID: <fb95bebd-52ec-eda5-22c3-c3e494e29674@quicinc.com>
Date:   Fri, 2 Jun 2023 08:51:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andy.shevchenko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
 <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
 <ZHTK7uEzO7kcx_cV@surfacebook>
 <aefd0df1-8dfb-1b69-589b-974dea312845@quicinc.com>
 <664940c3-9ec1-b4bd-9db5-fa3529e3d1ff@linaro.org>
 <8146f367-c539-bea5-12b6-424213018488@quicinc.com>
 <eb109116-94eb-5b6d-0049-7bb31feada36@linaro.org>
 <33979417-2c0c-5474-23e0-7e72add99873@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <33979417-2c0c-5474-23e0-7e72add99873@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vp_2jjG7MS1Kcj8RfbOAJlefqzJHJQEo
X-Proofpoint-ORIG-GUID: vp_2jjG7MS1Kcj8RfbOAJlefqzJHJQEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_01,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=625 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020023
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2023 6:57 PM, Krzysztof Kozlowski wrote:
> On 01/06/2023 13:53, Krzysztof Kozlowski wrote:
>> On 01/06/2023 13:41, Sricharan Ramabadhran wrote:
>>>
>>>
>>> On 6/1/2023 3:21 PM, Krzysztof Kozlowski wrote:
>>>> On 01/06/2023 11:50, Sricharan Ramabadhran wrote:
>>>>>
>>>>>
>>>>> On 5/29/2023 9:25 PM, andy.shevchenko@gmail.com wrote:
>>>>>> Mon, May 29, 2023 at 03:58:09PM +0530, Sricharan Ramabadhran kirjoitti:
>>>>>>> On 5/20/2023 12:17 AM, Andy Shevchenko wrote:
>>>>>>>> On Fri, May 19, 2023 at 3:55 PM Sricharan Ramabadhran
>>>>>>>> <quic_srichara@quicinc.com> wrote:
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>>       depends on OF || COMPILE_TEST
>>>>>>>
>>>>>>>     Yeah sure. COMPILE_TEST could be standalone. Will fix it and repost.
>>>>>>
>>>>>> Standalone COMPILE_TEST will give you definitely NOT what you want.
>>>>>> And actually it's strange to have it standalone.
>>>>>>
>>>>>
>>>>>     Ho ok, i meant like this, "depends on ARM64 || COMPILE_TEST"
>>>>
>>>> Don't do it differently than all other drivers. Open the Kconfig and
>>>> look at existing entries.
>>>>
>>>     The latest added has this below, will use this
>>>
>>> 	depends on OF || COMPILE_TEST
>>
>> I would even drop this... Lemme check, it looks odd. We depend on
>> ARCH_QCOM which uses OF. We have few drivers which depend on ACPI, but
>> that also seems wrong. These are platform drivers so they should expect
>> platform select proper firmware interface. I think none of other
>> platform drivers do like this (neither Samsung pinctrl nor other
>> Qualcomm drivers)).
>>
>> I will fix this. For your patch I would just skip OF entirely.
> 
> Correction: you need OF :(

  yup, will follow the same then.

Regards,
  Sricharan
