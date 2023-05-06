Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA46F910D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjEFJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEFJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:59:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C35FE5;
        Sat,  6 May 2023 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683367151; x=1714903151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4m4FKscU3TLCqCEte0uaO/HavtRa1vj8zpUntm/7uc=;
  b=T3dQaEcG2JLb/rBKnEDA0XegoHs7f95uDW2Qln+4XIyQ4ohexQjSln+c
   h8alnHF8MxNC7+LF5UEsOTIMYli95BffdQl97V36MWUuKzF+cUIdjLdb6
   9+MEWaUK4ZzhBvN7CQ7LRqSFdfMomqbdLxu2Q0qs0Wnh1WllvMQx7WHEY
   6ftDBjdqZPx1NLF4HFoH28r6IhAEosz9q86lZvk/TJWD9EMI1Ep7SEBXr
   yb55TUHbmOHqiUwwSxLQF/tmh32ABXZgDgMtL2eSrVq3Cbry5gzQv6qcL
   M8MpUmS1z7lZsIj656+fjJyYoI2aeYtPHER7Jm96Ujrke9lHWQARWT4Us
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="414916505"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="414916505"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 02:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="842105386"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="842105386"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2023 02:59:08 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvEh1-00007F-28;
        Sat, 06 May 2023 09:59:07 +0000
Date:   Sat, 6 May 2023 17:58:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     wenjun93 <gwj0511@gmail.com>, miklos@szeredi.hu
Cc:     oe-kbuild-all@lists.linux.dev, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, gwj1235@yeah.net
Subject: Re: [PATCH] overlayfs: clean error handling
Message-ID: <202305061745.OX1sfYxg-lkp@intel.com>
References: <20230506082111.1655980-1-gwj1235@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506082111.1655980-1-gwj1235@yeah.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi wenjun93,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-vfs/overlayfs-next]
[also build test WARNING on linus/master v6.3 next-20230505]
[cannot apply to mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wenjun93/overlayfs-clean-error-handling/20230506-162258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
patch link:    https://lore.kernel.org/r/20230506082111.1655980-1-gwj1235%40yeah.net
patch subject: [PATCH] overlayfs: clean error handling
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230506/202305061745.OX1sfYxg-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d5593461bec1095c3008da7403952420e637c01a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wenjun93/overlayfs-clean-error-handling/20230506-162258
        git checkout d5593461bec1095c3008da7403952420e637c01a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305061745.OX1sfYxg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/overlayfs/super.c: In function 'ovl_workdir_create':
>> fs/overlayfs/super.c:804:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     804 |                 if (d_really_is_negative(work))
         |                 ^~
   fs/overlayfs/super.c:806:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     806 |                         goto out_dput;
         |                         ^~~~
   fs/overlayfs/super.c: In function 'ovl_check_rename_whiteout':
   fs/overlayfs/super.c:1195:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1195 |         if (IS_ERR(temp))
         |         ^~
   fs/overlayfs/super.c:1197:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1197 |                 goto out_unlock;
         |                 ^~~~
   fs/overlayfs/super.c:1216:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1216 |         if (IS_ERR(whiteout))
         |         ^~
   fs/overlayfs/super.c:1218:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1218 |                 goto cleanup_temp;
         |                 ^~~~
   fs/overlayfs/super.c: In function 'ovl_make_workdir':
   fs/overlayfs/super.c:1295:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1295 |         if (IS_ERR_OR_NULL(workdir))
         |         ^~
   fs/overlayfs/super.c:1297:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1297 |                 goto out;
         |                 ^~~~
   fs/overlayfs/super.c: In function 'ovl_get_layers':
   fs/overlayfs/super.c:1610:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1610 |         if (ofs->fs == NULL)
         |         ^~
   fs/overlayfs/super.c:1612:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1612 |                 goto out;
         |                 ^~~~
   fs/overlayfs/super.c: In function 'ovl_get_lowerstack':
   fs/overlayfs/super.c:1760:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1760 |         if (!oe)
         |         ^~
   fs/overlayfs/super.c:1762:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1762 |                 goto out_err;
         |                 ^~~~
   fs/overlayfs/super.c: In function 'ovl_fill_super':
   fs/overlayfs/super.c:1904:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1904 |         if (WARN_ON(sb->s_user_ns != current_user_ns()))
         |         ^~
   fs/overlayfs/super.c:1906:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1906 |                 goto out;
         |                 ^~~~
   fs/overlayfs/super.c:1911:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1911 |         if (!ofs)
         |         ^~
   fs/overlayfs/super.c:1913:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1913 |                 goto out;
         |                 ^~~~
   fs/overlayfs/super.c:1916:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1916 |         if (!cred)
         |         ^~
   fs/overlayfs/super.c:1918:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1918 |                 goto out_err;
         |                 ^~~~
   fs/overlayfs/super.c:1940:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1940 |         if (!splitlower)
         |         ^~
   fs/overlayfs/super.c:1942:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1942 |                 goto out_err;
         |                 ^~~~
   fs/overlayfs/super.c:1953:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1953 |         if (!layers)
         |         ^~
   fs/overlayfs/super.c:1955:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1955 |                 goto out_err;
         |                 ^~~~
   fs/overlayfs/super.c:2010:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2010 |         if (IS_ERR(oe))
         |         ^~
   fs/overlayfs/super.c:2012:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2012 |                 goto out_err;
         |                 ^~~~
   fs/overlayfs/super.c:2065:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2065 |         if (!root_dentry)
         |         ^~
   fs/overlayfs/super.c:2067:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2067 |                 goto out_free_oe;
         |                 ^~~~
--
   fs/overlayfs/namei.c: In function 'ovl_verify_index':
>> fs/overlayfs/namei.c:536:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     536 |         if (index->d_name.len < sizeof(struct ovl_fb)*2)
         |         ^~
   fs/overlayfs/namei.c:538:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     538 |                 goto fail;
         |                 ^~~~
   fs/overlayfs/namei.c:542:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     542 |         if (!fh)
         |         ^~
   fs/overlayfs/namei.c:544:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     544 |                 goto fail;
         |                 ^~~~
   fs/overlayfs/namei.c:546:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     546 |         if (hex2bin(fh->buf, index->d_name.name, len))
         |         ^~
   fs/overlayfs/namei.c:548:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     548 |                 goto fail;
         |                 ^~~~
   fs/overlayfs/namei.c: In function 'ovl_lookup':
   fs/overlayfs/namei.c:910:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     910 |                 if (!stack)
         |                 ^~
   fs/overlayfs/namei.c:912:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     912 |                         goto out_put_upper;
         |                         ^~~~
   fs/overlayfs/namei.c:1071:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1071 |         if (!oe)
         |         ^~
   fs/overlayfs/namei.c:1073:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1073 |                 goto out_put;
         |                 ^~~~
   fs/overlayfs/namei.c:1118:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1118 |                 if (IS_ERR(inode))
         |                 ^~
   fs/overlayfs/namei.c:1120:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1120 |                         goto out_free_oe;
         |                         ^~~~
--
   fs/overlayfs/dir.c: In function 'ovl_cleanup_and_whiteout':
>> fs/overlayfs/dir.c:118:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     118 |         if (IS_ERR(whiteout))
         |         ^~
   fs/overlayfs/dir.c:120:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     120 |                 return err;
         |                 ^~~~~~
   fs/overlayfs/dir.c: In function 'ovl_create_real':
   fs/overlayfs/dir.c:179:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     179 |         if (newdentry->d_inode)
         |         ^~
   fs/overlayfs/dir.c:181:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     181 |                 goto out;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_create_upper':
   fs/overlayfs/dir.c:339:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     339 |         if (IS_ERR(newdentry))
         |         ^~
   fs/overlayfs/dir.c:341:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     341 |                 goto out_unlock;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_clear_empty':
   fs/overlayfs/dir.c:397:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     397 |         if (IS_ERR(opaquedir))
         |         ^~
   fs/overlayfs/dir.c:399:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     399 |                 goto out_unlock;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_create_over_whiteout':
   fs/overlayfs/dir.c:476:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     476 |         if (IS_ERR(upper))
         |         ^~
   fs/overlayfs/dir.c:478:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     478 |                 goto out_unlock;
         |                 ^~~~
   fs/overlayfs/dir.c:480:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     480 |         if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper)))
         |         ^~
   fs/overlayfs/dir.c:482:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     482 |                 goto out_dput;
         |                 ^~~~
   fs/overlayfs/dir.c:485:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     485 |         if (IS_ERR(newdentry))
         |         ^~
   fs/overlayfs/dir.c:487:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     487 |                 goto out_dput;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_create_or_link':
   fs/overlayfs/dir.c:581:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     581 |                 if (!override_cred)
         |                 ^~
   fs/overlayfs/dir.c:583:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     583 |                         goto out_revert_creds;
         |                         ^~~~
   fs/overlayfs/dir.c: In function 'ovl_create_object':
   fs/overlayfs/dir.c:636:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     636 |         if (!inode)
         |         ^~
   fs/overlayfs/dir.c:638:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     638 |                 goto out_drop_write;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_remove_and_whiteout':
   fs/overlayfs/dir.c:762:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     762 |                 if (IS_ERR(opaquedir))
         |                 ^~
   fs/overlayfs/dir.c:764:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     764 |                         goto out;
         |                         ^~~~
   fs/overlayfs/dir.c:773:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     773 |         if (IS_ERR(upper))
         |         ^~
   fs/overlayfs/dir.c:775:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     775 |                 goto out_unlock;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_remove_upper':
   fs/overlayfs/dir.c:813:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     813 |                 if (IS_ERR(opaquedir))
         |                 ^~
   fs/overlayfs/dir.c:815:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     815 |                         goto out;
         |                         ^~~~
   fs/overlayfs/dir.c:821:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     821 |         if (IS_ERR(upper))
         |         ^~
   fs/overlayfs/dir.c:823:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     823 |                 goto out_unlock;
         |                 ^~~~
   fs/overlayfs/dir.c:825:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     825 |         if ((opaquedir && upper != opaquedir) ||
         |         ^~
   fs/overlayfs/dir.c:828:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     828 |                 goto out_dput_upper;
         |                 ^~~~
   fs/overlayfs/dir.c: In function 'ovl_rename':
   fs/overlayfs/dir.c:1101:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1101 |         if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
         |         ^~
   fs/overlayfs/dir.c:1103:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1103 |                 goto out;
         |                 ^~~~
   fs/overlayfs/dir.c:1108:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1108 |         if (!ovl_can_move(old) || (!overwrite && !ovl_can_move(new)))
--
   fs/overlayfs/readdir.c: In function 'ovl_iterate':
>> fs/overlayfs/readdir.c:767:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     767 |                 if (IS_ERR(cache))
         |                 ^~
   fs/overlayfs/readdir.c:769:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     769 |                         goto out;
         |                         ^~~~
--
   fs/overlayfs/copy_up.c: In function 'ovl_create_index':
>> fs/overlayfs/copy_up.c:511:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     511 |         if (IS_ERR(temp))
         |         ^~
   fs/overlayfs/copy_up.c:513:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     513 |                 goto free_name;
         |                 ^~~~
   fs/overlayfs/copy_up.c: In function 'ovl_copy_up_workdir':
   fs/overlayfs/copy_up.c:709:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     709 |         if (lock_rename(c->workdir, c->destdir) != NULL)
         |         ^~
   fs/overlayfs/copy_up.c:711:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     711 |                 goto unlock;
         |                 ^~~~
   fs/overlayfs/copy_up.c:720:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     720 |         if (IS_ERR(temp))
         |         ^~
   fs/overlayfs/copy_up.c:722:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     722 |                 goto unlock;
         |                 ^~~~
   fs/overlayfs/copy_up.c:745:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     745 |         if (IS_ERR(upper))
         |         ^~
   fs/overlayfs/copy_up.c:747:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     747 |                 goto cleanup;
         |                 ^~~~
--
   fs/overlayfs/export.c: In function 'ovl_lookup_real_one':
>> fs/overlayfs/export.c:383:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     383 |         if (ovl_dentry_real_at(connected, layer->idx) != parent)
         |         ^~
   fs/overlayfs/export.c:385:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     385 |                 goto fail;
         |                 ^~~~
   fs/overlayfs/export.c: In function 'ovl_lower_fh_to_d':
   fs/overlayfs/export.c:719:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     719 |                 if (IS_ERR(inode))
         |                 ^~
   fs/overlayfs/export.c:721:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     721 |                         goto out_err;
         |                         ^~~~
   fs/overlayfs/export.c:744:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     744 |                 if (IS_ERR_OR_NULL(upper))
         |                 ^~
   fs/overlayfs/export.c:746:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     746 |                         goto out_err;
         |                         ^~~~
   fs/overlayfs/export.c: In function 'ovl_fh_to_dentry':
   fs/overlayfs/export.c:813:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     813 |         if (IS_ERR(fh))
         |         ^~
   fs/overlayfs/export.c:815:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     815 |                 goto out_err;
         |                 ^~~~


vim +/if +804 fs/overlayfs/super.c

e9be9d5e76e348 Miklos Szeredi    2014-10-24  761  
ad204488d3046b Miklos Szeredi    2017-11-10  762  static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
6b8aa129dcbe0e Amir Goldstein    2017-06-21  763  					 const char *name, bool persist)
e9be9d5e76e348 Miklos Szeredi    2014-10-24  764  {
ad204488d3046b Miklos Szeredi    2017-11-10  765  	struct inode *dir =  ofs->workbasedir->d_inode;
08f4c7c86d4cf1 Miklos Szeredi    2020-06-04  766  	struct vfsmount *mnt = ovl_upper_mnt(ofs);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  767  	struct dentry *work;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  768  	int err;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  769  	bool retried = false;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  770  
5955102c9984fa Al Viro           2016-01-22  771  	inode_lock_nested(dir, I_MUTEX_PARENT);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  772  retry:
22f289ce1f8b10 Christian Brauner 2022-04-04  773  	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
e9be9d5e76e348 Miklos Szeredi    2014-10-24  774  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  775  	if (!IS_ERR(work)) {
c11b9fdd6a612f Miklos Szeredi    2016-09-01  776  		struct iattr attr = {
c11b9fdd6a612f Miklos Szeredi    2016-09-01  777  			.ia_valid = ATTR_MODE,
32a3d848eb91a2 Al Viro           2016-12-04  778  			.ia_mode = S_IFDIR | 0,
c11b9fdd6a612f Miklos Szeredi    2016-09-01  779  		};
e9be9d5e76e348 Miklos Szeredi    2014-10-24  780  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  781  		if (work->d_inode) {
e9be9d5e76e348 Miklos Szeredi    2014-10-24  782  			err = -EEXIST;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  783  			if (retried)
e9be9d5e76e348 Miklos Szeredi    2014-10-24  784  				goto out_dput;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  785  
6b8aa129dcbe0e Amir Goldstein    2017-06-21  786  			if (persist)
6b8aa129dcbe0e Amir Goldstein    2017-06-21  787  				goto out_unlock;
6b8aa129dcbe0e Amir Goldstein    2017-06-21  788  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  789  			retried = true;
576bb263450bbb Christian Brauner 2022-04-04  790  			err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  791  			dput(work);
235ce9ed96bc62 Amir Goldstein    2020-08-30  792  			if (err == -EINVAL) {
235ce9ed96bc62 Amir Goldstein    2020-08-30  793  				work = ERR_PTR(err);
235ce9ed96bc62 Amir Goldstein    2020-08-30  794  				goto out_unlock;
235ce9ed96bc62 Amir Goldstein    2020-08-30  795  			}
e9be9d5e76e348 Miklos Szeredi    2014-10-24  796  			goto retry;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  797  		}
e9be9d5e76e348 Miklos Szeredi    2014-10-24  798  
576bb263450bbb Christian Brauner 2022-04-04  799  		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
1f5573cfe7a705 Miklos Szeredi    2021-11-04  800  		if (err)
1f5573cfe7a705 Miklos Szeredi    2021-11-04  801  			goto out_dput;
1f5573cfe7a705 Miklos Szeredi    2021-11-04  802  
1f5573cfe7a705 Miklos Szeredi    2021-11-04  803  		/* Weird filesystem returning with hashed negative (kernfs)? */
1f5573cfe7a705 Miklos Szeredi    2021-11-04 @804  		if (d_really_is_negative(work))
d5593461bec109 wenjun93          2023-05-06  805  			err = -EINVAL;
1f5573cfe7a705 Miklos Szeredi    2021-11-04  806  			goto out_dput;
c11b9fdd6a612f Miklos Szeredi    2016-09-01  807  
cb348edb6bef72 Miklos Szeredi    2016-10-04  808  		/*
cb348edb6bef72 Miklos Szeredi    2016-10-04  809  		 * Try to remove POSIX ACL xattrs from workdir.  We are good if:
cb348edb6bef72 Miklos Szeredi    2016-10-04  810  		 *
cb348edb6bef72 Miklos Szeredi    2016-10-04  811  		 * a) success (there was a POSIX ACL xattr and was removed)
cb348edb6bef72 Miklos Szeredi    2016-10-04  812  		 * b) -ENODATA (there was no POSIX ACL xattr)
cb348edb6bef72 Miklos Szeredi    2016-10-04  813  		 * c) -EOPNOTSUPP (POSIX ACL xattrs are not supported)
cb348edb6bef72 Miklos Szeredi    2016-10-04  814  		 *
cb348edb6bef72 Miklos Szeredi    2016-10-04  815  		 * There are various other error values that could effectively
cb348edb6bef72 Miklos Szeredi    2016-10-04  816  		 * mean that the xattr doesn't exist (e.g. -ERANGE is returned
cb348edb6bef72 Miklos Szeredi    2016-10-04  817  		 * if the xattr name is too long), but the set of filesystems
cb348edb6bef72 Miklos Szeredi    2016-10-04  818  		 * allowed as upper are limited to "normal" ones, where checking
cb348edb6bef72 Miklos Szeredi    2016-10-04  819  		 * for the above two errors is sufficient.
cb348edb6bef72 Miklos Szeredi    2016-10-04  820  		 */
31acceb97500dd Christian Brauner 2022-09-22  821  		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_DEFAULT);
e1ff3dd1ae52ce Miklos Szeredi    2016-09-05  822  		if (err && err != -ENODATA && err != -EOPNOTSUPP)
c11b9fdd6a612f Miklos Szeredi    2016-09-01  823  			goto out_dput;
c11b9fdd6a612f Miklos Szeredi    2016-09-01  824  
31acceb97500dd Christian Brauner 2022-09-22  825  		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_ACCESS);
e1ff3dd1ae52ce Miklos Szeredi    2016-09-05  826  		if (err && err != -ENODATA && err != -EOPNOTSUPP)
c11b9fdd6a612f Miklos Szeredi    2016-09-01  827  			goto out_dput;
c11b9fdd6a612f Miklos Szeredi    2016-09-01  828  
c11b9fdd6a612f Miklos Szeredi    2016-09-01  829  		/* Clear any inherited mode bits */
c11b9fdd6a612f Miklos Szeredi    2016-09-01  830  		inode_lock(work->d_inode);
a15506eac96fdb Christian Brauner 2022-04-04  831  		err = ovl_do_notify_change(ofs, work, &attr);
c11b9fdd6a612f Miklos Szeredi    2016-09-01  832  		inode_unlock(work->d_inode);
c11b9fdd6a612f Miklos Szeredi    2016-09-01  833  		if (err)
c11b9fdd6a612f Miklos Szeredi    2016-09-01  834  			goto out_dput;
6b8aa129dcbe0e Amir Goldstein    2017-06-21  835  	} else {
6b8aa129dcbe0e Amir Goldstein    2017-06-21  836  		err = PTR_ERR(work);
6b8aa129dcbe0e Amir Goldstein    2017-06-21  837  		goto out_err;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  838  	}
e9be9d5e76e348 Miklos Szeredi    2014-10-24  839  out_unlock:
6b8aa129dcbe0e Amir Goldstein    2017-06-21  840  	inode_unlock(dir);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  841  	return work;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  842  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  843  out_dput:
e9be9d5e76e348 Miklos Szeredi    2014-10-24  844  	dput(work);
6b8aa129dcbe0e Amir Goldstein    2017-06-21  845  out_err:
1bd0a3aea4357e lijiazi           2019-12-16  846  	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n",
ad204488d3046b Miklos Szeredi    2017-11-10  847  		ofs->config.workdir, name, -err);
6b8aa129dcbe0e Amir Goldstein    2017-06-21  848  	work = NULL;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  849  	goto out_unlock;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  850  }
e9be9d5e76e348 Miklos Szeredi    2014-10-24  851  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
