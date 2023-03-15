Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80C6BAF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCOLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjCOLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:24:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E398EA2F;
        Wed, 15 Mar 2023 04:23:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FATaYi025361;
        Wed, 15 Mar 2023 11:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aYH1IAU5lpVLRcwPmpY5z2BHPzzxvgI4uSFyVQBkL+0=;
 b=WW2+4NRZT0RH/AdK6eiRjHdnalwywc69U4qra2iIg9FjVmMDazDD/2n34A9SD3V4sNt6
 J0qSlwLkSdDmw2Jo534OkjEWSaVSK2M7k1+LDnPd1hCI1TCJigmjkPqo/ougdYEaDEl5
 A8NwFb/C362ALK+Wa5GUwg36X67jw4iKv0KFLulNoVYIbSrWzotbjxO3Nt6nl6o0PFLW
 amOEc6gQu9NUd9lUsc9PfnQvPDSzJ1VzVv6ghS1rGqQYqMpcrJVMwKa6YSdr9DGAen/8
 Fnm3/qqKpDZlDEr8Vd3wdOw1DV1NFz6P4VqPVTx74ZoLde2dZ2wrrsLWYavNFR5tayrb qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c99b45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 11:22:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FBMwwU027486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 11:22:58 GMT
Received: from [10.216.13.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 04:22:48 -0700
Message-ID: <e482a189-823f-35b1-b411-4c4db22a86a6@quicinc.com>
Date:   Wed, 15 Mar 2023 16:52:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V8 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
 <15d270ca-1068-b926-efc9-a14ddfc90a54@quicinc.com>
 <CAHp75VfMae9M2R0Bw6-sYuHPPberakEzKct65SXV0XEaOFtXTg@mail.gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAHp75VfMae9M2R0Bw6-sYuHPPberakEzKct65SXV0XEaOFtXTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D0mbF0bygG_qOvrQGKZ46Ph7JFlKDuzE
X-Proofpoint-GUID: D0mbF0bygG_qOvrQGKZ46Ph7JFlKDuzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=908 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2302240000 definitions=main-2303150097
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2023 6:54 PM, Andy Shevchenko wrote:
> On Wed, Mar 8, 2023 at 11:52 AM Devi Priya <quic_devipriy@quicinc.com> wrote:
>> On 3/7/2023 5:28 AM, andy.shevchenko@gmail.com wrote:
> 
> ...
> 
>>>> +    depends on OF
>>>
>>> No compile test on non-OF configurations?
> 
>> As per the generic convention followed in other
>> SoCs, we do not have compile test on non-OF configurations
> 
> Why not? So, you have to explain the deliberate narrowing of the test coverageOn adding 'depends on OF || COMPILE_TEST', the driver compiles
for non-OF configuration as well.
Will update this in the next spin!
> 
>>>> +    depends on ARM64 || COMPILE_TEST
> 
> ...
> 
>>>> +#define FUNCTION(fname)                                     \
>>>
>>> PINCTRL_PINFUNCTION() ?
>> I see that there are quite a bunch of files that has to
>> be modified for using the generic data type and
>> macro for the pin function definition
>> We shall post a separate series to accommodate the changes
> 
> Sure, that's fine. Please do!
Sure, thanks
> 
>>>> +    [msm_mux_##fname] = {                           \
>>>> +            .name = #fname,                         \
>>>> +            .groups = fname##_groups,               \
>>>> +            .ngroups = ARRAY_SIZE(fname##_groups),  \
>>>> +    }
> 
> ...
> 
>>>> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)    \
>>>> +    {                                               \
>>>> +            .name = "gpio" #id,                     \
>>>> +            .pins = gpio##id##_pins,                \
>>>> +            .npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),     \
>>>
>>> Can you embed struct pingroup?
>> Will take care of this in a separate series
> 
> Ditto. Thanks!
Sure, thanks
> 
>>>> +    }
> 
> ...
> 
>>>> +};
>>>
>>> No MODULE_DEVICE_TABLE()?
>> The MODULE_DEVICE_TABLE(of, ipq9574_pinctrl_of_match) entry has
>> been added at the end of the file
> 
> So, you know what to do then to address my comment :-)
Yep, got it!
> 

Best Regards,
Devi Priya
