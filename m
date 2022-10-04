Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F555F4A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJDUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJDUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:03:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A16B660;
        Tue,  4 Oct 2022 13:02:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JtZ8j005960;
        Tue, 4 Oct 2022 20:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yzZr1rqcaYcmEG9p1d/xn0IstIbc44yEsBfPBU/W980=;
 b=VYhp7f8PV83zpxytd8hPllZpQoIiLKMVDDBqm1QxpAiX9nLRj+1JdJcZZvrmqjcDlkvm
 N50PI6iiteILhPERypBFIemtVZ/zKXkhM7oVrAAPvwGdIHbHeYluChp+o/XjZc6fnygA
 ECrQ+QSFVtvy0KhaTGM4YSg6UbWBpzAzGXTdWpuXCWX/iQi2Ek4H9LSjg7Y9NUj1dGrD
 LgD7KIon0JdBt6Rn05DCQpWb+xRBEP2aE5dIFS71BNasXeWsqGDSMXmPmdxUTgmW8jD/
 uImWuWyC2Yx4MG+QkbLNRsqrKuaBLS1na2leR3qLfKJdGzdEmUTnuixSHgaOYnxA8Aow YQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0sq5r6aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 20:02:54 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K2r87024495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 20:02:53 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:02:51 -0700
Message-ID: <d6212df1-b012-6186-e56d-b552a215418e@quicinc.com>
Date:   Tue, 4 Oct 2022 15:02:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] interconnect: qcom: Add QDU1000/QRU1000 interconnect
 driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030602.28232-1-quic_molvera@quicinc.com>
 <20221001030602.28232-3-quic_molvera@quicinc.com>
 <CAA8EJpopGgmThv1BUHAP-bYsgm-ojF0FJ_KVNgycwOAOj=_D4g@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpopGgmThv1BUHAP-bYsgm-ojF0FJ_KVNgycwOAOj=_D4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p7T3foRQeN-h7_y5vWJdtZx4peCoPI2v
X-Proofpoint-GUID: p7T3foRQeN-h7_y5vWJdtZx4peCoPI2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040130
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 2:13 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
>> platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/Kconfig    |    9 +
>>  drivers/interconnect/qcom/Makefile   |    2 +
>>  drivers/interconnect/qcom/qdru1000.c | 1091 ++++++++++++++++++++++++++
>>  drivers/interconnect/qcom/qdru1000.h |   95 +++
>>  4 files changed, 1197 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/qdru1000.c
>>  create mode 100644 drivers/interconnect/qcom/qdru1000.h
>>
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index 25d5b4baf6f6..760f855d7618 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -200,5 +200,14 @@ config INTERCONNECT_QCOM_SM8450
>>           This is a driver for the Qualcomm Network-on-Chip on SM8450-based
>>           platforms.
>>
>> +config INTERCONNECT_QCOM_QDRU1000
>> +       tristate "Qualcomm QDU1000/QRU1000 interconnect driver"
>> +       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>> +       select INTERCONNECT_QCOM_RPMH
>> +       select INTERCONNECT_QCOM_BCM_VOTER
>> +       help
>> +         This is a driver for the Qualcomm Network-on-Chip on QDU1000-based
>> +         and QRU1000-based platforms.
>> +
>>  config INTERCONNECT_QCOM_SMD_RPM
>>         tristate
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> index 8e357528185d..85b7f0de473d 100644
>> --- a/drivers/interconnect/qcom/Makefile
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -25,6 +25,7 @@ qnoc-sm8150-objs                      := sm8150.o
>>  qnoc-sm8250-objs                       := sm8250.o
>>  qnoc-sm8350-objs                       := sm8350.o
>>  qnoc-sm8450-objs                       := sm8450.o
>> +qnoc-qdru1000-objs                     := qdru1000.o
> Alphabetic sorting
Will fix.
>
>>  icc-smd-rpm-objs                       := smd-rpm.o icc-rpm.o
>>
>>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
>> @@ -49,4 +50,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_QDRU1000) += qnoc-qdru1000.o
> Alphabetic sorting.
Will fix.
>
>
Thanks,
Melody
