Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5C66C9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjAPQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjAPQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:57:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6958673;
        Mon, 16 Jan 2023 08:40:12 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GF7juW006491;
        Mon, 16 Jan 2023 16:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fBP1FmAab/H6Zgk5p7ul1PIoBPGFloOSW0OMal6THLU=;
 b=KGrmx8ORc5zc9liFyr38NqQc+NOdkQjOTvufPh9yC4NFDUtSHoO7iEc2mflnNburgbRA
 Br1gb3Wy8+cwQ2u1gWpIXXVcNxbE3sdTvbWk5zLTeHOLaLwWY+Dzy3aABgQFEQZXPFHF
 hRZB/RQ5JwdqyAZ+iday/bqCbSsT6EF1UIC7EaBzWGDfIIHPTKrxI+UJBMNp/2y0Ncsw
 CnCEyr1w1yhXW3YqOZlusE+nqNDZH167EPP2+4/FX7DEghfTao5tud1fxnybRZDrWxyT
 NrzjyT6NYGRXMLa49XOEq9KB0cAnM17E8KVzm8Odj+kyZh5Xqit2X7basMBAQSi96EaX 9A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4cvx0cxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 16:40:09 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GCwacZ028803;
        Mon, 16 Jan 2023 16:40:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n3m169y0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 16:40:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30GGe2Ms45220114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 16:40:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9131520043;
        Mon, 16 Jan 2023 16:40:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39FAA20040;
        Mon, 16 Jan 2023 16:40:02 +0000 (GMT)
Received: from osiris (unknown [9.171.95.75])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Jan 2023 16:40:02 +0000 (GMT)
Date:   Mon, 16 Jan 2023 17:40:00 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: Build regressions/improvements in v6.2-rc4
Message-ID: <Y8V94PKtaWO3yRS4@osiris>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
 <20230116122924.116745-1-geert@linux-m68k.org>
 <46ba7912-3df6-dff9-792-49f4eaadefec@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ba7912-3df6-dff9-792-49f4eaadefec@linux-m68k.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xL_-_Pq954s8cKuha69CSrGO0WNJ98z-
X-Proofpoint-GUID: xL_-_Pq954s8cKuha69CSrGO0WNJ98z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_14,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=887 phishscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301160123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:36:34PM +0100, Geert Uytterhoeven wrote:
> On Mon, 16 Jan 2023, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.2-rc4[1] to v6.2-rc3-8-g1fe4fd6f5cad346e[3], the summaries are:
> >  - build errors: +1/-5
> 
>   + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]:  => 57:33
> 
> s390x-gcc11/s390-allmodconfig
> 
> /kisskb/src/arch/s390/kernel/setup.c: In function 'setup_lowcore_dat_on':
> /kisskb/src/include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> /kisskb/src/include/linux/fortify-string.h:578:9: note: in expansion of macro '__underlying_memcpy'
>   578 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> /kisskb/src/include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
>   623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> /kisskb/src/arch/s390/kernel/setup.c:526:9: note: in expansion of macro 'memcpy'
>   526 |         memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
>       |         ^~~~~~
> 
> Looks like this was "'__builtin_memcpy' offset [0, 127] is out of the bounds
> [0, 0]" before.

Thanks for reporting. Of course this doesn't happen with gcc-12, and
this code will be rewritten with the next merge window anyway.
But to workaround this with gcc-11, we could go with the below:

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 2b6091349daa..696c9e007a36 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -508,6 +508,7 @@ static void __init setup_lowcore_dat_on(void)
 {
 	struct lowcore *abs_lc;
 	unsigned long flags;
+	int i;
 
 	__ctl_clear_bit(0, 28);
 	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
@@ -523,8 +524,8 @@ static void __init setup_lowcore_dat_on(void)
 	abs_lc = get_abs_lowcore(&flags);
 	abs_lc->restart_flags = RESTART_FLAG_CTLREGS;
 	abs_lc->program_new_psw = S390_lowcore.program_new_psw;
-	memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
-	       sizeof(abs_lc->cregs_save_area));
+	for (i = 0; i < 16; i++)
+		abs_lc->cregs_save_area[i] = S390_lowcore.cregs_save_area[i];
 	put_abs_lowcore(abs_lc, flags);
 }
 
