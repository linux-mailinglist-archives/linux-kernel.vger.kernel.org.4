Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9FE74A081
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjGFPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGFPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:10:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0378F;
        Thu,  6 Jul 2023 08:09:57 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366EcjSA008648;
        Thu, 6 Jul 2023 15:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c4QaIRQUNk1e+H5Acb69EJkalxJ1Qgs1utxlPliRjxQ=;
 b=CfMiuD+6wbGgBlZ3jPlShrHSVMyEA2vFhHl8YsG3wY58jZl8SxBGRlrOh2IDonxTs/Ds
 4UfIBgllEK1C2P9lBPiMAHF7lD6mwPrd5kNvVQAXpsKAjifvPYaPQl4TPHcGcoh0shdx
 SEKGQOb2cWvQXBAYzE7iNcf/kFrNj2I3QdxPIPWQMqv/njB7lwLhZC+kKaX6XsC+3wGy
 x7cTvHov9cWHSw0Ezlw5K5y1CzCIz6hO067cSLPOLh9GaO7i5VhUcXo3R6ZdHRH+dkuy
 7OhkliVajo4jpcFReWg0i5K92aF6nI4umJp+S6T/4PPISO4fon+BMUKwRgDExd4hapHj RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cpbrg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:09:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366F9rGT015343
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 15:09:53 GMT
Received: from [10.216.13.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 08:09:49 -0700
Message-ID: <73c97b05-db0a-e76f-5f4c-268ce802e4f6@quicinc.com>
Date:   Thu, 6 Jul 2023 20:39:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/4] Add support for pinctrl in pmic chips.
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
 <42126323-7414-11f8-7580-391edd0b3b5b@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <42126323-7414-11f8-7580-391edd0b3b5b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u9uKCoz6iOGrFv6erCBtUfuysb_fpRZR
X-Proofpoint-ORIG-GUID: u9uKCoz6iOGrFv6erCBtUfuysb_fpRZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=835
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060136
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 8:32 PM, Konrad Dybcio wrote:
> On 6.07.2023 15:30, Rohit Agarwal wrote:
>> Hi,
> The subject should definitely specify which PMIC chips (or what platform)
> the changes are for, otherwise it's overly generic, so for example:
>
> Add pinctrl support for SDX75 PMICs
>
>
> It's not a big issue, but it helps when one needs to search through email
> history for a specific thread.
Understood will update in the next version.

Thanks,
Rohit.
>
> Konrad
>> This series adds GPIO support for PM7550ba and PMX75 pmic.
>>
>> Thanks,
>> Rohit.
>>
>> Rohit Agarwal (4):
>>    dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
>>    dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
>>    pinctrl: qcom-pmic-gpio: Add support for pm7550ba
>>    pinctrl: qcom-pmic-gpio: Add support for pmx75
>>
>>   Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 6 ++++++
>>   drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                      | 2 ++
>>   2 files changed, 8 insertions(+)
>>
