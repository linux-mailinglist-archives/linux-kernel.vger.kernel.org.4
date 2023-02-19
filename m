Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3969C377
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBSX45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBSX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:56:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A0B471
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676851013; x=1708387013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LvIR4VK4Nnui3gCiGBEXXrCpCCkA0sKwlYlvboJzQNA=;
  b=MxE95WwxjE3V7fNlsYg2+7Z+Y572mEwwBMdOazuCpm8jttV8GnuhfCbK
   AR8/Sme3SEBluJiM0BiJNYHJmgrEYsd6bKfsrmn/KaBq6fXnKmZxTPZr1
   viJiPf+OuxfqwUTW9slxK45Zr8X4VT52zLeEcQUhs+jQDbvG5JOHvPwq5
   scOCglAKTTOTQmDUouON/8QtwnmocPa7gJrJhO5C6gY38jL+VWCDJFv6n
   /hJ9mfTCjALf0UdzfbDGg8ESSl0zShBArFfHl6WhRQGhD7xMeHBz7xBka
   h/qMuWa4itC72pe/aABzp5DYa7IYJdK3wB7M++m48nb8PRhRG3KQW1r/i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="320414115"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="320414115"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 15:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="1000088687"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="1000088687"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2023 15:56:51 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTtY2-000DVB-1F;
        Sun, 19 Feb 2023 23:56:50 +0000
Date:   Mon, 20 Feb 2023 07:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Paul Durrant <paul@xen.org>
Subject: drivers/net/xen-netback/netback.c:886:7: warning: variable
 'pending_idx' set but not used
Message-ID: <202302200719.wP3xBxCC-lkp@intel.com>
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

Hi Ross,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
commit: ad7f402ae4f466647c3a669b8a6f3e5d4271c84a xen/netback: Ensure protocol headers don't fall in the non-linear area
date:   3 months ago
config: x86_64-randconfig-a015-20230220 (https://download.01.org/0day-ci/archive/20230220/202302200719.wP3xBxCC-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad7f402ae4f466647c3a669b8a6f3e5d4271c84a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ad7f402ae4f466647c3a669b8a6f3e5d4271c84a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/xen-netback/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302200719.wP3xBxCC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/xen-netback/netback.c:886:7: warning: variable 'pending_idx' set but not used [-Wunused-but-set-variable]
                   u16 pending_idx;
                       ^
   1 warning generated.


vim +/pending_idx +886 drivers/net/xen-netback/netback.c

210c34dcd8d912 Paul Durrant   2015-09-02   871  
e9ce7cb6b10740 Wei Liu        2014-06-04   872  static void xenvif_tx_build_gops(struct xenvif_queue *queue,
bdab82759b8e36 Zoltan Kiss    2014-04-02   873  				     int budget,
bdab82759b8e36 Zoltan Kiss    2014-04-02   874  				     unsigned *copy_ops,
bdab82759b8e36 Zoltan Kiss    2014-04-02   875  				     unsigned *map_ops)
f942dc2552b8bf Ian Campbell   2011-03-15   876  {
2475b22526d702 Ross Lagerwall 2015-08-03   877  	struct sk_buff *skb, *nskb;
f942dc2552b8bf Ian Campbell   2011-03-15   878  	int ret;
2475b22526d702 Ross Lagerwall 2015-08-03   879  	unsigned int frag_overflow;
f942dc2552b8bf Ian Campbell   2011-03-15   880  
e9ce7cb6b10740 Wei Liu        2014-06-04   881  	while (skb_queue_len(&queue->tx_queue) < budget) {
f942dc2552b8bf Ian Campbell   2011-03-15   882  		struct xen_netif_tx_request txreq;
376414945d15aa Wei Liu        2013-05-02   883  		struct xen_netif_tx_request txfrags[XEN_NETBK_LEGACY_SLOTS_MAX];
f942dc2552b8bf Ian Campbell   2011-03-15   884  		struct xen_netif_extra_info extras[XEN_NETIF_EXTRA_TYPE_MAX-1];
562abd39a19027 Paul Durrant   2016-03-10   885  		unsigned int extra_count;
f942dc2552b8bf Ian Campbell   2011-03-15  @886  		u16 pending_idx;
f942dc2552b8bf Ian Campbell   2011-03-15   887  		RING_IDX idx;
f942dc2552b8bf Ian Campbell   2011-03-15   888  		int work_to_do;
f942dc2552b8bf Ian Campbell   2011-03-15   889  		unsigned int data_len;
f942dc2552b8bf Ian Campbell   2011-03-15   890  		pending_ring_idx_t index;
f942dc2552b8bf Ian Campbell   2011-03-15   891  
e9ce7cb6b10740 Wei Liu        2014-06-04   892  		if (queue->tx.sring->req_prod - queue->tx.req_cons >
48856286b64e4b Ian Campbell   2013-02-06   893  		    XEN_NETIF_TX_RING_SIZE) {
e9ce7cb6b10740 Wei Liu        2014-06-04   894  			netdev_err(queue->vif->dev,
48856286b64e4b Ian Campbell   2013-02-06   895  				   "Impossible number of requests. "
48856286b64e4b Ian Campbell   2013-02-06   896  				   "req_prod %d, req_cons %d, size %ld\n",
e9ce7cb6b10740 Wei Liu        2014-06-04   897  				   queue->tx.sring->req_prod, queue->tx.req_cons,
48856286b64e4b Ian Campbell   2013-02-06   898  				   XEN_NETIF_TX_RING_SIZE);
e9ce7cb6b10740 Wei Liu        2014-06-04   899  			xenvif_fatal_tx_err(queue->vif);
e9d8b2c2968499 Wei Liu        2014-04-01   900  			break;
48856286b64e4b Ian Campbell   2013-02-06   901  		}
48856286b64e4b Ian Campbell   2013-02-06   902  
09e545f7381459 Juergen Gross  2022-05-30   903  		work_to_do = XEN_RING_NR_UNCONSUMED_REQUESTS(&queue->tx);
b3f980bd827e6e Wei Liu        2013-08-26   904  		if (!work_to_do)
b3f980bd827e6e Wei Liu        2013-08-26   905  			break;
f942dc2552b8bf Ian Campbell   2011-03-15   906  
e9ce7cb6b10740 Wei Liu        2014-06-04   907  		idx = queue->tx.req_cons;
f942dc2552b8bf Ian Campbell   2011-03-15   908  		rmb(); /* Ensure that we see the request before we copy it. */
68a33bfd8403e4 David Vrabel   2015-10-30   909  		RING_COPY_REQUEST(&queue->tx, idx, &txreq);
f942dc2552b8bf Ian Campbell   2011-03-15   910  
f942dc2552b8bf Ian Campbell   2011-03-15   911  		/* Credit-based scheduling. */
e9ce7cb6b10740 Wei Liu        2014-06-04   912  		if (txreq.size > queue->remaining_credit &&
e9ce7cb6b10740 Wei Liu        2014-06-04   913  		    tx_credit_exceeded(queue, txreq.size))
b3f980bd827e6e Wei Liu        2013-08-26   914  			break;
f942dc2552b8bf Ian Campbell   2011-03-15   915  
e9ce7cb6b10740 Wei Liu        2014-06-04   916  		queue->remaining_credit -= txreq.size;
f942dc2552b8bf Ian Campbell   2011-03-15   917  
f942dc2552b8bf Ian Campbell   2011-03-15   918  		work_to_do--;
e9ce7cb6b10740 Wei Liu        2014-06-04   919  		queue->tx.req_cons = ++idx;
f942dc2552b8bf Ian Campbell   2011-03-15   920  
f942dc2552b8bf Ian Campbell   2011-03-15   921  		memset(extras, 0, sizeof(extras));
562abd39a19027 Paul Durrant   2016-03-10   922  		extra_count = 0;
f942dc2552b8bf Ian Campbell   2011-03-15   923  		if (txreq.flags & XEN_NETTXF_extra_info) {
e9ce7cb6b10740 Wei Liu        2014-06-04   924  			work_to_do = xenvif_get_extras(queue, extras,
562abd39a19027 Paul Durrant   2016-03-10   925  						       &extra_count,
f942dc2552b8bf Ian Campbell   2011-03-15   926  						       work_to_do);
e9ce7cb6b10740 Wei Liu        2014-06-04   927  			idx = queue->tx.req_cons;
48856286b64e4b Ian Campbell   2013-02-06   928  			if (unlikely(work_to_do < 0))
b3f980bd827e6e Wei Liu        2013-08-26   929  				break;
f942dc2552b8bf Ian Campbell   2011-03-15   930  		}
f942dc2552b8bf Ian Campbell   2011-03-15   931  
210c34dcd8d912 Paul Durrant   2015-09-02   932  		if (extras[XEN_NETIF_EXTRA_TYPE_MCAST_ADD - 1].type) {
210c34dcd8d912 Paul Durrant   2015-09-02   933  			struct xen_netif_extra_info *extra;
210c34dcd8d912 Paul Durrant   2015-09-02   934  
210c34dcd8d912 Paul Durrant   2015-09-02   935  			extra = &extras[XEN_NETIF_EXTRA_TYPE_MCAST_ADD - 1];
210c34dcd8d912 Paul Durrant   2015-09-02   936  			ret = xenvif_mcast_add(queue->vif, extra->u.mcast.addr);
210c34dcd8d912 Paul Durrant   2015-09-02   937  
562abd39a19027 Paul Durrant   2016-03-10   938  			make_tx_response(queue, &txreq, extra_count,
210c34dcd8d912 Paul Durrant   2015-09-02   939  					 (ret == 0) ?
210c34dcd8d912 Paul Durrant   2015-09-02   940  					 XEN_NETIF_RSP_OKAY :
210c34dcd8d912 Paul Durrant   2015-09-02   941  					 XEN_NETIF_RSP_ERROR);
210c34dcd8d912 Paul Durrant   2015-09-02   942  			push_tx_responses(queue);
210c34dcd8d912 Paul Durrant   2015-09-02   943  			continue;
210c34dcd8d912 Paul Durrant   2015-09-02   944  		}
210c34dcd8d912 Paul Durrant   2015-09-02   945  
210c34dcd8d912 Paul Durrant   2015-09-02   946  		if (extras[XEN_NETIF_EXTRA_TYPE_MCAST_DEL - 1].type) {
210c34dcd8d912 Paul Durrant   2015-09-02   947  			struct xen_netif_extra_info *extra;
210c34dcd8d912 Paul Durrant   2015-09-02   948  
210c34dcd8d912 Paul Durrant   2015-09-02   949  			extra = &extras[XEN_NETIF_EXTRA_TYPE_MCAST_DEL - 1];
210c34dcd8d912 Paul Durrant   2015-09-02   950  			xenvif_mcast_del(queue->vif, extra->u.mcast.addr);
210c34dcd8d912 Paul Durrant   2015-09-02   951  
562abd39a19027 Paul Durrant   2016-03-10   952  			make_tx_response(queue, &txreq, extra_count,
562abd39a19027 Paul Durrant   2016-03-10   953  					 XEN_NETIF_RSP_OKAY);
210c34dcd8d912 Paul Durrant   2015-09-02   954  			push_tx_responses(queue);
210c34dcd8d912 Paul Durrant   2015-09-02   955  			continue;
210c34dcd8d912 Paul Durrant   2015-09-02   956  		}
210c34dcd8d912 Paul Durrant   2015-09-02   957  
ad7f402ae4f466 Ross Lagerwall 2022-11-22   958  		data_len = (txreq.size > XEN_NETBACK_TX_COPY_LEN) ?
ad7f402ae4f466 Ross Lagerwall 2022-11-22   959  			XEN_NETBACK_TX_COPY_LEN : txreq.size;
ad7f402ae4f466 Ross Lagerwall 2022-11-22   960  
562abd39a19027 Paul Durrant   2016-03-10   961  		ret = xenvif_count_requests(queue, &txreq, extra_count,
562abd39a19027 Paul Durrant   2016-03-10   962  					    txfrags, work_to_do);
ad7f402ae4f466 Ross Lagerwall 2022-11-22   963  
48856286b64e4b Ian Campbell   2013-02-06   964  		if (unlikely(ret < 0))
b3f980bd827e6e Wei Liu        2013-08-26   965  			break;
48856286b64e4b Ian Campbell   2013-02-06   966  
f942dc2552b8bf Ian Campbell   2011-03-15   967  		idx += ret;
f942dc2552b8bf Ian Campbell   2011-03-15   968  
f942dc2552b8bf Ian Campbell   2011-03-15   969  		if (unlikely(txreq.size < ETH_HLEN)) {
e9ce7cb6b10740 Wei Liu        2014-06-04   970  			netdev_dbg(queue->vif->dev,
f942dc2552b8bf Ian Campbell   2011-03-15   971  				   "Bad packet size: %d\n", txreq.size);
562abd39a19027 Paul Durrant   2016-03-10   972  			xenvif_tx_err(queue, &txreq, extra_count, idx);
b3f980bd827e6e Wei Liu        2013-08-26   973  			break;
f942dc2552b8bf Ian Campbell   2011-03-15   974  		}
f942dc2552b8bf Ian Campbell   2011-03-15   975  
f942dc2552b8bf Ian Campbell   2011-03-15   976  		/* No crossing a page as the payload mustn't fragment. */
d0089e8a0e4c97 Julien Grall   2015-05-05   977  		if (unlikely((txreq.offset + txreq.size) > XEN_PAGE_SIZE)) {
e9ce7cb6b10740 Wei Liu        2014-06-04   978  			netdev_err(queue->vif->dev,
68946159da1b0b Julien Grall   2015-06-16   979  				   "txreq.offset: %u, size: %u, end: %lu\n",
f942dc2552b8bf Ian Campbell   2011-03-15   980  				   txreq.offset, txreq.size,
d0089e8a0e4c97 Julien Grall   2015-05-05   981  				   (unsigned long)(txreq.offset&~XEN_PAGE_MASK) + txreq.size);
e9ce7cb6b10740 Wei Liu        2014-06-04   982  			xenvif_fatal_tx_err(queue->vif);
b3f980bd827e6e Wei Liu        2013-08-26   983  			break;
f942dc2552b8bf Ian Campbell   2011-03-15   984  		}
f942dc2552b8bf Ian Campbell   2011-03-15   985  
e9ce7cb6b10740 Wei Liu        2014-06-04   986  		index = pending_index(queue->pending_cons);
e9ce7cb6b10740 Wei Liu        2014-06-04   987  		pending_idx = queue->pending_ring[index];
f942dc2552b8bf Ian Campbell   2011-03-15   988  
ad7f402ae4f466 Ross Lagerwall 2022-11-22   989  		if (ret >= XEN_NETBK_LEGACY_SLOTS_MAX - 1 && data_len < txreq.size)
ad7f402ae4f466 Ross Lagerwall 2022-11-22   990  			data_len = txreq.size;
f942dc2552b8bf Ian Campbell   2011-03-15   991  
e3377f36ca20a0 Zoltan Kiss    2014-03-06   992  		skb = xenvif_alloc_skb(data_len);
f942dc2552b8bf Ian Campbell   2011-03-15   993  		if (unlikely(skb == NULL)) {
e9ce7cb6b10740 Wei Liu        2014-06-04   994  			netdev_dbg(queue->vif->dev,
f942dc2552b8bf Ian Campbell   2011-03-15   995  				   "Can't allocate a skb in start_xmit.\n");
562abd39a19027 Paul Durrant   2016-03-10   996  			xenvif_tx_err(queue, &txreq, extra_count, idx);
f942dc2552b8bf Ian Campbell   2011-03-15   997  			break;
f942dc2552b8bf Ian Campbell   2011-03-15   998  		}
f942dc2552b8bf Ian Campbell   2011-03-15   999  
2475b22526d702 Ross Lagerwall 2015-08-03  1000  		skb_shinfo(skb)->nr_frags = ret;
2475b22526d702 Ross Lagerwall 2015-08-03  1001  		/* At this point shinfo->nr_frags is in fact the number of
2475b22526d702 Ross Lagerwall 2015-08-03  1002  		 * slots, which can be as large as XEN_NETBK_LEGACY_SLOTS_MAX.
2475b22526d702 Ross Lagerwall 2015-08-03  1003  		 */
2475b22526d702 Ross Lagerwall 2015-08-03  1004  		frag_overflow = 0;
2475b22526d702 Ross Lagerwall 2015-08-03  1005  		nskb = NULL;
2475b22526d702 Ross Lagerwall 2015-08-03  1006  		if (skb_shinfo(skb)->nr_frags > MAX_SKB_FRAGS) {
2475b22526d702 Ross Lagerwall 2015-08-03  1007  			frag_overflow = skb_shinfo(skb)->nr_frags - MAX_SKB_FRAGS;
2475b22526d702 Ross Lagerwall 2015-08-03  1008  			BUG_ON(frag_overflow > MAX_SKB_FRAGS);
2475b22526d702 Ross Lagerwall 2015-08-03  1009  			skb_shinfo(skb)->nr_frags = MAX_SKB_FRAGS;
2475b22526d702 Ross Lagerwall 2015-08-03  1010  			nskb = xenvif_alloc_skb(0);
2475b22526d702 Ross Lagerwall 2015-08-03  1011  			if (unlikely(nskb == NULL)) {
3a0233ddec554b Ross Lagerwall 2019-08-05  1012  				skb_shinfo(skb)->nr_frags = 0;
2475b22526d702 Ross Lagerwall 2015-08-03  1013  				kfree_skb(skb);
562abd39a19027 Paul Durrant   2016-03-10  1014  				xenvif_tx_err(queue, &txreq, extra_count, idx);
2475b22526d702 Ross Lagerwall 2015-08-03  1015  				if (net_ratelimit())
2475b22526d702 Ross Lagerwall 2015-08-03  1016  					netdev_err(queue->vif->dev,
2475b22526d702 Ross Lagerwall 2015-08-03  1017  						   "Can't allocate the frag_list skb.\n");
2475b22526d702 Ross Lagerwall 2015-08-03  1018  				break;
2475b22526d702 Ross Lagerwall 2015-08-03  1019  			}
2475b22526d702 Ross Lagerwall 2015-08-03  1020  		}
2475b22526d702 Ross Lagerwall 2015-08-03  1021  
f942dc2552b8bf Ian Campbell   2011-03-15  1022  		if (extras[XEN_NETIF_EXTRA_TYPE_GSO - 1].type) {
f942dc2552b8bf Ian Campbell   2011-03-15  1023  			struct xen_netif_extra_info *gso;
f942dc2552b8bf Ian Campbell   2011-03-15  1024  			gso = &extras[XEN_NETIF_EXTRA_TYPE_GSO - 1];
f942dc2552b8bf Ian Campbell   2011-03-15  1025  
e9ce7cb6b10740 Wei Liu        2014-06-04  1026  			if (xenvif_set_skb_gso(queue->vif, skb, gso)) {
7376419a469765 Wei Liu        2013-08-26  1027  				/* Failure in xenvif_set_skb_gso is fatal. */
3a0233ddec554b Ross Lagerwall 2019-08-05  1028  				skb_shinfo(skb)->nr_frags = 0;
f942dc2552b8bf Ian Campbell   2011-03-15  1029  				kfree_skb(skb);
2475b22526d702 Ross Lagerwall 2015-08-03  1030  				kfree_skb(nskb);
b3f980bd827e6e Wei Liu        2013-08-26  1031  				break;
f942dc2552b8bf Ian Campbell   2011-03-15  1032  			}
f942dc2552b8bf Ian Campbell   2011-03-15  1033  		}
f942dc2552b8bf Ian Campbell   2011-03-15  1034  
c2d09fde7299f6 Paul Durrant   2016-05-13  1035  		if (extras[XEN_NETIF_EXTRA_TYPE_HASH - 1].type) {
c2d09fde7299f6 Paul Durrant   2016-05-13  1036  			struct xen_netif_extra_info *extra;
c2d09fde7299f6 Paul Durrant   2016-05-13  1037  			enum pkt_hash_types type = PKT_HASH_TYPE_NONE;
c2d09fde7299f6 Paul Durrant   2016-05-13  1038  
c2d09fde7299f6 Paul Durrant   2016-05-13  1039  			extra = &extras[XEN_NETIF_EXTRA_TYPE_HASH - 1];
c2d09fde7299f6 Paul Durrant   2016-05-13  1040  
c2d09fde7299f6 Paul Durrant   2016-05-13  1041  			switch (extra->u.hash.type) {
c2d09fde7299f6 Paul Durrant   2016-05-13  1042  			case _XEN_NETIF_CTRL_HASH_TYPE_IPV4:
c2d09fde7299f6 Paul Durrant   2016-05-13  1043  			case _XEN_NETIF_CTRL_HASH_TYPE_IPV6:
c2d09fde7299f6 Paul Durrant   2016-05-13  1044  				type = PKT_HASH_TYPE_L3;
c2d09fde7299f6 Paul Durrant   2016-05-13  1045  				break;
c2d09fde7299f6 Paul Durrant   2016-05-13  1046  
c2d09fde7299f6 Paul Durrant   2016-05-13  1047  			case _XEN_NETIF_CTRL_HASH_TYPE_IPV4_TCP:
c2d09fde7299f6 Paul Durrant   2016-05-13  1048  			case _XEN_NETIF_CTRL_HASH_TYPE_IPV6_TCP:
c2d09fde7299f6 Paul Durrant   2016-05-13  1049  				type = PKT_HASH_TYPE_L4;
c2d09fde7299f6 Paul Durrant   2016-05-13  1050  				break;
c2d09fde7299f6 Paul Durrant   2016-05-13  1051  
c2d09fde7299f6 Paul Durrant   2016-05-13  1052  			default:
c2d09fde7299f6 Paul Durrant   2016-05-13  1053  				break;
c2d09fde7299f6 Paul Durrant   2016-05-13  1054  			}
c2d09fde7299f6 Paul Durrant   2016-05-13  1055  
c2d09fde7299f6 Paul Durrant   2016-05-13  1056  			if (type != PKT_HASH_TYPE_NONE)
c2d09fde7299f6 Paul Durrant   2016-05-13  1057  				skb_set_hash(skb,
c2d09fde7299f6 Paul Durrant   2016-05-13  1058  					     *(u32 *)extra->u.hash.value,
c2d09fde7299f6 Paul Durrant   2016-05-13  1059  					     type);
c2d09fde7299f6 Paul Durrant   2016-05-13  1060  		}
c2d09fde7299f6 Paul Durrant   2016-05-13  1061  
ad7f402ae4f466 Ross Lagerwall 2022-11-22  1062  		xenvif_get_requests(queue, skb, &txreq, txfrags, copy_ops,
ad7f402ae4f466 Ross Lagerwall 2022-11-22  1063  				    map_ops, frag_overflow, nskb, extra_count,
ad7f402ae4f466 Ross Lagerwall 2022-11-22  1064  				    data_len);
f942dc2552b8bf Ian Campbell   2011-03-15  1065  
e9ce7cb6b10740 Wei Liu        2014-06-04  1066  		__skb_queue_tail(&queue->tx_queue, skb);
1e0b6eac6a150a Annie Li       2012-06-27  1067  
e9ce7cb6b10740 Wei Liu        2014-06-04  1068  		queue->tx.req_cons = idx;
f942dc2552b8bf Ian Campbell   2011-03-15  1069  
ad7f402ae4f466 Ross Lagerwall 2022-11-22  1070  		if ((*map_ops >= ARRAY_SIZE(queue->tx_map_ops)) ||
e9ce7cb6b10740 Wei Liu        2014-06-04  1071  		    (*copy_ops >= ARRAY_SIZE(queue->tx_copy_ops)))
f942dc2552b8bf Ian Campbell   2011-03-15  1072  			break;
f942dc2552b8bf Ian Campbell   2011-03-15  1073  	}
f942dc2552b8bf Ian Campbell   2011-03-15  1074  
bdab82759b8e36 Zoltan Kiss    2014-04-02  1075  	return;
f942dc2552b8bf Ian Campbell   2011-03-15  1076  }
f942dc2552b8bf Ian Campbell   2011-03-15  1077  

:::::: The code at line 886 was first introduced by commit
:::::: f942dc2552b8bfdee607be867b12a8971bb9cd85 xen network backend driver

:::::: TO: Ian Campbell <Ian.Campbell@citrix.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
