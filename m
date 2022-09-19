Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B2D5BC1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiISDHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiISDHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:07:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9441A80A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663556823; x=1695092823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c31qxJtvgoDpOS/gJgKtkSFopOmafvLrhHFZkQo7SZk=;
  b=HUoK0X+s7PGsl4rdy5w9+Z9rY8T3znH08KQVvjVwS1XminVzEmnA9187
   1UwxQXQTl6causGqlpELRbVWvvHHIv4gO96K5RT+C/mQBB8V4F2iK45w5
   jINw61eIReOeXhOcJm4t6r+jne+Sfx6Dxq3s2gV4sojiv10qQxHG27Czq
   QnTitnCsU+6Ex7vDD6djayjP9MkP0mwLNKTh0r2ttkRx7mvrVPD3yN1x+
   olETtYqxW+w322KOghXll57kUcPoXw0GHrMmAoP5ij1BRlRX3Rl8eh+cc
   A6Epq9hlOyGpe6EQECtrcwD/FHHbezLcoVmIhQTlttRuTK7s8G+BDlsXq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="286337675"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="286337675"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 20:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569476714"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 20:07:00 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa77b-0001gj-2r;
        Mon, 19 Sep 2022 03:06:59 +0000
Date:   Mon, 19 Sep 2022 11:06:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 9182/9999]
 lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1096 bytes
 is larger than 1024 bytes
Message-ID: <202209191132.J3LdusQD-lkp@intel.com>
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

Hi Jason,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   d766f744e4827dc41ef6c01403a96b7bb3938132
commit: 3dd33a09f5dc12ccb0902923c4c784eb0f8c7554 [9182/9999] crypto: blake2s - remove shash module
config: mips-randconfig-r032-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191132.J3LdusQD-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=3dd33a09f5dc12ccb0902923c4c784eb0f8c7554
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 3dd33a09f5dc12ccb0902923c4c784eb0f8c7554
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash lib/crypto/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/crypto/blake2s-selftest.c: In function 'blake2s_selftest':
>> lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     632 | }
         | ^


vim +632 lib/crypto/blake2s-selftest.c

3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  614  
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  615  		memcpy(&state1, &state, sizeof(state1));
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  616  		blake2s_compress(&state1, blocks, 1, BLAKE2S_BLOCK_SIZE);
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  617  		for (l = 1; l < TEST_ALIGNMENT; ++l) {
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  618  			memcpy(unaligned_block + l, blocks,
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  619  			       BLAKE2S_BLOCK_SIZE);
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  620  			memcpy(&state2, &state, sizeof(state2));
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  621  			blake2s_compress(&state2, unaligned_block + l, 1,
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  622  					 BLAKE2S_BLOCK_SIZE);
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  623  			if (memcmp(&state1, &state2, sizeof(state1))) {
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  624  				pr_err("blake2s random compress align %d self-test %d: FAIL\n",
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  625  				       l, i + 1);
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  626  				success = false;
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  627  			}
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  628  		}
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  629  	}
3dd33a09f5dc12 Jason A. Donenfeld 2022-05-28  630  
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08  631  	return success;
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08 @632  }

:::::: The code at line 632 was first introduced by commit
:::::: 66d7fb94e4ffe5acc589e0b2b4710aecc1f07a28 crypto: blake2s - generic C library implementation and selftest

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
