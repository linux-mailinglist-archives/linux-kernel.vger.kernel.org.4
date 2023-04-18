Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B656E5E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDRJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjDRJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:55:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B940C7;
        Tue, 18 Apr 2023 02:55:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I8lAFv028173;
        Tue, 18 Apr 2023 09:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9MNYTWJnVX4ToZwrdikCP8x2UjqgSoVQz3bfG1l0798=;
 b=DvJWHfuo/X0ipclGHa1Mno5fXpqniawailplmc/tb1t3/+D9WXcuG/r+dc6PDd+AngRq
 PbCPTsSrJZgrxjt4u0oH0sOneCQPLWLSX59IhptKYfEblZEBBeo8aB28JZcQvpSn6wsZ
 XtuBEH3MbeHsxLyc6i1ZB9IAJACue5RsXIiHuTXNCAfxMvpiOSpG/upT+6Ow/9WKuqod
 ozt/OhEv8Nyau5p3ywJnkHdJ36YH+UTRnaPHiH7HO9wJ5v8iwU3hgOwQ5gDxrZQ3vzzv
 PIC05EkGRelzNazWRG42LS4euaMBb4oq3VmvZZ/3nHB4yVoNJQMPdhLOWiIJMgDTQ3kI pw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nk4gfnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:54:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9sps0027999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:54:51 GMT
Received: from [10.218.19.109] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 02:54:44 -0700
Message-ID: <12f13183-c381-25f7-459e-62e0c2b19498@quicinc.com>
Date:   Tue, 18 Apr 2023 15:24:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sa8775p: pmic: remove the PON modes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
 <20230413131705.3073911-2-brgl@bgdev.pl>
 <3e361a73-797f-41c7-1ead-ecafee3928e4@linaro.org>
 <792e1f22-c3eb-80c7-0600-b478b3764f7c@quicinc.com>
 <a17c21b7-9c0a-2458-735c-ac3b16ed337f@linaro.org>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <a17c21b7-9c0a-2458-735c-ac3b16ed337f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OUOSSZ3POk8lnWGVILgZtZ22ahS1OCSE
X-Proofpoint-GUID: OUOSSZ3POk8lnWGVILgZtZ22ahS1OCSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_06,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180085
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/2023 3:13 PM, Konrad Dybcio wrote:
> 
> 
> On 18.04.2023 06:39, Shazad Hussain wrote:
>>
>>
>> On 4/13/2023 9:42 PM, Krzysztof Kozlowski wrote:
>>> On 13/04/2023 15:17, Bartosz Golaszewski wrote:
>>>> From: Parikshit Pareek <quic_ppareek@quicinc.com>
>>>>
>>>> Remove the power on reasons with reboot from the pmm8654au_0_pon.
>>>> Instead, the PoN reaons should be part of different sdam_0 mode, to
>>>
>>> typo: reasons
>>>
>>>> be interoduced.
>>>
>>> introduced
>>>
>>> Anyway it does not say why. Are these power reasons not correct?
>>>
>>
>> Hi Krzysztof,
>> Since sm8350 the PMIC PON peripheral was split into PON_HLOS and PON_PBS
>> to avoid security concerns with HLOS APPS being able to trigger a PMIC
>> WARM_RESET unilaterally. When the split occurred, the spare registers
>> ended up in PON_PBS, not PON_HLOS. Thus at that time, we moved to using
>> an SDAM register for Linux “reboot reason” configuration. And bootloader
>> also SDAM register to get these reboot region data to get into
>> bootloader/edl, so to have this working we need to use SDAM.
>>
> Does that imply all PMICs following the PMK8350 scheme (separate HLOS and
> PBS) should direct reboot mode writes to SDAM?
> 
> Konrad

Yes, that's what the expectation is with bootloader using SDAM as well.

>>>>
>>>> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> ---
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> -Shazad

-Shazad
