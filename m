Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6D46E8790
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjDTBpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDTBpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:45:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E74EF8;
        Wed, 19 Apr 2023 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681955115; x=1713491115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xVg8UEI9PmbcwUJJJHD6epV4b56xa9c9CYHoPbn/eiM=;
  b=dbsvhQ+Q0D01YVnjnvaSaihNYZvwFeYjGxQhtZtLck+YqGjSZP2+xSF+
   vUieQF1PK3qLsCelC2le+ystC9MCrwKw60HIO6Qc0X+V2r0IBu52CewmV
   d8NxwW1EZl2aJ3yNt7HBwp6q6OKmWE7lReSBq7gACbhlPhH+cMbufZUIm
   8ehz/i0YqRLquy0N2A3AKFb9dfseGAswqfssJzW8QADsLj9uW2UilGXAk
   nkKXxcuUK7o8w62FyljoxiUIwi6TUAeuDNyMULxZbV+GuA8xSVNCVTw2j
   lKxw7zKLKzzDy51iB/ghAwMPm3RlkZgiyWZe9r/z25UQWT7oWRg7g41D2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="410844284"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="410844284"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835535037"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="835535037"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2023 18:45:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppJMD-000fLw-2V;
        Thu, 20 Apr 2023 01:45:09 +0000
Date:   Thu, 20 Apr 2023 09:44:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v10 13/14] HP BIOSCFG driver  - Makefile
Message-ID: <202304200914.VfJcRutc-lkp@intel.com>
References: <20230419151321.6167-14-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419151321.6167-14-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Lopez/HP-BIOSCFG-driver-Documentation/20230419-231828
patch link:    https://lore.kernel.org/r/20230419151321.6167-14-jorge.lopez2%40hp.com
patch subject: [PATCH v10 13/14] HP BIOSCFG driver  - Makefile
config: i386-randconfig-a015-20230417 (https://download.01.org/0day-ci/archive/20230420/202304200914.VfJcRutc-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cfbebfbd4ed15793fab894715bfd74387adcf4f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jorge-Lopez/HP-BIOSCFG-driver-Documentation/20230419-231828
        git checkout cfbebfbd4ed15793fab894715bfd74387adcf4f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/hp/hp-bioscfg/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200914.VfJcRutc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:141:2: warning: variable 'id' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!buf_cp) {
           ^~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:169:18: note: uninitialized use occurs here
           clear_passwords(id);
                           ^~
   drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:141:2: note: remove the 'if' if its condition is always false
           if (!buf_cp) {
           ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:138:8: note: initialize the variable 'id' to silence this warning
           int id, ret = -EIO;
                 ^
                  = 0
   1 warning generated.
--
>> drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:76:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!start)
           ^~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:87:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:76:2: note: remove the 'if' if its condition is always false
           if (!start)
           ^~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:72:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!start)
           ^~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:87:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:72:2: note: remove the 'if' if its condition is always false
           if (!start)
           ^~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:43:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (instance < 0)
           ^~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:87:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:43:2: note: remove the 'if' if its condition is always false
           if (instance < 0)
           ^~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:30:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   3 warnings generated.


vim +141 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c

1780f5eca27fb8 Jorge Lopez 2023-04-19  132  
1780f5eca27fb8 Jorge Lopez 2023-04-19  133  static ssize_t new_password_store(struct kobject *kobj,
1780f5eca27fb8 Jorge Lopez 2023-04-19  134  				  struct kobj_attribute *attr,
1780f5eca27fb8 Jorge Lopez 2023-04-19  135  				  const char *buf, size_t count)
1780f5eca27fb8 Jorge Lopez 2023-04-19  136  {
1780f5eca27fb8 Jorge Lopez 2023-04-19  137  	char *p, *buf_cp = NULL;
1780f5eca27fb8 Jorge Lopez 2023-04-19  138  	int id, ret = -EIO;
1780f5eca27fb8 Jorge Lopez 2023-04-19  139  
1780f5eca27fb8 Jorge Lopez 2023-04-19  140  	buf_cp = kstrdup(buf, GFP_KERNEL);
1780f5eca27fb8 Jorge Lopez 2023-04-19 @141  	if (!buf_cp) {
1780f5eca27fb8 Jorge Lopez 2023-04-19  142  		ret = -ENOMEM;
1780f5eca27fb8 Jorge Lopez 2023-04-19  143  		goto exit_password;
1780f5eca27fb8 Jorge Lopez 2023-04-19  144  	}
1780f5eca27fb8 Jorge Lopez 2023-04-19  145  
1780f5eca27fb8 Jorge Lopez 2023-04-19  146  	p = memchr(buf_cp, '\n', count);
1780f5eca27fb8 Jorge Lopez 2023-04-19  147  
1780f5eca27fb8 Jorge Lopez 2023-04-19  148  	if (p != NULL)
1780f5eca27fb8 Jorge Lopez 2023-04-19  149  		*p = '\0';
1780f5eca27fb8 Jorge Lopez 2023-04-19  150  
1780f5eca27fb8 Jorge Lopez 2023-04-19  151  	id = get_password_instance_id(kobj);
1780f5eca27fb8 Jorge Lopez 2023-04-19  152  
1780f5eca27fb8 Jorge Lopez 2023-04-19  153  	if (id >= 0)
1780f5eca27fb8 Jorge Lopez 2023-04-19  154  		ret = validate_password_input(id, buf_cp);
1780f5eca27fb8 Jorge Lopez 2023-04-19  155  
1780f5eca27fb8 Jorge Lopez 2023-04-19  156  	if (!ret)
1780f5eca27fb8 Jorge Lopez 2023-04-19  157  		strscpy(bioscfg_drv.password_data[id].new_password,
1780f5eca27fb8 Jorge Lopez 2023-04-19  158  			buf_cp,
1780f5eca27fb8 Jorge Lopez 2023-04-19  159  			sizeof(bioscfg_drv.password_data[id].new_password));
1780f5eca27fb8 Jorge Lopez 2023-04-19  160  
1780f5eca27fb8 Jorge Lopez 2023-04-19  161  	if (!ret)
1780f5eca27fb8 Jorge Lopez 2023-04-19  162  		ret = hp_set_attribute(kobj->name, buf_cp);
1780f5eca27fb8 Jorge Lopez 2023-04-19  163  
1780f5eca27fb8 Jorge Lopez 2023-04-19  164  exit_password:
1780f5eca27fb8 Jorge Lopez 2023-04-19  165  	/*
1780f5eca27fb8 Jorge Lopez 2023-04-19  166  	 * Regardless of the results both new and current passwords
1780f5eca27fb8 Jorge Lopez 2023-04-19  167  	 * will be set to zero and avoid security issues
1780f5eca27fb8 Jorge Lopez 2023-04-19  168  	 */
1780f5eca27fb8 Jorge Lopez 2023-04-19  169  	clear_passwords(id);
1780f5eca27fb8 Jorge Lopez 2023-04-19  170  
1780f5eca27fb8 Jorge Lopez 2023-04-19  171  	kfree(buf_cp);
1780f5eca27fb8 Jorge Lopez 2023-04-19  172  	return ret ? ret : count;
1780f5eca27fb8 Jorge Lopez 2023-04-19  173  }
1780f5eca27fb8 Jorge Lopez 2023-04-19  174  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
