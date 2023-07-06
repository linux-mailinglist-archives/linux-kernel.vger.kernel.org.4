Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53B749F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjGFOmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjGFOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:42:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1E10F5;
        Thu,  6 Jul 2023 07:42:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Dl7Xi002795;
        Thu, 6 Jul 2023 14:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cOy/D9wwF+YVZW0ZIhp1zNdTAQ7GSvA0zuPjMg2pfCw=;
 b=nw9wfHYpWg0E+3+ZIfYtFkz1XsAgPn/DjUrOLy1nvwSnGgp2V9thA5zrnjLtP/j3X82X
 3nmTLYDPVDcIDRON8xigEGPBV95p7e49wYTbV0RJjjH7f4dPK17yRSflVy9kUUNfUDFf
 scFtu8AFM8m2PMZEOkAao1TBwkRc+30HzIUAMwhmwciQFxtpTSEJapLrppUQvyFSZgYU
 7zUfsjNPQjdPhliumCEfry8uUHabYCKAQIWde/A6sqS3hyPyScoCrLdilcyrOshlWqCY
 Y/QsrVKfPiBWhhJAxhkhnopa0U/TZaXmB0C/7U9tthko2eyqUUvuydC9iKl1scNaW3Bw DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn152kty6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 14:42:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366EgHHa005936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 14:42:17 GMT
Received: from [10.216.13.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 07:42:13 -0700
Message-ID: <337a8204-033f-3c00-ffc3-0bd3a6050e54@quicinc.com>
Date:   Thu, 6 Jul 2023 20:12:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Add Generic RPM(h) PD
 indexes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
 <9e25ca29-9e19-b48c-06a7-f748af3fd243@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <9e25ca29-9e19-b48c-06a7-f748af3fd243@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dk8QoSW3p9f_FB-kWGpmnCZuV4063PEH
X-Proofpoint-ORIG-GUID: Dk8QoSW3p9f_FB-kWGpmnCZuV4063PEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=703
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060131
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 8:06 PM, Krzysztof Kozlowski wrote:
> On 06/07/2023 14:49, Rohit Agarwal wrote:
>> Add Generic RPM(h) Power Domain indexes that can be used
>> for all the Qualcomm SoC henceforth.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   include/dt-bindings/power/qcom-rpmpd.h | 49 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
> Didn't you just send a patch doing similar? There is no changelog, no
> versioning, how can anyone figure out which patch is the latest or which
> one should be ignored?
No, that patch was removing all the other SoCs macro which was against 
the ABI.
So dropping that series completely and this being new series didnt 
include the versioning.
Since all the patches in that series needed to be dropped I thought to 
start a new series.

Thanks,
Rohit.
> Best regards,
> Krzysztof
>
