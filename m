Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E0C717511
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjEaEVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEaEVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:21:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1474123
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685506863; x=1717042863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJbhEGm99k655lvM8taUIyNjFHd4qScUk0SSAoJcvM0=;
  b=CtnzN7XHy+3hNYBlkrTNwnqtootI8VG5TMiv1hFTfwbFl7ecCwUQKn9L
   uDEXLYOI4ruvY4KY3tTvmKKgPlnJ+Ml24pK6yAXhef2Jrg4H7tNfZZmjN
   sHm/fWZKjAc6laCAbjBO0r4QOHJULDzA/8h/aEE0hs5Gx5liHhI8qbmWH
   5h/TlRL6TB8L4n63zJhCA+tHjD+PcdwE+GAgvsm6waRQAjaJIeMga7aRO
   osdTPOxPGLbrlci3WliqO5CS1PBm0dp/Ux5yQEHhPaAKgQffXROdP/LHF
   eGMV5BryTo9V9l/w6k8hxmHqMcn/tdlRI3JYnJrP8o7B/EeHlbrynebxg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383390910"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="383390910"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 21:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036870419"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036870419"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2023 21:20:59 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4DKU-00014z-1A;
        Wed, 31 May 2023 04:20:58 +0000
Date:   Wed, 31 May 2023 12:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     ~akihirosuda <akihirosuda@git.sr.ht>, linux-kernel@vger.kernel.org,
        containers@lists.linux.dev, serge@hallyn.com, brauner@kernel.org,
        paul@paul-moore.com, ebiederm@xmission.com
Cc:     oe-kbuild-all@lists.linux.dev, suda.kyoto@gmail.com,
        akihiro.suda.cz@hco.ntt.co.jp
Subject: Re: [PATCH linux 3/3] userns: add sysctl "kernel.userns_group_range"
Message-ID: <202305311221.0GtxUteW-lkp@intel.com>
References: <168547265011.24337.4306067683997517082-3@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168547265011.24337.4306067683997517082-3@git.sr.ht>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ~akihirosuda,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linux/master]

url:    https://github.com/intel-lab-lkp/linux/commits/akihirosuda/group_range-allow-GID-from-2147483648-to-4294967294/20230531-030041
base:   linux/master
patch link:    https://lore.kernel.org/r/168547265011.24337.4306067683997517082-3%40git.sr.ht
patch subject: [PATCH linux 3/3] userns: add sysctl "kernel.userns_group_range"
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20230531/202305311221.0GtxUteW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7d893a64ad74171c7ad9aa2296da7bc4214bdf37
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review akihirosuda/group_range-allow-GID-from-2147483648-to-4294967294/20230531-030041
        git checkout 7d893a64ad74171c7ad9aa2296da7bc4214bdf37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305311221.0GtxUteW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/user.c:31:38: warning: missing braces around initializer [-Wmissing-braces]
      31 | struct user_namespace init_user_ns = {
         |                                      ^
   ......
      40 |                 },
         |                 }
   ......
      50 |                 },
         |                 }
   ......
      60 |                 },
         |                 }
      61 |         },
      62 |         .ns.count = REFCOUNT_INIT(3),
         |                                     }
   ......
      65 |         .ns.inum = PROC_USER_INIT_INO,
         |                                      }
   ......
      76 |                 .range = {0, ((gid_t)~0U) - 1},
         |                           {} {               }
>> kernel/user.c:31:38: warning: missing braces around initializer [-Wmissing-braces]
      31 | struct user_namespace init_user_ns = {
         |                                      ^
   ......
      40 |                 },
         |                 }
   ......
      50 |                 },
         |                 }
   ......
      60 |                 },
         |                 }
      61 |         },
      62 |         .ns.count = REFCOUNT_INIT(3),
         |                                     }
   ......
      65 |         .ns.inum = PROC_USER_INIT_INO,
         |                                      }
   ......
      76 |                 .range = {0, ((gid_t)~0U) - 1},
         |                           {} {               }
>> kernel/user.c:31:38: warning: missing braces around initializer [-Wmissing-braces]
      31 | struct user_namespace init_user_ns = {
         |                                      ^
   ......
      40 |                 },
         |                 }
   ......
      50 |                 },
         |                 }
   ......
      60 |                 },
         |                 }
      61 |         },
      62 |         .ns.count = REFCOUNT_INIT(3),
         |                                     }
   ......
      65 |         .ns.inum = PROC_USER_INIT_INO,
         |                                      }
   ......
      76 |                 .range = {0, ((gid_t)~0U) - 1},
         |                           {} {               }


vim +31 kernel/user.c

7d893a64ad7417 Akihiro Suda      2023-05-30  26  
59607db367c57f Serge E. Hallyn   2011-03-23  27  /*
59607db367c57f Serge E. Hallyn   2011-03-23  28   * userns count is 1 for root user, 1 for init_uts_ns,
59607db367c57f Serge E. Hallyn   2011-03-23  29   * and 1 for... ?
59607db367c57f Serge E. Hallyn   2011-03-23  30   */
aee16ce73c71a2 Pavel Emelyanov   2008-02-08 @31  struct user_namespace init_user_ns = {
22d917d80e8428 Eric W. Biederman 2011-11-17  32  	.uid_map = {
22d917d80e8428 Eric W. Biederman 2011-11-17  33  		.nr_extents = 1,
aa4bf44dc851c6 Christian Brauner 2017-10-25  34  		{
22d917d80e8428 Eric W. Biederman 2011-11-17  35  			.extent[0] = {
22d917d80e8428 Eric W. Biederman 2011-11-17  36  				.first = 0,
22d917d80e8428 Eric W. Biederman 2011-11-17  37  				.lower_first = 0,
4b06a81f1daee6 Eric W. Biederman 2012-05-19  38  				.count = 4294967295U,
22d917d80e8428 Eric W. Biederman 2011-11-17  39  			},
22d917d80e8428 Eric W. Biederman 2011-11-17  40  		},
aa4bf44dc851c6 Christian Brauner 2017-10-25  41  	},
22d917d80e8428 Eric W. Biederman 2011-11-17  42  	.gid_map = {
22d917d80e8428 Eric W. Biederman 2011-11-17  43  		.nr_extents = 1,
aa4bf44dc851c6 Christian Brauner 2017-10-25  44  		{
22d917d80e8428 Eric W. Biederman 2011-11-17  45  			.extent[0] = {
22d917d80e8428 Eric W. Biederman 2011-11-17  46  				.first = 0,
22d917d80e8428 Eric W. Biederman 2011-11-17  47  				.lower_first = 0,
4b06a81f1daee6 Eric W. Biederman 2012-05-19  48  				.count = 4294967295U,
22d917d80e8428 Eric W. Biederman 2011-11-17  49  			},
22d917d80e8428 Eric W. Biederman 2011-11-17  50  		},
aa4bf44dc851c6 Christian Brauner 2017-10-25  51  	},
f76d207a66c3a5 Eric W. Biederman 2012-08-30  52  	.projid_map = {
f76d207a66c3a5 Eric W. Biederman 2012-08-30  53  		.nr_extents = 1,
aa4bf44dc851c6 Christian Brauner 2017-10-25  54  		{
f76d207a66c3a5 Eric W. Biederman 2012-08-30  55  			.extent[0] = {
f76d207a66c3a5 Eric W. Biederman 2012-08-30  56  				.first = 0,
f76d207a66c3a5 Eric W. Biederman 2012-08-30  57  				.lower_first = 0,
f76d207a66c3a5 Eric W. Biederman 2012-08-30  58  				.count = 4294967295U,
f76d207a66c3a5 Eric W. Biederman 2012-08-30  59  			},
f76d207a66c3a5 Eric W. Biederman 2012-08-30  60  		},
aa4bf44dc851c6 Christian Brauner 2017-10-25  61  	},
265cbd62e034cb Kirill Tkhai      2020-08-03  62  	.ns.count = REFCOUNT_INIT(3),
783291e6900292 Eric W. Biederman 2011-11-17  63  	.owner = GLOBAL_ROOT_UID,
783291e6900292 Eric W. Biederman 2011-11-17  64  	.group = GLOBAL_ROOT_GID,
435d5f4bb2ccba Al Viro           2014-10-31  65  	.ns.inum = PROC_USER_INIT_INO,
33c429405a2c8d Al Viro           2014-11-01  66  #ifdef CONFIG_USER_NS
33c429405a2c8d Al Viro           2014-11-01  67  	.ns.ops = &userns_operations,
33c429405a2c8d Al Viro           2014-11-01  68  #endif
9cc46516ddf497 Eric W. Biederman 2014-12-02  69  	.flags = USERNS_INIT_FLAGS,
b206f281d0ee14 David Howells     2019-06-26  70  #ifdef CONFIG_KEYS
b206f281d0ee14 David Howells     2019-06-26  71  	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
0f44e4d976f96c David Howells     2019-06-26  72  	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
f36f8c75ae2e7d David Howells     2013-09-24  73  #endif
7d893a64ad7417 Akihiro Suda      2023-05-30  74  #ifdef CONFIG_SYSCTL
7d893a64ad7417 Akihiro Suda      2023-05-30  75  	.group_range = {
7d893a64ad7417 Akihiro Suda      2023-05-30  76  		.range = {0, ((gid_t)~0U) - 1},
7d893a64ad7417 Akihiro Suda      2023-05-30  77  	},
7d893a64ad7417 Akihiro Suda      2023-05-30  78  #endif
aee16ce73c71a2 Pavel Emelyanov   2008-02-08  79  };
aee16ce73c71a2 Pavel Emelyanov   2008-02-08  80  EXPORT_SYMBOL_GPL(init_user_ns);
aee16ce73c71a2 Pavel Emelyanov   2008-02-08  81  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
