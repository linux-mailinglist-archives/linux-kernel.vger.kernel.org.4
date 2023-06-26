Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAD73D7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFZGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFZGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:45:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B77180;
        Sun, 25 Jun 2023 23:45:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q6hS3w022283;
        Mon, 26 Jun 2023 06:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JgOSZ69WZr+nX7z2LLWuFszfxk9y+IQS0S2u2t608RY=;
 b=T62BPsA1MI6og3YdJxWicoSGZ9KuWKNym1KElCi0vvvDjq9kkt7mMbtlIw59UZOK8xD5
 OJW5XSSAykMlswm7r3W/CT6pkbT+54ckpsJHJjb9EF12uCU4P/cgQEhZA3OvScVgj7Sx
 sx47/d1S2fXcF4X038CEzPgMXQx1xv9Madvw/WAwrMUYUwfsAxVyPcTBOcZ/JGXmzdp3
 c024etFKCgj1IQBZOZ7S8r1aiuE9ULmEB8LOf/0i6tluBRqmPpcjX1UzjUWWPLhS7eFv
 s5XGgc+G4sJSh0IbkRWvoo0KK5qv1+2xrRRWYCrQH65y2WN4UFohTo+fT8U6VdyWpu18 mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdrk0k6xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 06:45:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35Q6j4si011474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 06:45:04 GMT
Received: from [10.217.198.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 25 Jun
 2023 23:45:02 -0700
Message-ID: <b6c4b0e7-a6c2-61e8-0f02-cbc3b973a93f@quicinc.com>
Date:   Mon, 26 Jun 2023 12:14:59 +0530
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
 <443b00b1-76b8-c31d-53d3-42e3592d26e8@quicinc.com>
 <CAPDyKFp5L454WmTPo2eYnBuZ=ZMKEtinLgYU09n=J=3DA1FSJQ@mail.gmail.com>
 <29ccc60e-9ef8-883f-9936-95e6ef842746@quicinc.com>
 <CAPDyKFqKw-6Qu7YoZw9LQDGvj1PFi3nCDkXcmCJTffxtX75naQ@mail.gmail.com>
Content-Language: en-US
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <CAPDyKFqKw-6Qu7YoZw9LQDGvj1PFi3nCDkXcmCJTffxtX75naQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eG6jfmzDmmts5LhAy-US6RR8fzqtOn5Q
X-Proofpoint-GUID: eG6jfmzDmmts5LhAy-US6RR8fzqtOn5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_03,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260059
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for checking this Ulf,

On 6/22/2023 6:31 PM, Ulf Hansson wrote:
> On Wed, 21 Jun 2023 at 08:21, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>>
>> Many thanks again,
>>
>> On 6/16/2023 4:25 PM, Ulf Hansson wrote:
>>> On Wed, 14 Jun 2023 at 08:43, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>>
>>>
>>> Right. I am not saying it's the perfect solution, but it seems like it
>>> could potentially solve the problem for many cases.
>>>
>>> If you want some help to turn the cpuidle-psci driver into a loadable
>>> module, just reach out, I am happy to help.
>>>
>> Thanks :)
> 
> Np!
> 
>> Making cpuidle-psci as loadable does not hold good for target does not
>> support DLKM, in addition to it rpmh driver has dependency on
>> cpuidle-psci for pm-domain and rpmh probe will get defer, their are
>> driver which depends on rpmh probe like interconnect, clk etc. And
>> eventually dependent driver probe defers which are essential for Linux
>> boot-up.
>> Hope you got scenario for getting probe defer if we make cpuidle-psci as
>> loadable.
> 
> I understand your concern, but you have got my idea wrong.
> 
> I was suggesting turning the cpuidle-psci driver into a loadable
> module - not the cpuidle-psci-domain driver. The latter is the genpd
> provider, which consumers like rpmh need to probe.
> 
hmm, I need to revisit.
>>
>> I have below options as well
>> [A]: Can we think of making "governor/param_governor"
>> module_param_string, string named governor only to load. In that way
>> need to remove check [3]. Let's say string passed as "teo" then it will
>> not load "menu" and loads "teo" once comes-up.
>>
>> [B]: Can we think of making cpuidle.off as writable, let governors to
>> register (i.e remove check [4]) and allow cpuidle_init() to happen (i.e
>> remove check [5])
>> So in this way cpuidle.off=1, your idle state can not be selected
>> because [6] and later we can write off=0 to let same check [6] to fail.
>>
>> [C]: Coming to this series approach...What is best way to utilize
>> already present Flag-CPUIDLE_FLAG_OFF ?
>> Since we can not add new DT property to take decision in driver as it's
>> not HW feature to be expose in device tree [7]. Can we introduce new
>> module_param() for making idle-state disable default and utilize
>> CPUIDLE_FLAG_OFF? maybe similar to [8]
>>
>> happy to hear your thoughts!
> 
> In general I am not in favor of module parameters, but maybe it's the
> best option to solve this problem. We need Rafael's and Daniel's
> opinion to conclude.
> 
Yea, I double thought before proposing module parameters options. But on 
other hand to justify CPUIDLE_FLAG_OFF looks good.
Will wait for Rafael's and Daniel's opinion.

> However, to me, I still think the easiest approach would be to turn
> the cpuidle-psci driver into a loadable module. Let me hack on that
> and post a few patches that you can test for this.
> 
Sure,
>>
>>
>> [3]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/governor.c?h=next-20230620#n93
>>
>> [4]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/governor.c?h=next-20230620#n86
>>
>> [5]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/cpuidle.c?h=next-20230620#n808
>>
>> [6]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/sched/idle.c?h=next-20230620#n167
>>
>> [7]
>> https://lore.kernel.org/lkml/20230608085544.16211-1-quic_tnimkar@quicinc.com/T/#m5d6012b0dfcff700f48c0efbba629382f18ee33b
>>
>> [8]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/idle/intel_idle.c?h=next-20230620#n2160
>>> [...]
>>>
> 
> Kind regards
> Uffe

Thanks,
Tushar
