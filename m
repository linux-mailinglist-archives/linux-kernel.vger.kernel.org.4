Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDEB5BB730
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIQIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIQIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:20:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAADE4D15D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663402852; x=1694938852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qdo57iPq2Cu9MBcbsTZD6zHurk0GJP7ZJ6luDiGQ2Lo=;
  b=IIdUC68IxZO3tQB/7We/y7ktWRpU8iA7Trkh1ABCX1YHUGTMdzVO7MCB
   md5Ui484YxNeSa5LmjKeZ/uEYkROU7I9NMwWspQ57U5snivUJHF4sKbDh
   HUTMaYKN0Yd2qOPzen4mgy46wmBLEOkyq6X9ArLooxju1Q/l67pxpr0tX
   QVxJC3LX8JJAQom5K8qENfajxElDitu8SxlsSno+jadh6OLA8TBHnpFbZ
   +JEz014rPRgNNRS5rAStwxWxzu5PYGCp3v3mq0p1MQD1IvaB6afYJPEVK
   pD7aQFIDRYNDHL8WCeX71ecnqyLsArqr3KVgeZakPJzpRqceVM83SKQxL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286178754"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="286178754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 01:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="569085011"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Sep 2022 01:20:49 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZT4D-000099-0V;
        Sat, 17 Sep 2022 08:20:49 +0000
Date:   Sat, 17 Sep 2022 16:19:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/bpf-tc-links 1/10] net/core/dev.c:3970:44: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202209171632.1VYSsEBN-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/bpf-tc-links
head:   f9ab02443a6bd720c616b575437a851435c80c49
commit: f182834c964343d39688f653f16bfee1f3ff39c2 [1/10] bpf: Add initial fd-based API to attach tc BPF programs
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220917/202209171632.1VYSsEBN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/cilium/linux/commit/f182834c964343d39688f653f16bfee1f3ff39c2
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/bpf-tc-links
        git checkout f182834c964343d39688f653f16bfee1f3ff39c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/core/ net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3325:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3325:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3325:23: sparse:     got unsigned int
   net/core/dev.c:3325:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:3970:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sch_entry *entry @@     got struct sch_entry [noderef] __rcu *sch_ingress @@
   net/core/dev.c:3970:44: sparse:     expected struct sch_entry *entry
   net/core/dev.c:3970:44: sparse:     got struct sch_entry [noderef] __rcu *sch_ingress
>> net/core/dev.c:4010:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sch_entry *entry @@     got struct sch_entry [noderef] __rcu *sch_egress @@
   net/core/dev.c:4010:44: sparse:     expected struct sch_entry *entry
   net/core/dev.c:4010:44: sparse:     got struct sch_entry [noderef] __rcu *sch_egress
   net/core/dev.c:204:9: sparse: sparse: context imbalance in 'unlist_netdevice' - different lock contexts for basic block
   net/core/dev.c:3829:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5206:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
--
>> net/sched/sch_ingress.c:92:66: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct mini_Qdisc [noderef] __rcu **p_miniq @@     got struct mini_Qdisc ** @@
   net/sched/sch_ingress.c:92:66: sparse:     expected struct mini_Qdisc [noderef] __rcu **p_miniq
   net/sched/sch_ingress.c:92:66: sparse:     got struct mini_Qdisc **
   net/sched/sch_ingress.c:242:74: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct mini_Qdisc [noderef] __rcu **p_miniq @@     got struct mini_Qdisc ** @@
   net/sched/sch_ingress.c:242:74: sparse:     expected struct mini_Qdisc [noderef] __rcu **p_miniq
   net/sched/sch_ingress.c:242:74: sparse:     got struct mini_Qdisc **
   net/sched/sch_ingress.c:262:73: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct mini_Qdisc [noderef] __rcu **p_miniq @@     got struct mini_Qdisc ** @@
   net/sched/sch_ingress.c:262:73: sparse:     expected struct mini_Qdisc [noderef] __rcu **p_miniq
   net/sched/sch_ingress.c:262:73: sparse:     got struct mini_Qdisc **

vim +3970 net/core/dev.c

  3957	
  3958	#ifdef CONFIG_NET_XGRESS
  3959	#ifdef CONFIG_NET_CLS_ACT
  3960	unsigned int sch_cls_ingress(const void *pskb, const struct bpf_insn *null)
  3961	{
  3962		struct sk_buff *skb = (void *)pskb;
  3963		struct mini_Qdisc *miniq;
  3964		struct tcf_result res;
  3965		int ret;
  3966	
  3967		tc_skb_cb(skb)->mru = 0;
  3968		tc_skb_cb(skb)->post_ct = false;
  3969	
> 3970		miniq = dev_sch_entry_pair(skb->dev->sch_ingress)->miniq;
  3971		if (!miniq)
  3972			return TC_ACT_UNSPEC;
  3973		mini_qdisc_bstats_cpu_update(miniq, skb);
  3974		__skb_pull(skb, skb->mac_len);
  3975		ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
  3976		__skb_push(skb, skb->mac_len);
  3977		/* Only tcf related quirks below. */
  3978		switch (ret) {
  3979		case TC_ACT_SHOT:
  3980			mini_qdisc_qstats_cpu_drop(miniq);
  3981			break;
  3982		case TC_ACT_OK:
  3983		case TC_ACT_RECLASSIFY:
  3984			skb->tc_index = TC_H_MIN(res.classid);
  3985			ret = TC_ACT_OK;
  3986			break;
  3987		case TC_ACT_STOLEN:
  3988		case TC_ACT_QUEUED:
  3989		case TC_ACT_TRAP:
  3990			ret = TC_ACT_CONSUMED;
  3991			break;
  3992		case TC_ACT_CONSUMED:
  3993			/* Bump refcount given skb is now in use elsewhere. */
  3994			skb_get(skb);
  3995			break;
  3996		}
  3997		return ret;
  3998	}
  3999	
  4000	unsigned int sch_cls_egress(const void *pskb, const struct bpf_insn *null)
  4001	{
  4002		struct sk_buff *skb = (void *)pskb;
  4003		struct mini_Qdisc *miniq;
  4004		struct tcf_result res;
  4005		int ret;
  4006	
  4007		tc_skb_cb(skb)->mru = 0;
  4008		tc_skb_cb(skb)->post_ct = false;
  4009	
> 4010		miniq = dev_sch_entry_pair(skb->dev->sch_egress)->miniq;
  4011		if (!miniq)
  4012			return TC_ACT_UNSPEC;
  4013		mini_qdisc_bstats_cpu_update(miniq, skb);
  4014		ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
  4015		/* Only tcf related quirks below. */
  4016		switch (ret) {
  4017		case TC_ACT_SHOT:
  4018			mini_qdisc_qstats_cpu_drop(miniq);
  4019			break;
  4020		case TC_ACT_OK:
  4021		case TC_ACT_RECLASSIFY:
  4022			skb->tc_index = TC_H_MIN(res.classid);
  4023			ret = TC_ACT_OK;
  4024			break;
  4025		case TC_ACT_STOLEN:
  4026		case TC_ACT_QUEUED:
  4027		case TC_ACT_TRAP:
  4028			ret = TC_ACT_CONSUMED;
  4029			break;
  4030		case TC_ACT_CONSUMED:
  4031			/* Bump refcount given skb is now in use elsewhere. */
  4032			skb_get(skb);
  4033			break;
  4034		}
  4035		return ret;
  4036	}
  4037	#endif /* CONFIG_NET_CLS_ACT */
  4038	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
