Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727A374EB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGKKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:13:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1069E;
        Tue, 11 Jul 2023 03:13:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9jPC2008987;
        Tue, 11 Jul 2023 10:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kuo7CikGsbdgndk67bwg/O5cTt5iHexi8B0jVS6YzSs=;
 b=GC581uu0EOQ+SJf4NvEZkfVez9ODBcBR8E6E3MsDR61Tc0IGwqThTk6Cxd3QPwol/rVY
 NMPZhOGotKdb1pqKy1XKQoS+ReX6F5d5jwvsPXyIQ1wZSZLoIrAf+vEEoVXReAUWvIs+
 QzKXpSbNpOafocqE8bnQArRbTFZ99LGXtpTyjOuh6k/P1nRLn0nEkwtmevsCzt2tDF5/
 xCQgmV9LYWZV2656zoqL1ftfOyHHTDpOdCey2UVIsYsQ1ts7cyD6qdoNjDUO5dHKdqOk
 rMl11Yxvb8CUl3vl2vVTyCJjphY7Ro5TjOeTF44mrG4G1yq/jSpqNd4hykheNJ2WlqPT Sg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs4qp01mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:12:54 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BACrVO010152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:12:53 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 03:12:50 -0700
Message-ID: <8a950aa5-fdd8-f983-0411-4b39ade596f4@quicinc.com>
Date:   Tue, 11 Jul 2023 18:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
To:     Marc Zyngier <maz@kernel.org>
CC:     <will@kernel.org>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_songxue@quicinc.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <875y6s8bwb.wl-maz@kernel.org>
 <32f442e3-3d5c-4cec-9791-0da039f88287@quicinc.com>
 <874jmc8654.wl-maz@kernel.org>
 <6e07ad52-2629-346e-6217-ec07777ebc5b@quicinc.com>
 <86lefnvsto.wl-maz@kernel.org>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <86lefnvsto.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bkzf8wlK7wOARRdwB-QYAjYggnEEcQKb
X-Proofpoint-GUID: Bkzf8wlK7wOARRdwB-QYAjYggnEEcQKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110089
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 2:57 PM, Marc Zyngier wrote:
> On Tue, 11 Jul 2023 04:30:44 +0100,
> "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
>>
>> On 7/10/2023 5:31 PM, Marc Zyngier wrote:
>>> On Mon, 10 Jul 2023 09:19:54 +0100,
>>> "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
>>>>
>>>> On 7/10/2023 3:27 PM, Marc Zyngier wrote:
>>>>> On Mon, 10 Jul 2023 06:59:55 +0100,
>>>>> Maria Yu <quic_aiquny@quicinc.com> wrote:
>>>>>>
>>>>>> In order to be able to disable lse_atomic even if cpu
>>>>>> support it, most likely because of memory controller
>>>>>> cannot deal with the lse atomic instructions, use a
>>>>>> new idreg override to deal with it.
>>>>>
>>>>> In general, the idreg overrides are *not* there to paper over HW bugs.
>>>>> They are there to force the kernel to use or disable a feature for
>>>>> performance reason or to guide the *enabling* of a feature, but not
>>>>> because the HW is broken.
>>>>>
>>>>> The broken status of a HW platform must also be documented so that we
>>>>> know what to expect when we look at, for example, a bad case of memory
>>>>> corruption (something I'd expect to see on a system that only
>>>>> partially implements atomic memory operations).
>>>>>
>>>>
>>>> good idea. A noc error would be happened if the lse atomic instruction
>>>> happened during a memory controller doesn't support lse atomic
>>>> instructions.
>>>> I can put the information in next patchset comment message. Pls feel
>>>> free to let know if there is other place to have this kind of
>>>> information with.
>>>
>>> For a start, Documentation/arch/arm64/silicon-errata.rst should
>>> contain an entry for the actual erratum, and a description of the
>>> symptoms of the issue (you're mentioning a "noc error": how is that
>>> reported to the CPU?).
>>
>> This is not a cpu's errata as my understanding. It is the DDR
>> subsystem which don't have the LSE atomic feature supported.
> 
> CPU or not doesn't matter. We also track system errata.

Thank you for clarify on this.
If I am correct understanding, are you suggesting system errata with DT 
seperate compatible (or similar) to runtime disable this feature instead 
of idreg override with arm64.nolse options?

While it is better to finally affect the host arm64_ftr_regs value since 
it can also derived to kvm sys reg as well.
> 
>>>
>>> The workaround should also be detected at runtime -- we cannot rely on
>>> the user to provide a command-line argument to disable an essential
>>> feature that anyone has taken for granted for most of a decade...
>>
>> We are also seeking help from DDR Subsystem POC to see whether it is
>> possible to detect the LSE atomic feature support or not at runtime.
> 
> Keying it off a DT compatible (or something similar) would work.
> 
>> In my opinion, LSE atomic is a system level feature instead of a cpu
>> only feature. So currently solution we is that even if cpu support lse
>> atomic, but it still needed to be disabled if the cpu working with a
>> lse atomic not support by current system's DDR subsystem.
> 
> In the absence of a detection mechanism for anything past the CPU,
> this is a moot point. At this stage, this is a bit like saying
> "writing to memory is a system thing, not only a CPU feature".
> 
> And this also breaks KVM if these CPUs don't have FWB, as a guest can
> always map a piece of memory as non-cacheable, and trigger the issue
> you describe in your reply to Will, even if you hide the atomics on
> the host.
> 

For the KVM part, per my understanding, as long as the current feature 
id being overriden, the KVM system also get the current vcpu without the 
lse atomic feature enabled.
KVM vcpu will read the sys reg from host arm64_ftr_regs which is already 
been controled by the idreg_overrides.

check reference from:
https://elixir.bootlin.com/linux/v6.5-rc1/source/arch/arm64/kernel/cpufeature.c#L680

https://elixir.bootlin.com/linux/v6.5-rc1/source/arch/arm64/kvm/sys_regs.c#L1360

> 	M.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

