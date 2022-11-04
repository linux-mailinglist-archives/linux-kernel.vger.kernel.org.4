Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF3619221
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKDHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKDHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:41:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C306286E4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667547687; x=1699083687;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c2OxO09QFqWM1TMKaaAGzznponwwtMj7CpJAzFzsD3Y=;
  b=j+SS8Ie2NBiWb+GmKuElTKYVOtyW8fL5h5KnklmQkChVfPQBT4dq70T2
   SVpyhA2IYJHF4EM9gJtEF8n5Gf1NQW9aokTWImbbIRgB7nXzz5KGtjhs7
   5MZnPQqg1mOby+oBQuTS+Qm+tLXVQiW9c/fyO5WuHqbkdfsy6fO3rEqym
   bidexwsQT8VMYkqGRXWBpecYDXQmcIXzyR0pfPcGAnGkaKNqs/P0r1DP6
   0hZ2aSsVzBeYM8NHvgGhFH70GjfItU115VzaEXnlDRaBTb5+12J/FA6bA
   W3eOGsr1efnh8+qvDlK8P64nsVZzAY1SM2ibfkVndD/H9mdV9AWnQpFcW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311642914"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="311642914"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:41:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964254106"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="964254106"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.215.240]) ([10.254.215.240])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:41:10 -0700
Subject: Re: drivers/dma/ppc4xx/adma.c:686:38: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>
Cc:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202211020635.n40AUN0G-lkp@intel.com>
 <30cc8356-bbd3-9c12-83c6-952b19e7115e@csgroup.eu>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <7b26c087-92e8-542f-1a47-fabdf3f92575@intel.com>
Date:   Fri, 4 Nov 2022 15:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <30cc8356-bbd3-9c12-83c6-952b19e7115e@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 10:06 PM, Christophe Leroy wrote:
> 
> 
> Le 01/11/2022 à 23:13, kernel test robot a écrit :
>> Hi Christophe,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   54917c90c2cfc6cf3be6deb143cf3967b6dd8d3b
>> commit: 2255411d1d0f0661d1e5acd5f6edf4e6652a345a powerpc/44x: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
> 
> I really can't see the link between that commit and the reported new
> sparse errors.

Hi Christophe,

Sorry for the inconvience, the bot is stupid, it can't identify the fix
commit, obviously the commit here fixed the build error and exposed the
below warnings.

Best Regards,
Rong Chen

> 
> Christophe
> 
>> date:   3 months ago
>> config: powerpc-randconfig-s031-20221031
>> compiler: powerpc-linux-gcc (GCC) 12.1.0
>> reproduce:
>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>           chmod +x ~/bin/make.cross
>>           # apt-get install sparse
>>           # sparse version: v0.6.4-39-gce1a6720-dirty
>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2255411d1d0f0661d1e5acd5f6edf4e6652a345a
>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>           git fetch --no-tags linus master
>>           git checkout 2255411d1d0f0661d1e5acd5f6edf4e6652a345a
>>           # save the config file
>>           mkdir build_dir && cp config build_dir/.config
>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/ppc4xx/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> sparse warnings: (new ones prefixed by >>)
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:543:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg1l @@     got restricted __le32 [usertype] @@
>>      drivers/dma/ppc4xx/adma.c:543:35: sparse:     expected unsigned int [usertype] sg1l
>>      drivers/dma/ppc4xx/adma.c:543:35: sparse:     got restricted __le32 [usertype]
>>      drivers/dma/ppc4xx/adma.c:544:35: sparse: sparse: invalid assignment: |=
>>      drivers/dma/ppc4xx/adma.c:544:35: sparse:    left side has type unsigned int
>>      drivers/dma/ppc4xx/adma.c:544:35: sparse:    right side has type restricted __le32
>>      drivers/dma/ppc4xx/adma.c:589:23: sparse: sparse: invalid assignment: |=
>>      drivers/dma/ppc4xx/adma.c:589:23: sparse:    left side has type unsigned int
>>      drivers/dma/ppc4xx/adma.c:589:23: sparse:    right side has type restricted __le32
>>      drivers/dma/ppc4xx/adma.c:627:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
>>      drivers/dma/ppc4xx/adma.c:627:23: sparse:     expected unsigned int [usertype]
>>      drivers/dma/ppc4xx/adma.c:627:23: sparse:     got restricted __le32 [usertype]
>>      drivers/dma/ppc4xx/adma.c:628:23: sparse: sparse: invalid assignment: |=
>>      drivers/dma/ppc4xx/adma.c:628:23: sparse:    left side has type unsigned int
>>      drivers/dma/ppc4xx/adma.c:628:23: sparse:    right side has type restricted __le32
>>      drivers/dma/ppc4xx/adma.c:653:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cnt @@     got restricted __le32 [usertype] @@
>>      drivers/dma/ppc4xx/adma.c:653:34: sparse:     expected unsigned int [usertype] cnt
>>      drivers/dma/ppc4xx/adma.c:653:34: sparse:     got restricted __le32 [usertype]
>>>> drivers/dma/ppc4xx/adma.c:686:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:686:38: sparse:     expected void volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:686:38: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:687:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:687:38: sparse:     expected void volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:687:38: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:689:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:689:39: sparse:     expected void volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:689:39: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:734:17: sparse: sparse: Using plain integer as NULL pointer
>>>> drivers/dma/ppc4xx/adma.c:1185:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
>>      drivers/dma/ppc4xx/adma.c:1185:25: sparse:     expected struct dma_regs *dma_reg
>>      drivers/dma/ppc4xx/adma.c:1185:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>>>> drivers/dma/ppc4xx/adma.c:1186:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1186:34: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1186:34: sparse:     got unsigned int *
>>>> drivers/dma/ppc4xx/adma.c:1188:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
>>      drivers/dma/ppc4xx/adma.c:1188:25: sparse:     expected struct xor_regs *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1188:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>>>> drivers/dma/ppc4xx/adma.c:1189:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1189:36: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1189:36: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1136:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
>>      drivers/dma/ppc4xx/adma.c:1136:25: sparse:     expected struct xor_regs *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1136:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1145:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1145:35: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1145:35: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1155:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1155:49: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1155:49: sparse:     got unsigned int *
>>>> drivers/dma/ppc4xx/adma.c:1157:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1157:38: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1157:38: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:909:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
>>      drivers/dma/ppc4xx/adma.c:909:25: sparse:     expected struct dma_regs *dma_reg
>>      drivers/dma/ppc4xx/adma.c:909:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>>      drivers/dma/ppc4xx/adma.c:910:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:910:40: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:910:40: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:927:37: sparse: sparse: cast to restricted __le32
>>      drivers/dma/ppc4xx/adma.c:972:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:972:32: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:972:32: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:977:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:977:40: sparse:     expected void volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:977:40: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:982:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
>>      drivers/dma/ppc4xx/adma.c:982:25: sparse:     expected struct xor_regs *xor_reg
>>      drivers/dma/ppc4xx/adma.c:982:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>>      drivers/dma/ppc4xx/adma.c:983:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:983:34: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:983:34: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:984:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:984:34: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:984:34: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:991:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:991:55: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:991:55: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:993:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:993:51: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:993:51: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:997:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:997:46: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:997:46: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1006:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1006:35: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1006:35: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1025:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
>>      drivers/dma/ppc4xx/adma.c:1025:25: sparse:     expected struct dma_regs *dma_reg
>>      drivers/dma/ppc4xx/adma.c:1025:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>>>> drivers/dma/ppc4xx/adma.c:1029:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
>>      drivers/dma/ppc4xx/adma.c:1029:31: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1029:31: sparse:     got unsigned short *
>>      drivers/dma/ppc4xx/adma.c:1029:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
>>      drivers/dma/ppc4xx/adma.c:1029:60: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1029:60: sparse:     got unsigned short *
>>      drivers/dma/ppc4xx/adma.c:1030:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
>>      drivers/dma/ppc4xx/adma.c:1030:31: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1030:31: sparse:     got unsigned short *
>>      drivers/dma/ppc4xx/adma.c:1030:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
>>      drivers/dma/ppc4xx/adma.c:1030:60: sparse:     expected void const volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1030:60: sparse:     got unsigned short *
>>      drivers/dma/ppc4xx/adma.c:1036:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
>>      drivers/dma/ppc4xx/adma.c:1036:25: sparse:     expected struct xor_regs *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1036:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1037:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1037:37: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1037:37: sparse:     got unsigned int *
>>>> drivers/dma/ppc4xx/adma.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
>>      drivers/dma/ppc4xx/adma.c:1051:48: sparse:     expected struct xor_regs *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1051:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1053:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1053:25: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1053:25: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1060:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1060:41: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1060:41: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1062:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1062:39: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1062:39: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1063:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1063:25: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1063:25: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1064:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1064:33: sparse:     expected void const [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1064:33: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1065:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1065:22: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1065:22: sparse:     got unsigned int *
>>>> drivers/dma/ppc4xx/adma.c:1078:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
>>      drivers/dma/ppc4xx/adma.c:1078:48: sparse:     expected struct dma_regs *dma_reg
>>      drivers/dma/ppc4xx/adma.c:1078:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>>      drivers/dma/ppc4xx/adma.c:1088:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1088:26: sparse:     expected void volatile [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1088:26: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:1208:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
>>      drivers/dma/ppc4xx/adma.c:1208:25: sparse:     expected struct xor_regs *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1208:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>>      drivers/dma/ppc4xx/adma.c:1212:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>>      drivers/dma/ppc4xx/adma.c:1212:30: sparse:     expected void [noderef] __iomem *addr
>>      drivers/dma/ppc4xx/adma.c:1212:30: sparse:     got unsigned int *
>>      drivers/dma/ppc4xx/adma.c:2775:62: sparse: sparse: Using plain integer as NULL pointer
>>>> drivers/dma/ppc4xx/adma.c:4091:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
>>      drivers/dma/ppc4xx/adma.c:4091:14: sparse:     expected void *regs
>>      drivers/dma/ppc4xx/adma.c:4091:14: sparse:     got void [noderef] __iomem *
>>>> drivers/dma/ppc4xx/adma.c:4099:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs [noderef] __iomem *xor_reg @@     got void *regs @@
>>      drivers/dma/ppc4xx/adma.c:4099:31: sparse:     expected struct xor_regs [noderef] __iomem *xor_reg
>>      drivers/dma/ppc4xx/adma.c:4099:31: sparse:     got void *regs
>>>> drivers/dma/ppc4xx/adma.c:4106:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs [noderef] __iomem *dma_reg @@     got void *regs @@
>>      drivers/dma/ppc4xx/adma.c:4106:31: sparse:     expected struct dma_regs [noderef] __iomem *dma_reg
>>      drivers/dma/ppc4xx/adma.c:4106:31: sparse:     got void *regs
>>
>> vim +686 drivers/dma/ppc4xx/adma.c
>>
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  673
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  674  /**
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  675   * ppc440spe_desc_set_dcheck - set CHECK pattern
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  676   */
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  677  static void ppc440spe_desc_set_dcheck(struct ppc440spe_adma_desc_slot *desc,
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  678  				struct ppc440spe_adma_chan *chan, u8 *qword)
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  679  {
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  680  	struct dma_cdb *dma_hw_desc;
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  681
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  682  	switch (chan->device->id) {
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  683  	case PPC440SPE_DMA0_ID:
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  684  	case PPC440SPE_DMA1_ID:
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  685  		dma_hw_desc = desc->hw_desc;
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11 @686  		iowrite32(qword[0], &dma_hw_desc->sg3l);
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  687  		iowrite32(qword[4], &dma_hw_desc->sg3u);
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  688  		iowrite32(qword[8], &dma_hw_desc->sg2l);
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  689  		iowrite32(qword[12], &dma_hw_desc->sg2u);
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  690  		break;
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  691  	default:
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  692  		BUG();
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  693  	}
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  694  }
>> 12458ea06efd7b Anatolij Gustschin 2009-12-11  695
>>
>> :::::: The code at line 686 was first introduced by commit
>> :::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver
>>
>> :::::: TO: Anatolij Gustschin <agust@denx.de>
>> :::::: CC: Dan Williams <dan.j.williams@intel.com>
