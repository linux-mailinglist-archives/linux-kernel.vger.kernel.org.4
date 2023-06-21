Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43A737B33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFUGVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:21:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D0F19C;
        Tue, 20 Jun 2023 23:21:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L5druq019659;
        Wed, 21 Jun 2023 06:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7ToFP2HpqlEDvbtmR06hiU8X4yOukC7Jo77fS4yeCIY=;
 b=cI9dV8CQ91BG1fY5lpni+U9EbSHoM5X6xjyBrgtbjZ23SXhGtr9a+QnurkfSYLfXGQRW
 MO+vVLJ/kWHeMjHDOOg1m2vWEdM6igcDEdecUJo6tCD8GRE3F9eYEWCUohNI6gd9RnYD
 aznbbmpTa+OkZR/eYYS9jsW9jMGmj9bpLKRSPafonICVWloDI3F4Kstz6jwCS/NNhOgn
 As0FXE+YVr0qo4XqOq7upY0lhD8qDGUT2DBL/qowgc/lih3l/phzixp7zi0n2LHMieZ9
 gYq5aDYgVAddINm35PfEZNZ96o3CQJhr42fEPMA0EOne25TXLvdP8tc+04lDyQBKLkQV Xg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb3xnk35h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:21:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L6LPT8009656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:21:25 GMT
Received: from [10.217.198.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 23:21:22 -0700
Message-ID: <29ccc60e-9ef8-883f-9936-95e6ef842746@quicinc.com>
Date:   Wed, 21 Jun 2023 11:51:19 +0530
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
Content-Language: en-US
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <CAPDyKFp5L454WmTPo2eYnBuZ=ZMKEtinLgYU09n=J=3DA1FSJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8FKHHEDZUzwmFFnomjXaFjAHSZfn1nRl
X-Proofpoint-GUID: 8FKHHEDZUzwmFFnomjXaFjAHSZfn1nRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210052
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks again,

On 6/16/2023 4:25 PM, Ulf Hansson wrote:
> On Wed, 14 Jun 2023 at 08:43, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:

> 
> Right. I am not saying it's the perfect solution, but it seems like it
> could potentially solve the problem for many cases.
> 
> If you want some help to turn the cpuidle-psci driver into a loadable
> module, just reach out, I am happy to help.
> 
Thanks :)
Making cpuidle-psci as loadable does not hold good for target does not 
support DLKM, in addition to it rpmh driver has dependency on 
cpuidle-psci for pm-domain and rpmh probe will get defer, their are 
driver which depends on rpmh probe like interconnect, clk etc. And 
eventually dependent driver probe defers which are essential for Linux 
boot-up.
Hope you got scenario for getting probe defer if we make cpuidle-psci as 
loadable.

I have below options as well
[A]: Can we think of making "governor/param_governor" 
module_param_string, string named governor only to load. In that way 
need to remove check [3]. Let's say string passed as "teo" then it will 
not load "menu" and loads "teo" once comes-up.

[B]: Can we think of making cpuidle.off as writable, let governors to 
register (i.e remove check [4]) and allow cpuidle_init() to happen (i.e 
remove check [5])
So in this way cpuidle.off=1, your idle state can not be selected 
because [6] and later we can write off=0 to let same check [6] to fail.

[C]: Coming to this series approach...What is best way to utilize 
already present Flag-CPUIDLE_FLAG_OFF ?
Since we can not add new DT property to take decision in driver as it's 
not HW feature to be expose in device tree [7]. Can we introduce new 
module_param() for making idle-state disable default and utilize 
CPUIDLE_FLAG_OFF? maybe similar to [8]

happy to hear your thoughts!


[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/governor.c?h=next-20230620#n93

[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/governor.c?h=next-20230620#n86

[5] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/cpuidle.c?h=next-20230620#n808

[6] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/sched/idle.c?h=next-20230620#n167

[7] 
https://lore.kernel.org/lkml/20230608085544.16211-1-quic_tnimkar@quicinc.com/T/#m5d6012b0dfcff700f48c0efbba629382f18ee33b

[8] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/idle/intel_idle.c?h=next-20230620#n2160
> [...]
> 
> Kind regards
> Uffe


Thanks,
Tushar
