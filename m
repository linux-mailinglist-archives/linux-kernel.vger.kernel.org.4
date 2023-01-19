Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262FF6739B4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASNOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjASNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:14:03 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A97EE4B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:12:44 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JChpCR026835;
        Thu, 19 Jan 2023 13:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9dD55pyEq2TTC5q4MO1ouTiL5zXt3s3mP+h3Kq+wOWI=;
 b=Jqyh8THMyKGe/8bGROnz6BCK5g86IT0XWyaa58BS59N65nQLy7HEXNgLALTclNVN+fWa
 Ms9dljMaf9BF25aPBSdL8hc8hndzlQptF2KbIYdG/pmY0ywpghnb+yRi5W+x4AePXQRh
 bQ/Qk6/LTBAaBRyr1WhFSj5gSQtV/rX80ZxXntt/UfkFHy+hm8lgMWBcDgtkQ4DSi0MF
 JFOI8kN/79iehKqsQt8h/I5fbs5KSn76Mt16yHKOQZ79S0ndujU/3Cf6/aUAIlh282f/
 sNkIRyA/20wemAVjGLWMDlXO3JWJK44bVj7NxEfkMnSxnENW9LsWr6d5jRbTQULHaP69 rg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n764crqxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 13:12:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J2h9vw008686;
        Thu, 19 Jan 2023 13:12:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16mw8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 13:12:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JDCRb440632690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 13:12:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 480CA20043;
        Thu, 19 Jan 2023 13:12:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA43220040;
        Thu, 19 Jan 2023 13:12:25 +0000 (GMT)
Received: from [9.109.198.153] (unknown [9.109.198.153])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 13:12:25 +0000 (GMT)
Message-ID: <b2273730-f885-7658-7ec4-12fb5bfc515b@linux.ibm.com>
Date:   Thu, 19 Jan 2023 18:42:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: arch/powerpc/kernel/head_85xx.o: warning: objtool:
 .head.text+0x1a6c: unannotated intra-function call
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <202301161955.38kK6ksW-lkp@intel.com>
From:   Sathvika Vasireddy <sv@linux.ibm.com>
In-Reply-To: <202301161955.38kK6ksW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1WuGtc__JWkc_69ppAANqBx4C9g-hUCC
X-Proofpoint-GUID: 1WuGtc__JWkc_69ppAANqBx4C9g-hUCC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 16/01/23 17:25, kernel test robot wrote:
> Hi Sathvika,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> commit: c984aef8c8326035570ff6e01d0ff9e79a5dfa76 objtool/powerpc: Add --mcount specific implementation
> date:   8 weeks ago
> config: powerpc-randconfig-c042-20230116
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c984aef8c8326035570ff6e01d0ff9e79a5dfa76
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout c984aef8c8326035570ff6e01d0ff9e79a5dfa76
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> arch/powerpc/kernel/head_85xx.o: warning: objtool: .head.text+0x1a6c: unannotated intra-function call

After annotating symbols with SYM_FUNC_START_LOCAL and SYM_FUNC_END 
macros, I don't see this warning anymore.

Below diff works for me:

diff --git a/arch/powerpc/kernel/head_85xx.S 
b/arch/powerpc/kernel/head_85xx.S
index d438ca74e96c..fdbee1093e2b 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -864,7 +864,7 @@ _GLOBAL(load_up_spe)
   * SPE unavailable trap from kernel - print a message, but let
   * the task use SPE in the kernel until it returns to user mode.
   */
-KernelSPE:
+SYM_FUNC_START_LOCAL(KernelSPE)
         lwz     r3,_MSR(r1)
         oris    r3,r3,MSR_SPE@h
         stw     r3,_MSR(r1)     /* enable use of SPE after return */
@@ -881,6 +881,7 @@ KernelSPE:
  #endif
         .align  4,0

+SYM_FUNC_END(KernelSPE)
  #endif /* CONFIG_SPE */

  /*

>>> arch/powerpc/kvm/booke.o: warning: objtool: kvmppc_fill_pt_regs+0x30: unannotated intra-function call

As an attempt to fix it, I tried expanding ANNOTATE_INTRA_FUNCTION_CALL 
macro to indicate that the branch target is valid. It then threw another 
warning (arch/powerpc/kvm/booke.o: warning: objtool: 
kvmppc_fill_pt_regs+0x38: intra_function_call not a direct call). The 
below diff just removes the warnings for me, but I'm not very sure if 
this is the best way to fix the objtool warnings seen with this 
particular file. Please let me know if there are any better ways to fix it.

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 0dce93ccaadf..b6a413824b98 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -917,7 +917,9 @@ static void kvmppc_fill_pt_regs(struct pt_regs *regs)
         asm("mr %0, 1" : "=r"(r1));
         asm("mflr %0" : "=r"(lr));
         asm("mfmsr %0" : "=r"(msr));
+       asm(".pushsection .discard.intra_function_calls; .long 999f; 
.popsection; 999:");
         asm("bl 1f; 1: mflr %0" : "=r"(ip));
+       asm("nop");

         memset(regs, 0, sizeof(*regs));
         regs->gpr[1] = r1;



Thanks,
Sathvika
