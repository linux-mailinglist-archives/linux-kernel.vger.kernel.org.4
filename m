Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3B73A60D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjFVQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFVQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349861BDF;
        Thu, 22 Jun 2023 09:25:41 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MGGlKS013633;
        Thu, 22 Jun 2023 16:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qD1qlhKCKV9Gk/Gjt6jadS5UFlsWxSGO0aUPUrItqzs=;
 b=jYYfGeGRQ3zLxjiAvNda/y4OI0ywP/4TVxqY691pSz9R4RSvpFS617nUYNj5UUutDpom
 UleDGVAcUhDXI+PuKYQkAWE61q0e1MrEx59dpSq0lnGywnAQCTuVXeIzei8NNSg3y1yt
 XgqXarDC/ZJzCx1hV/X+HF+DKQG9z+Q54SXgv+ppPs2lEa5WuSvXEkNqNsJWWhW94mg/
 6QMJW+Al7D23OIoT2g86XUFe3uWxhCGdhwQvlEcu+N2jps3uYBviGEJeLHNYiHumKmZb
 b+lkg15evovpPWtaS8fTKKOPolOBeanzafGNt614LBgCD/xl7rhZ7zwuo0Ez0+4Vt5dv zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcsfkrskb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 16:24:16 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MG49ni025954;
        Thu, 22 Jun 2023 16:24:15 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcsfkrsj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 16:24:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M9kkIB029518;
        Thu, 22 Jun 2023 16:24:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r943e3kjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 16:24:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MGO9tV10420856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 16:24:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29FCA20043;
        Thu, 22 Jun 2023 16:24:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77E2320040;
        Thu, 22 Jun 2023 16:24:05 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.59.34])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Jun 2023 16:24:05 +0000 (GMT)
Date:   Thu, 22 Jun 2023 18:24:03 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, peterz@infradead.org,
        frederic@kernel.org, akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 12/13] s390/kexec: refactor for kernel/Kconfig.kexec
Message-ID: <ZJR1o0lzhIUdpTb+@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230619145801.1064716-1-eric.devolder@oracle.com>
 <20230619145801.1064716-13-eric.devolder@oracle.com>
 <ZJKD690QaX1IgiAz@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <b89bb8d6-77db-76fe-e360-f6c439b80e73@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89bb8d6-77db-76fe-e360-f6c439b80e73@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qCenS3OA9UceHHV25yycwEWlCVqc_XCw
X-Proofpoint-GUID: t_YQDqT-rDR4fb7suT2OXhiuNh4-PXUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_11,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:10:49PM -0500, Eric DeVolder wrote:
Hi Eric,
...
> > > NOTE: The original Kconfig has a KEXEC_SIG which depends on
> > > MODULE_SIG_FORMAT. However, attempts to keep the MODULE_SIG_FORMAT
> > > dependency (using the strategy outlined in this series, and other
> > > techniques) results in 'error: recursive dependency detected'
> > > on CRYPTO. This occurs due to any path through KEXEC_SIG
> > > attempting to select CRYPTO is ultimately dependent upon CRYPTO:
> > > 
> > >   CRYPTO
> > >    <- ARCH_SUPPORTS_KEXEC_FILE
> > >       <- KEXEC_FILE
> > >          <- KEXEC_SIG
> > > 
> > > Therefore, the solution is to drop the MODULE_SIG_FORMAT dependency
> > > for KEXEC_SIG. In practice, however, MODULE_SIG_FORMAT is still
> > > configured-in as the use of KEXEC_SIG is in step with the use of
> > > SYSTEM_DATA_VERIFICATION, which does select MODULE_SIG_FORMAT.
> > 
> > No, it is actually the other way around.
> > Could you please provide the correct explanation?
> > 
> > AFAICT the MODULE_SIG_FORMAT dependency was introduced with commit
> > c8424e776b09 ("MODSIGN: Export module signature definitions") and
> > in fact was not necessary, since s390 did/does not use mod_check_sig()
> > anyway. So the SYSTEM_DATA_VERIFICATION could have left intact.
> 
> Thomas, would the correct explanation be simply indicating that
> MODULE_SIG_FORMAT isn't needed as it is not used by s390 (crediting your
> summary above)?

I guess, you asked me? Anyway, I will try to answer as if I were Thomas :)

MODULE_SIG_FORMAT is needed to select SYSTEM_DATA_VERIFICATION.
But SYSTEM_DATA_VERIFICATION is also selected by FS_VERITY*, so
dropping MODULE_SIG_FORMAT does not hurt.

Thanks!
