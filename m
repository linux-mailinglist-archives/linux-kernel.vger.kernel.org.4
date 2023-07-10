Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F274CFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGJIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjGJIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:20:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B9E42;
        Mon, 10 Jul 2023 01:20:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A7krCQ023910;
        Mon, 10 Jul 2023 08:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/dTrcIscOIZJe6yEHmvNp1+3t34E6M4g60mqMCOCoh4=;
 b=YGLCuJ72Yd2VxJXvd31r4R5xz8KzwvWWhcyHk669bvxCanG15JfJ+7/naWckdqug9ATu
 Af8PWrWG1FWzZAvqc0y7NsYlu+3I6FUMRKJPeJKRmiAgR1WhxMj8JrcA4XsQ49J9QbrR
 co4duyoWW51ir255b69zZfS83u+DDbsooUOh4aTRGXpkpjoL0C55JGmlCebjW0a9v/Da
 7AZWf2Q0Mi8hB8baiAIOvsQijoNyFD1U0+cG/gePBQq0cUCMJuyOdQsXo0Tox5a4LMzA
 EXgxzwKXpyixprV6bC7n1s62QyzeVi3XNGwFz/oXiHkF31F9MqQrs4AkgJOtFmkpC86e nA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyw1tv42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 08:20:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A8K1Sr019193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 08:20:01 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 01:19:57 -0700
Message-ID: <32f442e3-3d5c-4cec-9791-0da039f88287@quicinc.com>
Date:   Mon, 10 Jul 2023 16:19:54 +0800
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
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <875y6s8bwb.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9n2HqgBUyG4UyY5mpDd1fSudYTtjvnS-
X-Proofpoint-ORIG-GUID: 9n2HqgBUyG4UyY5mpDd1fSudYTtjvnS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_05,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100074
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2023 3:27 PM, Marc Zyngier wrote:
> On Mon, 10 Jul 2023 06:59:55 +0100,
> Maria Yu <quic_aiquny@quicinc.com> wrote:
>>
>> In order to be able to disable lse_atomic even if cpu
>> support it, most likely because of memory controller
>> cannot deal with the lse atomic instructions, use a
>> new idreg override to deal with it.
> 
> In general, the idreg overrides are *not* there to paper over HW bugs.
> They are there to force the kernel to use or disable a feature for
> performance reason or to guide the *enabling* of a feature, but not
> because the HW is broken.
> 
> The broken status of a HW platform must also be documented so that we
> know what to expect when we look at, for example, a bad case of memory
> corruption (something I'd expect to see on a system that only
> partially implements atomic memory operations).
> 

good idea. A noc error would be happened if the lse atomic instruction 
happened during a memory controller doesn't support lse atomic instructions.
I can put the information in next patchset comment message. Pls feel 
free to let know if there is other place to have this kind of 
information with.
>>
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  2 ++
>>   arch/arm64/include/asm/cpufeature.h             |  1 +
>>   arch/arm64/kernel/cpufeature.c                  |  4 +++-
>>   arch/arm64/kernel/idreg-override.c              | 11 +++++++++++
>>   4 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 85fb0fa5d091..6ad754549f1d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -433,6 +433,8 @@
>>   	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
>>   			Set instructions support
>>   
>> +	arm64.nolse_atomic [ARM64] Unconditionally disable LSE Atomic support
>> +
> 
> 'nolse', or 'noatomic' should be enough. In general, the suffix should
> be either derived from the FEAT_* name or the idreg field name.

noatomic can be used in next patchset.
ID_AA64ISAR0_EL1_ATOMIC_SHIFT
> 
>>   	ataflop=	[HW,M68k]
>>   
>>   	atarimouse=	[HW,MOUSE] Atari Mouse
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 96e50227f940..9d56dea1fe62 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -916,6 +916,7 @@ extern struct arm64_ftr_override id_aa64pfr0_override;
>>   extern struct arm64_ftr_override id_aa64pfr1_override;
>>   extern struct arm64_ftr_override id_aa64zfr0_override;
>>   extern struct arm64_ftr_override id_aa64smfr0_override;
>> +extern struct arm64_ftr_override id_aa64isar0_override;
>>   extern struct arm64_ftr_override id_aa64isar1_override;
>>   extern struct arm64_ftr_override id_aa64isar2_override;
>>   
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index f9d456fe132d..9bd766880807 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -669,6 +669,7 @@ struct arm64_ftr_override __ro_after_init id_aa64pfr0_override;
>>   struct arm64_ftr_override __ro_after_init id_aa64pfr1_override;
>>   struct arm64_ftr_override __ro_after_init id_aa64zfr0_override;
>>   struct arm64_ftr_override __ro_after_init id_aa64smfr0_override;
>> +struct arm64_ftr_override __ro_after_init id_aa64isar0_override;
>>   struct arm64_ftr_override __ro_after_init id_aa64isar1_override;
>>   struct arm64_ftr_override __ro_after_init id_aa64isar2_override;
>>   
>> @@ -721,7 +722,8 @@ static const struct __ftr_reg_entry {
>>   	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
>>   
>>   	/* Op1 = 0, CRn = 0, CRm = 6 */
>> -	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
>> +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0,
>> +			       &id_aa64isar0_override),
>>   	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1,
>>   			       &id_aa64isar1_override),
>>   	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
>> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
>> index 2fe2491b692c..af41ab4f3d94 100644
>> --- a/arch/arm64/kernel/idreg-override.c
>> +++ b/arch/arm64/kernel/idreg-override.c
>> @@ -105,6 +105,15 @@ static const struct ftr_set_desc pfr1 __initconst = {
>>   	},
>>   };
>>   
>> +static const struct ftr_set_desc isar0 __initconst = {
>> +	.name		= "id_aa64isar0",
>> +	.override	= &id_aa64isar0_override,
>> +	.fields		= {
>> +	        FIELD("atomic", ID_AA64ISAR0_EL1_ATOMIC_SHIFT, NULL),
>> +		{}
>> +	},
>> +};
>> +
>>   static const struct ftr_set_desc isar1 __initconst = {
>>   	.name		= "id_aa64isar1",
>>   	.override	= &id_aa64isar1_override,
>> @@ -163,6 +172,7 @@ static const struct ftr_set_desc * const regs[] __initconst = {
>>   	&mmfr1,
>>   	&pfr0,
>>   	&pfr1,
>> +	&isar0,
>>   	&isar1,
>>   	&isar2,
>>   	&smfr0,
>> @@ -185,6 +195,7 @@ static const struct {
>>   	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
>>   	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
>>   	{ "nokaslr",			"arm64_sw.nokaslr=1" },
>> +	{ "arm64.nolse_atomic",         "id_aa64isar0.atomic=0" },
> 
> And what of 32bit?
> 
> 	M.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

