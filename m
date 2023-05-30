Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95574715903
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjE3ItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjE3ItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:49:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E823B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685436560; x=1716972560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w2Gv9KSj0okFHg4Bc3Si4TizPRfpp0d2/7vDiOOnbrs=;
  b=fzGQf7Y7SRCup0LSrd4V92hbZDgkVFh7NUUSaNQt8rRuzI7fnFJFe5QZ
   bibJezp94U2S9celObkb64AJobHrdjj2/b1ArjYaT/rptzQnNVkTHDc/r
   ++iTQ8pDAcPmuD1/mtgW81WkozpHFtj40AfAuwx7f9FOvPAbNJHrx714N
   82h7FSQBqcX7megdFKIxLd56zNJ35eNmikrrpUoniET91XGLIPwr3ty7/
   zMUDdJnn4Ygwi78QdRMEgz9PKCdAy1jeBsRV6q6zo+QGYjYyJ7Vf/56iy
   ZWdSvMv1LoE8iv0xw1E5btxQ/8xOSqCsgSxF6gshgrBMyTAarBkEHJ3sC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383112228"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="383112228"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771450671"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="771450671"
Received: from lkp-server01.sh.intel.com (HELO fd90924b3b99) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2023 01:49:16 -0700
Received: from kbuild by fd90924b3b99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3v2Z-0000EE-2O;
        Tue, 30 May 2023 08:49:15 +0000
Date:   Tue, 30 May 2023 16:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/infiniband/hw/qedr/verbs.c:4238:33: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202305301642.HZmZK3x5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8b817fded42d8fe3a0eb47b1149d907851a3c942
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   12 months ago
config: sparc-randconfig-s041-20230530 (https://download.01.org/0day-ci/archive/20230530/202305301642.HZmZK3x5-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/vdso/ drivers/infiniband/hw/qedr/ drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305301642.HZmZK3x5-lkp@intel.com/

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

afa0e13be75430 Ram Amrani       2016-10-10  4093  
afa0e13be75430 Ram Amrani       2016-10-10  4094  static int qedr_poll_cq_req(struct qedr_dev *dev,
afa0e13be75430 Ram Amrani       2016-10-10  4095  			    struct qedr_qp *qp, struct qedr_cq *cq,
afa0e13be75430 Ram Amrani       2016-10-10  4096  			    int num_entries, struct ib_wc *wc,
afa0e13be75430 Ram Amrani       2016-10-10  4097  			    struct rdma_cqe_requester *req)
afa0e13be75430 Ram Amrani       2016-10-10  4098  {
afa0e13be75430 Ram Amrani       2016-10-10  4099  	int cnt = 0;
afa0e13be75430 Ram Amrani       2016-10-10  4100  
afa0e13be75430 Ram Amrani       2016-10-10  4101  	switch (req->status) {
afa0e13be75430 Ram Amrani       2016-10-10  4102  	case RDMA_CQE_REQ_STS_OK:
afa0e13be75430 Ram Amrani       2016-10-10  4103  		cnt = process_req(dev, qp, cq, num_entries, wc, req->sq_cons,
afa0e13be75430 Ram Amrani       2016-10-10  4104  				  IB_WC_SUCCESS, 0);
afa0e13be75430 Ram Amrani       2016-10-10  4105  		break;
afa0e13be75430 Ram Amrani       2016-10-10  4106  	case RDMA_CQE_REQ_STS_WORK_REQUEST_FLUSHED_ERR:
c78c31496111f4 Ram Amrani       2017-01-24  4107  		if (qp->state != QED_ROCE_QP_STATE_ERR)
dc728f779a7176 Kalderon, Michal 2018-01-25  4108  			DP_DEBUG(dev, QEDR_MSG_CQ,
afa0e13be75430 Ram Amrani       2016-10-10  4109  				 "Error: POLL CQ with RDMA_CQE_REQ_STS_WORK_REQUEST_FLUSHED_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4110  				 cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4111  		cnt = process_req(dev, qp, cq, num_entries, wc, req->sq_cons,
74c3875c3d9aad Amrani, Ram      2016-12-22  4112  				  IB_WC_WR_FLUSH_ERR, 1);
afa0e13be75430 Ram Amrani       2016-10-10  4113  		break;
afa0e13be75430 Ram Amrani       2016-10-10  4114  	default:
afa0e13be75430 Ram Amrani       2016-10-10  4115  		/* process all WQE before the cosumer */
afa0e13be75430 Ram Amrani       2016-10-10  4116  		qp->state = QED_ROCE_QP_STATE_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4117  		cnt = process_req(dev, qp, cq, num_entries, wc,
afa0e13be75430 Ram Amrani       2016-10-10 @4118  				  req->sq_cons - 1, IB_WC_SUCCESS, 0);
afa0e13be75430 Ram Amrani       2016-10-10  4119  		wc += cnt;
afa0e13be75430 Ram Amrani       2016-10-10  4120  		/* if we have extra WC fill it with actual error info */
afa0e13be75430 Ram Amrani       2016-10-10  4121  		if (cnt < num_entries) {
afa0e13be75430 Ram Amrani       2016-10-10  4122  			enum ib_wc_status wc_status;
afa0e13be75430 Ram Amrani       2016-10-10  4123  
afa0e13be75430 Ram Amrani       2016-10-10  4124  			switch (req->status) {
afa0e13be75430 Ram Amrani       2016-10-10  4125  			case RDMA_CQE_REQ_STS_BAD_RESPONSE_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4126  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4127  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_BAD_RESPONSE_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4128  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4129  				wc_status = IB_WC_BAD_RESP_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4130  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4131  			case RDMA_CQE_REQ_STS_LOCAL_LENGTH_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4132  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4133  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_LOCAL_LENGTH_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4134  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4135  				wc_status = IB_WC_LOC_LEN_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4136  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4137  			case RDMA_CQE_REQ_STS_LOCAL_QP_OPERATION_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4138  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4139  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_LOCAL_QP_OPERATION_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4140  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4141  				wc_status = IB_WC_LOC_QP_OP_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4142  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4143  			case RDMA_CQE_REQ_STS_LOCAL_PROTECTION_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4144  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4145  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_LOCAL_PROTECTION_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4146  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4147  				wc_status = IB_WC_LOC_PROT_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4148  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4149  			case RDMA_CQE_REQ_STS_MEMORY_MGT_OPERATION_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4150  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4151  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_MEMORY_MGT_OPERATION_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4152  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4153  				wc_status = IB_WC_MW_BIND_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4154  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4155  			case RDMA_CQE_REQ_STS_REMOTE_INVALID_REQUEST_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4156  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4157  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_REMOTE_INVALID_REQUEST_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4158  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4159  				wc_status = IB_WC_REM_INV_REQ_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4160  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4161  			case RDMA_CQE_REQ_STS_REMOTE_ACCESS_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4162  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4163  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_REMOTE_ACCESS_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4164  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4165  				wc_status = IB_WC_REM_ACCESS_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4166  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4167  			case RDMA_CQE_REQ_STS_REMOTE_OPERATION_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4168  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4169  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_REMOTE_OPERATION_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4170  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4171  				wc_status = IB_WC_REM_OP_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4172  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4173  			case RDMA_CQE_REQ_STS_RNR_NAK_RETRY_CNT_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4174  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4175  				       "Error: POLL CQ with RDMA_CQE_REQ_STS_RNR_NAK_RETRY_CNT_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4176  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4177  				wc_status = IB_WC_RNR_RETRY_EXC_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4178  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4179  			case RDMA_CQE_REQ_STS_TRANSPORT_RETRY_CNT_ERR:
afa0e13be75430 Ram Amrani       2016-10-10  4180  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4181  				       "Error: POLL CQ with ROCE_CQE_REQ_STS_TRANSPORT_RETRY_CNT_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4182  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4183  				wc_status = IB_WC_RETRY_EXC_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4184  				break;
afa0e13be75430 Ram Amrani       2016-10-10  4185  			default:
afa0e13be75430 Ram Amrani       2016-10-10  4186  				DP_ERR(dev,
afa0e13be75430 Ram Amrani       2016-10-10  4187  				       "Error: POLL CQ with IB_WC_GENERAL_ERR. CQ icid=0x%x, QP icid=0x%x\n",
afa0e13be75430 Ram Amrani       2016-10-10  4188  				       cq->icid, qp->icid);
afa0e13be75430 Ram Amrani       2016-10-10  4189  				wc_status = IB_WC_GENERAL_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4190  			}
afa0e13be75430 Ram Amrani       2016-10-10  4191  			cnt += process_req(dev, qp, cq, 1, wc, req->sq_cons,
afa0e13be75430 Ram Amrani       2016-10-10  4192  					   wc_status, 1);
afa0e13be75430 Ram Amrani       2016-10-10  4193  		}
afa0e13be75430 Ram Amrani       2016-10-10  4194  	}
afa0e13be75430 Ram Amrani       2016-10-10  4195  
afa0e13be75430 Ram Amrani       2016-10-10  4196  	return cnt;
afa0e13be75430 Ram Amrani       2016-10-10  4197  }
afa0e13be75430 Ram Amrani       2016-10-10  4198  
b6acd71fefc92d Amrani, Ram      2017-04-27  4199  static inline int qedr_cqe_resp_status_to_ib(u8 status)
afa0e13be75430 Ram Amrani       2016-10-10  4200  {
b6acd71fefc92d Amrani, Ram      2017-04-27  4201  	switch (status) {
afa0e13be75430 Ram Amrani       2016-10-10  4202  	case RDMA_CQE_RESP_STS_LOCAL_ACCESS_ERR:
b6acd71fefc92d Amrani, Ram      2017-04-27  4203  		return IB_WC_LOC_ACCESS_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4204  	case RDMA_CQE_RESP_STS_LOCAL_LENGTH_ERR:
b6acd71fefc92d Amrani, Ram      2017-04-27  4205  		return IB_WC_LOC_LEN_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4206  	case RDMA_CQE_RESP_STS_LOCAL_QP_OPERATION_ERR:
b6acd71fefc92d Amrani, Ram      2017-04-27  4207  		return IB_WC_LOC_QP_OP_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4208  	case RDMA_CQE_RESP_STS_LOCAL_PROTECTION_ERR:
b6acd71fefc92d Amrani, Ram      2017-04-27  4209  		return IB_WC_LOC_PROT_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4210  	case RDMA_CQE_RESP_STS_MEMORY_MGT_OPERATION_ERR:
b6acd71fefc92d Amrani, Ram      2017-04-27  4211  		return IB_WC_MW_BIND_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4212  	case RDMA_CQE_RESP_STS_REMOTE_INVALID_REQUEST_ERR:
b6acd71fefc92d Amrani, Ram      2017-04-27  4213  		return IB_WC_REM_INV_RD_REQ_ERR;
afa0e13be75430 Ram Amrani       2016-10-10  4214  	case RDMA_CQE_RESP_STS_OK:
b6acd71fefc92d Amrani, Ram      2017-04-27  4215  		return IB_WC_SUCCESS;
b6acd71fefc92d Amrani, Ram      2017-04-27  4216  	default:
b6acd71fefc92d Amrani, Ram      2017-04-27  4217  		return IB_WC_GENERAL_ERR;
b6acd71fefc92d Amrani, Ram      2017-04-27  4218  	}
b6acd71fefc92d Amrani, Ram      2017-04-27  4219  }
b6acd71fefc92d Amrani, Ram      2017-04-27  4220  
b6acd71fefc92d Amrani, Ram      2017-04-27  4221  static inline int qedr_set_ok_cqe_resp_wc(struct rdma_cqe_responder *resp,
b6acd71fefc92d Amrani, Ram      2017-04-27  4222  					  struct ib_wc *wc)
b6acd71fefc92d Amrani, Ram      2017-04-27  4223  {
b6acd71fefc92d Amrani, Ram      2017-04-27  4224  	wc->status = IB_WC_SUCCESS;
afa0e13be75430 Ram Amrani       2016-10-10  4225  	wc->byte_len = le32_to_cpu(resp->length);
afa0e13be75430 Ram Amrani       2016-10-10  4226  
b6acd71fefc92d Amrani, Ram      2017-04-27  4227  	if (resp->flags & QEDR_RESP_IMM) {
7bed7ebcb7c33e Jason Gunthorpe  2018-01-11  4228  		wc->ex.imm_data = cpu_to_be32(le32_to_cpu(resp->imm_data_or_inv_r_Key));
b6acd71fefc92d Amrani, Ram      2017-04-27  4229  		wc->wc_flags |= IB_WC_WITH_IMM;
afa0e13be75430 Ram Amrani       2016-10-10  4230  
b6acd71fefc92d Amrani, Ram      2017-04-27  4231  		if (resp->flags & QEDR_RESP_RDMA)
afa0e13be75430 Ram Amrani       2016-10-10  4232  			wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
afa0e13be75430 Ram Amrani       2016-10-10  4233  
b6acd71fefc92d Amrani, Ram      2017-04-27  4234  		if (resp->flags & QEDR_RESP_INV)
b6acd71fefc92d Amrani, Ram      2017-04-27  4235  			return -EINVAL;
b6acd71fefc92d Amrani, Ram      2017-04-27  4236  
b6acd71fefc92d Amrani, Ram      2017-04-27  4237  	} else if (resp->flags & QEDR_RESP_INV) {
b6acd71fefc92d Amrani, Ram      2017-04-27 @4238  		wc->ex.imm_data = le32_to_cpu(resp->imm_data_or_inv_r_Key);
b6acd71fefc92d Amrani, Ram      2017-04-27  4239  		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
b6acd71fefc92d Amrani, Ram      2017-04-27  4240  
b6acd71fefc92d Amrani, Ram      2017-04-27  4241  		if (resp->flags & QEDR_RESP_RDMA)
b6acd71fefc92d Amrani, Ram      2017-04-27  4242  			return -EINVAL;
b6acd71fefc92d Amrani, Ram      2017-04-27  4243  
b6acd71fefc92d Amrani, Ram      2017-04-27  4244  	} else if (resp->flags & QEDR_RESP_RDMA) {
b6acd71fefc92d Amrani, Ram      2017-04-27  4245  		return -EINVAL;
afa0e13be75430 Ram Amrani       2016-10-10  4246  	}
b6acd71fefc92d Amrani, Ram      2017-04-27  4247  
b6acd71fefc92d Amrani, Ram      2017-04-27  4248  	return 0;
afa0e13be75430 Ram Amrani       2016-10-10  4249  }
afa0e13be75430 Ram Amrani       2016-10-10  4250  

:::::: The code at line 4238 was first introduced by commit
:::::: b6acd71fefc92d13ac9a0f117101d1aab1102d18 RDMA/qedr: add support for send+invalidate in poll CQ

:::::: TO: Amrani, Ram <Ram.Amrani@cavium.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
