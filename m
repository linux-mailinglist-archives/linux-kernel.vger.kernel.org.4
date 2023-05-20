Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41D970A66C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjETIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjETIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:32:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC65D9
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:32:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-309382efe13so2549542f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684571532; x=1687163532;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyO1+FBwVzvC74bq7ZySLVyPcbtYurQjKmG/2r04Nk4=;
        b=YaS1DbAu6V316l+/TplKzaYsQdIkTccMzhXKXbIAi8guapisnRDlgqz4J30v7Lj7tz
         oY9oTtA0f9JkVWSt87SAJlpHDvtX51WKqqsf2HLBt96VJ58avTxKZR0vo62M4+E1TVN0
         pVYSp3+gmBNdrPPjadfK+F9LkDnGOtVTEtdsCIrjIR1oTRqnDmzDKjFBwhehefuRqCyd
         d1++w6EdB273ekZ/KIvzF2v9i7JI70xRO93UY9OwVHXaRzepK01F95HTraNTNTV7xcnC
         RR/zra6eY7mPwx2LEV6cZhSlhyeQqA9q4hmOfP34XIdkoXFVlnK2h9sA02NP8qhNazgU
         pB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684571532; x=1687163532;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyO1+FBwVzvC74bq7ZySLVyPcbtYurQjKmG/2r04Nk4=;
        b=UWccUD80l7kBgXSWdu4gNgT/NUXXDPlO6Atsog9AwaOty+WdaIdirJKRIW+7OCgLg5
         QGGElHwbH4/rcQBUK7YAtG4IGF0QnBLlKFqj0o73fKiO494aa8so9MBlC+vAW2I1pGU/
         2SB+vbEseWDhvzyuFocGPNhurNfy4kVsayOvLrUcQCOVjghGdE6GTJeEpfMCTjKcFjaZ
         AnUem7rtUcbOr+lbr3moJ1KI+DstFxOzYfGpnzIg06+7OtpUeP+ltq632sJM8JEOmjc3
         lKn5zAGgevYT7sE+gCi1wUA5wzLfwHkGsC9mCw7T1ebVC4IMCXruI4cigy4jjHIna5NM
         TnSg==
X-Gm-Message-State: AC+VfDzAcCo+/wAFEjov6m5momkAAHu6jyqMfhWfrBD/p0LY2Ofi9Ctn
        EVcUFKW9wQeBy9BVAmgeesPMBA==
X-Google-Smtp-Source: ACHHUZ6OhSG9ExEjqJvHVUG47GYQI9FdC2ybjVbvNtGAS8H1/7v2AgfC3MDUzwUSz9zr4jl4mAfvRA==
X-Received: by 2002:adf:f74a:0:b0:306:342a:6a01 with SMTP id z10-20020adff74a000000b00306342a6a01mr3295800wrp.47.1684571532242;
        Sat, 20 May 2023 01:32:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd841000000b002f28de9f73bsm1276478wrl.55.2023.05.20.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 01:32:10 -0700 (PDT)
Date:   Sat, 20 May 2023 11:32:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Edward Cree <ecree.xilinx@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: drivers/net/ethernet/sfc/tc.c:450 efx_tc_flower_replace() warn:
 missing unwind goto?
Message-ID: <cbbbf576-6788-4049-b1e8-a05862f62cc2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3f704310cc7e04e89d178ea080a2e74dae9db67
commit: b7f5e17b3bb96165979f55f2821190a77f984d0e sfc: handle enc keys in efx_tc_flower_parse_match()
config: ia64-randconfig-m041-20230514
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305200745.xmIlkqjH-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/sfc/tc.c:450 efx_tc_flower_replace() warn: missing unwind goto?

vim +450 drivers/net/ethernet/sfc/tc.c

d902e1a737d44e Edward Cree 2022-09-26  382  static int efx_tc_flower_replace(struct efx_nic *efx,
d902e1a737d44e Edward Cree 2022-09-26  383  				 struct net_device *net_dev,
d902e1a737d44e Edward Cree 2022-09-26  384  				 struct flow_cls_offload *tc,
d902e1a737d44e Edward Cree 2022-09-26  385  				 struct efx_rep *efv)
d902e1a737d44e Edward Cree 2022-09-26  386  {
d902e1a737d44e Edward Cree 2022-09-26  387  	struct flow_rule *fr = flow_cls_offload_flow_rule(tc);
d902e1a737d44e Edward Cree 2022-09-26  388  	struct netlink_ext_ack *extack = tc->common.extack;
d902e1a737d44e Edward Cree 2022-09-26  389  	struct efx_tc_flow_rule *rule = NULL, *old;
d902e1a737d44e Edward Cree 2022-09-26  390  	struct efx_tc_action_set *act = NULL;
d902e1a737d44e Edward Cree 2022-09-26  391  	const struct flow_action_entry *fa;
d902e1a737d44e Edward Cree 2022-09-26  392  	struct efx_rep *from_efv, *to_efv;
d902e1a737d44e Edward Cree 2022-09-26  393  	struct efx_tc_match match;
d902e1a737d44e Edward Cree 2022-09-26  394  	s64 rc;
d902e1a737d44e Edward Cree 2022-09-26  395  	int i;
d902e1a737d44e Edward Cree 2022-09-26  396  
d902e1a737d44e Edward Cree 2022-09-26  397  	if (!tc_can_offload_extack(efx->net_dev, extack))
d902e1a737d44e Edward Cree 2022-09-26  398  		return -EOPNOTSUPP;
d902e1a737d44e Edward Cree 2022-09-26  399  	if (WARN_ON(!efx->tc))
d902e1a737d44e Edward Cree 2022-09-26  400  		return -ENETDOWN;
d902e1a737d44e Edward Cree 2022-09-26  401  	if (WARN_ON(!efx->tc->up))
d902e1a737d44e Edward Cree 2022-09-26  402  		return -ENETDOWN;
d902e1a737d44e Edward Cree 2022-09-26  403  
d902e1a737d44e Edward Cree 2022-09-26  404  	from_efv = efx_tc_flower_lookup_efv(efx, net_dev);
d902e1a737d44e Edward Cree 2022-09-26  405  	if (IS_ERR(from_efv)) {
d902e1a737d44e Edward Cree 2022-09-26  406  		/* Might be a tunnel decap rule from an indirect block.
d902e1a737d44e Edward Cree 2022-09-26  407  		 * Support for those not implemented yet.
d902e1a737d44e Edward Cree 2022-09-26  408  		 */
d902e1a737d44e Edward Cree 2022-09-26  409  		return -EOPNOTSUPP;
d902e1a737d44e Edward Cree 2022-09-26  410  	}
d902e1a737d44e Edward Cree 2022-09-26  411  
d902e1a737d44e Edward Cree 2022-09-26  412  	if (efv != from_efv) {
d902e1a737d44e Edward Cree 2022-09-26  413  		/* can't happen */
ad1c80d5f777b8 Edward Cree 2022-10-18  414  		NL_SET_ERR_MSG_FMT_MOD(extack, "for %s efv is %snull but from_efv is %snull (can't happen)",
d902e1a737d44e Edward Cree 2022-09-26  415  				       netdev_name(net_dev), efv ? "non-" : "",
d902e1a737d44e Edward Cree 2022-09-26  416  				       from_efv ? "non-" : "");
d902e1a737d44e Edward Cree 2022-09-26  417  		return -EINVAL;
d902e1a737d44e Edward Cree 2022-09-26  418  	}
d902e1a737d44e Edward Cree 2022-09-26  419  
d902e1a737d44e Edward Cree 2022-09-26  420  	/* Parse match */
d902e1a737d44e Edward Cree 2022-09-26  421  	memset(&match, 0, sizeof(match));
d902e1a737d44e Edward Cree 2022-09-26  422  	rc = efx_tc_flower_external_mport(efx, from_efv);
d902e1a737d44e Edward Cree 2022-09-26  423  	if (rc < 0) {
ad1c80d5f777b8 Edward Cree 2022-10-18  424  		NL_SET_ERR_MSG_MOD(extack, "Failed to identify ingress m-port");
d902e1a737d44e Edward Cree 2022-09-26  425  		return rc;
d902e1a737d44e Edward Cree 2022-09-26  426  	}
d902e1a737d44e Edward Cree 2022-09-26  427  	match.value.ingress_port = rc;
d902e1a737d44e Edward Cree 2022-09-26  428  	match.mask.ingress_port = ~0;
d902e1a737d44e Edward Cree 2022-09-26  429  	rc = efx_tc_flower_parse_match(efx, fr, &match, extack);
d902e1a737d44e Edward Cree 2022-09-26  430  	if (rc)
d902e1a737d44e Edward Cree 2022-09-26  431  		return rc;
b7f5e17b3bb961 Edward Cree 2023-03-27  432  	if (efx_tc_match_is_encap(&match.mask)) {
b7f5e17b3bb961 Edward Cree 2023-03-27  433  		NL_SET_ERR_MSG_MOD(extack, "Ingress enc_key matches not supported");
b7f5e17b3bb961 Edward Cree 2023-03-27  434  		rc = -EOPNOTSUPP;
b7f5e17b3bb961 Edward Cree 2023-03-27  435  		goto release;

This goto confuses Smatch.  It could be converted to a direct return.

b7f5e17b3bb961 Edward Cree 2023-03-27  436  	}
d902e1a737d44e Edward Cree 2022-09-26  437  
d902e1a737d44e Edward Cree 2022-09-26  438  	if (tc->common.chain_index) {
ad1c80d5f777b8 Edward Cree 2022-10-18  439  		NL_SET_ERR_MSG_MOD(extack, "No support for nonzero chain_index");
d902e1a737d44e Edward Cree 2022-09-26  440  		return -EOPNOTSUPP;
d902e1a737d44e Edward Cree 2022-09-26  441  	}
d902e1a737d44e Edward Cree 2022-09-26  442  	match.mask.recirc_id = 0xff;
d902e1a737d44e Edward Cree 2022-09-26  443  
d902e1a737d44e Edward Cree 2022-09-26  444  	rc = efx_mae_match_check_caps(efx, &match.mask, extack);
d902e1a737d44e Edward Cree 2022-09-26  445  	if (rc)
d902e1a737d44e Edward Cree 2022-09-26  446  		return rc;
d902e1a737d44e Edward Cree 2022-09-26  447  
d902e1a737d44e Edward Cree 2022-09-26  448  	rule = kzalloc(sizeof(*rule), GFP_USER);
d902e1a737d44e Edward Cree 2022-09-26  449  	if (!rule)
d902e1a737d44e Edward Cree 2022-09-26 @450  		return -ENOMEM;
d902e1a737d44e Edward Cree 2022-09-26  451  	INIT_LIST_HEAD(&rule->acts.list);
d902e1a737d44e Edward Cree 2022-09-26  452  	rule->cookie = tc->cookie;
d902e1a737d44e Edward Cree 2022-09-26  453  	old = rhashtable_lookup_get_insert_fast(&efx->tc->match_action_ht,
d902e1a737d44e Edward Cree 2022-09-26  454  						&rule->linkage,
d902e1a737d44e Edward Cree 2022-09-26  455  						efx_tc_match_action_ht_params);
d902e1a737d44e Edward Cree 2022-09-26  456  	if (old) {
d902e1a737d44e Edward Cree 2022-09-26  457  		netif_dbg(efx, drv, efx->net_dev,
d902e1a737d44e Edward Cree 2022-09-26  458  			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
d902e1a737d44e Edward Cree 2022-09-26  459  		rc = -EEXIST;
d902e1a737d44e Edward Cree 2022-09-26  460  		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
d902e1a737d44e Edward Cree 2022-09-26  461  		goto release;

It looks like this error path is problematic because it will remove the
existing rule from the list.  Better to just do:

	if (old) {
		netif_dbg(...);
		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
		kfree(rule);
		return -EEXIST;
	}

d902e1a737d44e Edward Cree 2022-09-26  462  	}
d902e1a737d44e Edward Cree 2022-09-26  463  
d902e1a737d44e Edward Cree 2022-09-26  464  	/* Parse actions */
d902e1a737d44e Edward Cree 2022-09-26  465  	act = kzalloc(sizeof(*act), GFP_USER);
d902e1a737d44e Edward Cree 2022-09-26  466  	if (!act) {
d902e1a737d44e Edward Cree 2022-09-26  467  		rc = -ENOMEM;
d902e1a737d44e Edward Cree 2022-09-26  468  		goto release;
d902e1a737d44e Edward Cree 2022-09-26  469  	}
d902e1a737d44e Edward Cree 2022-09-26  470  
edd025ca088719 Edward Cree 2023-03-27  471  	/**
edd025ca088719 Edward Cree 2023-03-27  472  	 * DOC: TC action translation
edd025ca088719 Edward Cree 2023-03-27  473  	 *
edd025ca088719 Edward Cree 2023-03-27  474  	 * Actions in TC are sequential and cumulative, with delivery actions
edd025ca088719 Edward Cree 2023-03-27  475  	 * potentially anywhere in the order.  The EF100 MAE, however, takes
edd025ca088719 Edward Cree 2023-03-27  476  	 * an 'action set list' consisting of 'action sets', each of which is
edd025ca088719 Edward Cree 2023-03-27  477  	 * applied to the _original_ packet, and consists of a set of optional
edd025ca088719 Edward Cree 2023-03-27  478  	 * actions in a fixed order with delivery at the end.
edd025ca088719 Edward Cree 2023-03-27  479  	 * To translate between these two models, we maintain a 'cursor', @act,
edd025ca088719 Edward Cree 2023-03-27  480  	 * which describes the cumulative effect of all the packet-mutating
edd025ca088719 Edward Cree 2023-03-27  481  	 * actions encountered so far; on handling a delivery (mirred or drop)
edd025ca088719 Edward Cree 2023-03-27  482  	 * action, once the action-set has been inserted into hardware, we
edd025ca088719 Edward Cree 2023-03-27  483  	 * append @act to the action-set list (@rule->acts); if this is a pipe
edd025ca088719 Edward Cree 2023-03-27  484  	 * action (mirred mirror) we then allocate a new @act with a copy of
edd025ca088719 Edward Cree 2023-03-27  485  	 * the cursor state _before_ the delivery action, otherwise we set @act
edd025ca088719 Edward Cree 2023-03-27  486  	 * to %NULL.
edd025ca088719 Edward Cree 2023-03-27  487  	 * This ensures that every allocated action-set is either attached to
edd025ca088719 Edward Cree 2023-03-27  488  	 * @rule->acts or pointed to by @act (and never both), and that only
edd025ca088719 Edward Cree 2023-03-27  489  	 * those action-sets in @rule->acts exist in hardware.  Consequently,
edd025ca088719 Edward Cree 2023-03-27  490  	 * in the failure path, @act only needs to be freed in memory, whereas
edd025ca088719 Edward Cree 2023-03-27  491  	 * for @rule->acts we remove each action-set from hardware before
edd025ca088719 Edward Cree 2023-03-27  492  	 * freeing it (efx_tc_free_action_set_list()), even if the action-set
edd025ca088719 Edward Cree 2023-03-27  493  	 * list itself is not in hardware.
edd025ca088719 Edward Cree 2023-03-27  494  	 */
d902e1a737d44e Edward Cree 2022-09-26  495  	flow_action_for_each(i, fa, &fr->action) {
d902e1a737d44e Edward Cree 2022-09-26  496  		struct efx_tc_action_set save;
05ccd8d8a15e6b Edward Cree 2023-03-09  497  		u16 tci;
d902e1a737d44e Edward Cree 2022-09-26  498  
d902e1a737d44e Edward Cree 2022-09-26  499  		if (!act) {
d902e1a737d44e Edward Cree 2022-09-26  500  			/* more actions after a non-pipe action */
ad1c80d5f777b8 Edward Cree 2022-10-18  501  			NL_SET_ERR_MSG_MOD(extack, "Action follows non-pipe action");
d902e1a737d44e Edward Cree 2022-09-26  502  			rc = -EINVAL;
d902e1a737d44e Edward Cree 2022-09-26  503  			goto release;
d902e1a737d44e Edward Cree 2022-09-26  504  		}
d902e1a737d44e Edward Cree 2022-09-26  505  
2e0f1eb05692b4 Edward Cree 2022-11-14  506  		if ((fa->id == FLOW_ACTION_REDIRECT ||
2e0f1eb05692b4 Edward Cree 2022-11-14  507  		     fa->id == FLOW_ACTION_MIRRED ||
2e0f1eb05692b4 Edward Cree 2022-11-14  508  		     fa->id == FLOW_ACTION_DROP) && fa->hw_stats) {
2e0f1eb05692b4 Edward Cree 2022-11-14  509  			struct efx_tc_counter_index *ctr;
2e0f1eb05692b4 Edward Cree 2022-11-14  510  
83a187a4eb3a8d Edward Cree 2022-11-14  511  			/* Currently the only actions that want stats are
83a187a4eb3a8d Edward Cree 2022-11-14  512  			 * mirred and gact (ok, shot, trap, goto-chain), which
83a187a4eb3a8d Edward Cree 2022-11-14  513  			 * means we want stats just before delivery.  Also,
83a187a4eb3a8d Edward Cree 2022-11-14  514  			 * note that tunnel_key set shouldn't change the length
83a187a4eb3a8d Edward Cree 2022-11-14  515  			 * — it's only the subsequent mirred that does that,
83a187a4eb3a8d Edward Cree 2022-11-14  516  			 * and the stats are taken _before_ the mirred action
83a187a4eb3a8d Edward Cree 2022-11-14  517  			 * happens.
83a187a4eb3a8d Edward Cree 2022-11-14  518  			 */
83a187a4eb3a8d Edward Cree 2022-11-14  519  			if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_COUNT)) {
83a187a4eb3a8d Edward Cree 2022-11-14  520  				/* All supported actions that count either steal
83a187a4eb3a8d Edward Cree 2022-11-14  521  				 * (gact shot, mirred redirect) or clone act
83a187a4eb3a8d Edward Cree 2022-11-14  522  				 * (mirred mirror), so we should never get two
83a187a4eb3a8d Edward Cree 2022-11-14  523  				 * count actions on one action_set.
83a187a4eb3a8d Edward Cree 2022-11-14  524  				 */
83a187a4eb3a8d Edward Cree 2022-11-14  525  				NL_SET_ERR_MSG_MOD(extack, "Count-action conflict (can't happen)");
83a187a4eb3a8d Edward Cree 2022-11-14  526  				rc = -EOPNOTSUPP;
83a187a4eb3a8d Edward Cree 2022-11-14  527  				goto release;
83a187a4eb3a8d Edward Cree 2022-11-14  528  			}
83a187a4eb3a8d Edward Cree 2022-11-14  529  
2e0f1eb05692b4 Edward Cree 2022-11-14  530  			if (!(fa->hw_stats & FLOW_ACTION_HW_STATS_DELAYED)) {
2e0f1eb05692b4 Edward Cree 2022-11-14  531  				NL_SET_ERR_MSG_FMT_MOD(extack, "hw_stats_type %u not supported (only 'delayed')",
2e0f1eb05692b4 Edward Cree 2022-11-14  532  						       fa->hw_stats);
2e0f1eb05692b4 Edward Cree 2022-11-14  533  				rc = -EOPNOTSUPP;
2e0f1eb05692b4 Edward Cree 2022-11-14  534  				goto release;
2e0f1eb05692b4 Edward Cree 2022-11-14  535  			}
2e0f1eb05692b4 Edward Cree 2022-11-14  536  
2e0f1eb05692b4 Edward Cree 2022-11-14  537  			ctr = efx_tc_flower_get_counter_index(efx, tc->cookie,
2e0f1eb05692b4 Edward Cree 2022-11-14  538  							      EFX_TC_COUNTER_TYPE_AR);
2e0f1eb05692b4 Edward Cree 2022-11-14  539  			if (IS_ERR(ctr)) {
2e0f1eb05692b4 Edward Cree 2022-11-14  540  				rc = PTR_ERR(ctr);
2e0f1eb05692b4 Edward Cree 2022-11-14  541  				NL_SET_ERR_MSG_MOD(extack, "Failed to obtain a counter");
2e0f1eb05692b4 Edward Cree 2022-11-14  542  				goto release;
2e0f1eb05692b4 Edward Cree 2022-11-14  543  			}
2e0f1eb05692b4 Edward Cree 2022-11-14  544  			act->count = ctr;
2e0f1eb05692b4 Edward Cree 2022-11-14  545  		}
2e0f1eb05692b4 Edward Cree 2022-11-14  546  
d902e1a737d44e Edward Cree 2022-09-26  547  		switch (fa->id) {
d902e1a737d44e Edward Cree 2022-09-26  548  		case FLOW_ACTION_DROP:
d902e1a737d44e Edward Cree 2022-09-26  549  			rc = efx_mae_alloc_action_set(efx, act);
d902e1a737d44e Edward Cree 2022-09-26  550  			if (rc) {
ad1c80d5f777b8 Edward Cree 2022-10-18  551  				NL_SET_ERR_MSG_MOD(extack, "Failed to write action set to hw (drop)");
d902e1a737d44e Edward Cree 2022-09-26  552  				goto release;
d902e1a737d44e Edward Cree 2022-09-26  553  			}
d902e1a737d44e Edward Cree 2022-09-26  554  			list_add_tail(&act->list, &rule->acts.list);
d902e1a737d44e Edward Cree 2022-09-26  555  			act = NULL; /* end of the line */
d902e1a737d44e Edward Cree 2022-09-26  556  			break;
d902e1a737d44e Edward Cree 2022-09-26  557  		case FLOW_ACTION_REDIRECT:
d902e1a737d44e Edward Cree 2022-09-26  558  		case FLOW_ACTION_MIRRED:
d902e1a737d44e Edward Cree 2022-09-26  559  			save = *act;
83a187a4eb3a8d Edward Cree 2022-11-14  560  
83a187a4eb3a8d Edward Cree 2022-11-14  561  			if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_DELIVER)) {
83a187a4eb3a8d Edward Cree 2022-11-14  562  				/* can't happen */
83a187a4eb3a8d Edward Cree 2022-11-14  563  				rc = -EOPNOTSUPP;
83a187a4eb3a8d Edward Cree 2022-11-14  564  				NL_SET_ERR_MSG_MOD(extack, "Deliver action violates action order (can't happen)");
83a187a4eb3a8d Edward Cree 2022-11-14  565  				goto release;
83a187a4eb3a8d Edward Cree 2022-11-14  566  			}
83a187a4eb3a8d Edward Cree 2022-11-14  567  
d902e1a737d44e Edward Cree 2022-09-26  568  			to_efv = efx_tc_flower_lookup_efv(efx, fa->dev);
d902e1a737d44e Edward Cree 2022-09-26  569  			if (IS_ERR(to_efv)) {
ad1c80d5f777b8 Edward Cree 2022-10-18  570  				NL_SET_ERR_MSG_MOD(extack, "Mirred egress device not on switch");
d902e1a737d44e Edward Cree 2022-09-26  571  				rc = PTR_ERR(to_efv);
d902e1a737d44e Edward Cree 2022-09-26  572  				goto release;
d902e1a737d44e Edward Cree 2022-09-26  573  			}
d902e1a737d44e Edward Cree 2022-09-26  574  			rc = efx_tc_flower_external_mport(efx, to_efv);
d902e1a737d44e Edward Cree 2022-09-26  575  			if (rc < 0) {
ad1c80d5f777b8 Edward Cree 2022-10-18  576  				NL_SET_ERR_MSG_MOD(extack, "Failed to identify egress m-port");
d902e1a737d44e Edward Cree 2022-09-26  577  				goto release;
d902e1a737d44e Edward Cree 2022-09-26  578  			}
d902e1a737d44e Edward Cree 2022-09-26  579  			act->dest_mport = rc;
d902e1a737d44e Edward Cree 2022-09-26  580  			act->deliver = 1;
d902e1a737d44e Edward Cree 2022-09-26  581  			rc = efx_mae_alloc_action_set(efx, act);
d902e1a737d44e Edward Cree 2022-09-26  582  			if (rc) {
ad1c80d5f777b8 Edward Cree 2022-10-18  583  				NL_SET_ERR_MSG_MOD(extack, "Failed to write action set to hw (mirred)");
d902e1a737d44e Edward Cree 2022-09-26  584  				goto release;
d902e1a737d44e Edward Cree 2022-09-26  585  			}
d902e1a737d44e Edward Cree 2022-09-26  586  			list_add_tail(&act->list, &rule->acts.list);
d902e1a737d44e Edward Cree 2022-09-26  587  			act = NULL;
d902e1a737d44e Edward Cree 2022-09-26  588  			if (fa->id == FLOW_ACTION_REDIRECT)
d902e1a737d44e Edward Cree 2022-09-26  589  				break; /* end of the line */
d902e1a737d44e Edward Cree 2022-09-26  590  			/* Mirror, so continue on with saved act */
2e0f1eb05692b4 Edward Cree 2022-11-14  591  			save.count = NULL;
d902e1a737d44e Edward Cree 2022-09-26  592  			act = kzalloc(sizeof(*act), GFP_USER);
d902e1a737d44e Edward Cree 2022-09-26  593  			if (!act) {
d902e1a737d44e Edward Cree 2022-09-26  594  				rc = -ENOMEM;
d902e1a737d44e Edward Cree 2022-09-26  595  				goto release;
d902e1a737d44e Edward Cree 2022-09-26  596  			}
d902e1a737d44e Edward Cree 2022-09-26  597  			*act = save;
d902e1a737d44e Edward Cree 2022-09-26  598  			break;
05ccd8d8a15e6b Edward Cree 2023-03-09  599  		case FLOW_ACTION_VLAN_POP:
05ccd8d8a15e6b Edward Cree 2023-03-09  600  			if (act->vlan_push) {
05ccd8d8a15e6b Edward Cree 2023-03-09  601  				act->vlan_push--;
05ccd8d8a15e6b Edward Cree 2023-03-09  602  			} else if (efx_tc_flower_action_order_ok(act, EFX_TC_AO_VLAN_POP)) {
05ccd8d8a15e6b Edward Cree 2023-03-09  603  				act->vlan_pop++;
05ccd8d8a15e6b Edward Cree 2023-03-09  604  			} else {
05ccd8d8a15e6b Edward Cree 2023-03-09  605  				NL_SET_ERR_MSG_MOD(extack,
05ccd8d8a15e6b Edward Cree 2023-03-09  606  						   "More than two VLAN pops, or action order violated");
05ccd8d8a15e6b Edward Cree 2023-03-09  607  				rc = -EINVAL;
05ccd8d8a15e6b Edward Cree 2023-03-09  608  				goto release;
05ccd8d8a15e6b Edward Cree 2023-03-09  609  			}
05ccd8d8a15e6b Edward Cree 2023-03-09  610  			break;
05ccd8d8a15e6b Edward Cree 2023-03-09  611  		case FLOW_ACTION_VLAN_PUSH:
05ccd8d8a15e6b Edward Cree 2023-03-09  612  			if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_VLAN_PUSH)) {
05ccd8d8a15e6b Edward Cree 2023-03-09  613  				rc = -EINVAL;
05ccd8d8a15e6b Edward Cree 2023-03-09  614  				NL_SET_ERR_MSG_MOD(extack,
05ccd8d8a15e6b Edward Cree 2023-03-09  615  						   "More than two VLAN pushes, or action order violated");
05ccd8d8a15e6b Edward Cree 2023-03-09  616  				goto release;
05ccd8d8a15e6b Edward Cree 2023-03-09  617  			}
05ccd8d8a15e6b Edward Cree 2023-03-09  618  			tci = fa->vlan.vid & VLAN_VID_MASK;
05ccd8d8a15e6b Edward Cree 2023-03-09  619  			tci |= fa->vlan.prio << VLAN_PRIO_SHIFT;
05ccd8d8a15e6b Edward Cree 2023-03-09  620  			act->vlan_tci[act->vlan_push] = cpu_to_be16(tci);
05ccd8d8a15e6b Edward Cree 2023-03-09  621  			act->vlan_proto[act->vlan_push] = fa->vlan.proto;
05ccd8d8a15e6b Edward Cree 2023-03-09  622  			act->vlan_push++;
05ccd8d8a15e6b Edward Cree 2023-03-09  623  			break;
d902e1a737d44e Edward Cree 2022-09-26  624  		default:
ad1c80d5f777b8 Edward Cree 2022-10-18  625  			NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled action %u",
ad1c80d5f777b8 Edward Cree 2022-10-18  626  					       fa->id);
d902e1a737d44e Edward Cree 2022-09-26  627  			rc = -EOPNOTSUPP;
d902e1a737d44e Edward Cree 2022-09-26  628  			goto release;
d902e1a737d44e Edward Cree 2022-09-26  629  		}
d902e1a737d44e Edward Cree 2022-09-26  630  	}
d902e1a737d44e Edward Cree 2022-09-26  631  
d902e1a737d44e Edward Cree 2022-09-26  632  	if (act) {
d902e1a737d44e Edward Cree 2022-09-26  633  		/* Not shot/redirected, so deliver to default dest */
d902e1a737d44e Edward Cree 2022-09-26  634  		if (from_efv == EFX_EFV_PF)
d902e1a737d44e Edward Cree 2022-09-26  635  			/* Rule applies to traffic from the wire,
d902e1a737d44e Edward Cree 2022-09-26  636  			 * and default dest is thus the PF
d902e1a737d44e Edward Cree 2022-09-26  637  			 */
d902e1a737d44e Edward Cree 2022-09-26  638  			efx_mae_mport_uplink(efx, &act->dest_mport);
d902e1a737d44e Edward Cree 2022-09-26  639  		else
d902e1a737d44e Edward Cree 2022-09-26  640  			/* Representor, so rule applies to traffic from
d902e1a737d44e Edward Cree 2022-09-26  641  			 * representee, and default dest is thus the rep.
d902e1a737d44e Edward Cree 2022-09-26  642  			 * All reps use the same mport for delivery
d902e1a737d44e Edward Cree 2022-09-26  643  			 */
d902e1a737d44e Edward Cree 2022-09-26  644  			efx_mae_mport_mport(efx, efx->tc->reps_mport_id,
d902e1a737d44e Edward Cree 2022-09-26  645  					    &act->dest_mport);
d902e1a737d44e Edward Cree 2022-09-26  646  		act->deliver = 1;
d902e1a737d44e Edward Cree 2022-09-26  647  		rc = efx_mae_alloc_action_set(efx, act);
d902e1a737d44e Edward Cree 2022-09-26  648  		if (rc) {
ad1c80d5f777b8 Edward Cree 2022-10-18  649  			NL_SET_ERR_MSG_MOD(extack, "Failed to write action set to hw (deliver)");
d902e1a737d44e Edward Cree 2022-09-26  650  			goto release;
d902e1a737d44e Edward Cree 2022-09-26  651  		}
d902e1a737d44e Edward Cree 2022-09-26  652  		list_add_tail(&act->list, &rule->acts.list);
d902e1a737d44e Edward Cree 2022-09-26  653  		act = NULL; /* Prevent double-free in error path */
d902e1a737d44e Edward Cree 2022-09-26  654  	}
d902e1a737d44e Edward Cree 2022-09-26  655  
d902e1a737d44e Edward Cree 2022-09-26  656  	netif_dbg(efx, drv, efx->net_dev,
d902e1a737d44e Edward Cree 2022-09-26  657  		  "Successfully parsed filter (cookie %lx)\n",
d902e1a737d44e Edward Cree 2022-09-26  658  		  tc->cookie);
d902e1a737d44e Edward Cree 2022-09-26  659  
d902e1a737d44e Edward Cree 2022-09-26  660  	rule->match = match;
d902e1a737d44e Edward Cree 2022-09-26  661  
d902e1a737d44e Edward Cree 2022-09-26  662  	rc = efx_mae_alloc_action_set_list(efx, &rule->acts);
d902e1a737d44e Edward Cree 2022-09-26  663  	if (rc) {
ad1c80d5f777b8 Edward Cree 2022-10-18  664  		NL_SET_ERR_MSG_MOD(extack, "Failed to write action set list to hw");
d902e1a737d44e Edward Cree 2022-09-26  665  		goto release;
d902e1a737d44e Edward Cree 2022-09-26  666  	}
d902e1a737d44e Edward Cree 2022-09-26  667  	rc = efx_mae_insert_rule(efx, &rule->match, EFX_TC_PRIO_TC,
d902e1a737d44e Edward Cree 2022-09-26  668  				 rule->acts.fw_id, &rule->fw_id);
d902e1a737d44e Edward Cree 2022-09-26  669  	if (rc) {
ad1c80d5f777b8 Edward Cree 2022-10-18  670  		NL_SET_ERR_MSG_MOD(extack, "Failed to insert rule in hw");
d902e1a737d44e Edward Cree 2022-09-26  671  		goto release_acts;
d902e1a737d44e Edward Cree 2022-09-26  672  	}
d902e1a737d44e Edward Cree 2022-09-26  673  	return 0;
d902e1a737d44e Edward Cree 2022-09-26  674  
d902e1a737d44e Edward Cree 2022-09-26  675  release_acts:
d902e1a737d44e Edward Cree 2022-09-26  676  	efx_mae_free_action_set_list(efx, &rule->acts);
d902e1a737d44e Edward Cree 2022-09-26  677  release:
d902e1a737d44e Edward Cree 2022-09-26  678  	/* We failed to insert the rule, so free up any entries we created in
d902e1a737d44e Edward Cree 2022-09-26  679  	 * subsidiary tables.
d902e1a737d44e Edward Cree 2022-09-26  680  	 */
d902e1a737d44e Edward Cree 2022-09-26  681  	if (act)
d902e1a737d44e Edward Cree 2022-09-26  682  		efx_tc_free_action_set(efx, act, false);
d902e1a737d44e Edward Cree 2022-09-26  683  	if (rule) {
d902e1a737d44e Edward Cree 2022-09-26  684  		rhashtable_remove_fast(&efx->tc->match_action_ht,
d902e1a737d44e Edward Cree 2022-09-26  685  				       &rule->linkage,
d902e1a737d44e Edward Cree 2022-09-26  686  				       efx_tc_match_action_ht_params);
d902e1a737d44e Edward Cree 2022-09-26  687  		efx_tc_free_action_set_list(efx, &rule->acts, false);
d902e1a737d44e Edward Cree 2022-09-26  688  	}
d902e1a737d44e Edward Cree 2022-09-26  689  	kfree(rule);
d902e1a737d44e Edward Cree 2022-09-26  690  	return rc;
d902e1a737d44e Edward Cree 2022-09-26  691  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

