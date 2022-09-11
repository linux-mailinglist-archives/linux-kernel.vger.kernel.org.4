Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830BC5B51A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIKWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIKWwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:52:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D691FCC2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662936735; x=1694472735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uh6h+f5XxlUrid+mW5lRb+0HK1TmXzjsJDHaZGGayRA=;
  b=nov1mQ6E4Hcu+grL9uS2yMnotpdKYdRDzRmZxGEKzWRoM0RYboLhk9+y
   cUqD4TyM8HoG0ltDlPKezHOfWUfASsBtzcEs+ZcyNTMm3SetleQawXT+d
   vkUsXuiU7P5lUsaFK6Ym4ZxOCkR33cIqUUWNQ++an2011AXJL1W++XORO
   uZEN1nTUcoLQPoC7YzVc9mBpgHhRdE+5vIfjPaIQz45w7cELwWqXeeUSx
   YVORgKc3qQjdionXwPq/x7CPMBpqCxO4HDrn5G8zd7SgfUT0E5XS/XLKq
   ymZl9m9TKO7yCFrWIf/DWHymiAO6QhbK2lAkCcchob99piOs1+gcahsXy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299096906"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299096906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 15:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="649060190"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Sep 2022 15:52:12 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXVoC-0001vZ-0S;
        Sun, 11 Sep 2022 22:52:12 +0000
Date:   Mon, 12 Sep 2022 06:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [linux-stable-rc:linux-5.10.y 5204/8352]
 fs/ocfs2/cluster/heartbeat.o: warning: objtool: o2hb_setup_one_bio() falls
 through to next function o2hb_wait_on_io()
Message-ID: <202209120657.feDONzxI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   281e81a5e2b211e2ecdca7362330acf9b238a1a6
commit: 58823a9b097cf36dd59c4d463396e15a5ec4efb7 [5204/8352] ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
config: x86_64-randconfig-a012-20220912 (https://download.01.org/0day-ci/archive/20220912/202209120657.feDONzxI-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=58823a9b097cf36dd59c4d463396e15a5ec4efb7
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 58823a9b097cf36dd59c4d463396e15a5ec4efb7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ocfs2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ocfs2/cluster/heartbeat.o: warning: objtool: o2hb_setup_one_bio() falls through to next function o2hb_wait_on_io()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
