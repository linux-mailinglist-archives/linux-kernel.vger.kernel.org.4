Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3C74FD46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjGLCsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGLCse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:48:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA361AE;
        Tue, 11 Jul 2023 19:48:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C1QIbV005045;
        Wed, 12 Jul 2023 02:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CsAdAZdLWuI1tfff7Rxs2HPAgmvW1dSZS2GwPKSIfG8=;
 b=OBqttuAvuKVjoWLtquYByENz8FJwxQh8Jc33fk97MlziFObzoUWoDhA/9OZ9I91EjoYl
 1/DsFJytk7EewHrjLDC5LMk9sLVM+cICSBdcmH2dt7pTFibEPJ/C3amNQGGb4ZP68dNO
 fNqPo+rGk76IMPEE3SMnQhNxToGRg86J3w/IDg9oG8LVhFPXcA6J61ZkMqqy7SghCY+F
 PwaSUbpFlj88XV5vGB76OiDSzG6qAIhamHw+LAmALIHavqUky2SzMJeo5MwyAGsGgwBu
 puFkTdfJwdFOEWIzuqFRYJVXiL144jMzBH8x9yNEIf8G0IklOFofoNXOfKY0XTuOCINi pw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf87gctj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 02:48:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C2m1E2012927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 02:48:01 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 19:47:57 -0700
Message-ID: <9e69158f-1e67-344b-fea9-85bb5e21183f@quicinc.com>
Date:   Wed, 12 Jul 2023 10:47:55 +0800
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
 <8a950aa5-fdd8-f983-0411-4b39ade596f4@quicinc.com>
 <86cz0ywx5p.wl-maz@kernel.org>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <86cz0ywx5p.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iK6lXty1YSXqhCO3YhCWB5FJqrjyXRAi
X-Proofpoint-ORIG-GUID: iK6lXty1YSXqhCO3YhCWB5FJqrjyXRAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=907 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120022
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 6:38 PM, Marc Zyngier wrote:
> On Tue, 11 Jul 2023 11:12:48 +0100,
> "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
>>
>> For the KVM part, per my understanding, as long as the current feature
>> id being overriden, the KVM system also get the current vcpu without
>> the lse atomic feature enabled.
>> KVM vcpu will read the sys reg from host arm64_ftr_regs which is
>> already been controled by the idreg_overrides.
> 
> You're completely missing the point.
> 
> The guest is free to map memory as non-cacheable *and* to use LSE
> atomics even if the idregs pretend this is not available. At which
The guest also can have the current linux kernel mechanism of LSE ATOMIC 
way.

+----------------------------+ 
 

|                            | 
 

| Read the cpu feature IDs   | 
 

+----------------------------+ 
 

 
 

              v 
 

+----------------------------+         +-------------------+ 
 

|                            |  Y      | Use lse atomic ins| 
 

| if lse atomic supported    |  --     |                   | 
 

+----------------------------+         +-------------------+ 
 

              v   N 
 

+----------------------------+ 
 

| Use    r/stxr + atomic ins | 
 

|                            | 
 

+----------------------------+ 
 


Just like other KVM vcpu cpu features, lse atomic can be a feature 
inherit from the pysical cpu features for the KVM vcpus.

> point the HW throws a fit and the system is dead. Is that acceptable?
> Of course not.
> 

The current patchset is try to have the ability to *kind of free* to not 
make system dead. Since currently linux kernel already have the runtime 
patching of lse atomic ops, we are trying to have user have option to 
re-use the switch of system_uses_lse_atomics().

#define __lse_ll_sc_body(op, ...)					\
({									\
	system_uses_lse_atomics() ?					\
		__lse_##op(__VA_ARGS__) :				\
		__ll_sc_##op(__VA_ARGS__);				\
})

> So there are two aspects to your problem:
> 
> - for Linux, there is nothing to do: the kernel will correctly behave,
>    and as long as you don't expose non-cacheable memory to userspace.
>    Out of tree drivers are none of our concern here.
> 

For Linux kernel, we have provide the In-line patching at runtime, and 
all third party kernel modules are built with those in-line patching as 
well.
if we can have an option, the current system can still run those third 
party kernel modules without system crash.

/* In-line patching at runtime */
#define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
	ALTERNATIVE(llsc, __LSE_PREAMBLE lse, ARM64_HAS_LSE_ATOMICS)

static __always_inline bool system_uses_lse_atomics(void)
{
	return alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS);
}
> - for guests, it looks like the HW doesn't provide the basic
>    requirements for virtualisation, and you should always disable KVM
>    on this HW (or even better, enter the kernel at EL1).
> 
I can see that KVM can still be supported even if current phisical cpu 
don't have emulated vcpu features. We can only disable the current vcpu 
feature which exposed to KVM guest.
> In both cases, nothing to do in the kernel, which is good news.
> 
> 	M.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

