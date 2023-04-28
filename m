Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727FD6F0F62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbjD1APg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD1APe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:15:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC22706
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682640932; x=1714176932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/evQb/sFjxB1OZf6O2iJAPxelGlxTqHFs8emOxK2d9Y=;
  b=BFhs7/PpZGvRLi3noid0orySbkS8kCz4Tb+HPq50vqRRgHs5zeURqF5y
   na4gOqoqicrnoHvjjvJqVsW0g5UGkGFcbPeC0A2/8OCO1hq/CYIrF0vQr
   ZgT+Zmapmr9/VM1kpZ0rnOBT9MepSAB+Pojhm9zE/LHYVS7auDdVe8S/6
   +iXuJ7jTcfbUqgv/wE8SS3uK6QroxzqDg3YPS+mbkmrisyQnjUICQXoZx
   H2+rKrHI1pFOboJrW9lJk3k8LmdW3b/6KwFE6Yxf1JCVe9epo1TqRrjvG
   LpXc6KdJafh1z3mzUuYJmnzYgXoL1cXjdGc9L0WPFPDK9EktmCWoA3Jiv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412989414"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412989414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 17:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="868940767"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="868940767"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2023 17:15:30 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psBlp-0000DR-38;
        Fri, 28 Apr 2023 00:15:29 +0000
Date:   Fri, 28 Apr 2023 08:14:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: fs/btrfs/tree-log.c:6211:23: warning: 'last_range_start' may be used
 uninitialized in this function
Message-ID: <202304280811.DeQmh7Ky-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d06f5a3f7140921ada47d49574ae6fa4de5e2a89
commit: f372463124df5f980de6ee0cd6000a3e43df0e01 btrfs: mark btrfs_assertfail() __noreturn
date:   10 days ago
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20230428/202304280811.DeQmh7Ky-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f372463124df5f980de6ee0cd6000a3e43df0e01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f372463124df5f980de6ee0cd6000a3e43df0e01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280811.DeQmh7Ky-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   fs/btrfs/tree-log.c: In function 'log_delayed_deletions_incremental.isra':
>> fs/btrfs/tree-log.c:6211:23: warning: 'last_range_start' may be used uninitialized in this function [-Wmaybe-uninitialized]
    6211 |                 ret = insert_dir_log_key(trans, log, path, key.objectid,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6212 |                                          first_dir_index, last_dir_index);
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/last_range_start +6211 fs/btrfs/tree-log.c

30b80f3ce0f9d5 Filipe Manana 2022-08-22  6152  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6153  static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6154  					     struct btrfs_inode *inode,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6155  					     struct btrfs_path *path,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6156  					     const struct list_head *delayed_del_list,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6157  					     struct btrfs_log_ctx *ctx)
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6158  {
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6159  	struct btrfs_root *log = inode->root->log_root;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6160  	const struct btrfs_delayed_item *curr;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6161  	u64 last_range_start;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6162  	u64 last_range_end = 0;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6163  	struct btrfs_key key;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6164  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6165  	key.objectid = btrfs_ino(inode);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6166  	key.type = BTRFS_DIR_INDEX_KEY;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6167  	curr = list_first_entry(delayed_del_list, struct btrfs_delayed_item,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6168  				log_list);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6169  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6170  	while (!list_entry_is_head(curr, delayed_del_list, log_list)) {
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6171  		const struct btrfs_delayed_item *last = curr;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6172  		u64 first_dir_index = curr->index;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6173  		u64 last_dir_index;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6174  		bool deleted_items = false;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6175  		int ret;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6176  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6177  		key.offset = curr->index;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6178  		ret = btrfs_search_slot(trans, log, &key, path, -1, 1);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6179  		if (ret < 0) {
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6180  			return ret;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6181  		} else if (ret == 0) {
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6182  			ret = batch_delete_dir_index_items(trans, inode, path, ctx,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6183  							   delayed_del_list, curr,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6184  							   &last);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6185  			if (ret)
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6186  				return ret;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6187  			deleted_items = true;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6188  		}
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6189  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6190  		btrfs_release_path(path);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6191  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6192  		/*
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6193  		 * If we deleted items from the leaf, it means we have a range
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6194  		 * item logging their range, so no need to add one or update an
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6195  		 * existing one. Otherwise we have to log a dir range item.
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6196  		 */
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6197  		if (deleted_items)
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6198  			goto next_batch;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6199  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6200  		last_dir_index = last->index;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6201  		ASSERT(last_dir_index >= first_dir_index);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6202  		/*
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6203  		 * If this range starts right after where the previous one ends,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6204  		 * then we want to reuse the previous range item and change its
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6205  		 * end offset to the end of this range. This is just to minimize
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6206  		 * leaf space usage, by avoiding adding a new range item.
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6207  		 */
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6208  		if (last_range_end != 0 && first_dir_index == last_range_end + 1)
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6209  			first_dir_index = last_range_start;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6210  
30b80f3ce0f9d5 Filipe Manana 2022-08-22 @6211  		ret = insert_dir_log_key(trans, log, path, key.objectid,
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6212  					 first_dir_index, last_dir_index);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6213  		if (ret)
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6214  			return ret;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6215  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6216  		last_range_start = first_dir_index;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6217  		last_range_end = last_dir_index;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6218  next_batch:
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6219  		curr = list_next_entry(last, log_list);
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6220  	}
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6221  
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6222  	return 0;
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6223  }
30b80f3ce0f9d5 Filipe Manana 2022-08-22  6224  

:::::: The code at line 6211 was first introduced by commit
:::::: 30b80f3ce0f9d58ab8a2094922f3d54d2fd4f92e btrfs: use delayed items when logging a directory

:::::: TO: Filipe Manana <fdmanana@suse.com>
:::::: CC: David Sterba <dsterba@suse.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
