Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04691749FAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjGFOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjGFOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:49:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3561426AD;
        Thu,  6 Jul 2023 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688654931; x=1720190931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WmEM0Uv0V9podpjJiFKtXB/oy3LQV9ca9bVrgASMa9o=;
  b=IwZUrLh/yRZKOQfqDhbiyPW5WZTvVwGDMh3jE5H7VTyCG7gGEAs/JWdc
   5RZdAsK8cYNL2JC1fTeNhRJPm9p263sSoUi3UI8rBhT2X5DArmATdxn0I
   flfeboayu+4LtBWM5/1qV5DQxnDNpVjjoWKABQTmlD+li+YpeNNcuVPL7
   aY4tkHRbUifXywarqemfSlJ17q2r6QZtsIcPQjyKmSDwPN6rNVQlfbDu6
   d2EJQJhakNDfCHXPcU090uyeKR57FXbdoyMS7Lq+KMXOv2RviRBg4KCDf
   IerfK+Oh7Tcxj5tEgmjQC1lGUvvPVyHc7baxny6QsODsU4pOcAl+Didwb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363657252"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363657252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713606831"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="713606831"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 07:48:27 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHQHT-0001Ne-0E;
        Thu, 06 Jul 2023 14:48:27 +0000
Date:   Thu, 6 Jul 2023 22:48:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH V3] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <202307062220.o7LjIj48-lkp@intel.com>
References: <20230703170054.2152662-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703170054.2152662-1-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4 next-20230706]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suman-Ghosh/octeontx2-pf-Add-additional-check-for-MCAM-rules/20230704-010247
base:   linus/master
patch link:    https://lore.kernel.org/r/20230703170054.2152662-1-sumang%40marvell.com
patch subject: [PATCH V3] octeontx2-pf: Add additional check for MCAM rules
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20230706/202307062220.o7LjIj48-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230706/202307062220.o7LjIj48-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307062220.o7LjIj48-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:877:8: warning: variable 'vlan_etype' is uninitialized when used here [-Wuninitialized]
     877 |                         if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
         |                             ^~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:867:17: note: initialize the variable 'vlan_etype' to silence this warning
     867 |                 u16 vlan_etype;
         |                               ^
         |                                = 0
   1 warning generated.


vim +/vlan_etype +877 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

   810	
   811	static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
   812				      struct npc_install_flow_req *req)
   813	{
   814		struct ethhdr *eth_mask = &fsp->m_u.ether_spec;
   815		struct ethhdr *eth_hdr = &fsp->h_u.ether_spec;
   816		struct flow_msg *pmask = &req->mask;
   817		struct flow_msg *pkt = &req->packet;
   818		u32 flow_type;
   819		int ret;
   820	
   821		flow_type = fsp->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
   822		switch (flow_type) {
   823		/* bits not set in mask are don't care */
   824		case ETHER_FLOW:
   825			if (!is_zero_ether_addr(eth_mask->h_source)) {
   826				ether_addr_copy(pkt->smac, eth_hdr->h_source);
   827				ether_addr_copy(pmask->smac, eth_mask->h_source);
   828				req->features |= BIT_ULL(NPC_SMAC);
   829			}
   830			if (!is_zero_ether_addr(eth_mask->h_dest)) {
   831				ether_addr_copy(pkt->dmac, eth_hdr->h_dest);
   832				ether_addr_copy(pmask->dmac, eth_mask->h_dest);
   833				req->features |= BIT_ULL(NPC_DMAC);
   834			}
   835			if (eth_hdr->h_proto) {
   836				memcpy(&pkt->etype, &eth_hdr->h_proto,
   837				       sizeof(pkt->etype));
   838				memcpy(&pmask->etype, &eth_mask->h_proto,
   839				       sizeof(pmask->etype));
   840				req->features |= BIT_ULL(NPC_ETYPE);
   841			}
   842			break;
   843		case IP_USER_FLOW:
   844		case TCP_V4_FLOW:
   845		case UDP_V4_FLOW:
   846		case SCTP_V4_FLOW:
   847		case AH_V4_FLOW:
   848		case ESP_V4_FLOW:
   849			ret = otx2_prepare_ipv4_flow(fsp, req, flow_type);
   850			if (ret)
   851				return ret;
   852			break;
   853		case IPV6_USER_FLOW:
   854		case TCP_V6_FLOW:
   855		case UDP_V6_FLOW:
   856		case SCTP_V6_FLOW:
   857		case AH_V6_FLOW:
   858		case ESP_V6_FLOW:
   859			ret = otx2_prepare_ipv6_flow(fsp, req, flow_type);
   860			if (ret)
   861				return ret;
   862			break;
   863		default:
   864			return -EOPNOTSUPP;
   865		}
   866		if (fsp->flow_type & FLOW_EXT) {
   867			u16 vlan_etype;
   868	
   869			if (fsp->m_ext.vlan_etype) {
   870				/* Partial masks not supported */
   871				if (be16_to_cpu(fsp->m_ext.vlan_etype) != 0xFFFF)
   872					return -EINVAL;
   873	
   874				/* Drop rule with vlan_etype == 802.1Q
   875				 * and vlan_id == 0 is not supported
   876				 */
 > 877				if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
   878				    fsp->ring_cookie == RX_CLS_FLOW_DISC)
   879					return -EINVAL;
   880	
   881				vlan_etype = be16_to_cpu(fsp->h_ext.vlan_etype);
   882				/* Only ETH_P_8021Q and ETH_P_802AD types supported */
   883				if (vlan_etype != ETH_P_8021Q &&
   884				    vlan_etype != ETH_P_8021AD)
   885					return -EINVAL;
   886	
   887				memcpy(&pkt->vlan_etype, &fsp->h_ext.vlan_etype,
   888				       sizeof(pkt->vlan_etype));
   889				memcpy(&pmask->vlan_etype, &fsp->m_ext.vlan_etype,
   890				       sizeof(pmask->vlan_etype));
   891	
   892				if (vlan_etype == ETH_P_8021Q)
   893					req->features |= BIT_ULL(NPC_VLAN_ETYPE_CTAG);
   894				else
   895					req->features |= BIT_ULL(NPC_VLAN_ETYPE_STAG);
   896			}
   897	
   898			if (fsp->m_ext.vlan_tci) {
   899				memcpy(&pkt->vlan_tci, &fsp->h_ext.vlan_tci,
   900				       sizeof(pkt->vlan_tci));
   901				memcpy(&pmask->vlan_tci, &fsp->m_ext.vlan_tci,
   902				       sizeof(pmask->vlan_tci));
   903				req->features |= BIT_ULL(NPC_OUTER_VID);
   904			}
   905	
   906			if (fsp->m_ext.data[1]) {
   907				if (flow_type == IP_USER_FLOW) {
   908					if (be32_to_cpu(fsp->h_ext.data[1]) != IPV4_FLAG_MORE)
   909						return -EINVAL;
   910	
   911					pkt->ip_flag = be32_to_cpu(fsp->h_ext.data[1]);
   912					pmask->ip_flag = be32_to_cpu(fsp->m_ext.data[1]);
   913					req->features |= BIT_ULL(NPC_IPFRAG_IPV4);
   914				} else if (fsp->h_ext.data[1] ==
   915						cpu_to_be32(OTX2_DEFAULT_ACTION)) {
   916					/* Not Drop/Direct to queue but use action
   917					 * in default entry
   918					 */
   919					req->op = NIX_RX_ACTION_DEFAULT;
   920				}
   921			}
   922		}
   923	
   924		if (fsp->flow_type & FLOW_MAC_EXT &&
   925		    !is_zero_ether_addr(fsp->m_ext.h_dest)) {
   926			ether_addr_copy(pkt->dmac, fsp->h_ext.h_dest);
   927			ether_addr_copy(pmask->dmac, fsp->m_ext.h_dest);
   928			req->features |= BIT_ULL(NPC_DMAC);
   929		}
   930	
   931		if (!req->features)
   932			return -EOPNOTSUPP;
   933	
   934		return 0;
   935	}
   936	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
