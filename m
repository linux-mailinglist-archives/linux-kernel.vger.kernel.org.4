Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D669A8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBQKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBQKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:07:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB315ECAA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676628428; x=1708164428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bp2ZwgTbVmS8uj/vpGLRzoyOMBO2zLtjxhIe9Y357bo=;
  b=NfXXHpWOuG5tkMUMLm5d1IKhbutS0iZauAqP1ejh98vGX8aNAQC2lOHR
   SfgpMW2RdM3Ows1AcBPCbRGy56+rMUIrR3gVoer/ueS42LlcgGbhScsTH
   SZ71llKGHB1g0DDimUzaoFNiG8y+2G07JeElUjFrEOeoSwafB70ZWzwee
   zxAu5DHOIa/6y2jRAQZruGmYoxeTqwKlleDw77e6YLIOF6lbDD2ZgMbai
   XeJG6kxSmLUX2GNDDRUHPBB5/E2dMoc+Za3k2N3AYWVux4Rynk9P+ib1U
   RnU8+tNqwxqoEizD8EyVS/Qvkan08Z0X7Zg7gGExjt0++/doVsuCgGrN0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="320060445"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="320060445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 02:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="700850578"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="700850578"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2023 02:07:06 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSxdx-000BJV-39;
        Fri, 17 Feb 2023 10:07:05 +0000
Date:   Fri, 17 Feb 2023 18:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/brocade/bna/bnad.c:2918:41: warning: variable
 'unmap' set but not used
Message-ID: <202302171856.VFtt4Vbn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ec35307e18ba8174e2a3f701956059f6a36f22fb
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   7 months ago
config: openrisc-buildonly-randconfig-r002-20230217 (https://download.01.org/0day-ci/archive/20230217/202302171856.VFtt4Vbn-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ded2ee36313c941f1a12b6f85cde295b575264ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ded2ee36313c941f1a12b6f85cde295b575264ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/net/ethernet/brocade/bna/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171856.VFtt4Vbn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/brocade/bna/bnad.c: In function 'bnad_start_xmit':
>> drivers/net/ethernet/brocade/bna/bnad.c:2918:41: warning: variable 'unmap' set but not used [-Wunused-but-set-variable]
    2918 |         struct bnad_tx_unmap *unmap_q, *unmap, *head_unmap;
         |                                         ^~~~~


vim +/unmap +2918 drivers/net/ethernet/brocade/bna/bnad.c

5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2907  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2908  /*
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2909   * bnad_start_xmit : Netdev entry point for Transmit
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2910   *		     Called under lock held by net_device
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2911   */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2912  static netdev_tx_t
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2913  bnad_start_xmit(struct sk_buff *skb, struct net_device *netdev)
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2914  {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2915  	struct bnad *bnad = netdev_priv(netdev);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2916  	u32 txq_id = 0;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2917  	struct bna_tcb *tcb = NULL;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11 @2918  	struct bnad_tx_unmap *unmap_q, *unmap, *head_unmap;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2919  	u32		prod, q_depth, vect_id;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2920  	u32		wis, vectors, len;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2921  	int		i;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2922  	dma_addr_t		dma_addr;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2923  	struct bna_txq_entry *txqent;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2924  
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  2925  	len = skb_headlen(skb);
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  2926  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2927  	/* Sanity checks for the skb */
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  2928  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2929  	if (unlikely(skb->len <= ETH_HLEN)) {
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  2930  		dev_kfree_skb_any(skb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2931  		BNAD_UPDATE_CTR(bnad, tx_skb_too_short);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2932  		return NETDEV_TX_OK;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2933  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2934  	if (unlikely(len > BFI_TX_MAX_DATA_PER_VECTOR)) {
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  2935  		dev_kfree_skb_any(skb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2936  		BNAD_UPDATE_CTR(bnad, tx_skb_headlen_zero);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2937  		return NETDEV_TX_OK;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2938  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2939  	if (unlikely(len == 0)) {
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  2940  		dev_kfree_skb_any(skb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2941  		BNAD_UPDATE_CTR(bnad, tx_skb_headlen_zero);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2942  		return NETDEV_TX_OK;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2943  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2944  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2945  	tcb = bnad->tx_info[0].tcb[txq_id];
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2946  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2947  	/*
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2948  	 * Takes care of the Tx that is scheduled between clearing the flag
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2949  	 * and the netif_tx_stop_all_queues() call.
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2950  	 */
96e31adf8d73f1 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  2951  	if (unlikely(!tcb || !test_bit(BNAD_TXQ_TX_STARTED, &tcb->flags))) {
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  2952  		dev_kfree_skb_any(skb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2953  		BNAD_UPDATE_CTR(bnad, tx_skb_stopping);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2954  		return NETDEV_TX_OK;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2955  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2956  
96e31adf8d73f1 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  2957  	q_depth = tcb->q_depth;
96e31adf8d73f1 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  2958  	prod = tcb->producer_index;
96e31adf8d73f1 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  2959  	unmap_q = tcb->unmap_q;
96e31adf8d73f1 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  2960  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2961  	vectors = 1 + skb_shinfo(skb)->nr_frags;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2962  	wis = BNA_TXQ_WI_NEEDED(vectors);	/* 4 vectors per work item */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2963  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2964  	if (unlikely(vectors > BFI_TX_MAX_VECTORS_PER_PKT)) {
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  2965  		dev_kfree_skb_any(skb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2966  		BNAD_UPDATE_CTR(bnad, tx_skb_max_vectors);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2967  		return NETDEV_TX_OK;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2968  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2969  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2970  	/* Check for available TxQ resources */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2971  	if (unlikely(wis > BNA_QE_FREE_CNT(tcb, q_depth))) {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2972  		if ((*tcb->hw_consumer_index != tcb->consumer_index) &&
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2973  		    !test_and_set_bit(BNAD_TXQ_FREE_SENT, &tcb->flags)) {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2974  			u32 sent;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2975  			sent = bnad_txcmpl_process(bnad, tcb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2976  			if (likely(test_bit(BNAD_TXQ_TX_STARTED, &tcb->flags)))
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2977  				bna_ib_ack(tcb->i_dbell, sent);
4e857c58efeb99 drivers/net/ethernet/brocade/bna/bnad.c Peter Zijlstra          2014-03-17  2978  			smp_mb__before_atomic();
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2979  			clear_bit(BNAD_TXQ_FREE_SENT, &tcb->flags);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2980  		} else {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2981  			netif_stop_queue(netdev);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2982  			BNAD_UPDATE_CTR(bnad, netif_queue_stop);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2983  		}
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  2984  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2985  		smp_mb();
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2986  		/*
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2987  		 * Check again to deal with race condition between
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2988  		 * netif_stop_queue here, and netif_wake_queue in
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2989  		 * interrupt handler which is not inside netif tx lock.
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2990  		 */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2991  		if (likely(wis > BNA_QE_FREE_CNT(tcb, q_depth))) {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2992  			BNAD_UPDATE_CTR(bnad, netif_queue_stop);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2993  			return NETDEV_TX_BUSY;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2994  		} else {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2995  			netif_wake_queue(netdev);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2996  			BNAD_UPDATE_CTR(bnad, netif_queue_wakeup);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2997  		}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2998  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  2999  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3000  	txqent = &((struct bna_txq_entry *)tcb->sw_q)[prod];
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3001  	head_unmap = &unmap_q[prod];
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3002  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3003  	/* Program the opcode, flags, frame_len, num_vectors in WI */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3004  	if (bnad_txq_wi_prepare(bnad, tcb, skb, txqent)) {
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  3005  		dev_kfree_skb_any(skb);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3006  		return NETDEV_TX_OK;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3007  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3008  	txqent->hdr.wi.reserved = 0;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3009  	txqent->hdr.wi.num_vectors = vectors;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3010  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3011  	head_unmap->skb = skb;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3012  	head_unmap->nvecs = 0;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3013  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3014  	/* Program the vectors */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3015  	unmap = head_unmap;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3016  	dma_addr = dma_map_single(&bnad->pcidev->dev, skb->data,
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3017  				  len, DMA_TO_DEVICE);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3018  	if (dma_mapping_error(&bnad->pcidev->dev, dma_addr)) {
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3019  		dev_kfree_skb_any(skb);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3020  		BNAD_UPDATE_CTR(bnad, tx_skb_map_failed);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3021  		return NETDEV_TX_OK;
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3022  	}
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3023  	BNA_SET_DMA_ADDR(dma_addr, &txqent->vector[0].host_addr);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3024  	txqent->vector[0].length = htons(len);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3025  	dma_unmap_addr_set(&unmap->vectors[0], dma_addr, dma_addr);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3026  	head_unmap->nvecs++;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3027  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3028  	for (i = 0, vect_id = 0; i < vectors - 1; i++) {
d7840976e39156 drivers/net/ethernet/brocade/bna/bnad.c Matthew Wilcox (Oracle  2019-07-22  3029) 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
24f5d33d42d648 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  3030  		u32		size = skb_frag_size(frag);
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3031  
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3032  		if (unlikely(size == 0)) {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3033  			/* Undo the changes starting at tcb->producer_index */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3034  			bnad_tx_buff_unmap(bnad, unmap_q, q_depth,
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3035  				tcb->producer_index);
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  3036  			dev_kfree_skb_any(skb);
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3037  			BNAD_UPDATE_CTR(bnad, tx_skb_frag_zero);
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3038  			return NETDEV_TX_OK;
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3039  		}
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3040  
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3041  		len += size;
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3042  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3043  		vect_id++;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3044  		if (vect_id == BFI_TX_MAX_VECTORS_PER_WI) {
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3045  			vect_id = 0;
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3046  			BNA_QE_INDX_INC(prod, q_depth);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3047  			txqent = &((struct bna_txq_entry *)tcb->sw_q)[prod];
b779d0afccffac drivers/net/ethernet/brocade/bna/bnad.c Joe Perches             2014-03-12  3048  			txqent->hdr.wi_ext.opcode = htons(BNA_TXQ_WI_EXTENSION);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3049  			unmap = &unmap_q[prod];
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3050  		}
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3051  
4d5b1a674e3426 drivers/net/ethernet/brocade/bna/bnad.c Ian Campbell            2011-08-29  3052  		dma_addr = skb_frag_dma_map(&bnad->pcidev->dev, frag,
4d5b1a674e3426 drivers/net/ethernet/brocade/bna/bnad.c Ian Campbell            2011-08-29  3053  					    0, size, DMA_TO_DEVICE);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3054  		if (dma_mapping_error(&bnad->pcidev->dev, dma_addr)) {
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3055  			/* Undo the changes starting at tcb->producer_index */
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3056  			bnad_tx_buff_unmap(bnad, unmap_q, q_depth,
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3057  					   tcb->producer_index);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3058  			dev_kfree_skb_any(skb);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3059  			BNAD_UPDATE_CTR(bnad, tx_skb_map_failed);
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3060  			return NETDEV_TX_OK;
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3061  		}
ba5ca7848be05d drivers/net/ethernet/brocade/bna/bnad.c Ivan Vecera             2015-09-16  3062  
ecca6a968fc454 drivers/net/ethernet/brocade/bna/bnad.c David S. Miller         2014-01-06  3063  		dma_unmap_len_set(&unmap->vectors[vect_id], dma_len, size);
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3064  		BNA_SET_DMA_ADDR(dma_addr, &txqent->vector[vect_id].host_addr);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3065  		txqent->vector[vect_id].length = htons(size);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3066  		dma_unmap_addr_set(&unmap->vectors[vect_id], dma_addr,
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3067  				   dma_addr);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3068  		head_unmap->nvecs++;
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3069  	}
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3070  
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3071  	if (unlikely(len != skb->len)) {
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3072  		/* Undo the changes starting at tcb->producer_index */
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3073  		bnad_tx_buff_unmap(bnad, unmap_q, q_depth, tcb->producer_index);
27400df8e92b0e drivers/net/ethernet/brocade/bna/bnad.c Eric W. Biederman       2014-03-15  3074  		dev_kfree_skb_any(skb);
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3075  		BNAD_UPDATE_CTR(bnad, tx_skb_len_mismatch);
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3076  		return NETDEV_TX_OK;
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3077  	}
271e8b79470002 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2011-08-30  3078  
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3079  	BNA_QE_INDX_INC(prod, q_depth);
5216562a2ccd03 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2012-12-11  3080  	tcb->producer_index = prod;
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3081  
d667f78514c656 drivers/net/ethernet/brocade/bna/bnad.c Benjamin Poirier        2016-11-07  3082  	wmb();
be7fa3263a15d3 drivers/net/bna/bnad.c                  Rasesh Mody             2010-12-23  3083  
be7fa3263a15d3 drivers/net/bna/bnad.c                  Rasesh Mody             2010-12-23  3084  	if (unlikely(!test_bit(BNAD_TXQ_TX_STARTED, &tcb->flags)))
be7fa3263a15d3 drivers/net/bna/bnad.c                  Rasesh Mody             2010-12-23  3085  		return NETDEV_TX_OK;
be7fa3263a15d3 drivers/net/bna/bnad.c                  Rasesh Mody             2010-12-23  3086  
fee1253e280a61 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  3087  	skb_tx_timestamp(skb);
fee1253e280a61 drivers/net/ethernet/brocade/bna/bnad.c Rasesh Mody             2013-12-17  3088  
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3089  	bna_txq_prod_indx_doorbell(tcb);
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3090  
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3091  	return NETDEV_TX_OK;
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3092  }
8b230ed8ec96c9 drivers/net/bna/bnad.c                  Rasesh Mody             2010-08-23  3093  

:::::: The code at line 2918 was first introduced by commit
:::::: 5216562a2ccd037d0eb85a2e8bbfd6315e3f1bb5 bna: Tx and Rx Optimizations

:::::: TO: Rasesh Mody <rmody@brocade.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
