Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C666E5823
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDREjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDREjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:39:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C431BDC;
        Mon, 17 Apr 2023 21:39:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I1Qn8m013458;
        Tue, 18 Apr 2023 04:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3XTWqtZ3w9Eey9pd4PsRb/Fejz/hw3NeUUOaQHLLLss=;
 b=glq8roC9jkCIWGP91biXuYIWmm1AErqmOW1al3+O4uLUbwfguEIEPcJoDJ/pT7nDjZx+
 XPBev/YHr6JNAmm1WMZiUS10NNJ8YSXPlyipv4WBACbjHY0qd63noq6tF72Rq7ys3DiN
 EfkYMwPgLBhKcnMsSHofxwesdueD6KljH0KKwYdE3H6ntTaeRhqKuYJa/HfsaZrmhGkP
 Kpg4mdYKSwsmfGf2ei8cQCOV2lR9rGnAJlgVm2eynR8vA13SluYxUwIi7zQB3Gpy5TGC
 8gMH8ZEmjufwcuW51R67zxvYElMeXlW19mcOq8lucyZPKw0wrVCRE1xNqCS2QEhC3QBr rA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1h0cgbbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 04:39:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I4dFBv004298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 04:39:15 GMT
Received: from [10.217.217.202] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 21:39:08 -0700
Message-ID: <792e1f22-c3eb-80c7-0600-b478b3764f7c@quicinc.com>
Date:   Tue, 18 Apr 2023 10:09:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sa8775p: pmic: remove the PON modes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <3e361a73-797f-41c7-1ead-ecafee3928e4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4fG5p8sFF0XmZEJRWb4HKzAGsKAglQ2H
X-Proofpoint-GUID: 4fG5p8sFF0XmZEJRWb4HKzAGsKAglQ2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=949 malwarescore=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180041
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2023 9:42 PM, Krzysztof Kozlowski wrote:
> On 13/04/2023 15:17, Bartosz Golaszewski wrote:
>> From: Parikshit Pareek <quic_ppareek@quicinc.com>
>>
>> Remove the power on reasons with reboot from the pmm8654au_0_pon.
>> Instead, the PoN reaons should be part of different sdam_0 mode, to
> 
> typo: reasons
> 
>> be interoduced.
> 
> introduced
> 
> Anyway it does not say why. Are these power reasons not correct?
> 

Hi Krzysztof,
Since sm8350 the PMIC PON peripheral was split into PON_HLOS and PON_PBS
to avoid security concerns with HLOS APPS being able to trigger a PMIC
WARM_RESET unilaterally. When the split occurred, the spare registers
ended up in PON_PBS, not PON_HLOS. Thus at that time, we moved to using
an SDAM register for Linux “reboot reason” configuration. And bootloader
also SDAM register to get these reboot region data to get into
bootloader/edl, so to have this working we need to use SDAM.

>>
>> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
> 
> Best regards,
> Krzysztof
> 

-Shazad
