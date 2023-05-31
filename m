Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3371725D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjEaAW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEaAWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:22:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98638C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685492572; x=1717028572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OBDVJ95AvQ/dhfa20lh1RvdAgHH3FYRxlSWMLHBpmTM=;
  b=HzNlt8v3G+Re4JuD2ClFBJrljwDUcieZWeQ5oX9PRySu0l5hYiOJ7q6x
   5wHkenAGLkoBRjo4p9V56astktaRRkektzbXy2m9ujn3odBdwNfw4DvaG
   A1nQrILIhdbEBeRzt7Jf6xffmeicJJRHpmrLU+dywXa69NAf4mcgFMl02
   brAATA/LrrUHS6jxRvnZUIekgtBb6ALzrr7eDcNYdzU1dycBIeKNCdT1x
   oNvn0B3X9KklUBcGE9eOO0kfDa6JpY+3J5EZtfTWq8VUxhFgsrLnNwNsL
   YAJnH0p+Qazh/u+m1kVorWOBmW8655kY/OLRUFxSjT4RXGUOzf5sTT8fB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334708304"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334708304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 17:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="830982324"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="830982324"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 17:22:50 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q49c1-0000vX-2i;
        Wed, 31 May 2023 00:22:49 +0000
Date:   Wed, 31 May 2023 08:21:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230530 9/9]
 fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of
 size 0
Message-ID: <202305310857.whO1DJq1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230530
head:   a2e8533878017f1874b21d78b6bf08a6c4095365
commit: a2e8533878017f1874b21d78b6bf08a6c4095365 [9/9] Makefile: Globally enable -Wstringop-overflow
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230531/202305310857.whO1DJq1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=a2e8533878017f1874b21d78b6bf08a6c4095365
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fam01-next20230530
        git checkout a2e8533878017f1874b21d78b6bf08a6c4095365
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/smb/client/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305310857.whO1DJq1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:23,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/smb/client/cifssmb.c:17:
   In function 'fortify_memcpy_chk',
       inlined from 'CIFS_open' at fs/smb/client/cifssmb.c:1249:3:
   include/linux/fortify-string.h:592:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     592 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'cifs_init_ace',
       inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
       inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
>> fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
    2987 |         cifs_ace->cifs_e_perm = local_ace->e_perm;
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
   In file included from fs/smb/client/cifssmb.c:27:
   fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
   fs/smb/client/cifspdu.h:384:14: note: at offset [7, 11] into destination object 'Protocol' of size 4
     384 |         __u8 Protocol[4];
         |              ^~~~~~~~
   In function 'cifs_init_ace',
       inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
       inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
   fs/smb/client/cifssmb.c:2988:30: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
    2988 |         cifs_ace->cifs_e_tag =  local_ace->e_tag;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
   fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
   fs/smb/client/cifspdu.h:384:14: note: at offset [6, 10] into destination object 'Protocol' of size 4
     384 |         __u8 Protocol[4];
         |              ^~~~~~~~


vim +2987 fs/smb/client/cifssmb.c

bd9684b042dcbb fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2978  
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2979  /**
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2980   * cifs_init_ace - convert ACL entry from POSIX ACL to cifs format
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2981   * @cifs_ace: the cifs ACL entry to store into
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2982   * @local_ace: the POSIX ACL entry to convert
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2983   */
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2984  static void cifs_init_ace(struct cifs_posix_ace *cifs_ace,
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2985  			  const struct posix_acl_entry *local_ace)
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2986  {
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22 @2987  	cifs_ace->cifs_e_perm = local_ace->e_perm;
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2988  	cifs_ace->cifs_e_tag =  local_ace->e_tag;
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2989  
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2990  	switch (local_ace->e_tag) {
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2991  	case ACL_USER:
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2992  		cifs_ace->cifs_uid =
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2993  			cpu_to_le64(from_kuid(&init_user_ns, local_ace->e_uid));
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2994  		break;
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2995  	case ACL_GROUP:
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2996  		cifs_ace->cifs_uid =
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2997  			cpu_to_le64(from_kgid(&init_user_ns, local_ace->e_gid));
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2998  		break;
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  2999  	default:
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  3000  		cifs_ace->cifs_uid = cpu_to_le64(-1);
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  3001  	}
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  3002  }
dc1af4c4b4721a fs/cifs/cifssmb.c Christian Brauner 2022-09-22  3003  

:::::: The code at line 2987 was first introduced by commit
:::::: dc1af4c4b4721abfa07b351063825acc7e69cc66 cifs: implement set acl method

:::::: TO: Christian Brauner <brauner@kernel.org>
:::::: CC: Christian Brauner (Microsoft) <brauner@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
