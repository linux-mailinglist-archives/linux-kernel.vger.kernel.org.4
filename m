Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEB5B59A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiILLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiILLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:51:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65343CBFA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662983460; x=1694519460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jijzTv1Vnv9CPrkmrbijgdU0fNmPsr412xiNyLGgTeY=;
  b=lSmXiE6SS0CxwvMoe5AIZ91Hwq1TKbUo3jK8RwyiTJybs6smEr+D1xZq
   CeczfmLGONGBCHogXOh+kjQpojMKzceS70upKtwfyzEbqEU/HUg/+12Nt
   BY6pJ1vOhb46TiNbnpLtKzWugc/qAtzKDOTYNlznUAnVSHgfjput/XE4k
   Db78iQHoOiTjBhA2p6xxmQ9awSWQJ/rvolrdBlu55vEBZSyEtxssuEdFv
   j3JXJpc3vvcfpi8mMaiCpyciVqZyEItTDuTmDszxzggtPK16GsgaskJ3c
   PhY5qh9tW5hpSEEZ00nsisPAXu/HHvLR4H81RE9hCNxCzUhEN1jDh+q77
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="278236788"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="278236788"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="593461923"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2022 04:50:43 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXhxa-0002UJ-36;
        Mon, 12 Sep 2022 11:50:42 +0000
Date:   Mon, 12 Sep 2022 19:49:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Archie Pusaka <apusaka@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shyh-In Hwang <josephsih@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 9741/9999]
 net/bluetooth/af_bluetooth.c:551: Error: unrecognized opcode `csrc
 sstatus,a5'
Message-ID: <202209121904.dOfF1woq-lkp@intel.com>
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

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 9b30b4dd29c7f6b53f53076d7339e112c308f05e [9741/9999] CHROMIUM: bluetooth: enable turn on/off debug logs at runtime
config: riscv-buildonly-randconfig-r003-20220911 (https://download.01.org/0day-ci/archive/20220912/202209121904.dOfF1woq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/9b30b4dd29c7f6b53f53076d7339e112c308f05e
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 9b30b4dd29c7f6b53f53076d7339e112c308f05e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash M=net/bluetooth

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/bluetooth/af_bluetooth.c: Assembler messages:
   net/bluetooth/af_bluetooth.c:540: Error: unrecognized opcode `csrs sstatus,a5'
>> net/bluetooth/af_bluetooth.c:551: Error: unrecognized opcode `csrc sstatus,a5'
   net/bluetooth/af_bluetooth.c:551: Error: unrecognized opcode `csrs sstatus,a5'


vim +551 net/bluetooth/af_bluetooth.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  522  
3241ad820dbb17 Marcel Holtmann 2008-07-14  523  int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
3241ad820dbb17 Marcel Holtmann 2008-07-14  524  {
3241ad820dbb17 Marcel Holtmann 2008-07-14  525  	struct sock *sk = sock->sk;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  526  	struct sk_buff *skb;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  527  	long amount;
3241ad820dbb17 Marcel Holtmann 2008-07-14  528  	int err;
3241ad820dbb17 Marcel Holtmann 2008-07-14  529  
3241ad820dbb17 Marcel Holtmann 2008-07-14  530  	BT_DBG("sk %p cmd %x arg %lx", sk, cmd, arg);
3241ad820dbb17 Marcel Holtmann 2008-07-14  531  
3241ad820dbb17 Marcel Holtmann 2008-07-14  532  	switch (cmd) {
43cbeee9f9b263 Marcel Holtmann 2008-07-14  533  	case TIOCOUTQ:
43cbeee9f9b263 Marcel Holtmann 2008-07-14  534  		if (sk->sk_state == BT_LISTEN)
43cbeee9f9b263 Marcel Holtmann 2008-07-14  535  			return -EINVAL;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  536  
31e6d363abcd0d Eric Dumazet    2009-06-17  537  		amount = sk->sk_sndbuf - sk_wmem_alloc_get(sk);
43cbeee9f9b263 Marcel Holtmann 2008-07-14  538  		if (amount < 0)
43cbeee9f9b263 Marcel Holtmann 2008-07-14  539  			amount = 0;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  540  		err = put_user(amount, (int __user *) arg);
43cbeee9f9b263 Marcel Holtmann 2008-07-14  541  		break;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  542  
43cbeee9f9b263 Marcel Holtmann 2008-07-14  543  	case TIOCINQ:
43cbeee9f9b263 Marcel Holtmann 2008-07-14  544  		if (sk->sk_state == BT_LISTEN)
43cbeee9f9b263 Marcel Holtmann 2008-07-14  545  			return -EINVAL;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  546  
43cbeee9f9b263 Marcel Holtmann 2008-07-14  547  		lock_sock(sk);
43cbeee9f9b263 Marcel Holtmann 2008-07-14  548  		skb = skb_peek(&sk->sk_receive_queue);
43cbeee9f9b263 Marcel Holtmann 2008-07-14  549  		amount = skb ? skb->len : 0;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  550  		release_sock(sk);
43cbeee9f9b263 Marcel Holtmann 2008-07-14 @551  		err = put_user(amount, (int __user *) arg);
43cbeee9f9b263 Marcel Holtmann 2008-07-14  552  		break;
43cbeee9f9b263 Marcel Holtmann 2008-07-14  553  
3241ad820dbb17 Marcel Holtmann 2008-07-14  554  	case SIOCGSTAMP:
3241ad820dbb17 Marcel Holtmann 2008-07-14  555  		err = sock_get_timestamp(sk, (struct timeval __user *) arg);
3241ad820dbb17 Marcel Holtmann 2008-07-14  556  		break;
3241ad820dbb17 Marcel Holtmann 2008-07-14  557  
3241ad820dbb17 Marcel Holtmann 2008-07-14  558  	case SIOCGSTAMPNS:
3241ad820dbb17 Marcel Holtmann 2008-07-14  559  		err = sock_get_timestampns(sk, (struct timespec __user *) arg);
3241ad820dbb17 Marcel Holtmann 2008-07-14  560  		break;
3241ad820dbb17 Marcel Holtmann 2008-07-14  561  
3241ad820dbb17 Marcel Holtmann 2008-07-14  562  	default:
3241ad820dbb17 Marcel Holtmann 2008-07-14  563  		err = -ENOIOCTLCMD;
3241ad820dbb17 Marcel Holtmann 2008-07-14  564  		break;
3241ad820dbb17 Marcel Holtmann 2008-07-14  565  	}
3241ad820dbb17 Marcel Holtmann 2008-07-14  566  
3241ad820dbb17 Marcel Holtmann 2008-07-14  567  	return err;
3241ad820dbb17 Marcel Holtmann 2008-07-14  568  }
3241ad820dbb17 Marcel Holtmann 2008-07-14  569  EXPORT_SYMBOL(bt_sock_ioctl);
3241ad820dbb17 Marcel Holtmann 2008-07-14  570  

:::::: The code at line 551 was first introduced by commit
:::::: 43cbeee9f9b26300275e4e2d55ed1607f8c5f760 [Bluetooth] Add support for TIOCOUTQ and TIOCINQ ioctls

:::::: TO: Marcel Holtmann <marcel@holtmann.org>
:::::: CC: Marcel Holtmann <marcel@holtmann.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
