Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594E70630E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjEQIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjEQIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:37:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4EE5D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:36:52 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H86rNR032593;
        Wed, 17 May 2023 08:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=k5ezE3oty8ShAQ0hZ/r7CNmwk8Sn0FZoFnTfrFKJtAA=;
 b=Fim/btnHSuJ6+sxpBD5e04I7Uei98jRkXcaGiq13X2A+Kv+eryDJbtGNQ+2yX5yKkgFW
 oxaszOVCj8GyoD/IT/e9blnolJ9n+LmcNxxHxJ/HJjXW0NT9NYR19sc4CvdZyEryhWIZ
 SYA9iMEoF5pnOP/SVvoSEpbsSWDR2VXlTSci6NGsjMk4HiPxSMeROQ8HyrorIBBxCydo
 qarR5g4OxbLYSZ3Bn1ZwkdU25ZtVTiKpZh8gWeg3dtiSdtncGltgSo4YJkplib/7Pesa
 2tsPfrCFDJ25TqFhpwucbIR5M3h3l0xML+pyzjXJPuY2GFIor1T+fmttMj2Y9yrie5tv 9Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmtwph7sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:36:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H3rLOO025501;
        Wed, 17 May 2023 08:36:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qj2651qcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:36:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H8aU4w39846632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 08:36:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0172A2004D;
        Wed, 17 May 2023 08:36:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2CB820040;
        Wed, 17 May 2023 08:36:26 +0000 (GMT)
Received: from [9.43.46.213] (unknown [9.43.46.213])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 08:36:26 +0000 (GMT)
Message-ID: <61cd5edb-3cce-823b-d3c5-affd1d898a9e@linux.ibm.com>
Date:   Wed, 17 May 2023 14:06:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: arch/powerpc/kexec/relocate_32.o: warning: objtool: .text+0x2bc:
 unannotated intra-function call
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <202305161316.4TNTsLUj-lkp@intel.com>
Content-Language: en-US
From:   Sathvika Vasireddy <sv@linux.ibm.com>
In-Reply-To: <202305161316.4TNTsLUj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uG9NiPj5_68t4ODaYwi588OATSrShghQ
X-Proofpoint-GUID: uG9NiPj5_68t4ODaYwi588OATSrShghQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305170070
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 5/16/23 11:19, kernel test robot wrote:
> Hi Sathvika,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> commit: c984aef8c8326035570ff6e01d0ff9e79a5dfa76 objtool/powerpc: Add --mcount specific implementation
> date:   6 months ago
> config: powerpc-randconfig-r006-20230516 (https://download.01.org/0day-ci/archive/20230516/202305161316.4TNTsLUj-lkp@intel.com/config)
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
> | Link: https://lore.kernel.org/oe-kbuild-all/202305161316.4TNTsLUj-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> arch/powerpc/kexec/relocate_32.o: warning: objtool: .text+0x2bc: unannotated intra-function call

Please find link to a patch that addresses the above reported warning: 
https://lore.kernel.org/linuxppc-dev/20221215115258.80810-1-sv@linux.ibm.com/. 
This patch still applies cleanly atop powerpc/merge branch and I don't 
see the warning anymore.

Thanks,
Sathvika
