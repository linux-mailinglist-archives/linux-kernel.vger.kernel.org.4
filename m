Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963974EB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGKKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGKKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:18:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4331E0;
        Tue, 11 Jul 2023 03:18:32 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAAPYm009618;
        Tue, 11 Jul 2023 10:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KO63ctyD0hbRkB5yTd9HFi5Gp8n5CTdw+VRyzr2gNSc=;
 b=XQLOF2vU0XtLxP6sOxD0EMn0AlEuOw0bNKxLtKy7tkdILi+rKOw9q/jOlLIPtyD+e2Li
 oEP9lR4c5RTgukAHO2qez5tfVEqvxHhPvLwcRn0sZl8YjjQvPeDssw1+z5bhfKzYbAZ3
 8s3djwO822VoqM6CvWs1VdW8lYovvX/xxLwhs+TvBNqw7dSGBbBz2AlpAcZB0BDpt/H/
 ZR30UakkKWPI2CoZ2+OezEKi4BklQmVD9rNqujDsDe9A99bkygrEn4F3Ys1DT+xpXOzO
 iSxU1KBV8vgXLIQ/JhKXt77DuLIBcXVF7i1JgBf271LiyHEDI5Vnx+aqcTt2xQIilThi Uw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs442g422-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:18:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BAFsSw013022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:15:54 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 03:15:52 -0700
Message-ID: <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
Date:   Tue, 11 Jul 2023 18:15:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
To:     Will Deacon <will@kernel.org>
CC:     <corbet@lwn.net>, <catalin.marinas@arm.com>, <maz@kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_songxue@quicinc.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <20230710093751.GC32673@willie-the-truck>
 <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
 <20230711082226.GA1554@willie-the-truck>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20230711082226.GA1554@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b8fTt_RYPXkhg-6RRvLwp_zgtjfOMMDq
X-Proofpoint-GUID: b8fTt_RYPXkhg-6RRvLwp_zgtjfOMMDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=673 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110091
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 4:22 PM, Will Deacon wrote:
> On Tue, Jul 11, 2023 at 12:02:22PM +0800, Aiqun(Maria) Yu wrote:
>> On 7/10/2023 5:37 PM, Will Deacon wrote:
>>> On Mon, Jul 10, 2023 at 01:59:55PM +0800, Maria Yu wrote:
>>>> In order to be able to disable lse_atomic even if cpu
>>>> support it, most likely because of memory controller
>>>> cannot deal with the lse atomic instructions, use a
>>>> new idreg override to deal with it.
>>>
>>> This should not be a problem for cacheable memory though, right?
>>>
>>> Given that Linux does not issue atomic operations to non-cacheable mappings,
>>> I'm struggling to see why there's a problem here.
>>
>> The lse atomic operation can be issued on non-cacheable mappings as well.
>> Even if it is cached data, with different CPUECTLR_EL1 setting, it can also
>> do far lse atomic operations.
> 
> Please can you point me to the place in the kernel sources where this
> happens? The architecture doesn't guarantee that atomics to non-cacheable
> mappings will work, see "B2.2.6 Possible implementation restrictions on
> using atomic instructions". Linux, therefore, doesn't issue atomics
> to non-cacheable memory.

We encounter the issue on third party kernel modules and third party 
apps instead of linux kernel itself.

This is a tradeoff of performance and stability. Per my understanding, 
options can be used to enable the lse_atomic to have the most 
performance cared system, and disable the lse_atomic by stability cared 
most system.
> 
>>> Please can you explain the problem that you are trying to solve?
>>
>> In our current case, it is a 100% reproducible issue that happened for
>> uncached data, the cpu which support LSE atomic, but the system's DDR
>> subsystem is not support this and caused a NOC error and thus synchronous
>> external abort happened.
> 
> So? The Arm ARM allows this behaviour and Linux shouldn't run into it.
> 
> Will

-- 
Thx and BRs,
Aiqun(Maria) Yu

