Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA66888C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBBVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:10:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2B7305F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675372253; x=1706908253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tn8gw+pUizUVyLWdeQ33cg43GfQyYKW0oJLsIw7Ajgo=;
  b=UjYOzRfGfpsyMrGcnIB22NP6AXJmI+oTSmYhZSmE1SPjhHLCaeQM5MkQ
   Qes5Fvf1HDP7RpDeBFfkYsV7dUvfFNkcFY6T0K8+zIUqnlJboATjjuuqH
   JM01yMwzTv2/qVLviyej+iGCO0PlzWUd7wxNLEH/GxBW2mB5+JBO2V/oC
   9t2b++pw+Td/DYqVCKGok4BB7XaiIRu6zerqzZtRWqOgVmHEiWkQilNmW
   kkgP1vssx8GKHnhZxq1tiOQ8pkZgEDMV8twTSXIPeqZdVEjKGi8D7GcLw
   jKwWmYvUI22s7JFlpA4a7lu0mGXarDg/e4Jeu+u84jIoxOwvJWuZuR0fs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="316564784"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="316564784"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 13:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="910900707"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="910900707"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2023 13:10:51 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNgr4-0006rw-1S;
        Thu, 02 Feb 2023 21:10:50 +0000
Date:   Fri, 3 Feb 2023 05:10:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/display/drm_dp_mst_topology.c:4780:7: warning: Local
 variable 'ret' shadows outer variable [shadowVariable]
Message-ID: <202302030532.61KWU5Iq-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f266ccaa2f5228bfe67ad58a94ca4e0109b954a
commit: 4d07b0bc403403438d9cf88450506240c5faf92f drm/display/dp_mst: Move all payload info into the atomic state
date:   5 months ago
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 4d07b0bc403403438d9cf88450506240c5faf92f
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/display/drm_dp_mst_topology.c:4780:7: warning: Local variable 'ret' shadows outer variable [shadowVariable]
     int ret;
         ^
   drivers/gpu/drm/display/drm_dp_mst_topology.c:4737:9: note: Shadowed declaration
    int i, ret;
           ^
   drivers/gpu/drm/display/drm_dp_mst_topology.c:4780:7: note: Shadow variable
     int ret;
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> fs/overlayfs/copy_up.c:480:40: warning: Operator '|' with one operand equal to zero is redundant. [badBitmaskCheck]
    temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
                                          ^
>> fs/overlayfs/copy_up.c:420:57: warning: Possible null pointer dereference: fh [nullPointer]
    err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
                                                           ^
   fs/overlayfs/copy_up.c:403:28: note: Assignment 'fh=NULL', assigned value is 0
    const struct ovl_fh *fh = NULL;
                              ^
   fs/overlayfs/copy_up.c:411:23: note: Assuming condition is false
    if (ovl_can_decode_fh(lower->d_sb)) {
                         ^
   fs/overlayfs/copy_up.c:420:57: note: Null pointer dereference
    err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
                                                           ^
>> fs/overlayfs/copy_up.c:107:10: warning: Local variable 'new' shadows outer argument [shadowArgument]
      void *new;
            ^
   fs/overlayfs/copy_up.c:47:81: note: Shadowed declaration
   int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *new)
                                                                                   ^
   fs/overlayfs/copy_up.c:107:10: note: Shadow variable
      void *new;
            ^
--
>> drivers/gpu/drm/display/drm_dp_mst_topology.c:1691:30: warning: Parameter 'port' can be declared as pointer to const [constParameter]
        struct drm_dp_mst_port *port)
                                ^
>> drivers/gpu/drm/display/drm_dp_mst_topology.c:5003:34: warning: Parameter 'branch' can be declared as pointer to const [constParameter]
          struct drm_dp_mst_branch *branch)
                                    ^

vim +/ret +4780 drivers/gpu/drm/display/drm_dp_mst_topology.c

51108f252b02d3 drivers/gpu/drm/drm_dp_mst_topology.c         Jim Bride         2016-04-14  4724  
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4725  /**
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4726   * drm_dp_mst_dump_topology(): dump topology to seq file.
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4727   * @m: seq_file to dump output to
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4728   * @mgr: manager to dump current topology for.
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4729   *
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4730   * helper to dump MST topology to a seq file for debugfs.
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4731   */
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4732  void drm_dp_mst_dump_topology(struct seq_file *m,
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4733  			      struct drm_dp_mst_topology_mgr *mgr)
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4734  {
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4735  	struct drm_dp_mst_topology_state *state;
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4736  	struct drm_dp_mst_atomic_payload *payload;
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4737  	int i, ret;
51108f252b02d3 drivers/gpu/drm/drm_dp_mst_topology.c         Jim Bride         2016-04-14  4738  
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4739  	mutex_lock(&mgr->lock);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4740  	if (mgr->mst_primary)
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4741  		drm_dp_mst_dump_mstb(m, mgr->mst_primary);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4742  
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4743  	/* dump VCPIs */
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4744  	mutex_unlock(&mgr->lock);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4745  
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4746  	ret = drm_modeset_lock_single_interruptible(&mgr->base.lock);
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4747  	if (ret < 0)
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4748  		return;
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4749  
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4750  	state = to_drm_dp_mst_topology_state(mgr->base.state);
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4751  	seq_printf(m, "\n*** Atomic state info ***\n");
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4752  	seq_printf(m, "payload_mask: %x, max_payloads: %d, start_slot: %u, pbn_div: %d\n",
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4753  		   state->payload_mask, mgr->max_payloads, state->start_slot, state->pbn_div);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4754  
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4755  	seq_printf(m, "\n| idx | port | vcpi | slots | pbn | dsc |     sink name     |\n");
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4756  	for (i = 0; i < mgr->max_payloads; i++) {
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4757  		list_for_each_entry(payload, &state->payloads, next) {
51108f252b02d3 drivers/gpu/drm/drm_dp_mst_topology.c         Jim Bride         2016-04-14  4758  			char name[14];
51108f252b02d3 drivers/gpu/drm/drm_dp_mst_topology.c         Jim Bride         2016-04-14  4759  
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4760  			if (payload->vcpi != i || payload->delete)
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4761  				continue;
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4762  
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4763  			fetch_monitor_name(mgr, payload->port, name, sizeof(name));
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4764  			seq_printf(m, " %5d %6d %6d %02d - %02d %5d %5s %19s\n",
e55f2ffc4dc105 drivers/gpu/drm/drm_dp_mst_topology.c         Eryk Brol         2021-03-25  4765  				   i,
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4766  				   payload->port->port_num,
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4767  				   payload->vcpi,
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4768  				   payload->vc_start_slot,
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4769  				   payload->vc_start_slot + payload->time_slots - 1,
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4770  				   payload->pbn,
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4771  				   payload->dsc_enabled ? "Y" : "N",
51108f252b02d3 drivers/gpu/drm/drm_dp_mst_topology.c         Jim Bride         2016-04-14  4772  				   (*name != 0) ? name : "Unknown");
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4773  		}
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4774  	}
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4775  
e55f2ffc4dc105 drivers/gpu/drm/drm_dp_mst_topology.c         Eryk Brol         2021-03-25  4776  	seq_printf(m, "\n*** DPCD Info ***\n");
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4777  	mutex_lock(&mgr->lock);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4778  	if (mgr->mst_primary) {
7056a2bccc3b5a drivers/gpu/drm/drm_dp_mst_topology.c         Andy Shevchenko   2018-03-19  4779  		u8 buf[DP_PAYLOAD_TABLE_SIZE];
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05 @4780  		int ret;
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4781  
7a710a8bc90931 drivers/gpu/drm/display/drm_dp_mst_topology.c Imre Deak         2022-06-14  4782  		if (drm_dp_read_dpcd_caps(mgr->aux, buf) < 0) {
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4783  			seq_printf(m, "dpcd read failed\n");
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4784  			goto out;
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4785  		}
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4786  		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4787  
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4788  		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
2ac6cdd581f48c drivers/gpu/drm/display/drm_dp_mst_topology.c Simon Ser         2022-02-10  4789  		if (ret != 2) {
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4790  			seq_printf(m, "faux/mst read failed\n");
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4791  			goto out;
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4792  		}
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4793  		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4794  
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4795  		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
2ac6cdd581f48c drivers/gpu/drm/display/drm_dp_mst_topology.c Simon Ser         2022-02-10  4796  		if (ret != 1) {
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4797  			seq_printf(m, "mst ctrl read failed\n");
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4798  			goto out;
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4799  		}
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4800  		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4801  
44790462d041d3 drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2015-07-14  4802  		/* dump the standard OUI branch header */
44790462d041d3 drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2015-07-14  4803  		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
2ac6cdd581f48c drivers/gpu/drm/display/drm_dp_mst_topology.c Simon Ser         2022-02-10  4804  		if (ret != DP_BRANCH_OUI_HEADER_SIZE) {
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4805  			seq_printf(m, "branch oui read failed\n");
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4806  			goto out;
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4807  		}
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4808  		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4809  
51108f252b02d3 drivers/gpu/drm/drm_dp_mst_topology.c         Jim Bride         2016-04-14  4810  		for (i = 0x3; i < 0x8 && buf[i]; i++)
44790462d041d3 drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2015-07-14  4811  			seq_printf(m, "%c", buf[i]);
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4812  		seq_printf(m, " revision: hw: %x.%x sw: %x.%x\n",
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4813  			   buf[0x9] >> 4, buf[0x9] & 0xf, buf[0xa], buf[0xb]);
46466b0dac3f6b drivers/gpu/drm/drm_dp_mst_topology.c         Joe Perches       2017-05-30  4814  		if (dump_dp_payload_table(mgr, buf))
7056a2bccc3b5a drivers/gpu/drm/drm_dp_mst_topology.c         Andy Shevchenko   2018-03-19  4815  			seq_printf(m, "payload table: %*ph\n", DP_PAYLOAD_TABLE_SIZE, buf);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4816  	}
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4817  
cb897542c6d2b3 drivers/gpu/drm/drm_dp_mst_topology.c         Benjamin Gaignard 2020-02-05  4818  out:
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4819  	mutex_unlock(&mgr->lock);
4d07b0bc403403 drivers/gpu/drm/display/drm_dp_mst_topology.c Lyude Paul        2022-08-17  4820  	drm_modeset_unlock(&mgr->base.lock);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4821  }
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4822  EXPORT_SYMBOL(drm_dp_mst_dump_topology);
ad7f8a1f9ced7f drivers/gpu/drm/drm_dp_mst_topology.c         Dave Airlie       2014-06-05  4823  

:::::: The code at line 4780 was first introduced by commit
:::::: ad7f8a1f9ced7f049f9b66d588723f243a7034cd drm/helper: add Displayport multi-stream helper (v0.6)

:::::: TO: Dave Airlie <airlied@redhat.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
