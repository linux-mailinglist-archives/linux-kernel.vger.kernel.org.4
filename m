Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5973135A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbjFOJPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245424AbjFOJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:10:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C42963;
        Thu, 15 Jun 2023 02:10:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8Pf9d012594;
        Thu, 15 Jun 2023 09:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B2xzt2fYv6iBrKDEpmdYGZv251NM8aRo0nVRMALINBE=;
 b=m/9XJXhdARJZ3cVyklW1HdPgghF6vOMtfM3Pd5sGr1cmyNUQWJ1i83tMJ3Z/QNpsseL9
 99xVPDxDFFPa4JKeQAIIBBmZFEaM8DKJBa2Pa8iqzGUPpniBa3Uc1STrwsmeEs6BFSok
 wgsq5mYVJtHsb7iR831TgflnM1p8QitWLwgkmdt25T2tJVLfzMXWNwn68MM6Yxesu/D+
 Hc1j5i9seuIidFp/s0QrmjIC76TFWV50z00lk5fGUxxLa++oBVx6f7x6xoEjzTl3QDon
 gIZXUjF0D4X0zvQWsLjboWpcQ6HpKNQvBYi+cuQpgTNXGOCLqrD1EWZkiTxO+2Ln1uYB qQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7cka2b8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:09:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F99g6M013747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:09:42 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 02:09:37 -0700
Message-ID: <3f9be7c4-a691-3e00-fc32-6861e5cecd77@quicinc.com>
Date:   Thu, 15 Jun 2023 17:09:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 03/13] coresight-tpdm: Introduce TPDM subtype to TPDM
 driver
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1686553666-5811-1-git-send-email-quic_taozha@quicinc.com>
 <1686553666-5811-4-git-send-email-quic_taozha@quicinc.com>
 <16b08ba8-f23e-af24-881c-61fe4e4c92e1@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <16b08ba8-f23e-af24-881c-61fe4e4c92e1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OwDaHX1JQ-kqjP8_6cb5N8ckgBepKa4b
X-Proofpoint-ORIG-GUID: OwDaHX1JQ-kqjP8_6cb5N8ckgBepKa4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=986 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150077
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/2023 11:35 PM, Suzuki K Poulose wrote:
> On 12/06/2023 08:07, Tao Zhang wrote:
>> Introduce the new subtype of "CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM"
>> for TPDM components in driver.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 1 +
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
>>   include/linux/coresight.h                    | 1 +
>>   3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 118fcf2..23b18c2 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1093,6 +1093,7 @@ static int coresight_validate_source(struct 
>> coresight_device *csdev,
>>         if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>> +        subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>
> minor nit: Alignment. Please always double check your patch for
> styling issues.
>
>
> Otherwise looks good to me

Sure, I will check all the patches and update to the next patch series soon.

Do you have more review comments on other patches?


Best,

Tao

>
> Suzuki
