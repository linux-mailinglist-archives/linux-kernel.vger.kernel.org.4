Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3066EFC85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbjDZVbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjDZVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:31:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E54A3AB0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682544682; x=1714080682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=52MENiElqGjCKNBKCv975upmz0b8AA0oByjYCq6NpxA=;
  b=my3yz4tIXHX/s80KxiBoH/IFgLZqut8MnhKSCWjhrOP86m8PCmvwR7CH
   wlVPxe6KB9zQqg5uyVIEZ2T1PxCpT9Isia+OPvkYENaxmTcsJ9JW7+6mG
   Td7TDivIC842WfRffGfobONjtr9XbA64uUgFTA8AH+x3moDKyW37gp3uD
   KbcjNPHYjxibSm8WkiDLbxvI+oJcqOscUErgw7uzhu0qOr/lh3TPmu8dG
   kxeWeDVQqjT8nfQrxFrzqc2GBbCqn9stXR3fRxtgWFG/d35j6lhQqRVrP
   P8lYrYiZZ7GGfZ94cXoJPAuDlaCF+y7rKsS6xouZYPoRJWnw8xX8i/Uq4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="326847779"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="326847779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="818253783"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="818253783"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2023 14:30:54 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prmiz-0000XI-16;
        Wed, 26 Apr 2023 21:30:53 +0000
Date:   Thu, 27 Apr 2023 05:30:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/infiniband/hw/qedr/verbs.c:4238:33: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202304270530.KnZhrFXD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c7ecada25d2086aee607ff7deb69e77faa4aa92
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   10 months ago
config: sparc-randconfig-s052-20230426 (https://download.01.org/0day-ci/archive/20230427/202304270530.KnZhrFXD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/infiniband/hw/qedr/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304270530.KnZhrFXD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/infiniband/hw/qedr/verbs.c:127:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] sys_image_guid @@     got unsigned long long [usertype] sys_image_guid @@
   drivers/infiniband/hw/qedr/verbs.c:127:30: sparse:     expected restricted __be64 [usertype] sys_image_guid
   drivers/infiniband/hw/qedr/verbs.c:127:30: sparse:     got unsigned long long [usertype] sys_image_guid
   drivers/infiniband/hw/qedr/verbs.c:1015:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] icid @@     got unsigned short [usertype] icid @@
   drivers/infiniband/hw/qedr/verbs.c:1015:34: sparse:     expected restricted __le16 [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:1015:34: sparse:     got unsigned short [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:1400:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] icid @@     got int @@
   drivers/infiniband/hw/qedr/verbs.c:1400:42: sparse:     expected restricted __le16 [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:1400:42: sparse:     got int
   drivers/infiniband/hw/qedr/verbs.c:1410:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] icid @@     got unsigned short [usertype] icid @@
   drivers/infiniband/hw/qedr/verbs.c:1410:42: sparse:     expected restricted __le16 [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:1410:42: sparse:     got unsigned short [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:1990:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] icid @@     got unsigned short [usertype] icid @@
   drivers/infiniband/hw/qedr/verbs.c:1990:34: sparse:     expected restricted __le16 [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:1990:34: sparse:     got unsigned short [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:2001:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] icid @@     got unsigned short [usertype] icid @@
   drivers/infiniband/hw/qedr/verbs.c:2001:34: sparse:     expected restricted __le16 [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:2001:34: sparse:     got unsigned short [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:2004:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] icid @@     got unsigned short [usertype] icid @@
   drivers/infiniband/hw/qedr/verbs.c:2004:41: sparse:     expected restricted __le16 [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:2004:41: sparse:     got unsigned short [usertype] icid
   drivers/infiniband/hw/qedr/verbs.c:2005:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] value @@     got unsigned long @@
   drivers/infiniband/hw/qedr/verbs.c:2005:42: sparse:     expected restricted __le16 [usertype] value
   drivers/infiniband/hw/qedr/verbs.c:2005:42: sparse:     got unsigned long
   drivers/infiniband/hw/qedr/verbs.c:3273:22: sparse: sparse: cast from restricted __le64
   drivers/infiniband/hw/qedr/verbs.c:3273:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:3273:20: sparse:     expected unsigned long long [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3273:20: sparse:     got restricted __be64 [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3433:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:3433:24: sparse:     expected restricted __le32 [usertype] hi
   drivers/infiniband/hw/qedr/verbs.c:3433:24: sparse:     got unsigned int [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3434:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:3434:24: sparse:     expected restricted __le32 [usertype] lo
   drivers/infiniband/hw/qedr/verbs.c:3434:24: sparse:     got unsigned int [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3435:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] l_key @@     got unsigned int const [usertype] key @@
   drivers/infiniband/hw/qedr/verbs.c:3435:22: sparse:     expected restricted __le32 [usertype] l_key
   drivers/infiniband/hw/qedr/verbs.c:3435:22: sparse:     got unsigned int const [usertype] key
   drivers/infiniband/hw/qedr/verbs.c:3454:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length_lo @@     got unsigned long long [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3454:26: sparse:     expected restricted __le32 [usertype] length_lo
   drivers/infiniband/hw/qedr/verbs.c:3454:26: sparse:     got unsigned long long [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3455:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:3455:28: sparse:     expected restricted __le32 [usertype] hi
   drivers/infiniband/hw/qedr/verbs.c:3455:28: sparse:     got unsigned int [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3456:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:3456:28: sparse:     expected restricted __le32 [usertype] lo
   drivers/infiniband/hw/qedr/verbs.c:3456:28: sparse:     got unsigned int [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3584:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bytes_len @@     got restricted __le32 [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3584:54: sparse:     expected unsigned int [usertype] bytes_len
   drivers/infiniband/hw/qedr/verbs.c:3584:54: sparse:     got restricted __le32 [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3597:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bytes_len @@     got restricted __le32 [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3597:54: sparse:     expected unsigned int [usertype] bytes_len
   drivers/infiniband/hw/qedr/verbs.c:3597:54: sparse:     got restricted __le32 [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3610:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bytes_len @@     got restricted __le32 [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3610:54: sparse:     expected unsigned int [usertype] bytes_len
   drivers/infiniband/hw/qedr/verbs.c:3610:54: sparse:     got restricted __le32 [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 const [usertype] imm_data @@
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse:     expected unsigned int [usertype] val
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse:     got restricted __be32 const [usertype] imm_data
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse: sparse: cast from restricted __be32
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse: sparse: cast from restricted __be32
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse: sparse: cast from restricted __be32
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse: sparse: cast from restricted __be32
   drivers/infiniband/hw/qedr/verbs.c:3623:34: sparse: sparse: cast from restricted __le32
   drivers/infiniband/hw/qedr/verbs.c:3623:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] imm_data @@     got restricted __be32 [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:3623:32: sparse:     expected restricted __le32 [usertype] imm_data
   drivers/infiniband/hw/qedr/verbs.c:3623:32: sparse:     got restricted __be32 [usertype]
   drivers/infiniband/hw/qedr/verbs.c:3630:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bytes_len @@     got restricted __le32 [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3630:54: sparse:     expected unsigned int [usertype] bytes_len
   drivers/infiniband/hw/qedr/verbs.c:3630:54: sparse:     got restricted __le32 [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3643:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bytes_len @@     got restricted __le32 [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3643:54: sparse:     expected unsigned int [usertype] bytes_len
   drivers/infiniband/hw/qedr/verbs.c:3643:54: sparse:     got restricted __le32 [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3660:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bytes_len @@     got restricted __le32 [usertype] length @@
   drivers/infiniband/hw/qedr/verbs.c:3660:54: sparse:     expected unsigned int [usertype] bytes_len
   drivers/infiniband/hw/qedr/verbs.c:3660:54: sparse:     got restricted __le32 [usertype] length
   drivers/infiniband/hw/qedr/verbs.c:3697:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inv_l_key @@     got unsigned int const [usertype] invalidate_rkey @@
   drivers/infiniband/hw/qedr/verbs.c:3697:33: sparse:     expected restricted __le32 [usertype] inv_l_key
   drivers/infiniband/hw/qedr/verbs.c:3697:33: sparse:     got unsigned int const [usertype] invalidate_rkey
   drivers/infiniband/hw/qedr/verbs.c:3779:42: sparse: sparse: restricted __le16 degrades to integer
   drivers/infiniband/hw/qedr/verbs.c:3978:42: sparse: sparse: restricted __le16 degrades to integer
   drivers/infiniband/hw/qedr/verbs.c:4007:43: sparse: sparse: cast from restricted __le32
   drivers/infiniband/hw/qedr/verbs.c:4007:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/infiniband/hw/qedr/verbs.c:4103:68: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned short [usertype] hw_cons @@     got restricted __le16 [usertype] sq_cons @@
   drivers/infiniband/hw/qedr/verbs.c:4103:68: sparse:     expected unsigned short [usertype] hw_cons
   drivers/infiniband/hw/qedr/verbs.c:4103:68: sparse:     got restricted __le16 [usertype] sq_cons
   drivers/infiniband/hw/qedr/verbs.c:4111:68: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned short [usertype] hw_cons @@     got restricted __le16 [usertype] sq_cons @@
   drivers/infiniband/hw/qedr/verbs.c:4111:68: sparse:     expected unsigned short [usertype] hw_cons
   drivers/infiniband/hw/qedr/verbs.c:4111:68: sparse:     got restricted __le16 [usertype] sq_cons
   drivers/infiniband/hw/qedr/verbs.c:4118:38: sparse: sparse: restricted __le16 degrades to integer
   drivers/infiniband/hw/qedr/verbs.c:4191:67: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned short [usertype] hw_cons @@     got restricted __le16 [usertype] sq_cons @@
   drivers/infiniband/hw/qedr/verbs.c:4191:67: sparse:     expected unsigned short [usertype] hw_cons
   drivers/infiniband/hw/qedr/verbs.c:4191:67: sparse:     got restricted __le16 [usertype] sq_cons
   drivers/infiniband/hw/qedr/verbs.c:4376:46: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned short [usertype] hw_cons @@     got restricted __le16 [usertype] rq_cons_or_srq_id @@
   drivers/infiniband/hw/qedr/verbs.c:4376:46: sparse:     expected unsigned short [usertype] hw_cons
   drivers/infiniband/hw/qedr/verbs.c:4376:46: sparse:     got restricted __le16 [usertype] rq_cons_or_srq_id
   drivers/infiniband/hw/qedr/verbs.c:1180:45: sparse: sparse: cast to restricted __be32
   drivers/infiniband/hw/qedr/verbs.c:1181:45: sparse: sparse: cast to restricted __be32
>> drivers/infiniband/hw/qedr/verbs.c:4238:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] imm_data @@     got unsigned int [usertype] @@
   drivers/infiniband/hw/qedr/verbs.c:4238:33: sparse:     expected restricted __be32 [usertype] imm_data
   drivers/infiniband/hw/qedr/verbs.c:4238:33: sparse:     got unsigned int [usertype]

vim +4238 drivers/infiniband/hw/qedr/verbs.c

b6acd71fefc92d Amrani, Ram     2017-04-27  4220  
b6acd71fefc92d Amrani, Ram     2017-04-27  4221  static inline int qedr_set_ok_cqe_resp_wc(struct rdma_cqe_responder *resp,
b6acd71fefc92d Amrani, Ram     2017-04-27  4222  					  struct ib_wc *wc)
b6acd71fefc92d Amrani, Ram     2017-04-27  4223  {
b6acd71fefc92d Amrani, Ram     2017-04-27  4224  	wc->status = IB_WC_SUCCESS;
afa0e13be75430 Ram Amrani      2016-10-10  4225  	wc->byte_len = le32_to_cpu(resp->length);
afa0e13be75430 Ram Amrani      2016-10-10  4226  
b6acd71fefc92d Amrani, Ram     2017-04-27  4227  	if (resp->flags & QEDR_RESP_IMM) {
7bed7ebcb7c33e Jason Gunthorpe 2018-01-11  4228  		wc->ex.imm_data = cpu_to_be32(le32_to_cpu(resp->imm_data_or_inv_r_Key));
b6acd71fefc92d Amrani, Ram     2017-04-27  4229  		wc->wc_flags |= IB_WC_WITH_IMM;
afa0e13be75430 Ram Amrani      2016-10-10  4230  
b6acd71fefc92d Amrani, Ram     2017-04-27  4231  		if (resp->flags & QEDR_RESP_RDMA)
afa0e13be75430 Ram Amrani      2016-10-10  4232  			wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
afa0e13be75430 Ram Amrani      2016-10-10  4233  
b6acd71fefc92d Amrani, Ram     2017-04-27  4234  		if (resp->flags & QEDR_RESP_INV)
b6acd71fefc92d Amrani, Ram     2017-04-27  4235  			return -EINVAL;
b6acd71fefc92d Amrani, Ram     2017-04-27  4236  
b6acd71fefc92d Amrani, Ram     2017-04-27  4237  	} else if (resp->flags & QEDR_RESP_INV) {
b6acd71fefc92d Amrani, Ram     2017-04-27 @4238  		wc->ex.imm_data = le32_to_cpu(resp->imm_data_or_inv_r_Key);
b6acd71fefc92d Amrani, Ram     2017-04-27  4239  		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
b6acd71fefc92d Amrani, Ram     2017-04-27  4240  
b6acd71fefc92d Amrani, Ram     2017-04-27  4241  		if (resp->flags & QEDR_RESP_RDMA)
b6acd71fefc92d Amrani, Ram     2017-04-27  4242  			return -EINVAL;
b6acd71fefc92d Amrani, Ram     2017-04-27  4243  
b6acd71fefc92d Amrani, Ram     2017-04-27  4244  	} else if (resp->flags & QEDR_RESP_RDMA) {
b6acd71fefc92d Amrani, Ram     2017-04-27  4245  		return -EINVAL;
afa0e13be75430 Ram Amrani      2016-10-10  4246  	}
b6acd71fefc92d Amrani, Ram     2017-04-27  4247  
b6acd71fefc92d Amrani, Ram     2017-04-27  4248  	return 0;
afa0e13be75430 Ram Amrani      2016-10-10  4249  }
afa0e13be75430 Ram Amrani      2016-10-10  4250  

:::::: The code at line 4238 was first introduced by commit
:::::: b6acd71fefc92d13ac9a0f117101d1aab1102d18 RDMA/qedr: add support for send+invalidate in poll CQ

:::::: TO: Amrani, Ram <Ram.Amrani@cavium.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
