Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF055FD33E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJMC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJMC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:28:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13F111BD9D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665628138; x=1697164138;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OKmjIi4RRpGbj9adtaLT08dZg3XMsO6R27MSFZOIOUo=;
  b=AnkInjDfuu/lAviEwaAj42cInJWyEXnNc45OtLMf7KAJ2lv7Bjjrfp7B
   GnKaXcy1+wT2O0OyLHMNJvEmyImrGP+RJSYG+8zU3P7CpyI2JDma5FWMC
   qBWdSWw6ZGqu0ynFKc7GunH5LQqFkwN4PMJR3lLTJkPCa71MF5uZFUEQe
   5US0wNfgVndWFShvgCwcXIFmOVj802Gw92/ACVMcVi62p5IBAlqnVQxEY
   4hs41mdn/VYOmCtsW4OPumGQxrLg80zND2UAyLiH+7L8Y2ZeMNPZEJge6
   fioNuKgrShtzC0UX0SYQSFZA0LPNEJ9Phw1fhzoWYkWUt/9zOhYrssWYv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="331459519"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="331459519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 19:28:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="802068187"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="802068187"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.13]) ([10.249.174.13])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 19:28:56 -0700
Subject: Re: [kbuild-all] Re: {standard input}:1440: Error: unrecognized
 opcode: `mbar'
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202210020415.2N6Vvctq-lkp@intel.com>
 <7433411d-fa67-2ddf-58d3-7d6ca04d8e0b@csgroup.eu>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0bec541e-06f4-244a-0a16-b6c88fcb1748@intel.com>
Date:   Thu, 13 Oct 2022 10:28:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7433411d-fa67-2ddf-58d3-7d6ca04d8e0b@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2022 1:57 AM, Christophe Leroy wrote:
> 
> 
> Le 01/10/2022 à 22:39, kernel test robot a écrit :
>> Hi Christophe,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   b357fd1c2afc1a3e1b73dc4574bb7ac0e3bd4193
>> commit: 2255411d1d0f0661d1e5acd5f6edf4e6652a345a powerpc/44x: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
>> date:   9 weeks ago
>> config: powerpc-randconfig-r015-20221001
>> compiler: powerpc-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>           chmod +x ~/bin/make.cross
>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2255411d1d0f0661d1e5acd5f6edf4e6652a345a
>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>           git fetch --no-tags linus master
>>           git checkout 2255411d1d0f0661d1e5acd5f6edf4e6652a345a
>>           # save the config file
>>           mkdir build_dir && cp config build_dir/.config
>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>      {standard input}: Assembler messages:
>>>> {standard input}:1440: Error: unrecognized opcode: `mbar'
>>      {standard input}:1457: Error: unrecognized opcode: `mbar'
> 
> When you select CONFIG_TOOLCHAIN_DEFAULT_CPU=y, you have to provide a
> compiler which matches your config.
> 
> Here you are building for powerpc 44x, seems like your version of GCC
> doesn't default to -mpcu=440

Hi Christophe,

Thanks for the reply, we'll disable CONFIG_TOOLCHAIN_DEFAULT_CPU for 
powerpc.

Best Regards,
Rong Chen

> 
> 
>>
>> Kconfig warnings: (for reference only)
>>      WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>>      Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>>      Selected by [y]:
>>      - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
>>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
