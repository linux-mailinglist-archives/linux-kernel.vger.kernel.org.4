Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C808274E555
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGKDbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGKDbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:31:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CACE;
        Mon, 10 Jul 2023 20:31:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B2qEi7000675;
        Tue, 11 Jul 2023 03:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2E5Wwf9zHynho7YeHL1uNkcW/BeMipMerE6+V7msgwY=;
 b=IXfoD3tnf3yuTxPk5QEEODaQTBDcwCWehfOYpU5OPNfQJ2W01WpDLJugS2CsnEAaCXc0
 ZXb5lerFqo6eQO8z1Ikwwi/rHs1csJebeTRoJfBBIzIFvlbyMwtccORQYS5Pdn6j+fTw
 VeoNdq7bIbuvsHqT6FYkRoAcMOC/EX9Kxs6n2Mc6+pA6/o5ioERDukxhzD3xt65raRns
 zn5I8Ckw+frTvmWnOpS9fOO+zV9jGivjiOPSQaFeQa+KCXc6JKRnnkERdO9X3vMWFkdn
 4C26IaI1POAKjcIqHAAKP7cFX3EjzC2CSqbcQ2YZ4dyPmAQDriLWZ5neE87yPfw6haIu pA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrx7yg2u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 03:30:51 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B3UoKh001774
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 03:30:50 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 20:30:47 -0700
Message-ID: <6e07ad52-2629-346e-6217-ec07777ebc5b@quicinc.com>
Date:   Tue, 11 Jul 2023 11:30:44 +0800
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
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <874jmc8654.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GVrel2fJN7N_WB35GqcX8c5jdxgxhIwD
X-Proofpoint-ORIG-GUID: GVrel2fJN7N_WB35GqcX8c5jdxgxhIwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_18,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110029
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2023 5:31 PM, Marc Zyngier wrote:
> On Mon, 10 Jul 2023 09:19:54 +0100,
> "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
>>
>> On 7/10/2023 3:27 PM, Marc Zyngier wrote:
>>> On Mon, 10 Jul 2023 06:59:55 +0100,
>>> Maria Yu <quic_aiquny@quicinc.com> wrote:
>>>>
>>>> In order to be able to disable lse_atomic even if cpu
>>>> support it, most likely because of memory controller
>>>> cannot deal with the lse atomic instructions, use a
>>>> new idreg override to deal with it.
>>>
>>> In general, the idreg overrides are *not* there to paper over HW bugs.
>>> They are there to force the kernel to use or disable a feature for
>>> performance reason or to guide the *enabling* of a feature, but not
>>> because the HW is broken.
>>>
>>> The broken status of a HW platform must also be documented so that we
>>> know what to expect when we look at, for example, a bad case of memory
>>> corruption (something I'd expect to see on a system that only
>>> partially implements atomic memory operations).
>>>
>>
>> good idea. A noc error would be happened if the lse atomic instruction
>> happened during a memory controller doesn't support lse atomic
>> instructions.
>> I can put the information in next patchset comment message. Pls feel
>> free to let know if there is other place to have this kind of
>> information with.
> 
> For a start, Documentation/arch/arm64/silicon-errata.rst should
> contain an entry for the actual erratum, and a description of the
> symptoms of the issue (you're mentioning a "noc error": how is that
> reported to the CPU?).

This is not a cpu's errata as my understanding. It is the DDR subsystem 
which don't have the LSE atomic feature supported.
> 
> The workaround should also be detected at runtime -- we cannot rely on
> the user to provide a command-line argument to disable an essential
> feature that anyone has taken for granted for most of a decade...

We are also seeking help from DDR Subsystem POC to see whether it is 
possible to detect the LSE atomic feature support or not at runtime.

In my opinion, LSE atomic is a system level feature instead of a cpu 
only feature. So currently solution we is that even if cpu support lse 
atomic, but it still needed to be disabled if the cpu working with a lse 
atomic not support by current system's DDR subsystem.

> 
> [...]
> 
>>>> @@ -185,6 +195,7 @@ static const struct {
>>>>    	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
>>>>    	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
>>>>    	{ "nokaslr",			"arm64_sw.nokaslr=1" },
>>>> +	{ "arm64.nolse_atomic",         "id_aa64isar0.atomic=0" },
>>>
>>> And what of 32bit?
> 
> This particular question still stands, as it is likely to affect VMs.
> 
> 	M.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

