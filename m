Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9025174FD73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGLDJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGLDJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:09:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059D1712;
        Tue, 11 Jul 2023 20:09:28 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C2upi5030604;
        Wed, 12 Jul 2023 03:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=unT4TGu4vj4swGuvnf1SU6F2ymowiMhTHYePcXIoqQs=;
 b=FKK5RUaBV7yAQKHQ8SQcnoQzLy6irO0yL92mE0LPXX3LZDo9Q2DJSfnNmaWky/Dvzvae
 1N67OZP+CuFBsm8EFJVCh++dEdPVgsscQ9dXYgODLQ4IuOF3VMXq0VnM1fE5HBA4FHi2
 f3MjdHFRtMICHNtproMnuC3K4zBGWTn1zlo9PG3o3SLUi9ocBNTf31OukyLeODoTSf3I
 y7rsXidfzjWJH2x3Z6ARH+ilw3wmipDEGGZY2UDWXAj1QsNTZUAZV9pZ2VrYbVeorU3b
 Wv9Ab5oap3eQYvvEkL9nQaMdo6t0gRVAg/ybH/UK+cKgIyrTyOg6xtoQy0FnZLwOscfZ DQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf51gedw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 03:09:16 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C39F13000622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 03:09:15 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 20:09:12 -0700
Message-ID: <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
Date:   Wed, 12 Jul 2023 11:09:10 +0800
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
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
 <20230711102510.GA1809@willie-the-truck>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20230711102510.GA1809@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9pM9JF9wyctwtA2vdxDJQ6sFV5k5Xh3F
X-Proofpoint-GUID: 9pM9JF9wyctwtA2vdxDJQ6sFV5k5Xh3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120025
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 6:25 PM, Will Deacon wrote:
> On Tue, Jul 11, 2023 at 06:15:49PM +0800, Aiqun(Maria) Yu wrote:
>> On 7/11/2023 4:22 PM, Will Deacon wrote:
>>> On Tue, Jul 11, 2023 at 12:02:22PM +0800, Aiqun(Maria) Yu wrote:
>>>> On 7/10/2023 5:37 PM, Will Deacon wrote:
>>>>> On Mon, Jul 10, 2023 at 01:59:55PM +0800, Maria Yu wrote:
>>>>>> In order to be able to disable lse_atomic even if cpu
>>>>>> support it, most likely because of memory controller
>>>>>> cannot deal with the lse atomic instructions, use a
>>>>>> new idreg override to deal with it.
>>>>>
>>>>> This should not be a problem for cacheable memory though, right?
>>>>>
>>>>> Given that Linux does not issue atomic operations to non-cacheable mappings,
>>>>> I'm struggling to see why there's a problem here.
>>>>
>>>> The lse atomic operation can be issued on non-cacheable mappings as well.
>>>> Even if it is cached data, with different CPUECTLR_EL1 setting, it can also
>>>> do far lse atomic operations.
>>>
>>> Please can you point me to the place in the kernel sources where this
>>> happens? The architecture doesn't guarantee that atomics to non-cacheable
>>> mappings will work, see "B2.2.6 Possible implementation restrictions on
>>> using atomic instructions". Linux, therefore, doesn't issue atomics
>>> to non-cacheable memory.
>>
>> We encounter the issue on third party kernel modules and third party apps
>> instead of linux kernel itself.
> 
> Great, so there's nothing to do in the kernel then!
> 
> The third party code needs to be modified not to use atomic instructions
> with non-cacheable mappings. No need to involve us with that.

> 
>> This is a tradeoff of performance and stability. Per my understanding,
>> options can be used to enable the lse_atomic to have the most performance
>> cared system, and disable the lse_atomic by stability cared most system.
> 
> Where do livelock and starvation fit in with "stability"? Disabling LSE
> atomics for things like qspinlock and the scheduler just because of some
> badly written third-party code isn't much of a tradeoff.
We also have requirement to have cpus/system fully support lse atomic 
and cpus/system not fully support lse atomic with a generic kernel image.
Same kernel module wanted to be used by lse atomic fully support cpu and 
not fully support cpu/system as well.

That's why we want to have a runtime option here.

> 
> Will

-- 
Thx and BRs,
Aiqun(Maria) Yu

