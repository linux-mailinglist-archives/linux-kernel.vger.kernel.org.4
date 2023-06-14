Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3CB72F517
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjFNGpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjFNGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:45:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012B91A3;
        Tue, 13 Jun 2023 23:45:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E4GfjX011094;
        Wed, 14 Jun 2023 06:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Jr5jIEmZwqk5/vqIbzjrfUS9+c47/9L9q13IlgbuhxI=;
 b=QDuJKcQvEg3++mOt83KenN3UHuvhVZ1+jxwRcN8/GRRDZ/d7yUFP1MLP+Nk2eG4iwp0A
 Tq4jLXOm96J5MOAKEpqmt+oXO1EF/Gy6Rt6e6ic5fHT/69O54FONmzlEwLIymrJ2+tkm
 LnAiFJQzwgBO+UC7zOGobxhWJtO3nY7be13VazhrlM0/5WVxIO2XOQRh+UmF5FFVUEJW
 XVZP+tdpZMzc6rZbP+w8RnRTbo/UbwsK1rr/RFe2gXg7TE7RKIiANQZGyPdUrxEdkVly
 EcsQ46N6eeat14vpyYyO6VhvQhYvlDRRpL75GTlrPfRV0A91eE8Ve4XcD9bdUrG/iC29 NQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6t0bst3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:45:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E6j71O020146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:45:07 GMT
Received: from [10.217.198.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 23:45:04 -0700
Message-ID: <0b66dc99-7c88-f980-b91c-ac5d1f1301b3@quicinc.com>
Date:   Wed, 14 Jun 2023 12:15:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>, <devicetree@vger.kernel.org>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
 <9ae34dcc-0022-8097-7c86-8b11811ac2e1@kernel.org>
Content-Language: en-US
In-Reply-To: <9ae34dcc-0022-8097-7c86-8b11811ac2e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Wvuk5GCLUBVFRb4f7y2Olehcr3iZHwi
X-Proofpoint-ORIG-GUID: 7Wvuk5GCLUBVFRb4f7y2Olehcr3iZHwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=892 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140057
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof for reviewing,

On 6/9/2023 6:44 PM, Krzysztof Kozlowski wrote:
> On 08/06/2023 10:55, Tushar Nimkar wrote:
>> This change adds idle-state-disabled property using which certain or all
> 
> Please do not use "This commit/patch", but imperative mood. See longer
> explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
Sure, will update in next version.
>> idle-states can be kept disabled during boot-up. Once boot-up is completed
>> same can be enabled using below command.
>>
> 
> I don't understand and you did not explain here, why this is useful and
> why this is needed.
> 
I will update commit text to why this is useful in new version.
>> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> 
> 
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
Yes, In new version will take care.
>> ---

>> +          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> 
> This is Linux specific command, so does not fit the bindings.
Will remove in new version.
> 
> Best regards,
> Krzysztof
> 

Thanks,
Tushar
