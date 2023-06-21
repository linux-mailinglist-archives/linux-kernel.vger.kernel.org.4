Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713727383BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjFUM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFUM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:28:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF21A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:28:38 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LCD7jC001521;
        Wed, 21 Jun 2023 12:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vSB2msI7SSeVrz8Q33MAHJ9/wece0yQ/jgLpeoqSN10=;
 b=YApTTIliFM28ttCDCHpdPfRo0o4i+/2lwb1xSzZxhl5JspYLtPhnkJx++l5w9KwrKYpJ
 oSaOQRgZipzyF2odJbpeZDNnSul/ZdIq+1lvnwkmqh7F/9ZrQkcmQv+WBLAB2QOIGXwr
 fH604Bgr6/m1UWVNJUp959iB1Y7bv7eBXygMPtaJY1JatVNic1Mx8TIBEnpv/dSYYqEA
 Wbu8DfH+H6jh9iDgqoUd8HNL+ACkbwpaGTQEXJDKFExi6+7q380qVf8scsaG3SeanaCc
 fSc4Ivo+YxlZWH/fp6P22bOoGs6B66Lh2goslxyLiThB8eCFhakClE+AxO5phx7wCPWZ hg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc0mqh16n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 12:28:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L1pPxv003626;
        Wed, 21 Jun 2023 12:28:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5arm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 12:28:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LCSS1L46203330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 12:28:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18D720043;
        Wed, 21 Jun 2023 12:28:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83E0020040;
        Wed, 21 Jun 2023 12:28:28 +0000 (GMT)
Received: from [9.152.212.241] (unknown [9.152.212.241])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 12:28:28 +0000 (GMT)
Message-ID: <0820010f-e9dc-779d-7924-49c7df446bce@linux.ibm.com>
Date:   Wed, 21 Jun 2023 14:28:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] gcov: add prototypes for internal functions
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230517125011.930274-1-arnd@kernel.org>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20230517125011.930274-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _NLVaxH2yik-kQXKI2EeQrOw8gBfDHyI
X-Proofpoint-ORIG-GUID: _NLVaxH2yik-kQXKI2EeQrOw8gBfDHyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2023 14:50, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcov uses global functions that are called from generated code,
> but these have no prototype in a header, which causes a W=1
> build warning:

Sorry for the late reply. I can confirm that the problem exists, both
with GCC and Clang compiles. I see some issues with your fix though:

1. It contains extraneous prototypes that are duplicates of existing
prototypes in gcov.h (everything that doesn't start with __gcov or llvm)

2. Adding the list of prototypes, though not actually needed by kernel
source code, will require updating gcov.h if new calls from generated
code are introduced - this is extra work I'd like to avoid if possible

Because this situation is special, I would rather prefer to silence
these warnings by removing the associated compiler flags
(-Wmissing-prototypes and I think also -Wmissing-declarations) for
gcc_base.c and clang.c using CFLAGS_REMOVE.

If you agree, do you want to provide a v2 along these lines?

[...]

> --- a/kernel/gcov/gcov.h
> +++ b/kernel/gcov/gcov.h
> @@ -82,4 +82,34 @@ extern const struct gcov_link gcov_link[];
>  extern int gcov_events_enabled;
>  extern struct mutex gcov_lock;
>  

FYI - these are defined in gcc_base.c and called only by GCC generated code:

> +void __gcov_init(struct gcov_info *info);
> +void __gcov_flush(void);
> +void __gcov_merge_add(gcov_type *counters, unsigned int n_counters);
> +void __gcov_merge_single(gcov_type *counters, unsigned int n_counters);
> +void __gcov_merge_delta(gcov_type *counters, unsigned int n_counters);
> +void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters);
> +void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters);
> +void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters);
> +void __gcov_exit(void);

These are defined in both gcc_4_7.c and clang.c and used by other code
in kernel/gcov/*:

> +size_t convert_to_gcda(char *buffer, struct gcov_info *info);
> +void gcov_info_add(struct gcov_info *dst, struct gcov_info *src);
> +struct gcov_info *gcov_info_dup(struct gcov_info *info);
> +const char *gcov_info_filename(struct gcov_info *info);
> +void gcov_info_free(struct gcov_info *info);
> +int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2);
> +void gcov_info_link(struct gcov_info *info);
> +struct gcov_info *gcov_info_next(struct gcov_info *info);
> +void gcov_info_reset(struct gcov_info *info);
> +void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info);
> +unsigned int gcov_info_version(struct gcov_info *info);
> +bool gcov_info_within_module(struct gcov_info *info, struct module *mod);

And these are defined in clang.c and called only by Clang generated code:

> +void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters);
> +void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum);
> +void llvm_gcda_end_file(void);
> +void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum);
> +void llvm_gcda_summary_info(void);
> +typedef void (*llvm_gcov_callback)(void);
> +void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush);

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

