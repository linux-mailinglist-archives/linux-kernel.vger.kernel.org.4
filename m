Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457E26F8FD4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjEFHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEFHWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:22:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F29EEA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:22:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f37a36b713so26469325e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683357730; x=1685949730;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fU8R1W3uogRJdDg/JWNdRA3Ig28vXMtcdzNpjKyBWIM=;
        b=gPkq3wpwgrS/A42ZKMHL1vRn5ZFM+mgclPQcIjyISVniLUPVSR/+bsR2Lv+O8+cmyG
         YWZTD+B5j8Tt0exVG8JXqwuMdZOivCrHchdGPIAs3ajpZmDQno7L8O6NlZbHXmy/ix+o
         E83Q23nGpCLZVF+w3Gly9tAvQzymNEAtCzT1D9+6dcssA6jgR3sEHqQInxqFqt9w2OLa
         ZavMxycHFQc3+HTms2teIGblYS6s7F/Qg8puK+K6ASKd5Xirbn2bDYKYYvE7fFebAjLz
         96JvC1BzZmUQj0rh+Zgwo88JQa9gnEuGYpcjOPNXjIq4m1exRyHFW5kl0cZFr5+tYeT4
         c3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683357730; x=1685949730;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU8R1W3uogRJdDg/JWNdRA3Ig28vXMtcdzNpjKyBWIM=;
        b=lENPLpM8AUl8CDeHkZ7thD9eRKK4bOQRK5n+gDqydEBFOKTQC620ZDwIZsjevYgEsP
         Vzg1kksSRmrVge690ZwXIDjdICvEKOaFMPzxvq/0pRwm5IzLTfHgLzdWXqHYF5T18eWb
         T1alDa7hVKwF1hEBiCivAfhGLqLh1wSxy5jTRd58TC7+8b88OJ7EKinUFFQREga4f37t
         wCBocV5vHKVNYNr0SXWvPsxKcbq2woYmn+wvkyUA+vun7w3m/A+DoCJcpjvmFVla+C61
         tWkd39+dCJWuwV4HxvmlhJh1UtIqaKz4kYc6B8NXUwACSvqA1yXlUMnhbW+74XxxIKHw
         ttDQ==
X-Gm-Message-State: AC+VfDwJ69Rf4JLZGS1FVlY4doSq83PgDbZH1hhkSRbH08/AgUk0OehH
        3jjlufHbyF9GSjEANszxirlYng==
X-Google-Smtp-Source: ACHHUZ7oqPu5QkfMYeUvctqCAVp7tcfmTRNn8dSDVaG/rX3gdu3RFZzbOmtZr7HaMTXiOi/BkRaD/g==
X-Received: by 2002:a1c:ed13:0:b0:3f0:b095:15d9 with SMTP id l19-20020a1ced13000000b003f0b09515d9mr2466239wmh.40.1683357730343;
        Sat, 06 May 2023 00:22:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b003f193d7c6b7sm9856630wme.41.2023.05.06.00.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:22:07 -0700 (PDT)
Date:   Sat, 6 May 2023 10:22:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: kernel/rcu/srcutree.c:1644 srcu_advance_state() warn: inconsistent
 returns '&ssp->srcu_sup->srcu_gp_mutex'.
Message-ID: <c0937326-1cf1-429a-9883-30d9d79b01d0@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
head:   418d5c98319f67b9ae651babea031b5394425c18
commit: e3a6ab25cfa0fcdcb31c346b9871a566d440980d srcu: Move ->srcu_gp_mutex from srcu_struct to srcu_usage
config: x86_64-randconfig-m001-20230501 (https://download.01.org/0day-ci/archive/20230506/202305060951.I8mz6eHt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305060951.I8mz6eHt-lkp@intel.com/

smatch warnings:
kernel/rcu/srcutree.c:1644 srcu_advance_state() warn: inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.

vim +1644 kernel/rcu/srcutree.c

aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1584  static void srcu_advance_state(struct srcu_struct *ssp)
dad81a2026841b Paul E. McKenney 2017-03-25  1585  {
dad81a2026841b Paul E. McKenney 2017-03-25  1586  	int idx;
dad81a2026841b Paul E. McKenney 2017-03-25  1587  
e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1588  	mutex_lock(&ssp->srcu_sup->srcu_gp_mutex);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1589  
dad81a2026841b Paul E. McKenney 2017-03-25  1590  	/*
dad81a2026841b Paul E. McKenney 2017-03-25  1591  	 * Because readers might be delayed for an extended period after
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1592  	 * fetching ->srcu_idx for their index, at any point in time there
dad81a2026841b Paul E. McKenney 2017-03-25  1593  	 * might well be readers using both idx=0 and idx=1.  We therefore
dad81a2026841b Paul E. McKenney 2017-03-25  1594  	 * need to wait for readers to clear from both index values before
dad81a2026841b Paul E. McKenney 2017-03-25  1595  	 * invoking a callback.
dad81a2026841b Paul E. McKenney 2017-03-25  1596  	 *
dad81a2026841b Paul E. McKenney 2017-03-25  1597  	 * The load-acquire ensures that we see the accesses performed
dad81a2026841b Paul E. McKenney 2017-03-25  1598  	 * by the prior grace period.
dad81a2026841b Paul E. McKenney 2017-03-25  1599  	 */
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1600  	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq)); /* ^^^ */
dad81a2026841b Paul E. McKenney 2017-03-25  1601  	if (idx == SRCU_STATE_IDLE) {
b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1602  		spin_lock_irq_rcu_node(ssp->srcu_sup);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1603  		if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1604  			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq));
b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1605  			spin_unlock_irq_rcu_node(ssp->srcu_sup);
e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1606  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
dad81a2026841b Paul E. McKenney 2017-03-25  1607  			return;
dad81a2026841b Paul E. McKenney 2017-03-25  1608  		}
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1609  		idx = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
dad81a2026841b Paul E. McKenney 2017-03-25  1610  		if (idx == SRCU_STATE_IDLE)
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1611  			srcu_gp_start(ssp);
b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1612  		spin_unlock_irq_rcu_node(ssp->srcu_sup);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1613  		if (idx != SRCU_STATE_IDLE) {
e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1614  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
dad81a2026841b Paul E. McKenney 2017-03-25  1615  			return; /* Someone else started the grace period. */
dad81a2026841b Paul E. McKenney 2017-03-25  1616  		}
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1617  	}
dad81a2026841b Paul E. McKenney 2017-03-25  1618  
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1619  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1620  		idx = 1 ^ (ssp->srcu_idx & 1);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1621  		if (!try_check_zero(ssp, idx, 1)) {
e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1622  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
dad81a2026841b Paul E. McKenney 2017-03-25  1623  			return; /* readers present, retry later. */
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1624  		}
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1625  		srcu_flip(ssp);
b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1626  		spin_lock_irq_rcu_node(ssp->srcu_sup);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1627  		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
282d8998e9979c Paul E. McKenney 2022-03-08  1628  		ssp->srcu_n_exp_nodelay = 0;
b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1629  		spin_unlock_irq_rcu_node(ssp->srcu_sup);
dad81a2026841b Paul E. McKenney 2017-03-25  1630  	}
dad81a2026841b Paul E. McKenney 2017-03-25  1631  
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1632  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {

We don't mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex) if this if
statement is false.

dad81a2026841b Paul E. McKenney 2017-03-25  1633  
dad81a2026841b Paul E. McKenney 2017-03-25  1634  		/*
dad81a2026841b Paul E. McKenney 2017-03-25  1635  		 * SRCU read-side critical sections are normally short,
dad81a2026841b Paul E. McKenney 2017-03-25  1636  		 * so check at least twice in quick succession after a flip.
dad81a2026841b Paul E. McKenney 2017-03-25  1637  		 */
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1638  		idx = 1 ^ (ssp->srcu_idx & 1);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1639  		if (!try_check_zero(ssp, idx, 2)) {
e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1640  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1641  			return; /* readers present, retry later. */
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1642  		}
282d8998e9979c Paul E. McKenney 2022-03-08  1643  		ssp->srcu_n_exp_nodelay = 0;
aacb5d91ab1bfb Paul E. McKenney 2018-10-28 @1644  		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
dad81a2026841b Paul E. McKenney 2017-03-25  1645  	}
dad81a2026841b Paul E. McKenney 2017-03-25  1646  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

