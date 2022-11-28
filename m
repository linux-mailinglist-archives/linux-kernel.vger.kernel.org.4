Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832C639E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiK1Alw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK1Alt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:41:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1932BCB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 16:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669596109; x=1701132109;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JjEejyMn2VBqUpS7vNcqB4ZqV8pqnM1g+5BHkB5Xwks=;
  b=Mm0y9GccQInslmdQQ4MrY0Cd+sBLN8N9/NF7/kF+QBb2S9mz5HJw0b1H
   kdjWAXDbvA72V1jQgHNvXag0+0q97eeoxwzLKWVar6kumC+AaLWQYPXl6
   k6/OY2CRGY1Af6IKny8wbkE+Wh5cdaK8nttPtthqavzqGmpGUh5GfyxbK
   CK9W2WplumDyjf0cJ9PaRMvaSBeCem1sOwzie8Qz+y8xexChXGxKEAhKR
   yRXPziwwq/2L6kkhiYND3Rv9Sv/ib1TtucxljQuf/RtWd9RGyOKYIoOvS
   vcMGDb4RSw/jmhnzuTnxW/R0TMqqGpj1QyKN9wz+gmmbkMoREVxjGeba9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313418081"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="313418081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 16:41:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="645298357"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="645298357"
Received: from wanmeng-mobl.ccr.corp.intel.com (HELO [10.254.209.116]) ([10.254.209.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 16:41:47 -0800
Subject: Re: [sj:damon/next 27/30] mm/damon/sysfs-schemes.c:1409:26: error:
 invalid use of undefined type 'struct mem_cgroup'
To:     SeongJae Park <sj@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
References: <20221127185239.82898-1-sj@kernel.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ac866014-d4fa-9efc-eb5e-cca1a599fdfa@intel.com>
Date:   Mon, 28 Nov 2022 08:41:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221127185239.82898-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2022 2:52 AM, SeongJae Park wrote:
> Hi Robot,
> 
> 
> Thank you always for the report!
> 
> On Sat, 26 Nov 2022 18:26:31 +0800 kernel test robot <lkp@intel.com> wrote:
> 
>> [-- Attachment #1: Type: text/plain, Size: 1887 bytes --]
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
>> head:   61742c95d33e74cf64b7d5b8e51f12adef425b3e
>> commit: d768680bbe8153f2b79382bd2cd5d6734b6f5c42 [27/30] mm/damon/sysfs-schemes: implement scheme filters
>> config: xtensa-randconfig-r014-20221124
>> compiler: xtensa-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?id=d768680bbe8153f2b79382bd2cd5d6734b6f5c42
>>          git remote add sj https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
>>          git fetch --no-tags sj damon/next
>>          git checkout d768680bbe8153f2b79382bd2cd5d6734b6f5c42
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash mm/damon/
> 
> I couldn't reproduce this issue as the last command above gives me below error.
> 
>      $ COMPILER_INSTALL_PATH=$HOME/0day make.cross W=1 O=../build_test ARCH=xtensa SHELL=/bin/bash mm/damon/
>      Compiler will be installed in /home/xxxx/0day
>      Please update: libc6

Hi SeongJae,

It may be due to the old version of libc6 in your environment,
could you update it?

Best Regards,
Rong Chen


>      ldd /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc
>      /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc)
>      /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc)
>      setup_crosstool failed
> 
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     mm/damon/sysfs-schemes.c: In function 'damon_sysfs_memcg_path_eq':
>>>> mm/damon/sysfs-schemes.c:1409:26: error: invalid use of undefined type 'struct mem_cgroup'
>>      1409 |         cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
>>           |                          ^~
> 
> Nevertheless, seems the issue was due to missed inclusion of memcontrol.h,
> which defines the 'struct mem_cgroup'.  Fixed and pushed[1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=7eaaa606788b0766ece3c105fdcf963aba8511ef
> 
> 
> Thanks,
> SJ
> 
> [...]
> 
