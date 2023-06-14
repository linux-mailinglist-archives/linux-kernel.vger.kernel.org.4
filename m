Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC23A72F512
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjFNGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjFNGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:43:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DE41A3;
        Tue, 13 Jun 2023 23:43:42 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E6hRFs028347;
        Wed, 14 Jun 2023 06:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OHJVjMCHbOTg9z9Hw3Zobx6VP/+k/cKz+YRT4tNpl4A=;
 b=ZOIfFzxycPj5wZiFJb6+A5sttY3rEjPOe55zWFuAzThhjMGOF3q2pA+Sjyhmyd9/SGWL
 pfdWFHzaWglpRpVLS38Vo4aoLxgLfBKsF9KlO5I4zD2hltshYo0eczhC2cryw+GZZ3Cp
 lYnosQkf+jS73nrFeNzR9A1kh3y3NexUBMCLbOWRsQywcaaOcM4uLPjiORvCGwdU0IOS
 yNTCcz+Mt+iatSrefx9180w26sSCw093ayR6zeVBTBdZMhRxBQ4vuJ2mkDF3Lvd6X/N+
 KtUtSmq24BrAo2CCSXulfs3SXj4/bDLib/dVZOZAw0vrYwbzZtqj99R+U/Dcnm1DaDvW Hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6q4r27g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:43:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E6hbc0026999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:43:37 GMT
Received: from [10.217.198.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 23:43:34 -0700
Message-ID: <443b00b1-76b8-c31d-53d3-42e3592d26e8@quicinc.com>
Date:   Wed, 14 Jun 2023 12:13:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Add provision to keep idle state disabled
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <CAPDyKFqhVkMH42Vz0+a62j5kFh+R_CvGrcSU7hxoW__tjOhfLw@mail.gmail.com>
Content-Language: en-US
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <CAPDyKFqhVkMH42Vz0+a62j5kFh+R_CvGrcSU7hxoW__tjOhfLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H5mFTQsSmriRQmg1VqrrhotXgjuuIHsw
X-Proofpoint-ORIG-GUID: H5mFTQsSmriRQmg1VqrrhotXgjuuIHsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_03,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=753 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140057
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for response Ulf.

On 6/12/2023 3:56 PM, Ulf Hansson wrote:
> On Thu, 8 Jun 2023 at 10:56, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>>
>> CPUidle already has CPUIDLE_FLAG_OFF to keep idle state disabled,
>> Lets extend the support to set this flag using device tree.
>>
>> This allows to keep an idle state disabled and they can be enabled back using
>> sysfs after certain point using below command.
>>
>> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
>>
>> This helps in cases where vendors want to keep cpuidle off until home
>> screen comes up. In the past attempt was done at [1] but it was not considered
>> safe option to export cpu_idle_poll_ctrl().
>>
>> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com/
> 
> Before considering this, I don't recall if I ever received a reply to
> my earlier suggestion to the above thread. So, let me repeat my
> question.
> 
> I am wondering if a similar improvement can be achieved by
> modularizing the cpuidle-psci driver. If insmodding it after the
> homescreen, we allow only ARM WFI during boot. This should achieve the
> similar results as we get with $subject series, right?
> 
> [...]
> 
This will not work for targets which does not have DLKM support.

>>
>> Thanks,
>> Tushar Nimkar.
>>
>> Tushar Nimkar (2):
>>    dt-bindings: cpu: idle-states: Add idle-state-disabled property
>>    cpuidle: dt: Add support to keep idle state disabled
>>
>>   Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
>>   drivers/cpuidle/dt_idle_states.c                       | 3 +++
>>   2 files changed, 11 insertions(+)
>>
> 
> Kind regards
> Uffe

Thanks,
Tushar
