Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95A5E70B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiIWAfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiIWAfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:35:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1610195D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663893350; x=1695429350;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k9s9+DMJ/i/LrduLk4l7gHizU0+NduUdUkypqP+R8N4=;
  b=NBTK0pGyjXeGjHqznqTKv+KbCk6XPcVJynvT915xNkLnaNxd8u9XqNLj
   qTymMG0xRfER6sXKHpcSugRay6MlOHY83NZnuofI6eug0MepnNDe41Bx1
   ZRKPy+eNeVHIxTiIbNq57iktOPSQMkQtoHmZwPjfHEb0nz/sFEBhDQUAZ
   6iV0qVW9ONqQ2sFpwO0erSDGX0mGi7chlj9YLxWOSTG/gQ8ESRzmdSjof
   f+Scb26h6sw7T6eDkMCnT7vGxzwbWC6UXSEV111vaTMr/HuQIzbv1pCC+
   sD29oFaLj4F0ghvjWEmKSyFm903IDyzYV51+PMUsfVH6nckS087czqYer
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301350815"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301350815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="709110107"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 17:35:49 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obWfU-00057l-1R;
        Fri, 23 Sep 2022 00:35:48 +0000
Date:   Fri, 23 Sep 2022 08:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] drivers/input/serio/serio_raw.c:178:29: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202209230804.CMXykb9S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s023-20220919 (https://download.01.org/0day-ci/archive/20220923/202209230804.CMXykb9S-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2600a472582e2968633831d430c2a1366ad3e8b1
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2600a472582e2968633831d430c2a1366ad3e8b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/ drivers/input/serio/ drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/input/serio/serio_raw.c:178:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/input/serio/serio_raw.c:178:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:178:29: sparse:     got char *
>> drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const *
--
>> drivers/input/serio/serport.c:216:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/input/serio/serport.c:216:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/input/serio/serport.c:216:21: sparse:     got unsigned long *

vim +178 drivers/input/serio/serio_raw.c

^1da177e4c3f415 Linus Torvalds   2005-04-16  156  
15a564d8dbfc942 Dmitry Torokhov  2011-10-10  157  static ssize_t serio_raw_read(struct file *file, char __user *buffer,
15a564d8dbfc942 Dmitry Torokhov  2011-10-10  158  			      size_t count, loff_t *ppos)
^1da177e4c3f415 Linus Torvalds   2005-04-16  159  {
7c5bbb2eb7ad047 Dmitry Torokhov  2011-10-10  160  	struct serio_raw_client *client = file->private_data;
7c5bbb2eb7ad047 Dmitry Torokhov  2011-10-10  161  	struct serio_raw *serio_raw = client->serio_raw;
3f649ab728cda80 Kees Cook        2020-06-03  162  	char c;
7a0a27d2ce38aee Che-Liang Chiou  2012-02-01  163  	ssize_t read = 0;
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  164  	int error;
^1da177e4c3f415 Linus Torvalds   2005-04-16  165  
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  166  	for (;;) {
85f5b35da86bcd6 Dmitry Torokhov  2011-10-10  167  		if (serio_raw->dead)
^1da177e4c3f415 Linus Torvalds   2005-04-16  168  			return -ENODEV;
^1da177e4c3f415 Linus Torvalds   2005-04-16  169  
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  170  		if (serio_raw->head == serio_raw->tail &&
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  171  		    (file->f_flags & O_NONBLOCK))
^1da177e4c3f415 Linus Torvalds   2005-04-16  172  			return -EAGAIN;
^1da177e4c3f415 Linus Torvalds   2005-04-16  173  
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  174  		if (count == 0)
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  175  			break;
^1da177e4c3f415 Linus Torvalds   2005-04-16  176  
7a0a27d2ce38aee Che-Liang Chiou  2012-02-01  177  		while (read < count && serio_raw_fetch_byte(serio_raw, &c)) {
46f49b7a223ac74 Dmitry Torokhov  2012-05-02 @178  			if (put_user(c, buffer++))
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  179  				return -EFAULT;
7a0a27d2ce38aee Che-Liang Chiou  2012-02-01  180  			read++;
^1da177e4c3f415 Linus Torvalds   2005-04-16  181  		}
^1da177e4c3f415 Linus Torvalds   2005-04-16  182  
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  183  		if (read)
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  184  			break;
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  185  
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  186  		if (!(file->f_flags & O_NONBLOCK)) {
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  187  			error = wait_event_interruptible(serio_raw->wait,
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  188  					serio_raw->head != serio_raw->tail ||
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  189  					serio_raw->dead);
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  190  			if (error)
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  191  				return error;
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  192  		}
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  193  	}
486c8aba39e5f19 Dmitry Torokhov  2012-04-20  194  
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  195  	return read;
^1da177e4c3f415 Linus Torvalds   2005-04-16  196  }
^1da177e4c3f415 Linus Torvalds   2005-04-16  197  
15a564d8dbfc942 Dmitry Torokhov  2011-10-10  198  static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
15a564d8dbfc942 Dmitry Torokhov  2011-10-10  199  			       size_t count, loff_t *ppos)
^1da177e4c3f415 Linus Torvalds   2005-04-16  200  {
7c5bbb2eb7ad047 Dmitry Torokhov  2011-10-10  201  	struct serio_raw_client *client = file->private_data;
7c5bbb2eb7ad047 Dmitry Torokhov  2011-10-10  202  	struct serio_raw *serio_raw = client->serio_raw;
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  203  	int retval = 0;
^1da177e4c3f415 Linus Torvalds   2005-04-16  204  	unsigned char c;
^1da177e4c3f415 Linus Torvalds   2005-04-16  205  
c4e32e9faaaa833 Arjan van de Ven 2006-02-19  206  	retval = mutex_lock_interruptible(&serio_raw_mutex);
^1da177e4c3f415 Linus Torvalds   2005-04-16  207  	if (retval)
^1da177e4c3f415 Linus Torvalds   2005-04-16  208  		return retval;
^1da177e4c3f415 Linus Torvalds   2005-04-16  209  
85f5b35da86bcd6 Dmitry Torokhov  2011-10-10  210  	if (serio_raw->dead) {
^1da177e4c3f415 Linus Torvalds   2005-04-16  211  		retval = -ENODEV;
^1da177e4c3f415 Linus Torvalds   2005-04-16  212  		goto out;
^1da177e4c3f415 Linus Torvalds   2005-04-16  213  	}
^1da177e4c3f415 Linus Torvalds   2005-04-16  214  
^1da177e4c3f415 Linus Torvalds   2005-04-16  215  	if (count > 32)
^1da177e4c3f415 Linus Torvalds   2005-04-16  216  		count = 32;
^1da177e4c3f415 Linus Torvalds   2005-04-16  217  
^1da177e4c3f415 Linus Torvalds   2005-04-16  218  	while (count--) {
^1da177e4c3f415 Linus Torvalds   2005-04-16 @219  		if (get_user(c, buffer++)) {
^1da177e4c3f415 Linus Torvalds   2005-04-16  220  			retval = -EFAULT;
^1da177e4c3f415 Linus Torvalds   2005-04-16  221  			goto out;
^1da177e4c3f415 Linus Torvalds   2005-04-16  222  		}
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  223  
7c5bbb2eb7ad047 Dmitry Torokhov  2011-10-10  224  		if (serio_write(serio_raw->serio, c)) {
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  225  			/* Either signal error or partial write */
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  226  			if (retval == 0)
^1da177e4c3f415 Linus Torvalds   2005-04-16  227  				retval = -EIO;
^1da177e4c3f415 Linus Torvalds   2005-04-16  228  			goto out;
^1da177e4c3f415 Linus Torvalds   2005-04-16  229  		}
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  230  
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  231  		retval++;
d89c9bcb3390956 Che-Liang Chiou  2012-01-10  232  	}
^1da177e4c3f415 Linus Torvalds   2005-04-16  233  
^1da177e4c3f415 Linus Torvalds   2005-04-16  234  out:
c4e32e9faaaa833 Arjan van de Ven 2006-02-19  235  	mutex_unlock(&serio_raw_mutex);
46f49b7a223ac74 Dmitry Torokhov  2012-05-02  236  	return retval;
^1da177e4c3f415 Linus Torvalds   2005-04-16  237  }
^1da177e4c3f415 Linus Torvalds   2005-04-16  238  

:::::: The code at line 178 was first introduced by commit
:::::: 46f49b7a223ac7493e7cf619fb583d11edefc2c2 Input: serio_raw - signal EFAULT even if read/write partially succeeds

:::::: TO: Dmitry Torokhov <dmitry.torokhov@gmail.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
