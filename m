Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB067326E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbjFPF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbjFPF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:56:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB52D50;
        Thu, 15 Jun 2023 22:56:31 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G5FkcU024268;
        Fri, 16 Jun 2023 05:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+9HBRmd5eI7voSotvO83qQ9bZ7jS8TilhDrz5QR9rxs=;
 b=NYzUjzP+8405lrtCK5MbUGAbE4wtv4XjjGPX7mZ7UZ08C+hnKLq8b1UkCXvBKNr9hIDo
 ApMYuvgriMoSG8r+bf06Az88TkPfH+ZXtsXNO4iBESENog1U8R3pCaFBW/lqT7UjV6/h
 kpP6bDC9QrbyQKAsLoTLGaJsOmBHmvBUGCpRmer4iNPfreD4nYM4/KiGS3EKrc4t1aKD
 8KRd/F2VxhMwmOLVSQDqdqGjz54gC+XUxMw4s8JDrbb1Pt5Ec4pP++z+a44NrLQxtqey
 wILLM15WnnPgoprHaBi1bT2DlTiMjKouuSgLyzMpJ0K/HIdxpSwN5v/PdDw4hFtn4nER 3w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8g2y867x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 05:56:25 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35G5uPoc017983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 05:56:25 GMT
Received: from [10.216.51.142] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 22:56:21 -0700
Message-ID: <5820345a-4207-3b12-87eb-098bac4ef4e8@quicinc.com>
Date:   Fri, 16 Jun 2023 11:26:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>, <devicetree@vger.kernel.org>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
 <20230615085629.b2aaumhq7yqhs5lf@bogus>
Content-Language: en-US
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <20230615085629.b2aaumhq7yqhs5lf@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fLu7cBxhv2Rb6IwloqXpXoK0PdC4kvRr
X-Proofpoint-GUID: fLu7cBxhv2Rb6IwloqXpXoK0PdC4kvRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_02,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 mlxlogscore=933 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306160052
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for review Sundeep,

On 6/15/2023 2:26 PM, Sudeep Holla wrote:
> On Thu, Jun 08, 2023 at 02:25:42PM +0530, Tushar Nimkar wrote:
>> +      idle-state-disabled:
>> +        description: |
>> +          If present the idle state stays disabled. It can be enabled back from
>> +          shell using below command.
>> +          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
>> +        type: boolean
>> +
> 
> This is clearly a policy and not a hardware or firmware feature to expose
> in the device tree. So NACK, why can't you load it modules if you don't want
> idle states in the boot.
> 
Attempt of making cpuidle governors to modular was rejected in past [2]

[2] 
https://lore.kernel.org/lkml/1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com/#t

> It is same as choosing any default governor or performance states, will you
> add those next ? It is simply policy not a feature/property to be exposed
> in the device tree.
> 
> --
> Regards,
> Sudeep

Thanks,
Tushar
