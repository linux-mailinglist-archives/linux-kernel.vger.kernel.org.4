Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D08465E454
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAEEEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAEEEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:04:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BE3724D;
        Wed,  4 Jan 2023 20:04:03 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3052ocgB031542;
        Thu, 5 Jan 2023 04:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J4oDPGt7tSAoPWGWfIL7yp1U4a7QkzAs7ExHzBT4k0A=;
 b=f1SY0Zch5ZHi4c2FP+6K6ocFOP2AtE7284pb9xcdiijeqJ2sTMwbQ/XPdVvG/Ei4X+Gi
 Q+hcZre9OvEbi01e4Mc9Hw0rBxfJ7/E4TMwuuZfVsb2pa4PL2WCX5tGTQqkNXwVJDiJS
 kAzy/yMjj+bulch4e/GAz7FAGPOgWg6kW2vfUkCZScfwr1HOg9SocUBeZa/i/IWRj/Yj
 P8IIGjEtxgawa3Uqgb3BhP14JgwAfnzM+miCUM45HKaUlvjNCCa6VYmzhNLIFQZzK56m
 7M4Wy+5Eu5nbixicIEx+t7aozmjM2vI6zLN81w3RRzyH13S+UFDEMjgzpqhvJMFCfeU3 nQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvfbcux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 04:03:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30543utx015824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 04:03:56 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 20:03:54 -0800
Message-ID: <9a0d7b7c-53bb-cfa6-8629-a0c48b70364f@quicinc.com>
Date:   Thu, 5 Jan 2023 12:03:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RESEND PATCH v5 0/2] Add LED driver for flash module in QCOM
 PMICs
Content-Language: en-US
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
References: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dK-Adf1Vcl-VWoQ_gXdV7Mrov7rgc1aP
X-Proofpoint-ORIG-GUID: dK-Adf1Vcl-VWoQ_gXdV7Mrov7rgc1aP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=870
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050032
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel, Jones,

Can you help to review the new flash LED driver changes for Qcom flash 
LED module when you are available? It's pending for while.
Thanks

Fenglin

On 2022/12/27 16:15, Fenglin Wu wrote:
> Initial driver and binding document changes for supporting flash LED
> module in Qualcomm Technologies, Inc. PMICs.
> 
> Changes in V5:
>    1. Add MODULE_DEVICE_TABLE for auto-loading.
> 
> Changes in V4:
>    1. Added Tested-By tag.
>    2. Addressed review comments in the binding change and added
>       Reviewed-by tag.
> 
> Changes in V3:
>    1. Updated the driver to use regmap_field for register access.
>    2. Adressed the review comments in binding document change.
> 
> Changes in V2:
>    1. Addressed review comments in binding change, thanks Krzysztof!
>    2. Updated driver to address the compilation issue reported by
>       kernel test robot.
> 
> Fenglin Wu (2):
>    leds: flash: add driver to support flash LED module in QCOM PMICs
>    dt-bindings: leds: add QCOM flash LED controller
> 
>   .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 +++
>   drivers/leds/flash/Kconfig                    |  15 +
>   drivers/leds/flash/Makefile                   |   1 +
>   drivers/leds/flash/leds-qcom-flash.c          | 701 ++++++++++++++++++
>   4 files changed, 833 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
>   create mode 100644 drivers/leds/flash/leds-qcom-flash.c
> 
