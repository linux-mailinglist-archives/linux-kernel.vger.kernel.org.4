Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6549A695566
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjBNAdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjBNAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:33:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631D1969E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7B8FB81A2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FFEC433EF;
        Tue, 14 Feb 2023 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676334817;
        bh=/do0D6iRKp1copguw3lgY3LpRB5yMBGMUMUs4OVo/gU=;
        h=From:To:Cc:Subject:Date:From;
        b=cbOu9dqIVMv0yT0piNMsGLWl+ii4hW+oa0EUdbRKTl/ovD7nK3RA2pj4KH0BBGn9V
         c3P7WGCOihsEy6q3oGIGwSHcvtCnXQY1uTKXXs5FVrcpwhLy1pPLcZyTLM0aw++6x4
         ci9qELe1RfYTCcuTQZ57zb8XOcGQg4sMG961ShdsPIR8BDcBXZwB1PP/3sLvJbWfG+
         M6Lhao6cBD93V+iwwTHHNslXzWDL7x9Ne/p051lcSZGtdDMoCiRY/vhgWDGKsklBX0
         Yi1aYWpLLvkFzGqkHZlSM/MXuDm8HAl6BuDOc4ZQFRhUNYEU9k0kaB7XpnL5GHeEK9
         VYQwlvmZvCchA==
From:   SeongJae Park <sj@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Date:   Tue, 14 Feb 2023 00:33:28 +0000
Message-Id: <20230214003328.55285-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


DAMON has merged into mainline as a data access monitoring tool that equips a
best-effort overhead-accuracy tradeoff mechanism, and then extended for data
access-aware system operations.  I'd like to briefly introduce current state of
DAMON and share/discuss about 2023 plans including below.

- Finer and easier-to-use DAMOS tuning
  - tuning aggressiveness based on user or kernel feed (e.g., QPS or PSI)
- Merging DAMON user space tool into the mainline
- Extending DAMON
  - Page-granularity monitoring
    - LRU-lists based page-granulariy monitoring
  - CPU-specific access monitoring
  - Read/Write-only access monitoring
- More DAMON-based Operation Schemes
  - Tiered memory management
  - THP memory footprint reduction
  - NUMA balancing

I hope to hear concerns/interests about the plans for prioritizing each work
items and get some suggestions of future works and collaboration with other
kernel subsystems/hackers.


Thanks,
SJ
