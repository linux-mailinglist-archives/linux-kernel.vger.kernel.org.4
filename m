Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294C164D01F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiLNTf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiLNTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:35:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D292BC28
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671046549; x=1702582549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mWqY5oZMJfKjHyrRXEsgqKLFq20hWVVh1jzehH7VT1Q=;
  b=l1zPtX2+WmowRiMG/WOxcIAwgm+0U9xVdGWhvNPfSom8OvLnJuGWUxbK
   jcwripO5s72o/dIpeJ/0ZixBt0B90Ec0CPCuNCnoihWe6XCttwqeGICB8
   TTth66IFGkQ6cru6I5M9PHBzfZ8u4gSkxZLoJbPhbX/9BfwjSgQIUXJhz
   7JYe4Xg1t80jF0Vfjn7Oo/22FzTjZj7/IhjcEosY6zf0IKznnKltw2Qd2
   biy7To/8dRn8U/RhBsYZqsUyRQl1A/O3bbCqL58rjESa7kZUO9lz2diTG
   CEwta6YMukWGL66Ur18iCYlVwmOs0w77bqNQk5pYtxVVi+JPnAMqyvFKr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="382797314"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="382797314"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 11:35:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="649143566"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="649143566"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2022 11:35:24 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5XXH-0005kI-1N;
        Wed, 14 Dec 2022 19:35:23 +0000
Date:   Thu, 15 Dec 2022 03:35:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to
 restricted __le16
Message-ID: <202212150327.Oo3SGc0m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gF/081Jhk0FnYx9M"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gF/081Jhk0FnYx9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   5 months ago
config: openrisc-randconfig-s043-20221214
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ded2ee36313c941f1a12b6f85cde295b575264ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ded2ee36313c941f1a12b6f85cde295b575264ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/message/fusion/ drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1240:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1240:52: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:1240:52: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1244:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1244:46: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:1244:46: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1248:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1248:46: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:1248:46: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1250:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1250:55: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:1250:55: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1264:38: sparse: sparse: invalid assignment: |=
>> drivers/message/fusion/mptlan.c:1264:38: sparse:    left side has type unsigned int
>> drivers/message/fusion/mptlan.c:1264:38: sparse:    right side has type restricted __le32
>> drivers/message/fusion/mptlan.c:1266:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] BucketCount @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1266:39: sparse:     expected unsigned int [usertype] BucketCount
   drivers/message/fusion/mptlan.c:1266:39: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:974:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:974:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:974:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:974:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:977:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:977:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:977:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:977:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:986:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:986:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:986:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:986:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:1498:27: sparse: sparse: restricted __be16 degrades to integer
>> drivers/message/fusion/mptlan.c:1535:29: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] ethertype @@
   drivers/message/fusion/mptlan.c:1535:29: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1535:29: sparse:     got restricted __be16 [usertype] ethertype
>> drivers/message/fusion/mptlan.c:1538:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/message/fusion/mptlan.c:1538:16: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1538:16: sparse:     got restricted __be16 [usertype]
   drivers/message/fusion/mptlan.c:746:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:746:36: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:746:36: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:754:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:754:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:754:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:757:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:757:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:757:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:767:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:767:30: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:767:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:776:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:776:30: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:776:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:778:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:778:39: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:778:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:820:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] protocol @@     got unsigned short @@
   drivers/message/fusion/mptlan.c:820:23: sparse:     expected restricted __be16 [usertype] protocol
   drivers/message/fusion/mptlan.c:820:23: sparse:     got unsigned short
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32
--
   drivers/net/ethernet/freescale/enetc/enetc_ethtool.c: note: in included file (through drivers/net/ethernet/freescale/enetc/enetc.h):
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: restricted __le64 degrades to integer
>> drivers/net/ethernet/freescale/enetc/enetc_hw.h:462:16: sparse: sparse: cast to restricted __le64

vim +1177 drivers/message/fusion/mptlan.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  1139  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1140  static void
c4028958b6ecad David Howells       2006-11-22  1141  mpt_lan_post_receive_buckets(struct mpt_lan_priv *priv)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1142  {
c4028958b6ecad David Howells       2006-11-22  1143  	struct net_device *dev = priv->dev;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1144  	MPT_ADAPTER *mpt_dev = priv->mpt_dev;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1145  	MPT_FRAME_HDR *mf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1146  	LANReceivePostRequest_t *pRecvReq;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1147  	SGETransaction32_t *pTrans;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1148  	SGESimple64_t *pSimple;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1149  	struct sk_buff *skb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1150  	dma_addr_t dma;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1151  	u32 curr, buckets, count, max;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1152  	u32 len = (dev->mtu + dev->hard_header_len + 4);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1153  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1154  	int i;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1155  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1156  	curr = atomic_read(&priv->buckets_out);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1157  	buckets = (priv->max_buckets_out - curr);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1158  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1159  	dioprintk((KERN_INFO MYNAM ": %s/%s: @%s, Start_buckets = %u, buckets_out = %u\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16  1160  			IOC_AND_NETDEV_NAMES_s_s(dev),
cadbd4a5e36dde Harvey Harrison     2008-07-03  1161  			__func__, buckets, curr));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1162  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1163  	max = (mpt_dev->req_sz - MPT_LAN_RECEIVE_POST_REQUEST_SIZE) /
4e2e619f3c9e3c Gustavo A. R. Silva 2021-03-24  1164  			(sizeof(SGETransaction32_t) + sizeof(SGESimple64_t));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1165  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1166  	while (buckets) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1167  		mf = mpt_get_msg_frame(LanCtx, mpt_dev);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1168  		if (mf == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1169  			printk (KERN_ERR "%s: Unable to alloc request frame\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1170  				__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1171  			dioprintk((KERN_ERR "%s: %u buckets remaining\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1172  				 __func__, buckets));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1173  			goto out;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1174  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1175  		pRecvReq = (LANReceivePostRequest_t *) mf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1176  
e1fc2b5167f9c3 Eric Moore          2007-09-29 @1177  		i = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
e1fc2b5167f9c3 Eric Moore          2007-09-29  1178  		mpt_dev->RequestNB[i] = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1179  		count = buckets;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1180  		if (count > max)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1181  			count = max;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1182  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1183  		pRecvReq->Function    = MPI_FUNCTION_LAN_RECEIVE;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1184  		pRecvReq->ChainOffset = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1185  		pRecvReq->MsgFlags    = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1186  		pRecvReq->PortNumber  = priv->pnum;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1187  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1188  		pTrans = (SGETransaction32_t *) pRecvReq->SG_List;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1189  		pSimple = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1190  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1191  		for (i = 0; i < count; i++) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1192  			int ctx;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1193  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1194  			spin_lock_irqsave(&priv->rxfidx_lock, flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1195  			if (priv->mpt_rxfidx_tail < 0) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1196  				printk (KERN_ERR "%s: Can't alloc context\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1197  					__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1198  				spin_unlock_irqrestore(&priv->rxfidx_lock,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1199  						       flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1200  				break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1201  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1202  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1203  			ctx = priv->mpt_rxfidx[priv->mpt_rxfidx_tail--];
^1da177e4c3f41 Linus Torvalds      2005-04-16  1204  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1205  			skb = priv->RcvCtl[ctx].skb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1206  			if (skb && (priv->RcvCtl[ctx].len != len)) {
b114dda6f2f10c Christophe JAILLET  2022-01-06  1207  				dma_unmap_single(&mpt_dev->pcidev->dev,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1208  						 priv->RcvCtl[ctx].dma,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1209  						 priv->RcvCtl[ctx].len,
b114dda6f2f10c Christophe JAILLET  2022-01-06  1210  						 DMA_FROM_DEVICE);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1211  				dev_kfree_skb(priv->RcvCtl[ctx].skb);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1212  				skb = priv->RcvCtl[ctx].skb = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1213  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1214  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1215  			if (skb == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1216  				skb = dev_alloc_skb(len);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1217  				if (skb == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1218  					printk (KERN_WARNING
^1da177e4c3f41 Linus Torvalds      2005-04-16  1219  						MYNAM "/%s: Can't alloc skb\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1220  						__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1221  					priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1222  					spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1223  					break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1224  				}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1225  
b114dda6f2f10c Christophe JAILLET  2022-01-06  1226  				dma = dma_map_single(&mpt_dev->pcidev->dev,
b114dda6f2f10c Christophe JAILLET  2022-01-06  1227  						     skb->data, len,
b114dda6f2f10c Christophe JAILLET  2022-01-06  1228  						     DMA_FROM_DEVICE);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1229  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1230  				priv->RcvCtl[ctx].skb = skb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1231  				priv->RcvCtl[ctx].dma = dma;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1232  				priv->RcvCtl[ctx].len = len;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1233  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1234  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1235  			spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1236  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1237  			pTrans->ContextSize   = sizeof(u32);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1238  			pTrans->DetailsLength = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1239  			pTrans->Flags         = 0;
4e2e619f3c9e3c Gustavo A. R. Silva 2021-03-24 @1240  			pTrans->TransactionContext = cpu_to_le32(ctx);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1241  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1242  			pSimple = (SGESimple64_t *) pTrans->TransactionDetails;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1243  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1244  			pSimple->FlagsLength = cpu_to_le32(
^1da177e4c3f41 Linus Torvalds      2005-04-16  1245  				((MPI_SGE_FLAGS_END_OF_BUFFER |
^1da177e4c3f41 Linus Torvalds      2005-04-16  1246  				  MPI_SGE_FLAGS_SIMPLE_ELEMENT |
^1da177e4c3f41 Linus Torvalds      2005-04-16  1247  				  MPI_SGE_FLAGS_64_BIT_ADDRESSING) << MPI_SGE_FLAGS_SHIFT) | len);
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1248  			pSimple->Address.Low = cpu_to_le32((u32) priv->RcvCtl[ctx].dma);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1249  			if (sizeof(dma_addr_t) > sizeof(u32))
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1250  				pSimple->Address.High = cpu_to_le32((u32) ((u64) priv->RcvCtl[ctx].dma >> 32));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1251  			else
^1da177e4c3f41 Linus Torvalds      2005-04-16  1252  				pSimple->Address.High = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1253  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1254  			pTrans = (SGETransaction32_t *) (pSimple + 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1255  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1256  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1257  		if (pSimple == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1258  /**/			printk (KERN_WARNING MYNAM "/%s: No buckets posted\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1259  /**/				__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1260  			mpt_free_msg_frame(mpt_dev, mf);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1261  			goto out;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1262  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1263  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1264  		pSimple->FlagsLength |= cpu_to_le32(MPI_SGE_FLAGS_END_OF_LIST << MPI_SGE_FLAGS_SHIFT);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1265  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1266  		pRecvReq->BucketCount = cpu_to_le32(i);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1267  

:::::: The code at line 1177 was first introduced by commit
:::::: e1fc2b5167f9c3614099e55d3f49763a26a5a339 [SCSI] mptlan: bug fix, only half the message frame is dma'd resulting in corruption

:::::: TO: Eric Moore <eric.moore@lsi.com>
:::::: CC: James Bottomley <jejb@mulgrave.localdomain>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--gF/081Jhk0FnYx9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/openrisc 5.19.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="or1k-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_TIME_KUNIT_TEST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKHEADERS=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_HAVE_UID16=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
# CONFIG_PRINTK is not set
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_KCMP is not set
CONFIG_EMBEDDED=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_OPENRISC=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_MMU=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_NO_IOPORT_MAP=y
CONFIG_GENERIC_CSUM=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y

#
# Processor type and features
#
CONFIG_OR1K_1200=y
CONFIG_DCACHE_WRITETHROUGH=y
CONFIG_OPENRISC_BUILTIN_DTB=""

#
# Class II Instructions
#
# CONFIG_OPENRISC_HAVE_INST_FF1 is not set
# CONFIG_OPENRISC_HAVE_INST_FL1 is not set
CONFIG_OPENRISC_HAVE_INST_MUL=y
# CONFIG_OPENRISC_HAVE_INST_DIV is not set
CONFIG_OPENRISC_HAVE_INST_CMOV=y
CONFIG_OPENRISC_HAVE_INST_ROR=y
# CONFIG_OPENRISC_HAVE_INST_RORI is not set
# CONFIG_OPENRISC_HAVE_INST_SEXT is not set
# end of Class II Instructions

# CONFIG_SMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
# CONFIG_OPENRISC_HAVE_SHADOW_GPRS is not set
CONFIG_CMDLINE=""

#
# Debugging options
#
CONFIG_JUMP_UPON_UNHANDLED_EXCEPTION=y
CONFIG_OPENRISC_ESR_EXCEPTION_BUG_CHECK=y
# end of Debugging options
# end of Processor type and features

#
# General architecture-dependent options
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_DMA_SET_UNCACHED=y
CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_MMU_GATHER_NO_RANGE=y
CONFIG_LTO_NONE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_CPU_NO_EFFICIENT_FFS=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_CGROUP_FC_APPID=y
CONFIG_BLK_CGROUP_IOCOST=y
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_ELF_KUNIT_TEST=y
CONFIG_ELFCORE=y
# CONFIG_BINFMT_SCRIPT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

#
# SLAB allocator options
#
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_FLATMEM=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_INTERFACE=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
CONFIG_XFRM_ESPINTCP=y
CONFIG_SMC=y
# CONFIG_SMC_DIAG is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
CONFIG_INET_ESPINTCP=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=y
# CONFIG_TCP_CONG_HTCP is not set
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_NV=y
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=y
CONFIG_TCP_CONG_VENO=y
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=y
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HYBLA is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_IB is not set
# CONFIG_TIPC_MEDIA_UDP is not set
# CONFIG_TIPC_CRYPTO is not set
CONFIG_TIPC_DIAG=y
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
# CONFIG_BRIDGE_VLAN_FILTERING is not set
# CONFIG_BRIDGE_MRP is not set
CONFIG_BRIDGE_CFM=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_AR9331=y
CONFIG_NET_DSA_TAG_BRCM_COMMON=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_LEGACY=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
# CONFIG_NET_DSA_TAG_HELLCREEK is not set
CONFIG_NET_DSA_TAG_GSWIP=y
CONFIG_NET_DSA_TAG_DSA_COMMON=y
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_OCELOT=y
CONFIG_NET_DSA_TAG_OCELOT_8021Q=y
# CONFIG_NET_DSA_TAG_QCA is not set
CONFIG_NET_DSA_TAG_RTL4_A=y
# CONFIG_NET_DSA_TAG_RTL8_4 is not set
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_SJA1105=y
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_NET_DSA_TAG_XRS700X=y
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_IPDDP is not set
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=y
CONFIG_6LOWPAN_DEBUGFS=y
CONFIG_6LOWPAN_NHC=y
CONFIG_6LOWPAN_NHC_DEST=y
CONFIG_6LOWPAN_NHC_FRAGMENT=y
# CONFIG_6LOWPAN_NHC_HOP is not set
# CONFIG_6LOWPAN_NHC_IPV6 is not set
CONFIG_6LOWPAN_NHC_MOBILITY=y
CONFIG_6LOWPAN_NHC_ROUTING=y
# CONFIG_6LOWPAN_NHC_UDP is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=y
CONFIG_6LOWPAN_GHC_UDP=y
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=y
CONFIG_OPENVSWITCH_GENEVE=y
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VSOCKETS_LOOPBACK=y
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=y
# CONFIG_QRTR_SMD is not set
CONFIG_QRTR_TUN=y
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=y
# CONFIG_CAN_GW is not set
CONFIG_CAN_J1939=y
CONFIG_CAN_ISOTP=y

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=y
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_AT91 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_SUN4I is not set
# CONFIG_CAN_XILINXCAN is not set
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_RCAR is not set
# CONFIG_CAN_RCAR_CANFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

CONFIG_CAN_DEBUG_DEVICES=y
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_MCTP_TEST=y
CONFIG_MCTP_FLOWS=y
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
# CONFIG_NET_9P_FD is not set
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set
# CONFIG_NETDEV_ADDR_LIST_TEST is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
CONFIG_PCIE_XILINX_NWL=y
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_TEGRA=y
CONFIG_PCIE_RCAR_HOST=y
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
CONFIG_PCI_XGENE_MSI=y
# CONFIG_PCI_V3_SEMI is not set
CONFIG_PCI_VERSATILE=y
# CONFIG_PCIE_ALTERA is not set
CONFIG_PCI_HOST_THUNDER_PEM=y
CONFIG_PCI_HOST_THUNDER_ECAM=y
CONFIG_PCIE_ROCKCHIP=y
CONFIG_PCIE_ROCKCHIP_HOST=y
# CONFIG_PCIE_MEDIATEK is not set
CONFIG_PCIE_MEDIATEK_GEN3=y
CONFIG_PCIE_BRCMSTB=y
# CONFIG_PCI_LOONGSON is not set
CONFIG_PCIE_MICROCHIP_HOST=y
# CONFIG_PCIE_APPLE is not set
CONFIG_PCIE_MT7621=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCI_DRA7XX=y
CONFIG_PCI_DRA7XX_HOST=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCI_EXYNOS=y
# CONFIG_PCI_IMX6 is not set
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
CONFIG_PCI_LAYERSCAPE=y
# CONFIG_PCI_HISI is not set
CONFIG_PCIE_QCOM=y
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_ARTPEC6_HOST is not set
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
# CONFIG_PCIE_INTEL_GW is not set
CONFIG_PCIE_KEEMBAY=y
CONFIG_PCIE_KEEMBAY_HOST=y
CONFIG_PCIE_KIRIN=y
CONFIG_PCIE_HISI_STB=y
CONFIG_PCI_MESON=y
# CONFIG_PCIE_TEGRA194_HOST is not set
CONFIG_PCIE_VISCONTI_HOST=y
CONFIG_PCIE_UNIPHIER=y
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
CONFIG_PCIE_MOBIVEIL_PLAT=y
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
CONFIG_BT1_APB=y
# CONFIG_BT1_AXI is not set
CONFIG_MOXTET=y
CONFIG_HISILICON_LPC=y
CONFIG_INTEL_IXP4XX_EB=y
# CONFIG_QCOM_EBI2 is not set
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_MSG=y
# CONFIG_ARM_SCMI_TRANSPORT_MAILBOX is not set
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE is not set
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
# CONFIG_ARM_SCPI_POWER_DOMAIN is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_MTK_ADSP_IPC is not set
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
# CONFIG_TURRIS_MOX_RWTM is not set
CONFIG_BCM47XX_NVRAM=y
# CONFIG_BCM47XX_SPROM is not set
CONFIG_TEE_BNXT_FW=y
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_IMX_DSP is not set
CONFIG_IMX_SCU=y
# CONFIG_IMX_SCU_PD is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
# CONFIG_GNSS_MTK_SERIAL is not set
CONFIG_GNSS_SIRF_SERIAL=y
# CONFIG_GNSS_UBX_SERIAL is not set
# CONFIG_GNSS_USB is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_ZRAM=y
CONFIG_ZRAM_DEF_COMP_ZSTD=y
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="zstd"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_BLK_DEV_LOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_TCP=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ATMEL_SSC=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_GEHC_ACHC=y
# CONFIG_HI6421V600_IRQ is not set
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
CONFIG_QCOM_FASTRPC=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_OPEN_DICE=y
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_SPI is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_ECHO=y
# CONFIG_BCM_VK is not set
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
CONFIG_SCSI_CXGB4_ISCSI=y
CONFIG_SCSI_BNX2_ISCSI=y
CONFIG_SCSI_BNX2X_FCOE=y
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=y
CONFIG_AIC94XX_DEBUG=y
CONFIG_SCSI_HISI_SAS=y
CONFIG_SCSI_HISI_SAS_DEBUGFS_DEFAULT_ENABLE=y
# CONFIG_SCSI_MVSAS is not set
CONFIG_SCSI_MVUMI=y
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
CONFIG_MEGARAID_LEGACY=y
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
CONFIG_LIBFC=y
CONFIG_LIBFCOE=y
CONFIG_FCOE=y
# CONFIG_SCSI_SNIC is not set
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_PPA=y
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=y
CONFIG_TCM_QLA2XXX=y
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=y
# CONFIG_SCSI_EFCT is not set
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_NSP32=y
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_PMCRAID=y
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_BFA_FC=y
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_BRCM is not set
CONFIG_AHCI_DA850=y
CONFIG_AHCI_DM816=y
# CONFIG_AHCI_IMX is not set
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_MTK=y
# CONFIG_AHCI_MVEBU is not set
# CONFIG_AHCI_SUNXI is not set
CONFIG_AHCI_TEGRA=y
# CONFIG_AHCI_XGENE is not set
CONFIG_AHCI_QORIQ=y
CONFIG_SATA_FSL=y
CONFIG_SATA_GEMINI=y
CONFIG_SATA_AHCI_SEATTLE=y
CONFIG_SATA_INIC162X=y
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=y
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=y
CONFIG_PATA_IXP4XX_CF=y
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_NS87410 is not set
CONFIG_PATA_OPTI=y
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y
CONFIG_PATA_RZ1000=y
CONFIG_PATA_SAMSUNG_CF=y

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_LEGACY=y
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
CONFIG_TCM_USER2=y
CONFIG_LOOPBACK_TARGET=y
# CONFIG_TCM_FC is not set
CONFIG_ISCSI_TARGET=y
CONFIG_ISCSI_TARGET_CXGB4=y
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_FC=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set
CONFIG_FUSION_LAN=y
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
CONFIG_FIREWIRE_NET=y
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
CONFIG_WIREGUARD=y
# CONFIG_WIREGUARD_DEBUG is not set
CONFIG_EQUALIZER=y
CONFIG_NET_FC=y
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=y
CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
CONFIG_NET_TEAM_MODE_RANDOM=y
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
CONFIG_NET_TEAM_MODE_LOADBALANCE=y
# CONFIG_MACVLAN is not set
CONFIG_IPVLAN=y
CONFIG_IPVTAP=y
# CONFIG_VXLAN is not set
CONFIG_GENEVE=y
CONFIG_BAREUDP=y
CONFIG_GTP=y
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_RIONET is not set
CONFIG_TUN=y
CONFIG_TAP=y
CONFIG_TUN_VNET_CROSS_LE=y
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
CONFIG_NLMON=y
CONFIG_SUNGEM_PHY=y
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
CONFIG_B53_SPI_DRIVER=y
CONFIG_B53_MDIO_DRIVER=y
CONFIG_B53_MMAP_DRIVER=y
CONFIG_B53_SRAB_DRIVER=y
CONFIG_B53_SERDES=y
CONFIG_NET_DSA_BCM_SF2=y
CONFIG_NET_DSA_LOOP=y
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
CONFIG_NET_DSA_MT7530=y
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=y
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
CONFIG_NET_DSA_MSCC_FELIX=y
CONFIG_NET_DSA_MSCC_SEVILLE=y
# CONFIG_NET_DSA_AR9331 is not set
CONFIG_NET_DSA_SJA1105=y
# CONFIG_NET_DSA_SJA1105_PTP is not set
CONFIG_NET_DSA_XRS700X=y
CONFIG_NET_DSA_XRS700X_I2C=y
# CONFIG_NET_DSA_XRS700X_MDIO is not set
# CONFIG_NET_DSA_QCA8K is not set
# CONFIG_NET_DSA_REALTEK is not set
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
CONFIG_NET_DSA_VITESSE_VSC73XX=y
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=y
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=y
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_TYPHOON=y
# CONFIG_NET_VENDOR_ACTIONS is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=y
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_XGENE=y
# CONFIG_NET_XGENE_V2 is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_ARC_EMAC_CORE=y
CONFIG_ARC_EMAC=y
CONFIG_EMAC_ROCKCHIP=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_CX_ECAT=y
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCM4908_ENET is not set
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
CONFIG_BGMAC=y
CONFIG_BGMAC_PLATFORM=y
CONFIG_SYSTEMPORT=y
# CONFIG_BNXT is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
# CONFIG_CHELSIO_T3 is not set
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=y
CONFIG_CHELSIO_LIB=y
CONFIG_CHELSIO_INLINE_CRYPTO=y
# CONFIG_CRYPTO_DEV_CHELSIO_TLS is not set
CONFIG_CHELSIO_IPSEC_INLINE=y
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=y
CONFIG_CS89x0_PLATFORM=y
CONFIG_EP93XX_ETH=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_NET_VENDOR_DAVICOM is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
# CONFIG_BE2NET_LANCER is not set
# CONFIG_BE2NET_SKYHAWK is not set
# CONFIG_NET_VENDOR_ENGLEDER is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FARADAY is not set
CONFIG_NET_VENDOR_FREESCALE=y
CONFIG_FEC=y
# CONFIG_FSL_FMAN is not set
CONFIG_FSL_PQ_MDIO=y
CONFIG_FSL_XGMAC_MDIO=y
CONFIG_GIANFAR=y
CONFIG_FSL_DPAA2_SWITCH=y
CONFIG_FSL_ENETC=y
# CONFIG_FSL_ENETC_VF is not set
CONFIG_FSL_ENETC_IERB=y
CONFIG_FSL_ENETC_MDIO=y
# CONFIG_FSL_ENETC_PTP_CLOCK is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HISILICON is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_JME is not set
# CONFIG_KORINA is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MEDIATEK is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_MLXBF_GIGE is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_MSCC_OCELOT_SWITCH_LIB=y
CONFIG_MSCC_OCELOT_SWITCH=y
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_8390 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
# CONFIG_LPC_ENET is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=y
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCA7000=y
CONFIG_QCA7000_SPI=y
CONFIG_QCA7000_UART=y
CONFIG_QCOM_EMAC=y
CONFIG_RMNET=y
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
# CONFIG_8139TOO_8129 is not set
CONFIG_8139_OLD_RX_RESET=y
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=y
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=y
# CONFIG_SFC_MCDI_MON is not set
CONFIG_SFC_SRIOV=y
# CONFIG_SFC_MCDI_LOGGING is not set
# CONFIG_SFC_FALCON is not set
CONFIG_SFC_SIENA=y
CONFIG_SFC_SIENA_MCDI_MON=y
# CONFIG_SFC_SIENA_SRIOV is not set
# CONFIG_SFC_SIENA_MCDI_LOGGING is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=y
# CONFIG_CASSINI is not set
CONFIG_NIU=y
CONFIG_NET_VENDOR_SUNPLUS=y
CONFIG_SP7021_EMAC=y
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_DAVINCI_EMAC=y
CONFIG_TI_DAVINCI_MDIO=y
CONFIG_TI_CPSW_PHY_SEL=y
CONFIG_TI_CPSW=y
CONFIG_TI_CPSW_SWITCHDEV=y
CONFIG_TI_CPTS=y
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_MSE102X=y
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_EMACLITE=y
CONFIG_XILINX_AXI_EMAC=y
CONFIG_XILINX_LL_TEMAC=y
# CONFIG_FDDI is not set
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=y
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_SFP=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_ADIN_PHY is not set
CONFIG_ADIN1100_PHY=y
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=y
CONFIG_BCM54140_PHY=y
# CONFIG_BCM63XX_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_CYGNUS_PHY=y
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
CONFIG_MARVELL_88X2222_PHY=y
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MOTORCOMM_PHY=y
CONFIG_NATIONAL_PHY=y
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=y
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y

#
# MCTP Device Drivers
#
CONFIG_MCTP_TRANSPORT_I2C=y
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_SUN4I is not set
CONFIG_MDIO_XGENE=y
# CONFIG_MDIO_ASPEED is not set
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_IPROC=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_I2C=y
CONFIG_MDIO_MVUSB=y
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_MDIO_MOXART=y
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=y

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_MESON_G12A is not set
CONFIG_MDIO_BUS_MUX_BCM6368=y
CONFIG_MDIO_BUS_MUX_BCM_IPROC=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
CONFIG_MDIO_BUS_MUX_MMIOREG=y

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
CONFIG_PCS_LYNX=y
# end of PCS device drivers

CONFIG_PLIP=y
# CONFIG_PPP is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set
CONFIG_WAN=y
# CONFIG_HDLC is not set
# CONFIG_SLIC_DS26522 is not set
CONFIG_LAPBETHER=y

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_VMXNET3=y
CONFIG_USB4_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_MISDN=y
# CONFIG_MISDN_DSP is not set
# CONFIG_MISDN_L1OIP is not set

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=y
# CONFIG_MISDN_HFCMULTI is not set
CONFIG_MISDN_HFCUSB=y
CONFIG_MISDN_AVMFRITZ=y
# CONFIG_MISDN_SPEEDFAX is not set
CONFIG_MISDN_INFINEON=y
# CONFIG_MISDN_W6692 is not set
CONFIG_MISDN_IPAC=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
# CONFIG_JOYSTICK_XPAD_LEDS is not set
# CONFIG_JOYSTICK_WALKERA0701 is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_PXRC=y
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=y
# CONFIG_TABLET_USB_KBTAB is not set
CONFIG_TABLET_USB_PEGASUS=y
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_IPROC is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MSG2638=y
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW=y
# CONFIG_TOUCHSCREEN_MIGOR is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MXS_LRADC is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TS4800 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SUN4I is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_IPMB=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMI_KCS_BMC=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
# CONFIG_IPMI_KCS_BMC_CDEV_IPMI is not set
# CONFIG_IPMI_KCS_BMC_SERIO is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_ATMEL is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
# CONFIG_HW_RANDOM_OMAP3_ROM is not set
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_IMX_RNGC is not set
# CONFIG_HW_RANDOM_NOMADIK is not set
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
CONFIG_HW_RANDOM_MTK=y
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_APPLICOM=y
# CONFIG_DEVMEM is not set
CONFIG_DEVPORT=y
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set
CONFIG_XILLYBUS_OF=y
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_HIX5HD2=y
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
# CONFIG_I2C_ASPEED is not set
# CONFIG_I2C_AT91 is not set
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=y
# CONFIG_I2C_BCM_IPROC is not set
# CONFIG_I2C_BCM_KONA is not set
CONFIG_I2C_BRCMSTB=y
CONFIG_I2C_CADENCE=y
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DAVINCI=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DIGICOLOR=y
CONFIG_I2C_EG20T=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_EXYNOS5=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_HIGHLANDER is not set
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMG is not set
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
CONFIG_I2C_IOP3XX=y
CONFIG_I2C_JZ4780=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_LPC2K=y
CONFIG_I2C_MESON=y
CONFIG_I2C_MT65XX=y
# CONFIG_I2C_MT7621 is not set
# CONFIG_I2C_MV64XXX is not set
CONFIG_I2C_MXS=y
# CONFIG_I2C_NPCM7XX is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=y
CONFIG_I2C_OWL=y
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
# CONFIG_I2C_PXA_SLAVE is not set
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_QUP is not set
CONFIG_I2C_RIIC=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_S3C2410=y
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=y
# CONFIG_I2C_STM32F4 is not set
CONFIG_I2C_STM32F7=y
CONFIG_I2C_SUN6I_P2WI=y
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA_BPMP=y
# CONFIG_I2C_UNIPHIER is not set
CONFIG_I2C_UNIPHIER_F=y
CONFIG_I2C_VERSATILE=y
CONFIG_I2C_WMT=y
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_CP2615=y
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AR934X=y
CONFIG_SPI_ATH79=y
CONFIG_SPI_ARMADA_3700=y
CONFIG_SPI_ASPEED_SMC=y
CONFIG_SPI_ATMEL=y
CONFIG_SPI_ATMEL_QUADSPI=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BCM2835=y
CONFIG_SPI_BCM2835AUX=y
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
CONFIG_SPI_BCM_QSPI=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CADENCE_QUADSPI=y
CONFIG_SPI_CLPS711X=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_EP93XX=y
CONFIG_SPI_FSI=y
# CONFIG_SPI_FSL_LPSPI is not set
CONFIG_SPI_FSL_QUADSPI=y
CONFIG_SPI_HISI_KUNPENG=y
# CONFIG_SPI_HISI_SFC_V3XX is not set
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_IMG_SPFI=y
CONFIG_SPI_IMX=y
CONFIG_SPI_INGENIC=y
CONFIG_SPI_JCORE=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_LP8841_RTC=y
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_FSL_DSPI is not set
CONFIG_SPI_MESON_SPICC=y
CONFIG_SPI_MESON_SPIFC=y
CONFIG_SPI_MT65XX=y
CONFIG_SPI_MT7621=y
# CONFIG_SPI_MTK_NOR is not set
CONFIG_SPI_NPCM_FIU=y
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_OMAP24XX=y
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_OMAP_100K is not set
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PIC32=y
CONFIG_SPI_PIC32_SQI=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RPCIF=y
CONFIG_SPI_RSPI=y
CONFIG_SPI_QUP=y
CONFIG_SPI_S3C64XX=y
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_SH_MSIOF=y
# CONFIG_SPI_SH is not set
CONFIG_SPI_SH_HSPI=y
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SLAVE_MT27XX=y
CONFIG_SPI_SPRD=y
CONFIG_SPI_SPRD_ADI=y
CONFIG_SPI_STM32=y
CONFIG_SPI_ST_SSC4=y
# CONFIG_SPI_SUN4I is not set
CONFIG_SPI_SUN6I=y
# CONFIG_SPI_SUNPLUS_SP7021 is not set
# CONFIG_SPI_SYNQUACER is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TEGRA210_QUAD is not set
CONFIG_SPI_TEGRA114=y
# CONFIG_SPI_TEGRA20_SFLASH is not set
CONFIG_SPI_TEGRA20_SLINK=y
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_UNIPHIER=y
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_XLP is not set
CONFIG_SPI_XTENSA_XTFPGA=y
# CONFIG_SPI_ZYNQ_QSPI is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_SPMI_MSM_PMIC_ARB is not set
CONFIG_SPMI_MTK_PMIF=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_PTP_1588_CLOCK_DTE is not set
CONFIG_PTP_1588_CLOCK_QORIQ=y
# CONFIG_DP83640_PHY is not set
CONFIG_PTP_1588_CLOCK_INES=y
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PTP_1588_CLOCK_IDT82P33=y
CONFIG_PTP_1588_CLOCK_IDTCM=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AT91PIO4 is not set
CONFIG_PINCTRL_BM1880=y
CONFIG_PINCTRL_DA850_PUPD=y
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_INGENIC=y
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_PISTACHIO is not set
CONFIG_PINCTRL_RK805=y
CONFIG_PINCTRL_ROCKCHIP=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STARFIVE is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_OWL is not set
CONFIG_PINCTRL_ASPEED=y
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
CONFIG_PINCTRL_ASPEED_G6=y
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_BCM2835 is not set
CONFIG_PINCTRL_BCM4908=y
CONFIG_PINCTRL_BCM63XX=y
# CONFIG_PINCTRL_BCM6318 is not set
CONFIG_PINCTRL_BCM6328=y
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
CONFIG_PINCTRL_BCM63268=y
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_NS is not set
CONFIG_PINCTRL_NSP_GPIO=y
# CONFIG_PINCTRL_NS2_MUX is not set
CONFIG_PINCTRL_NSP_MUX=y
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
CONFIG_PINCTRL_MT7623=y
# CONFIG_PINCTRL_MT7629 is not set
CONFIG_PINCTRL_MT8135=y
# CONFIG_PINCTRL_MT8127 is not set
CONFIG_PINCTRL_MT2712=y
CONFIG_PINCTRL_MT6765=y
CONFIG_PINCTRL_MT6779=y
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
CONFIG_PINCTRL_MT7622=y
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT8167 is not set
CONFIG_PINCTRL_MT8173=y
CONFIG_PINCTRL_MT8183=y
CONFIG_PINCTRL_MT8186=y
# CONFIG_PINCTRL_MT8192 is not set
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
CONFIG_PINCTRL_MT6397=y
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_WPCM450 is not set
CONFIG_PINCTRL_NPCM7XX=y
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=y
# CONFIG_PINCTRL_MSM is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7280_LPASS_LPI=y
CONFIG_PINCTRL_SM8250_LPASS_LPI=y
# CONFIG_PINCTRL_SM8450 is not set
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
CONFIG_PINCTRL_PFC_R8A77950=y
# CONFIG_PINCTRL_PFC_R8A77951 is not set
CONFIG_PINCTRL_PFC_R8A7778=y
# CONFIG_PINCTRL_PFC_R8A7793 is not set
CONFIG_PINCTRL_PFC_R8A7791=y
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
CONFIG_PINCTRL_PFC_R8A7792=y
CONFIG_PINCTRL_PFC_R8A77980=y
CONFIG_PINCTRL_PFC_R8A77970=y
CONFIG_PINCTRL_PFC_R8A779A0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
CONFIG_PINCTRL_PFC_R8A73A4=y
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
CONFIG_PINCTRL_PFC_SH7722=y
# CONFIG_PINCTRL_PFC_SH7734 is not set
CONFIG_PINCTRL_PFC_SH7757=y
CONFIG_PINCTRL_PFC_SH7785=y
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
CONFIG_PINCTRL_S3C64XX=y
# CONFIG_PINCTRL_SPRD_SC9860 is not set
CONFIG_PINCTRL_STM32=y
# CONFIG_PINCTRL_STM32F429 is not set
CONFIG_PINCTRL_STM32F469=y
CONFIG_PINCTRL_STM32F746=y
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
CONFIG_PINCTRL_STM32MP157=y
CONFIG_PINCTRL_TI_IODELAY=y
# CONFIG_PINCTRL_UNIPHIER is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=y
# CONFIG_GPIO_BCM_KONA is not set
CONFIG_GPIO_BCM_XGS_IPROC=y
CONFIG_GPIO_BRCMSTB=y
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EIC_SPRD=y
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HISI is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_IOP=y
CONFIG_GPIO_LOGICVC=y
# CONFIG_GPIO_LPC18XX is not set
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MPC8XXX=y
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
CONFIG_GPIO_PMIC_EIC_SPRD=y
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_RDA is not set
CONFIG_GPIO_ROCKCHIP=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SNPS_CREG=y
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_TEGRA is not set
# CONFIG_GPIO_TEGRA186 is not set
CONFIG_GPIO_TS4800=y
CONFIG_GPIO_UNIPHIER=y
CONFIG_GPIO_VISCONTI=y
CONFIG_GPIO_VX855=y
CONFIG_GPIO_WCD934X=y
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_XLP=y
CONFIG_GPIO_AMD_FCH=y
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD71815 is not set
# CONFIG_GPIO_BD71828 is not set
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_SL28CPLD=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# CONFIG_GPIO_MOXTET is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_BRCMKONA is not set
# CONFIG_POWER_RESET_BRCMSTB is not set
# CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LINKSTATION=y
CONFIG_POWER_RESET_OCELOT_RESET=y
# CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_KEYSTONE is not set
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_POWER_RESET_RMOBILE=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_RESET_SC27XX=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CPCAP=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_INGENIC=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_CPCAP is not set
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MP2629=y
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_QCOM_SMBB=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_SC2731=y
# CONFIG_FUEL_GAUGE_SC27XX is not set
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_ACER_A500=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_ARM_SCMI=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_BT1_PVT=y
CONFIG_SENSORS_BT1_PVT_ALARMS=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_SPARX5 is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LAN966X=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NSA320=y
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=y
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=y
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE152=y
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_DA9062_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WM831X_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_MLX_WDT=y
# CONFIG_SL28CPLD_WATCHDOG is not set
CONFIG_ARMADA_37XX_WATCHDOG=y
CONFIG_ASM9260_WATCHDOG=y
CONFIG_AT91RM9200_WATCHDOG=y
CONFIG_AT91SAM9X_WATCHDOG=y
# CONFIG_SAMA5D4_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_FTWDT010_WATCHDOG=y
CONFIG_S3C2410_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_EP93XX_WATCHDOG=y
CONFIG_OMAP_WATCHDOG=y
CONFIG_PNX4008_WATCHDOG=y
CONFIG_DAVINCI_WATCHDOG=y
CONFIG_K3_RTI_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
# CONFIG_SUNXI_WATCHDOG is not set
CONFIG_NPCM7XX_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_STMP3XXX_RTC_WATCHDOG=y
CONFIG_TS4800_WATCHDOG=y
CONFIG_TS72XX_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_IMX2_WDT=y
# CONFIG_IMX7ULP_WDT is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_MOXART_WDT=y
# CONFIG_ST_LPC_WATCHDOG is not set
CONFIG_TEGRA_WATCHDOG=y
CONFIG_QCOM_WDT=y
CONFIG_MESON_GXBB_WATCHDOG=y
CONFIG_MESON_WATCHDOG=y
# CONFIG_MEDIATEK_WATCHDOG is not set
# CONFIG_DIGICOLOR_WATCHDOG is not set
CONFIG_LPC18XX_WATCHDOG=y
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
CONFIG_RENESAS_RZN1WDT=y
CONFIG_RENESAS_RZG2LWDT=y
CONFIG_ASPEED_WATCHDOG=y
CONFIG_UNIPHIER_WATCHDOG=y
CONFIG_RTD119X_WATCHDOG=y
CONFIG_REALTEK_OTTO_WDT=y
CONFIG_SPRD_WATCHDOG=y
CONFIG_VISCONTI_WATCHDOG=y
CONFIG_MSC313E_WATCHDOG=y
CONFIG_APPLE_WATCHDOG=y
CONFIG_SUNPLUS_WATCHDOG=y
# CONFIG_ALIM7101_WDT is not set
CONFIG_SC520_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_KEMPLD_WDT is not set
# CONFIG_RDC321X_WDT is not set
# CONFIG_BCM47XX_WDT is not set
# CONFIG_BCM2835_WDT is not set
CONFIG_BCM_KONA_WDT=y
# CONFIG_BCM_KONA_WDT_DEBUG is not set
# CONFIG_BCM7038_WDT is not set
CONFIG_IMGPDC_WDT=y
# CONFIG_MPC5200_WDT is not set
CONFIG_MEN_A21_WDT=y
CONFIG_UML_WATCHDOG=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_HOST_SOC=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_SUN4I_GPADC is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=y
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=y
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
# CONFIG_MFD_HI655X_PMIC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_PM8XXX=y
# CONFIG_MFD_SPMI_PMIC is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SC27XX_PMIC=y
CONFIG_ABX500_CORE=y
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
CONFIG_TPS65010=y
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_STW481X=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=y
CONFIG_MFD_STM32_TIMERS=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_KHADAS_MCU=y
CONFIG_MFD_ACER_A500_EC=y
CONFIG_MFD_QCOM_PM8008=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC=y
# CONFIG_MFD_RSMU_I2C is not set
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_ARM_SCMI=y
CONFIG_REGULATOR_AS3711=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD71815 is not set
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_CPCAP=y
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
# CONFIG_REGULATOR_HI6421V600 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6360=y
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PF8X00=y
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SMD_RPM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=y
CONFIG_REGULATOR_STM32_VREFBUF=y
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_TI_ABB=y
# CONFIG_REGULATOR_STW481X_VMMC is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS6286X=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS68470=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_UNIPHIER=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_H264=y
CONFIG_V4L2_VP9=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_S2255 is not set
# CONFIG_USB_STKWEBCAM is not set
CONFIG_VIDEO_USBTV=y
# CONFIG_USB_VIDEO_CLASS is not set
# CONFIG_USB_ZR364XX is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_GO7007=y
CONFIG_VIDEO_GO7007_USB=y
CONFIG_VIDEO_GO7007_LOADER=y
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=y
CONFIG_VIDEO_HDPVR=y
# CONFIG_VIDEO_PVRUSB2 is not set
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_CX231XX is not set

#
# Digital TV USB devices
#
CONFIG_DVB_AS102=y
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_USB_V2 is not set
CONFIG_SMS_USB_DRV=y
CONFIG_DVB_TTUSB_BUDGET=y
# CONFIG_DVB_TTUSB_DEC is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_ALSA=y
# CONFIG_VIDEO_EM28XX_DVB is not set

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
CONFIG_USB_HACKRF=y
CONFIG_USB_MSI2500=y
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIM2M is not set
CONFIG_VIDEO_VICODEC=y
CONFIG_VIDEO_VIMC=y
# CONFIG_VIDEO_VIVID is not set
CONFIG_DVB_TEST_DRIVERS=y
# CONFIG_DVB_VIDTV is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_SMS_SIANO_MDTV=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
CONFIG_VIDEO_V4L2_TPG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_HI556=y
CONFIG_VIDEO_HI846=y
CONFIG_VIDEO_HI847=y
CONFIG_VIDEO_IMX208=y
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=y
# CONFIG_VIDEO_IMX258 is not set
CONFIG_VIDEO_IMX274=y
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX334=y
CONFIG_VIDEO_IMX335=y
# CONFIG_VIDEO_IMX355 is not set
CONFIG_VIDEO_IMX412=y
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_NOON010PC30 is not set
CONFIG_VIDEO_OG01A1B=y
CONFIG_VIDEO_OV02A10=y
CONFIG_VIDEO_OV08D10=y
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=y
# CONFIG_VIDEO_OV5647 is not set
CONFIG_VIDEO_OV5670=y
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5693=y
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV7251=y
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
# CONFIG_VIDEO_OV772X is not set
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV9282=y
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_RDACM20=y
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
CONFIG_VIDEO_S5C73M3=y
CONFIG_VIDEO_S5K4ECGX=y
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=y
CONFIG_VIDEO_S5K6AA=y
CONFIG_VIDEO_SR030PC30=y
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
CONFIG_VIDEO_ET8EK8=y
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV748X=y
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_ISL7998X=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_MAX9286=y
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
# CONFIG_VIDEO_ST_MIPID02 is not set
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
# CONFIG_DVB_TDA18271C2DD is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=y
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=y
CONFIG_DVB_DRXD=y
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_L64781=y
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_NXT6000=y
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_RTL2832_SDR is not set
# CONFIG_DVB_S5H1432 is not set
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_ZL10353=y
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_ASCOT2E is not set
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_HELENE=y
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ISL6405=y
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=y
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_LGS8GL5=y
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_IMX_IPUV3_CORE=y
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CLPS711X is not set
CONFIG_FB_IMX=y
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=y
CONFIG_FB_CONTROL=y
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_GBE is not set
CONFIG_FB_PVR2=y
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_ATMEL=y
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_WM8505=y
CONFIG_FB_WMT_GE_ROPS=y
CONFIG_FB_PXA168=y
CONFIG_FB_W100=y
CONFIG_FB_SH_MOBILE_LCDC=y
CONFIG_FB_TMIO=y
# CONFIG_FB_TMIO_ACCELL is not set
# CONFIG_FB_S3C is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_DA8XX=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# CONFIG_FB_OMAP_LCD_H3 is not set
CONFIG_FB_OMAP2=y
# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=y
# CONFIG_FB_OMAP2_DSS_DEBUG is not set
CONFIG_FB_OMAP2_DSS_DEBUGFS=y
# CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS is not set
# CONFIG_FB_OMAP2_DSS_DPI is not set
CONFIG_FB_OMAP2_DSS_VENC=y
# CONFIG_FB_OMAP4_DSS_HDMI is not set
# CONFIG_FB_OMAP5_DSS_HDMI is not set
# CONFIG_FB_OMAP2_DSS_SDI is not set
# CONFIG_FB_OMAP2_DSS_DSI is not set
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
# CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET is not set

#
# OMAPFB Panel and Encoder Drivers
#
CONFIG_FB_OMAP2_ENCODER_OPA362=y
# CONFIG_FB_OMAP2_ENCODER_TFP410 is not set
CONFIG_FB_OMAP2_ENCODER_TPD12S015=y
CONFIG_FB_OMAP2_CONNECTOR_DVI=y
CONFIG_FB_OMAP2_CONNECTOR_HDMI=y
CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=y
# CONFIG_FB_OMAP2_PANEL_DPI is not set
# CONFIG_FB_OMAP2_PANEL_DSI_CM is not set
# CONFIG_FB_OMAP2_PANEL_SONY_ACX565AKM is not set
CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02=y
# CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1 is not set
CONFIG_FB_OMAP2_PANEL_TPO_TD043MTEA1=y
CONFIG_FB_OMAP2_PANEL_NEC_NL8048HL11=y
# end of OMAPFB Panel and Encoder Drivers

CONFIG_MMP_DISP=y
# CONFIG_MMP_DISP_CONTROLLER is not set
CONFIG_MMP_PANEL_TPOHVGA=y
CONFIG_MMP_FB=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_ATMEL_LCDC=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_CTL_VALIDATION is not set
CONFIG_SND_JACK_INJECTION_DEBUG=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
CONFIG_SND_AT73C213=y
CONFIG_SND_AT73C213_TARGET_BITRATE=48000
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_UA101=y
CONFIG_SND_USB_CAIAQ=y
# CONFIG_SND_USB_CAIAQ_INPUT is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
CONFIG_SND_USB_LINE6=y
CONFIG_SND_USB_POD=y
CONFIG_SND_USB_PODHD=y
CONFIG_SND_USB_TONEPORT=y
CONFIG_SND_USB_VARIAX=y
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=y
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=y
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=y
# CONFIG_SND_FIREWIRE_DIGI00X is not set
CONFIG_SND_FIREWIRE_TASCAM=y
# CONFIG_SND_FIREWIRE_MOTU is not set
CONFIG_SND_FIREFACE=y
# CONFIG_SND_SOC is not set
CONFIG_SND_VIRTIO=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_FT260=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=y
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MEGAWORLD_FF=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
CONFIG_HID_SIGMAMICRO=y
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_OF=y
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=y
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_XHCI_HISTB is not set
CONFIG_USB_XHCI_MTK=y
# CONFIG_USB_XHCI_MVEBU is not set
# CONFIG_USB_XHCI_RCAR is not set
# CONFIG_USB_BRCMSTB is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_SSB is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MTU3=y
CONFIG_USB_MTU3_HOST=y
CONFIG_USB_MTU3_DEBUG=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
# CONFIG_USB_MUSB_TUSB6010 is not set
CONFIG_USB_MUSB_DSPS=y
# CONFIG_USB_MUSB_UX500 is not set
# CONFIG_USB_MUSB_MEDIATEK is not set

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_QCOM_EUD=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=y
# CONFIG_BRCM_USB_PINMAP is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_KEYSTONE_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_AM335X_PHY_USB is not set
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_TEGRA_PHY=y
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
CONFIG_TYPEC_QCOM_PMIC=y
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SIMPLE is not set
# CONFIG_MMC_BLOCK is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_MESON_GX=y
CONFIG_MMC_MESON_MX_SDHC=y
CONFIG_MMC_MESON_MX_SDIO=y
# CONFIG_MMC_MOXART is not set
# CONFIG_MMC_OMAP_HS is not set
# CONFIG_MMC_ALCOR is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_DAVINCI=y
# CONFIG_MMC_SPI is not set
CONFIG_MMC_S3C=y
# CONFIG_MMC_S3C_HW_SDIO_IRQ is not set
# CONFIG_MMC_S3C_PIO is not set
CONFIG_MMC_S3C_DMA=y
CONFIG_MMC_TMIO_CORE=y
# CONFIG_MMC_TMIO is not set
CONFIG_MMC_SDHI=y
CONFIG_MMC_SDHI_SYS_DMAC=y
CONFIG_MMC_SDHI_INTERNAL_DMAC=y
CONFIG_MMC_UNIPHIER=y
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_DW=y
CONFIG_MMC_DW_PLTFM=y
CONFIG_MMC_DW_BLUEFIELD=y
CONFIG_MMC_DW_EXYNOS=y
CONFIG_MMC_DW_HI3798CV200=y
CONFIG_MMC_DW_K3=y
# CONFIG_MMC_DW_PCI is not set
# CONFIG_MMC_SH_MMCIF is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_BCM2835 is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_OWL=y
CONFIG_MMC_LITEX=y
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
CONFIG_SCSI_UFS_HWMON=y
CONFIG_SCSI_UFSHCD_PCI=y
CONFIG_SCSI_UFS_DWC_TC_PCI=y
CONFIG_SCSI_UFSHCD_PLATFORM=y
CONFIG_SCSI_UFS_CDNS_PLATFORM=y
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
CONFIG_SCSI_UFS_HISI=y
CONFIG_SCSI_UFS_TI_J721E=y
CONFIG_SCSI_UFS_EXYNOS=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=y
CONFIG_LEDS_CR0014114=y
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_TURRIS_OMNIA=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_S3C24XX is not set
# CONFIG_LEDS_COBALT_QUBE is not set
CONFIG_LEDS_COBALT_RAQ=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y
CONFIG_LEDS_SC27XX_BLTC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_PM8058 is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y
# CONFIG_LEDS_IP30 is not set
# CONFIG_LEDS_ACER_A500 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MAX77693=y
CONFIG_LEDS_MT6360=y
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
# CONFIG_INFINIBAND_USER_MAD is not set
CONFIG_INFINIBAND_USER_ACCESS=y
CONFIG_INFINIBAND_USER_MEM=y
# CONFIG_INFINIBAND_ON_DEMAND_PAGING is not set
# CONFIG_INFINIBAND_ADDR_TRANS is not set
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_MTHCA=y
CONFIG_INFINIBAND_MTHCA_DEBUG=y
# CONFIG_MLX4_INFINIBAND is not set
CONFIG_INFINIBAND_OCRDMA=y
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
CONFIG_RDMA_RXE=y
CONFIG_RDMA_SIW=y
CONFIG_INFINIBAND_IPOIB=y
CONFIG_INFINIBAND_IPOIB_CM=y
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_LIB_KUNIT_TEST=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_BRCMSTB=y
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_RK808 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BD70528 is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=y
CONFIG_RTC_DRV_PALMAS=y
# CONFIG_RTC_DRV_TPS6586X is not set
# CONFIG_RTC_DRV_RC5T583 is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_GAMECUBE is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_SC27XX=y
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_NTXEC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
CONFIG_RTC_DRV_DAVINCI=y
CONFIG_RTC_DRV_DIGICOLOR=y
CONFIG_RTC_DRV_FSL_FTM_ALARM=y
CONFIG_RTC_DRV_MESON=y
CONFIG_RTC_DRV_MESON_VRTC=y
# CONFIG_RTC_DRV_OMAP is not set
# CONFIG_RTC_DRV_S3C is not set
CONFIG_RTC_DRV_EP93XX=y
# CONFIG_RTC_DRV_VR41XX is not set
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_RTC_DRV_RZN1=y
# CONFIG_RTC_DRV_GENERIC is not set
CONFIG_RTC_DRV_VT8500=y
CONFIG_RTC_DRV_SUN6I=y
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=y
# CONFIG_RTC_DRV_ARMADA38X is not set
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_STMP is not set
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_JZ4740 is not set
# CONFIG_RTC_DRV_LPC24XX is not set
# CONFIG_RTC_DRV_LPC32XX is not set
CONFIG_RTC_DRV_PM8XXX=y
CONFIG_RTC_DRV_TEGRA=y
CONFIG_RTC_DRV_MXC=y
CONFIG_RTC_DRV_MXC_V2=y
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MOXART is not set
CONFIG_RTC_DRV_MT2712=y
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_MT7622=y
CONFIG_RTC_DRV_XGENE=y
CONFIG_RTC_DRV_R7301=y
CONFIG_RTC_DRV_STM32=y
# CONFIG_RTC_DRV_CPCAP is not set
CONFIG_RTC_DRV_RTD119X=y
# CONFIG_RTC_DRV_ASPEED is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_RTC_DRV_MSC313=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_PLATFORM=y
CONFIG_VFIO_AMBA=y
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
# CONFIG_VFIO_PLATFORM_AMDXGBE_RESET is not set
CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET=y
CONFIG_VFIO_MDEV=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=y
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=y
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
CONFIG_COMEDI_ADDI_APCI_3120=y
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
# CONFIG_COMEDI_AMPLC_PC263_PCI is not set
# CONFIG_COMEDI_AMPLC_PCI224 is not set
CONFIG_COMEDI_AMPLC_PCI230=y
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=y
CONFIG_COMEDI_MF6X4=y
CONFIG_COMEDI_ICP_MULTI=y
CONFIG_COMEDI_DAQBOARD2000=y
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
# CONFIG_COMEDI_ME_DAQ is not set
CONFIG_COMEDI_NI_6527=y
CONFIG_COMEDI_NI_65XX=y
# CONFIG_COMEDI_NI_660X is not set
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
# CONFIG_COMEDI_NI_PCIDIO is not set
# CONFIG_COMEDI_NI_PCIMIO is not set
CONFIG_COMEDI_RTD520=y
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
CONFIG_COMEDI_USBDUXFAST=y
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=y
# CONFIG_COMEDI_TESTS_NI_ROUTES is not set
CONFIG_STAGING=y
CONFIG_RTS5208=y
CONFIG_OCTEON_ETHERNET=y

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y
# CONFIG_ADE7854_SPI is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=y
CONFIG_STAGING_MEDIA=y
# CONFIG_VIDEO_HANTRO is not set
# CONFIG_VIDEO_IMX_MEDIA is not set
CONFIG_VIDEO_MAX96712=y
CONFIG_VIDEO_MESON_VDEC=y
CONFIG_VIDEO_OMAP4=y
CONFIG_VIDEO_ROCKCHIP_VDEC=y
# CONFIG_VIDEO_SUNXI is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_DVB_AV7110 is not set
CONFIG_STAGING_BOARD=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
# CONFIG_FB_TFT_BD663474 is not set
CONFIG_FB_TFT_HX8340BN=y
# CONFIG_FB_TFT_HX8347D is not set
CONFIG_FB_TFT_HX8353D=y
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=y
# CONFIG_FB_TFT_ILI9320 is not set
# CONFIG_FB_TFT_ILI9325 is not set
# CONFIG_FB_TFT_ILI9340 is not set
CONFIG_FB_TFT_ILI9341=y
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=y
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
CONFIG_FB_TFT_S6D1121=y
# CONFIG_FB_TFT_SEPS525 is not set
# CONFIG_FB_TFT_SH1106 is not set
# CONFIG_FB_TFT_SSD1289 is not set
CONFIG_FB_TFT_SSD1305=y
CONFIG_FB_TFT_SSD1306=y
CONFIG_FB_TFT_SSD1331=y
# CONFIG_FB_TFT_SSD1351 is not set
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=y
# CONFIG_FB_TFT_UC1701 is not set
CONFIG_FB_TFT_UPD161704=y
# CONFIG_MOST_COMPONENTS is not set
CONFIG_BCM_VIDEOCORE=y
CONFIG_BCM2835_VCHIQ=y
# CONFIG_VCHIQ_CDEV is not set
CONFIG_SND_BCM2835=y
# CONFIG_VIDEO_BCM2835 is not set
CONFIG_BCM2835_VCHIQ_MMAL=y
# CONFIG_PI433 is not set
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
CONFIG_QLGE=y

#
# VME Device Drivers
#
CONFIG_VME_USER=y
# CONFIG_GOLDFISH is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CROS_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
# CONFIG_MLXREG_IO is not set
CONFIG_MLXREG_LC=y
CONFIG_NVSW_SN2201=y
CONFIG_OLPC_EC=y
CONFIG_OLPC_XO175=y
CONFIG_OLPC_XO175_EC=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

CONFIG_CLK_HSDK=y
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_APPLE_NCO=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_HI655X=y
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_EN7523 is not set
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
CONFIG_COMMON_CLK_FSL_SAI=y
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_AXI_CLKGEN=y
# CONFIG_CLK_QORIQ is not set
CONFIG_CLK_LS1028A_PLLDIG=y
CONFIG_COMMON_CLK_XGENE=y
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_OXNAS=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_MMP2_AUDIO=y
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_ACTIONS=y
CONFIG_CLK_OWL_S500=y
CONFIG_CLK_OWL_S700=y
# CONFIG_CLK_OWL_S900 is not set
CONFIG_CLK_BAIKAL_T1=y
CONFIG_CLK_BT1_CCU_PLL=y
CONFIG_CLK_BT1_CCU_DIV=y
CONFIG_CLK_BCM2711_DVP=y
CONFIG_CLK_BCM2835=y
CONFIG_CLK_BCM_63XX=y
# CONFIG_CLK_BCM_63XX_GATE is not set
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
CONFIG_CLK_BCM_SR=y
# CONFIG_CLK_RASPBERRYPI is not set
# CONFIG_COMMON_CLK_HI3516CV300 is not set
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
CONFIG_COMMON_CLK_HI3660=y
# CONFIG_COMMON_CLK_HI3670 is not set
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
CONFIG_CLK_IMX8MP=y
CONFIG_CLK_IMX8MQ=y
CONFIG_CLK_IMX8ULP=y
CONFIG_CLK_IMX93=y

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
CONFIG_INGENIC_CGU_JZ4725B=y
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
# CONFIG_COMMON_CLK_MT2712_IMGSYS is not set
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
CONFIG_COMMON_CLK_MT2712_MFGCFG=y
CONFIG_COMMON_CLK_MT2712_MMSYS=y
CONFIG_COMMON_CLK_MT2712_VDECSYS=y
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
# CONFIG_COMMON_CLK_MT6765 is not set
CONFIG_COMMON_CLK_MT6779=y
# CONFIG_COMMON_CLK_MT6779_MMSYS is not set
# CONFIG_COMMON_CLK_MT6779_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6779_IPESYS is not set
# CONFIG_COMMON_CLK_MT6779_CAMSYS is not set
# CONFIG_COMMON_CLK_MT6779_VDECSYS is not set
CONFIG_COMMON_CLK_MT6779_VENCSYS=y
CONFIG_COMMON_CLK_MT6779_MFGCFG=y
CONFIG_COMMON_CLK_MT6779_AUDSYS=y
CONFIG_COMMON_CLK_MT6797=y
CONFIG_COMMON_CLK_MT6797_MMSYS=y
# CONFIG_COMMON_CLK_MT6797_IMGSYS is not set
CONFIG_COMMON_CLK_MT6797_VDECSYS=y
# CONFIG_COMMON_CLK_MT6797_VENCSYS is not set
CONFIG_COMMON_CLK_MT7622=y
CONFIG_COMMON_CLK_MT7622_ETHSYS=y
CONFIG_COMMON_CLK_MT7622_HIFSYS=y
# CONFIG_COMMON_CLK_MT7622_AUDSYS is not set
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
CONFIG_COMMON_CLK_MT7986_ETHSYS=y
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
# CONFIG_COMMON_CLK_MT8192_AUDSYS is not set
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
# CONFIG_COMMON_CLK_MT8192_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
CONFIG_COMMON_CLK_MT8192_MFGCFG=y
CONFIG_COMMON_CLK_MT8192_MMSYS=y
CONFIG_COMMON_CLK_MT8192_MSDC=y
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
CONFIG_MCHP_CLK_MPFS=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_QCOM_GDSC=y
CONFIG_QCOM_RPMCC=y
CONFIG_COMMON_CLK_QCOM=y
CONFIG_QCOM_A53PLL=y
CONFIG_QCOM_A7PLL=y
CONFIG_QCOM_CLK_APCS_MSM8916=y
CONFIG_QCOM_CLK_APCS_SDX55=y
CONFIG_QCOM_CLK_SMD_RPM=y
CONFIG_QCOM_CLK_RPMH=y
CONFIG_APQ_GCC_8084=y
# CONFIG_APQ_MMCC_8084 is not set
CONFIG_IPQ_APSS_PLL=y
# CONFIG_IPQ_APSS_6018 is not set
# CONFIG_IPQ_GCC_4019 is not set
# CONFIG_IPQ_GCC_6018 is not set
CONFIG_IPQ_GCC_806X=y
CONFIG_IPQ_LCC_806X=y
# CONFIG_IPQ_GCC_8074 is not set
# CONFIG_MSM_GCC_8660 is not set
CONFIG_MSM_GCC_8916=y
CONFIG_MSM_GCC_8939=y
CONFIG_MSM_GCC_8960=y
CONFIG_MSM_LCC_8960=y
CONFIG_MDM_GCC_9607=y
CONFIG_MDM_GCC_9615=y
CONFIG_MDM_LCC_9615=y
# CONFIG_MSM_MMCC_8960 is not set
CONFIG_MSM_GCC_8953=y
CONFIG_MSM_GCC_8974=y
CONFIG_MSM_MMCC_8974=y
# CONFIG_MSM_GCC_8976 is not set
CONFIG_MSM_MMCC_8994=y
CONFIG_MSM_GCC_8994=y
CONFIG_MSM_GCC_8996=y
CONFIG_MSM_MMCC_8996=y
CONFIG_MSM_GCC_8998=y
CONFIG_MSM_GPUCC_8998=y
# CONFIG_MSM_MMCC_8998 is not set
CONFIG_QCM_GCC_2290=y
CONFIG_QCM_DISPCC_2290=y
CONFIG_QCS_GCC_404=y
# CONFIG_SC_CAMCC_7180 is not set
CONFIG_SC_CAMCC_7280=y
# CONFIG_SC_DISPCC_7180 is not set
CONFIG_SC_DISPCC_7280=y
CONFIG_SC_GCC_7180=y
CONFIG_SC_GCC_7280=y
# CONFIG_SC_GCC_8180X is not set
CONFIG_SC_GCC_8280XP=y
# CONFIG_SC_GPUCC_7180 is not set
# CONFIG_SC_GPUCC_7280 is not set
# CONFIG_SC_LPASSCC_7280 is not set
CONFIG_SC_LPASS_CORECC_7180=y
CONFIG_SC_LPASS_CORECC_7280=y
CONFIG_SC_MSS_7180=y
CONFIG_SC_VIDEOCC_7180=y
CONFIG_SC_VIDEOCC_7280=y
# CONFIG_SDM_CAMCC_845 is not set
CONFIG_SDM_GCC_660=y
CONFIG_SDM_MMCC_660=y
# CONFIG_SDM_GPUCC_660 is not set
# CONFIG_QCS_TURING_404 is not set
# CONFIG_QCS_Q6SSTOP_404 is not set
CONFIG_SDM_GCC_845=y
CONFIG_SDM_GPUCC_845=y
CONFIG_SDM_VIDEOCC_845=y
CONFIG_SDM_DISPCC_845=y
# CONFIG_SDM_LPASSCC_845 is not set
CONFIG_SDX_GCC_55=y
CONFIG_SDX_GCC_65=y
# CONFIG_SM_CAMCC_8250 is not set
# CONFIG_SM_DISPCC_6125 is not set
CONFIG_SM_DISPCC_8250=y
CONFIG_SM_DISPCC_6350=y
CONFIG_SM_GCC_6115=y
CONFIG_SM_GCC_6125=y
CONFIG_SM_GCC_6350=y
CONFIG_SM_GCC_8150=y
CONFIG_SM_GCC_8250=y
# CONFIG_SM_GCC_8350 is not set
CONFIG_SM_GCC_8450=y
CONFIG_SM_GPUCC_6350=y
CONFIG_SM_GPUCC_8150=y
CONFIG_SM_GPUCC_8250=y
CONFIG_SM_VIDEOCC_8150=y
CONFIG_SM_VIDEOCC_8250=y
CONFIG_SPMI_PMIC_CLKDIV=y
CONFIG_QCOM_HFPLL=y
CONFIG_KPSS_XCC=y
CONFIG_CLK_GFM_LPASS_SM8250=y
CONFIG_CLK_MT7621=y
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
CONFIG_S5PV210_COMMON_CLK=y
CONFIG_EXYNOS_3250_COMMON_CLK=y
CONFIG_EXYNOS_4_COMMON_CLK=y
CONFIG_EXYNOS_5250_COMMON_CLK=y
# CONFIG_EXYNOS_5260_COMMON_CLK is not set
CONFIG_EXYNOS_5410_COMMON_CLK=y
CONFIG_EXYNOS_5420_COMMON_CLK=y
# CONFIG_EXYNOS_ARM64_COMMON_CLK is not set
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
CONFIG_EXYNOS_CLKOUT=y
CONFIG_S3C2410_COMMON_CLK=y
CONFIG_S3C2412_COMMON_CLK=y
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
# CONFIG_CLK_INTEL_SOCFPGA64 is not set
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
# CONFIG_SUNXI_CCU is not set
CONFIG_COMMON_CLK_TI_ADPLL=y
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
CONFIG_COMMON_CLK_ZYNQMP=y
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
# CONFIG_DIGICOLOR_TIMER is not set
CONFIG_DW_APB_TIMER=y
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_MESON6_TIMER is not set
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
CONFIG_SUN5I_HSTIMER=y
CONFIG_TEGRA_TIMER=y
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
CONFIG_CADENCE_TTC_TIMER=y
# CONFIG_ASM9260_TIMER is not set
CONFIG_CLKSRC_DBX500_PRCMU=y
CONFIG_CLPS711X_TIMER=y
CONFIG_MXS_TIMER=y
# CONFIG_NSPIRE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_PISTACHIO=y
# CONFIG_CLKSRC_STM32_LP is not set
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
CONFIG_FSL_FTM_TIMER=y
CONFIG_OXNAS_RPS_TIMER=y
# CONFIG_MTK_TIMER is not set
# CONFIG_SPRD_TIMER is not set
CONFIG_CLKSRC_JCORE_PIT=y
CONFIG_SH_TIMER_CMT=y
# CONFIG_SH_TIMER_MTU2 is not set
CONFIG_RENESAS_OSTM=y
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_CLKSRC_PXA=y
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
CONFIG_GXP_TIMER=y
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_IMX_MBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_ARMADA_37XX_RWTM_MBOX is not set
CONFIG_ROCKCHIP_MBOX=y
CONFIG_ALTERA_MBOX=y
CONFIG_HI3660_MBOX=y
CONFIG_HI6220_MBOX=y
# CONFIG_MAILBOX_TEST is not set
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
# CONFIG_QCOM_APCS_IPC is not set
CONFIG_BCM_PDC_MBOX=y
# CONFIG_STM32_IPCC is not set
CONFIG_MTK_ADSP_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
CONFIG_OMAP_IOMMU=y
# CONFIG_OMAP_IOMMU_DEBUG is not set
# CONFIG_ROCKCHIP_IOMMU is not set
# CONFIG_SUN50I_IOMMU is not set
CONFIG_S390_CCW_IOMMU=y
CONFIG_S390_AP_IOMMU=y
CONFIG_MTK_IOMMU=y
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
CONFIG_INGENIC_VPU_RPROC=y
CONFIG_MTK_SCP=y
# CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
CONFIG_RCAR_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_MTK_SCP=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_RTKIT is not set
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
# CONFIG_ASPEED_LPC_SNOOP is not set
CONFIG_ASPEED_UART_ROUTING=y
CONFIG_ASPEED_P2A_CTRL=y
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=y
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
CONFIG_MTK_SCPSYS=y
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_COMMAND_DB=y
# CONFIG_QCOM_GENI_SE is not set
CONFIG_QCOM_GSBI=y
CONFIG_QCOM_LLCC=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_RPMHPD is not set
# CONFIG_QCOM_RPMPD is not set
CONFIG_QCOM_SMD_RPM=y
CONFIG_QCOM_SPM=y
CONFIG_QCOM_WCNSS_CTRL=y
# CONFIG_QCOM_APR is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
CONFIG_RST_RCAR=y
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_RCAR_GEN4=y
CONFIG_SYSC_R8A77995=y
CONFIG_SYSC_R8A7794=y
CONFIG_SYSC_R8A77990=y
# CONFIG_SYSC_R8A7779 is not set
# CONFIG_SYSC_R8A7790 is not set
CONFIG_SYSC_R8A7795=y
# CONFIG_SYSC_R8A7791 is not set
CONFIG_SYSC_R8A77965=y
# CONFIG_SYSC_R8A77960 is not set
CONFIG_SYSC_R8A77961=y
# CONFIG_SYSC_R8A779F0 is not set
# CONFIG_SYSC_R8A7792 is not set
# CONFIG_SYSC_R8A77980 is not set
CONFIG_SYSC_R8A77970=y
CONFIG_SYSC_R8A779A0=y
CONFIG_SYSC_R8A779G0=y
# CONFIG_SYSC_RMOBILE is not set
# CONFIG_SYSC_R8A77470 is not set
# CONFIG_SYSC_R8A7745 is not set
# CONFIG_SYSC_R8A7742 is not set
# CONFIG_SYSC_R8A7743 is not set
CONFIG_SYSC_R8A774C0=y
# CONFIG_SYSC_R8A774E1 is not set
# CONFIG_SYSC_R8A774A1 is not set
CONFIG_SYSC_R8A774B1=y
# CONFIG_ROCKCHIP_GRF is not set
CONFIG_ROCKCHIP_IODOMAIN=y
CONFIG_SOC_SAMSUNG=y
CONFIG_EXYNOS_ASV_ARM=y
CONFIG_EXYNOS_CHIPID=y
CONFIG_EXYNOS_USI=y
CONFIG_EXYNOS_PM_DOMAINS=y
CONFIG_EXYNOS_REGULATOR_COUPLER=y
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
CONFIG_ARM_IMX_BUS_DEVFREQ=y
CONFIG_ARM_TEGRA_DEVFREQ=y
CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=y
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
# CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU is not set
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_QCOM_SPMI_MISC=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_DDR=y
CONFIG_ATMEL_SDRAMC=y
# CONFIG_ATMEL_EBI is not set
CONFIG_BRCMSTB_DPFE=y
CONFIG_BT1_L2_CTL=y
# CONFIG_TI_AEMIF is not set
CONFIG_TI_EMIF=y
CONFIG_OMAP_GPMC=y
# CONFIG_OMAP_GPMC_DEBUG is not set
# CONFIG_MVEBU_DEVBUS is not set
CONFIG_FSL_CORENET_CF=y
CONFIG_FSL_IFC=y
CONFIG_JZ4780_NEMC=y
CONFIG_MTK_SMI=y
CONFIG_DA8XX_DDRCTL=y
CONFIG_RENESAS_RPCIF=y
CONFIG_STM32_FMC2_EBI=y
CONFIG_SAMSUNG_MC=y
CONFIG_EXYNOS5422_DMC=y
CONFIG_EXYNOS_SROM=y
# CONFIG_TEGRA_MC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16209=y
CONFIG_ADXL313=y
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=y
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
CONFIG_ADXL367=y
CONFIG_ADXL367_SPI=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
# CONFIG_SCA3300 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
# CONFIG_AD7192 is not set
CONFIG_AD7266=y
CONFIG_AD7280=y
CONFIG_AD7291=y
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=y
# CONFIG_AD7780 is not set
CONFIG_AD7791=y
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
# CONFIG_AD7949 is not set
CONFIG_AD799X=y
CONFIG_AD9467=y
CONFIG_ADI_AXI_ADC=y
CONFIG_ASPEED_ADC=y
# CONFIG_AT91_ADC is not set
CONFIG_AT91_SAMA5D2_ADC=y
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
CONFIG_CC10001_ADC=y
# CONFIG_CPCAP_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_EXYNOS_ADC=y
CONFIG_MXS_LRADC_ADC=y
# CONFIG_HI8435 is not set
CONFIG_HX711=y
# CONFIG_INA2XX_ADC is not set
CONFIG_INGENIC_ADC=y
# CONFIG_IMX7D_ADC is not set
CONFIG_IMX8QXP_ADC=y
CONFIG_LP8788_ADC=y
# CONFIG_LPC18XX_ADC is not set
CONFIG_LPC32XX_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2496=y
CONFIG_LTC2497=y
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
# CONFIG_MEDIATEK_MT6360_ADC is not set
CONFIG_MEDIATEK_MT6577_AUXADC=y
CONFIG_MEN_Z188_ADC=y
# CONFIG_MESON_SARADC is not set
CONFIG_MP2629_ADC=y
CONFIG_NAU7802=y
# CONFIG_NPCM_ADC is not set
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_PM8XXX_XOADC=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_RCAR_GYRO_ADC=y
CONFIG_ROCKCHIP_SARADC=y
# CONFIG_RZG2L_ADC is not set
CONFIG_SC27XX_ADC=y
# CONFIG_SPEAR_ADC is not set
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STM32_ADC_CORE=y
CONFIG_STM32_ADC=y
# CONFIG_STM32_DFSDM_CORE is not set
# CONFIG_STM32_DFSDM_ADC is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8344=y
CONFIG_TI_ADS8688=y
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_ADS131E08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
# CONFIG_TI_TSC2046 is not set
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
CONFIG_XILINX_XADC=y
CONFIG_XILINX_AMS=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_ADA4250=y
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD30_SERIAL=y
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=y
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# CONFIG_IIO_SCMI is not set
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC2688=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
CONFIG_AD5758=y
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
CONFIG_AD5791=y
# CONFIG_AD7293 is not set
CONFIG_AD7303=y
# CONFIG_AD8801 is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
# CONFIG_LPC18XX_DAC is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
CONFIG_STM32_DAC=y
CONFIG_STM32_DAC_CORE=y
CONFIG_TI_DAC082S085=y
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
# CONFIG_ADF4371 is not set
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV4420 is not set
CONFIG_ADRF6780=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
CONFIG_ADXRS290=y
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_HID_SENSOR_GYRO_3D=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_FXOS8700_SPI=y
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
CONFIG_INV_MPU6050_IIO=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=y
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2591=y
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
# CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
# CONFIG_IIO_ST_MAGN_SPI_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

# CONFIG_IIO_TEST_FORMAT is not set

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
CONFIG_IIO_STM32_TIMER_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MAX5432=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
# CONFIG_DLHL60D is not set
CONFIG_DPS310=y
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_ATMEL_TCB is not set
CONFIG_PWM_BCM_IPROC=y
CONFIG_PWM_BCM_KONA=y
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=y
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLPS711X is not set
CONFIG_PWM_DWC=y
CONFIG_PWM_EP93XX=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
CONFIG_PWM_IMX1=y
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_IQS620A=y
CONFIG_PWM_JZ4740=y
# CONFIG_PWM_KEEMBAY is not set
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPC18XX_SCT=y
# CONFIG_PWM_LPC32XX is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MESON is not set
CONFIG_PWM_MTK_DISP=y
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MXS is not set
CONFIG_PWM_NTXEC=y
# CONFIG_PWM_OMAP_DMTIMER is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
CONFIG_PWM_RCAR=y
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=y
CONFIG_PWM_SAMSUNG=y
CONFIG_PWM_SIFIVE=y
CONFIG_PWM_SL28CPLD=y
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=y
CONFIG_PWM_STI=y
CONFIG_PWM_STM32=y
CONFIG_PWM_STM32_LP=y
# CONFIG_PWM_SUN4I is not set
CONFIG_PWM_SUNPLUS=y
# CONFIG_PWM_TEGRA is not set
CONFIG_PWM_TIECAP=y
CONFIG_PWM_TIEHRPWM=y
CONFIG_PWM_TWL=y
# CONFIG_PWM_TWL_LED is not set
CONFIG_PWM_VISCONTI=y
# CONFIG_PWM_VT8500 is not set
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
CONFIG_OR1K_PIC=y
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
CONFIG_XILINX_INTC=y
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=y
CONFIG_IMX_IRQSTEER=y
CONFIG_IMX_INTMUX=y
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_LOONGSON_PCH_MSI is not set
# CONFIG_MST_IRQ is not set
CONFIG_MCHP_EIC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
CONFIG_RESET_AXS10X=y
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
CONFIG_RESET_MESON_AUDIO_ARB=y
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
CONFIG_RESET_QCOM_AOSS=y
CONFIG_RESET_QCOM_PDC=y
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
CONFIG_RESET_UNIPHIER_GLUE=y
CONFIG_RESET_ZYNQ=y
# CONFIG_COMMON_RESET_HI3660 is not set
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=y
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y
CONFIG_PHY_SUN4I_USB=y
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set
CONFIG_PHY_SUN50I_USB3=y
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON8B_USB2 is not set
CONFIG_PHY_MESON_GXL_USB2=y
# CONFIG_PHY_MESON_G12A_USB2 is not set
CONFIG_PHY_MESON_G12A_USB3_PCIE=y
# CONFIG_PHY_MESON_AXG_PCIE is not set
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
# CONFIG_PHY_CYGNUS_PCIE is not set
CONFIG_PHY_BCM_SR_USB=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_BCM_NS_USB2=y
# CONFIG_PHY_BCM_NS_USB3 is not set
# CONFIG_PHY_NS2_PCIE is not set
CONFIG_PHY_NS2_USB_DRD=y
# CONFIG_PHY_BRCM_SATA is not set
CONFIG_PHY_BRCM_USB=y
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_MIPI_DPHY=y
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
CONFIG_PHY_FSL_LYNX_28G=y
# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
CONFIG_PHY_HISI_INNO_USB2=y
# CONFIG_PHY_INGENIC_USB is not set
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
CONFIG_PHY_LANTIQ_RCU_USB2=y
CONFIG_ARMADA375_USBCLUSTER_PHY=y
CONFIG_PHY_BERLIN_SATA=y
CONFIG_PHY_BERLIN_USB=y
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
CONFIG_PHY_MVEBU_CP110_UTMI=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_PXA_USB=y
# CONFIG_PHY_MMP3_USB is not set
CONFIG_PHY_MMP3_HSIC=y
CONFIG_PHY_MTK_TPHY=y
CONFIG_PHY_MTK_UFS=y
CONFIG_PHY_MTK_XSPHY=y
CONFIG_PHY_MTK_HDMI=y
CONFIG_PHY_MTK_MIPI_DSI=y
CONFIG_PHY_SPARX5_SERDES=y
CONFIG_PHY_LAN966X_SERDES=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MAPPHONE_MDM6600=y
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_ATH79_USB=y
CONFIG_PHY_QCOM_EDP=y
CONFIG_PHY_QCOM_IPQ4019_USB=y
# CONFIG_PHY_QCOM_PCIE2 is not set
CONFIG_PHY_QCOM_QMP=y
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
CONFIG_PHY_QCOM_USB_HS_28NM=y
# CONFIG_PHY_QCOM_USB_SS is not set
CONFIG_PHY_QCOM_IPQ806X_USB=y
CONFIG_PHY_MT7621_PCI=y
CONFIG_PHY_RALINK_USB=y
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
CONFIG_PHY_ROCKCHIP_INNO_USB2=y
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=y
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
CONFIG_PHY_ROCKCHIP_PCIE=y
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
CONFIG_PHY_EXYNOS_DP_VIDEO=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
CONFIG_PHY_SAMSUNG_UFS=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_UNIPHIER_USB2=y
# CONFIG_PHY_UNIPHIER_USB3 is not set
CONFIG_PHY_UNIPHIER_PCIE=y
CONFIG_PHY_UNIPHIER_AHCI=y
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
CONFIG_PHY_STIH407_USB=y
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_DM816X_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
CONFIG_PHY_TI_GMII_SEL=y
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
CONFIG_PHY_INTEL_KEEMBAY_USB=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y
# CONFIG_RAS is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_KUNIT_TEST=y
CONFIG_USB4_DMA_TEST=y

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=y
CONFIG_NVMEM_IMX_OCOTP=y
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=y
# CONFIG_NVMEM_LPC18XX_OTP is not set
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_QCOM_QFPROM is not set
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
CONFIG_NVMEM_STM32_ROMEM=y
# CONFIG_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
CONFIG_NVMEM_LAYERSCAPE_SFP=y
CONFIG_NVMEM_SUNPLUS_OCOTP=y
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
CONFIG_INTERCONNECT_SAMSUNG=y
CONFIG_INTERCONNECT_EXYNOS=y
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_SND is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_PECI_ASPEED=y
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=y
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
CONFIG_OCFS2_DEBUG_FS=y
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
# CONFIG_DLM_DEBUG is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TEE=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_STATS=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BTREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_DMA=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=y
CONFIG_OBJAGG=y
# end of Library routines

CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
# CONFIG_NET_NS_REFCNT_TRACKER is not set
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_SLAB=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_NOP_TRACER=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_SYNTH_EVENTS=y
CONFIG_USER_EVENTS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# openrisc Debugging
#
# end of openrisc Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--gF/081Jhk0FnYx9M--
