Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C27737B66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjFUG1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFUG1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:27:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6317E1A3;
        Tue, 20 Jun 2023 23:27:42 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L69rOq027889;
        Wed, 21 Jun 2023 06:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jXLCsdAsdsHUa0zK53wusYT4EH7uxKMx5/XtZxXDxfo=;
 b=nU0uYWbL+jDBNYNRthnzkZ1Kmflc9WF+Wgwb5bjIKy6G/AIUV0I5woQRmAw7Rq1yiTvj
 kQws5vu4PQYQAK+53dRbw33c5yHgkniJJOqFvhfK8c3TN+2vmhHp9/5mV3AGgsXikDuh
 ItkH8jBX1lT440x+kJHeZ1lL56LOtquka3aIcILjJvsr5Kijn8ldtNR5+yChq+KSERu+
 Gtp1IXvqJZNXUUWiO4rQEBRyFd0LDPNW6eC0J2MLLSxrq4eQB2Yp8iHIQSEUff0n+LpR
 ahHKzQEaAEumHKSyArkkbddvY+qBOQ2YV2uxtzJwTaCry3l0/mcHkmQ3cG7MwnbOJ+ZI nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb3guu5mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:27:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L6RY96001892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:27:34 GMT
Received: from [10.217.198.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 23:27:31 -0700
Message-ID: <806f395c-91d7-a410-51ab-93898faba7ce@quicinc.com>
Date:   Wed, 21 Jun 2023 11:57:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
Content-Language: en-US
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
 <5820345a-4207-3b12-87eb-098bac4ef4e8@quicinc.com>
 <20230616153924.2wtvgr7lvjcul6to@bogus>
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <20230616153924.2wtvgr7lvjcul6to@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dRv8gxlGfj-30yRf5YMQ-oWYDWrHH-qC
X-Proofpoint-GUID: dRv8gxlGfj-30yRf5YMQ-oWYDWrHH-qC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=842
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210053
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again Sudeep,

On 6/16/2023 9:09 PM, Sudeep Holla wrote:
> On Fri, Jun 16, 2023 at 11:26:18AM +0530, Tushar Nimkar wrote:

> 
> OK try command line approach to disable all states(you can't get partial
> on/off in that case). I don't think the build config is of any use as we
> end up enabling it which will affect other platforms.
> 
Do you mean cpuidle.off=1 ?
It will disable idle states but this will not allow cpuidle_init() and 
governors register to happen which mean no way to re-enable idle states.
Do you mean any other command line approach?

> 
> The above still holds, so still NACK. It is a policy and not a
> hardware/firmware property or feature.
> 
Yes, understood!

Thanks,
Tushar
