Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630EA69FE07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBVV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:56:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DC410B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677102998; x=1708638998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rQn71Kov+1F6UG/MOVqCOyoMpCVAl0wLQNa5DFp3ZBo=;
  b=TdmR34HZI4XmtjWa0LyU2HH2VOxmmM0+3GtWkqq6BlQyRkxb1zkbSyWb
   /H3/yXvZPZrOt2hVzH7dU5dzDn0x7RxITtnQ6V3ExHZmP2PY4y+8kppyX
   DOgPLh4N7CO38ThwGAPjtt70c9R7GYwd51YZnkFyCksJrKbCis+PzXmzd
   jOh3IOvNcUFYFZRPCMTuPbFQpbYSo6NSU2aXUvGQbZxwUdgHDzgbXh801
   jSTJjaB7kOGMPCoexxJyzdiLhTzmBIuqn+8QAsGjmwZtlJLI5TASBW4kA
   P660sUwLFoI/RxNSVxyXrR8+m8+sDeeQqBSGBjGSwZgXkybKq0IvtyzPC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="331715291"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="331715291"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 13:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="665503736"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="665503736"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2023 13:56:33 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUx6G-0000l3-2w;
        Wed, 22 Feb 2023 21:56:32 +0000
Date:   Thu, 23 Feb 2023 05:56:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: fs/btrfs/tree-log.c:4867:23: warning: 'start_slot' may be used
 uninitialized
Message-ID: <202302230527.yIU4JpoR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23064dfe088e0926e3fc0922f118866dc1564405
commit: 1ec49744ba83f0429c5c706708610f7821a7b6f4 btrfs: turn on -Wmaybe-uninitialized
date:   9 days ago
config: arm-randconfig-r015-20230222 (https://download.01.org/0day-ci/archive/20230223/202302230527.yIU4JpoR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ec49744ba83f0429c5c706708610f7821a7b6f4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1ec49744ba83f0429c5c706708610f7821a7b6f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302230527.yIU4JpoR-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
>> fs/btrfs/tree-log.c:4867:23: warning: 'start_slot' may be used uninitialized [-Wmaybe-uninitialized]
    4867 |                 ret = copy_items(trans, inode, dst_path, path,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4868 |                                  start_slot, ins_nr, 1, 0);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/tree-log.c:4764:13: note: 'start_slot' was declared here
    4764 |         int start_slot;
         |             ^~~~~~~~~~


vim +/start_slot +4867 fs/btrfs/tree-log.c

8407f553268a46 Filipe Manana 2014-09-05  4741  
31d11b83b96faa Filipe Manana 2018-05-09  4742  /*
31d11b83b96faa Filipe Manana 2018-05-09  4743   * Log all prealloc extents beyond the inode's i_size to make sure we do not
d99478874355d3 Filipe Manana 2022-02-17  4744   * lose them after doing a full/fast fsync and replaying the log. We scan the
31d11b83b96faa Filipe Manana 2018-05-09  4745   * subvolume's root instead of iterating the inode's extent map tree because
31d11b83b96faa Filipe Manana 2018-05-09  4746   * otherwise we can log incorrect extent items based on extent map conversion.
31d11b83b96faa Filipe Manana 2018-05-09  4747   * That can happen due to the fact that extent maps are merged when they
31d11b83b96faa Filipe Manana 2018-05-09  4748   * are not in the extent map tree's list of modified extents.
31d11b83b96faa Filipe Manana 2018-05-09  4749   */
31d11b83b96faa Filipe Manana 2018-05-09  4750  static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
31d11b83b96faa Filipe Manana 2018-05-09  4751  				      struct btrfs_inode *inode,
31d11b83b96faa Filipe Manana 2018-05-09  4752  				      struct btrfs_path *path)
31d11b83b96faa Filipe Manana 2018-05-09  4753  {
31d11b83b96faa Filipe Manana 2018-05-09  4754  	struct btrfs_root *root = inode->root;
31d11b83b96faa Filipe Manana 2018-05-09  4755  	struct btrfs_key key;
31d11b83b96faa Filipe Manana 2018-05-09  4756  	const u64 i_size = i_size_read(&inode->vfs_inode);
31d11b83b96faa Filipe Manana 2018-05-09  4757  	const u64 ino = btrfs_ino(inode);
31d11b83b96faa Filipe Manana 2018-05-09  4758  	struct btrfs_path *dst_path = NULL;
0e56315ca147b3 Filipe Manana 2019-11-19  4759  	bool dropped_extents = false;
f135cea30de5f7 Filipe Manana 2020-04-23  4760  	u64 truncate_offset = i_size;
f135cea30de5f7 Filipe Manana 2020-04-23  4761  	struct extent_buffer *leaf;
f135cea30de5f7 Filipe Manana 2020-04-23  4762  	int slot;
31d11b83b96faa Filipe Manana 2018-05-09  4763  	int ins_nr = 0;
31d11b83b96faa Filipe Manana 2018-05-09  4764  	int start_slot;
31d11b83b96faa Filipe Manana 2018-05-09  4765  	int ret;
31d11b83b96faa Filipe Manana 2018-05-09  4766  
31d11b83b96faa Filipe Manana 2018-05-09  4767  	if (!(inode->flags & BTRFS_INODE_PREALLOC))
31d11b83b96faa Filipe Manana 2018-05-09  4768  		return 0;
31d11b83b96faa Filipe Manana 2018-05-09  4769  
31d11b83b96faa Filipe Manana 2018-05-09  4770  	key.objectid = ino;
31d11b83b96faa Filipe Manana 2018-05-09  4771  	key.type = BTRFS_EXTENT_DATA_KEY;
31d11b83b96faa Filipe Manana 2018-05-09  4772  	key.offset = i_size;
31d11b83b96faa Filipe Manana 2018-05-09  4773  	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
31d11b83b96faa Filipe Manana 2018-05-09  4774  	if (ret < 0)
31d11b83b96faa Filipe Manana 2018-05-09  4775  		goto out;
31d11b83b96faa Filipe Manana 2018-05-09  4776  
f135cea30de5f7 Filipe Manana 2020-04-23  4777  	/*
f135cea30de5f7 Filipe Manana 2020-04-23  4778  	 * We must check if there is a prealloc extent that starts before the
f135cea30de5f7 Filipe Manana 2020-04-23  4779  	 * i_size and crosses the i_size boundary. This is to ensure later we
f135cea30de5f7 Filipe Manana 2020-04-23  4780  	 * truncate down to the end of that extent and not to the i_size, as
f135cea30de5f7 Filipe Manana 2020-04-23  4781  	 * otherwise we end up losing part of the prealloc extent after a log
f135cea30de5f7 Filipe Manana 2020-04-23  4782  	 * replay and with an implicit hole if there is another prealloc extent
f135cea30de5f7 Filipe Manana 2020-04-23  4783  	 * that starts at an offset beyond i_size.
f135cea30de5f7 Filipe Manana 2020-04-23  4784  	 */
f135cea30de5f7 Filipe Manana 2020-04-23  4785  	ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
f135cea30de5f7 Filipe Manana 2020-04-23  4786  	if (ret < 0)
f135cea30de5f7 Filipe Manana 2020-04-23  4787  		goto out;
f135cea30de5f7 Filipe Manana 2020-04-23  4788  
f135cea30de5f7 Filipe Manana 2020-04-23  4789  	if (ret == 0) {
f135cea30de5f7 Filipe Manana 2020-04-23  4790  		struct btrfs_file_extent_item *ei;
f135cea30de5f7 Filipe Manana 2020-04-23  4791  
f135cea30de5f7 Filipe Manana 2020-04-23  4792  		leaf = path->nodes[0];
f135cea30de5f7 Filipe Manana 2020-04-23  4793  		slot = path->slots[0];
f135cea30de5f7 Filipe Manana 2020-04-23  4794  		ei = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
f135cea30de5f7 Filipe Manana 2020-04-23  4795  
f135cea30de5f7 Filipe Manana 2020-04-23  4796  		if (btrfs_file_extent_type(leaf, ei) ==
f135cea30de5f7 Filipe Manana 2020-04-23  4797  		    BTRFS_FILE_EXTENT_PREALLOC) {
f135cea30de5f7 Filipe Manana 2020-04-23  4798  			u64 extent_end;
f135cea30de5f7 Filipe Manana 2020-04-23  4799  
f135cea30de5f7 Filipe Manana 2020-04-23  4800  			btrfs_item_key_to_cpu(leaf, &key, slot);
f135cea30de5f7 Filipe Manana 2020-04-23  4801  			extent_end = key.offset +
f135cea30de5f7 Filipe Manana 2020-04-23  4802  				btrfs_file_extent_num_bytes(leaf, ei);
f135cea30de5f7 Filipe Manana 2020-04-23  4803  
f135cea30de5f7 Filipe Manana 2020-04-23  4804  			if (extent_end > i_size)
f135cea30de5f7 Filipe Manana 2020-04-23  4805  				truncate_offset = extent_end;
f135cea30de5f7 Filipe Manana 2020-04-23  4806  		}
f135cea30de5f7 Filipe Manana 2020-04-23  4807  	} else {
f135cea30de5f7 Filipe Manana 2020-04-23  4808  		ret = 0;
f135cea30de5f7 Filipe Manana 2020-04-23  4809  	}
f135cea30de5f7 Filipe Manana 2020-04-23  4810  
31d11b83b96faa Filipe Manana 2018-05-09  4811  	while (true) {
f135cea30de5f7 Filipe Manana 2020-04-23  4812  		leaf = path->nodes[0];
f135cea30de5f7 Filipe Manana 2020-04-23  4813  		slot = path->slots[0];
31d11b83b96faa Filipe Manana 2018-05-09  4814  
31d11b83b96faa Filipe Manana 2018-05-09  4815  		if (slot >= btrfs_header_nritems(leaf)) {
31d11b83b96faa Filipe Manana 2018-05-09  4816  			if (ins_nr > 0) {
31d11b83b96faa Filipe Manana 2018-05-09  4817  				ret = copy_items(trans, inode, dst_path, path,
0e56315ca147b3 Filipe Manana 2019-11-19  4818  						 start_slot, ins_nr, 1, 0);
31d11b83b96faa Filipe Manana 2018-05-09  4819  				if (ret < 0)
31d11b83b96faa Filipe Manana 2018-05-09  4820  					goto out;
31d11b83b96faa Filipe Manana 2018-05-09  4821  				ins_nr = 0;
31d11b83b96faa Filipe Manana 2018-05-09  4822  			}
31d11b83b96faa Filipe Manana 2018-05-09  4823  			ret = btrfs_next_leaf(root, path);
31d11b83b96faa Filipe Manana 2018-05-09  4824  			if (ret < 0)
31d11b83b96faa Filipe Manana 2018-05-09  4825  				goto out;
31d11b83b96faa Filipe Manana 2018-05-09  4826  			if (ret > 0) {
31d11b83b96faa Filipe Manana 2018-05-09  4827  				ret = 0;
31d11b83b96faa Filipe Manana 2018-05-09  4828  				break;
31d11b83b96faa Filipe Manana 2018-05-09  4829  			}
31d11b83b96faa Filipe Manana 2018-05-09  4830  			continue;
31d11b83b96faa Filipe Manana 2018-05-09  4831  		}
31d11b83b96faa Filipe Manana 2018-05-09  4832  
31d11b83b96faa Filipe Manana 2018-05-09  4833  		btrfs_item_key_to_cpu(leaf, &key, slot);
31d11b83b96faa Filipe Manana 2018-05-09  4834  		if (key.objectid > ino)
31d11b83b96faa Filipe Manana 2018-05-09  4835  			break;
31d11b83b96faa Filipe Manana 2018-05-09  4836  		if (WARN_ON_ONCE(key.objectid < ino) ||
31d11b83b96faa Filipe Manana 2018-05-09  4837  		    key.type < BTRFS_EXTENT_DATA_KEY ||
31d11b83b96faa Filipe Manana 2018-05-09  4838  		    key.offset < i_size) {
31d11b83b96faa Filipe Manana 2018-05-09  4839  			path->slots[0]++;
31d11b83b96faa Filipe Manana 2018-05-09  4840  			continue;
31d11b83b96faa Filipe Manana 2018-05-09  4841  		}
0e56315ca147b3 Filipe Manana 2019-11-19  4842  		if (!dropped_extents) {
31d11b83b96faa Filipe Manana 2018-05-09  4843  			/*
31d11b83b96faa Filipe Manana 2018-05-09  4844  			 * Avoid logging extent items logged in past fsync calls
31d11b83b96faa Filipe Manana 2018-05-09  4845  			 * and leading to duplicate keys in the log tree.
31d11b83b96faa Filipe Manana 2018-05-09  4846  			 */
8a2b3da191e5a1 Filipe Manana 2021-08-31  4847  			ret = truncate_inode_items(trans, root->log_root, inode,
8a2b3da191e5a1 Filipe Manana 2021-08-31  4848  						   truncate_offset,
8a2b3da191e5a1 Filipe Manana 2021-08-31  4849  						   BTRFS_EXTENT_DATA_KEY);
31d11b83b96faa Filipe Manana 2018-05-09  4850  			if (ret)
31d11b83b96faa Filipe Manana 2018-05-09  4851  				goto out;
0e56315ca147b3 Filipe Manana 2019-11-19  4852  			dropped_extents = true;
31d11b83b96faa Filipe Manana 2018-05-09  4853  		}
31d11b83b96faa Filipe Manana 2018-05-09  4854  		if (ins_nr == 0)
31d11b83b96faa Filipe Manana 2018-05-09  4855  			start_slot = slot;
31d11b83b96faa Filipe Manana 2018-05-09  4856  		ins_nr++;
31d11b83b96faa Filipe Manana 2018-05-09  4857  		path->slots[0]++;
31d11b83b96faa Filipe Manana 2018-05-09  4858  		if (!dst_path) {
31d11b83b96faa Filipe Manana 2018-05-09  4859  			dst_path = btrfs_alloc_path();
31d11b83b96faa Filipe Manana 2018-05-09  4860  			if (!dst_path) {
31d11b83b96faa Filipe Manana 2018-05-09  4861  				ret = -ENOMEM;
31d11b83b96faa Filipe Manana 2018-05-09  4862  				goto out;
31d11b83b96faa Filipe Manana 2018-05-09  4863  			}
31d11b83b96faa Filipe Manana 2018-05-09  4864  		}
31d11b83b96faa Filipe Manana 2018-05-09  4865  	}
0bc2d3c08e2b97 Filipe Manana 2020-04-21  4866  	if (ins_nr > 0)
0e56315ca147b3 Filipe Manana 2019-11-19 @4867  		ret = copy_items(trans, inode, dst_path, path,
31d11b83b96faa Filipe Manana 2018-05-09  4868  				 start_slot, ins_nr, 1, 0);
31d11b83b96faa Filipe Manana 2018-05-09  4869  out:
31d11b83b96faa Filipe Manana 2018-05-09  4870  	btrfs_release_path(path);
31d11b83b96faa Filipe Manana 2018-05-09  4871  	btrfs_free_path(dst_path);
31d11b83b96faa Filipe Manana 2018-05-09  4872  	return ret;
31d11b83b96faa Filipe Manana 2018-05-09  4873  }
31d11b83b96faa Filipe Manana 2018-05-09  4874  

:::::: The code at line 4867 was first introduced by commit
:::::: 0e56315ca147b3e60c7bf240233a301d3c7fb508 Btrfs: fix missing hole after hole punching and fsync when using NO_HOLES

:::::: TO: Filipe Manana <fdmanana@suse.com>
:::::: CC: David Sterba <dsterba@suse.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
