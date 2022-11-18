Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA562FDF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiKRTYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRTYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:24:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A766F0;
        Fri, 18 Nov 2022 11:24:40 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIIK6Y8003709;
        Fri, 18 Nov 2022 19:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dy7fm/CffSTrGxBiQ0piJhj/xW4rZh3fg19dYQbd2AU=;
 b=h/K15T9VkXDt5hzDaowLbBvvp1pYvk5qIDfRrZxXi7XMUwABxXPvLu0zsR2LIXZ36hbV
 WlLcCareuxULek1ONoqSt0byhVBiB8DJ0TijEH8Q6mXNKnGNuttMPmPCwJEjcDFGetTs
 6HN5rbn7ZhzxwqcFMB9U9yBsAaV/84kG/X+NyYw8AJWOeWuUh2kFO8ELfZZ3KpdxQ7Dn
 dbq2UmL3S0IBSHh+poqWru2J09eww4O5/hbN1wul5mNo+YNM+7A1GuEQgk+1IicU/d8n
 Qu7H8qkhRgFMSdvKHjw/jkHnl61HOtmKWaa+2pPJlxsv5OVAnvXQPQ9lLIXQIAXs2sGh 8g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0tea0du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:24:36 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AIJOZ3h024823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:24:35 GMT
Received: from [10.110.5.113] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 18 Nov
 2022 11:24:34 -0800
Message-ID: <f6842c89-fffc-e1b0-c68f-287111974378@quicinc.com>
Date:   Fri, 18 Nov 2022 13:24:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 0/2] spmi: pmic-arb: Add support for PMIC v7
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <Y2PP0cZaJ1vpv1Em@matsya>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <Y2PP0cZaJ1vpv1Em@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kbCo4LQQsEzGNu_GBE9FTgtlPkQXCPNv
X-Proofpoint-GUID: kbCo4LQQsEzGNu_GBE9FTgtlPkQXCPNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=901 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2022 9:27 AM, Vinod Koul wrote:
> On 14-09-22, 22:22, Vinod Koul wrote:
>> Hello,
>>
>> The is version 5 of support for PMIC v7. I have added a new property
>> qcom,bus-id for supporting v7 and then add driver changes for v7
> Stephen,
>
> Can you pick this? It has been so long...

Hi Stephen,

Do you mind looking at this? I've got some patches that depend on functionality here...
https://lore.kernel.org/all/20221118192241.29384-1-quic_molvera@quicinc.com/

Thanks,
Melody

>> Changes since v4:
>>  - Fix David name and email
>>  - remove trailing line in binding
>>
>> Changes since v3:
>>  - rebase on spmi/next
>>
>> David Collins (1):
>>   spmi: pmic-arb: Add support for PMIC v7
>>
>> Vinod Koul (1):
>>   dt-bindings: spmi: Add qcom,bus-id
>>
>>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  10 +
>>  drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
>>  2 files changed, 231 insertions(+), 21 deletions(-)
>>
>>
>> base-commit: 18c42f8d23426d3f4048df89523aa47203c3493a
>> -- 
>> 2.37.3

