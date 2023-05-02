Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C963D6F3BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjEBCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEBCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 22:00:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC82D63
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682992823; x=1714528823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S66U377J8eUTkE4TfoP8lxH292zCxuVdJBe9o9ruRwc=;
  b=FLSs8h3bW/2WmyWqsItDtTrAVahK1WAs6zFzRkB65TYIYR6IaqAOfkHR
   +JfqyUTGifXMRi6bPiP8QPF3fLVqEUQc1zI6omzanPBg2gHX9jC/JF1J5
   M75xv5cQv5QkD868h7k0VaOm4qMXbPM2f9Y2SdGwWNajf1pKFlRnTAWxC
   bQRRZo9blrlkdmC+FhY+br9G36pUfrmSizoAaeL5FhdLrXU/6XqocuaGU
   fABWt6FSQKc4kT7eiON3UW8o8RtmcV3h/Ubv+FdyfCaM8NgO160Zl31oh
   OqiZAkE5vOud7rgwXb5DoLzZq5vmWisxX8HIAPZ4A9tcAcnUQLyclOB2e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="332634186"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="332634186"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 19:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="870380012"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="870380012"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2023 19:00:21 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptfJU-0000lW-1j;
        Tue, 02 May 2023 02:00:20 +0000
Date:   Tue, 2 May 2023 09:59:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/module/dups.c:118:6: warning: no previous prototype for
 'kmod_dup_request_exists_wait'
Message-ID: <202305020955.b724hNuQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8c655c34e33544aec9d64b660872ab33c29b5f1
commit: 8660484ed1cf3261e89e0bad94c6395597e87599 module: add debugging auto-load duplicate module support
date:   12 days ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230502/202305020955.b724hNuQ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8660484ed1cf3261e89e0bad94c6395597e87599
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8660484ed1cf3261e89e0bad94c6395597e87599
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash kernel/module/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305020955.b724hNuQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/module/dups.c:118:6: warning: no previous prototype for 'kmod_dup_request_exists_wait' [-Wmissing-prototypes]
     118 | bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/module/dups.c:220:6: warning: no previous prototype for 'kmod_dup_request_announce' [-Wmissing-prototypes]
     220 | void kmod_dup_request_announce(char *module_name, int ret)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kmod_dup_request_exists_wait +118 kernel/module/dups.c

   117	
 > 118	bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
   119	{
   120		struct kmod_dup_req *kmod_req, *new_kmod_req;
   121		int ret;
   122	
   123		/*
   124		 * Pre-allocate the entry in case we have to use it later
   125		 * to avoid contention with the mutex.
   126		 */
   127		new_kmod_req = kzalloc(sizeof(*new_kmod_req), GFP_KERNEL);
   128		if (!new_kmod_req)
   129			return false;
   130	
   131		memcpy(new_kmod_req->name, module_name, strlen(module_name));
   132		INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
   133		INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
   134		init_completion(&new_kmod_req->first_req_done);
   135	
   136		mutex_lock(&kmod_dup_mutex);
   137	
   138		kmod_req = kmod_dup_request_lookup(module_name);
   139		if (!kmod_req) {
   140			/*
   141			 * If the first request that came through for a module
   142			 * was with request_module_nowait() we cannot wait for it
   143			 * and share its return value with other users which may
   144			 * have used request_module() and need a proper return value
   145			 * so just skip using them as an anchor.
   146			 *
   147			 * If a prior request to this one came through with
   148			 * request_module() though, then a request_module_nowait()
   149			 * would benefit from duplicate detection.
   150			 */
   151			if (!wait) {
   152				kfree(new_kmod_req);
   153				pr_debug("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);
   154				mutex_unlock(&kmod_dup_mutex);
   155				return false;
   156			}
   157	
   158			/*
   159			 * There was no duplicate, just add the request so we can
   160			 * keep tab on duplicates later.
   161			 */
   162			pr_debug("New request_module() for %s\n", module_name);
   163			list_add_rcu(&new_kmod_req->list, &dup_kmod_reqs);
   164			mutex_unlock(&kmod_dup_mutex);
   165			return false;
   166		}
   167		mutex_unlock(&kmod_dup_mutex);
   168	
   169		/* We are dealing with a duplicate request now */
   170		kfree(new_kmod_req);
   171	
   172		/*
   173		 * To fix these try to use try_then_request_module() instead as that
   174		 * will check if the component you are looking for is present or not.
   175		 * You could also just queue a single request to load the module once,
   176		 * instead of having each and everything you need try to request for
   177		 * the module.
   178		 *
   179		 * Duplicate request_module() calls  can cause quite a bit of wasted
   180		 * vmalloc() space when racing with userspace.
   181		 */
   182		if (enable_dups_trace)
   183			WARN(1, "module-autoload: duplicate request for module %s\n", module_name);
   184		else
   185			pr_warn("module-autoload: duplicate request for module %s\n", module_name);
   186	
   187		if (!wait) {
   188			/*
   189			 * If request_module_nowait() was used then the user just
   190			 * wanted to issue the request and if another module request
   191			 * was already its way with the same name we don't care for
   192			 * the return value either. Let duplicate request_module_nowait()
   193			 * calls bail out right away.
   194			 */
   195			*dup_ret = 0;
   196			return true;
   197		}
   198	
   199		/*
   200		 * If a duplicate request_module() was used they *may* care for
   201		 * the return value, so we have no other option but to wait for
   202		 * the first caller to complete. If the first caller used
   203		 * the request_module_nowait() call, subsquent callers will
   204		 * deal with the comprmise of getting a successful call with this
   205		 * optimization enabled ...
   206		 */
   207		ret = wait_for_completion_state(&kmod_req->first_req_done,
   208						TASK_UNINTERRUPTIBLE | TASK_KILLABLE);
   209		if (ret) {
   210			*dup_ret = ret;
   211			return true;
   212		}
   213	
   214		/* Now the duplicate request has the same exact return value as the first request */
   215		*dup_ret = kmod_req->dup_ret;
   216	
   217		return true;
   218	}
   219	
 > 220	void kmod_dup_request_announce(char *module_name, int ret)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
