Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D26DE7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDKXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2BF26A6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C999F62C59
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AF9C433EF;
        Tue, 11 Apr 2023 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681254615;
        bh=iRSaQxMso9NMr7Mmouuhi8hqfQsK/M9/LJ/+YH83b4A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RR4i3nfvV2Gl/ByE//CQODdIMIw0z53H8jYiiaWodkASz+had1Cwwh/jqoOz/IUR7
         FIWL5kB/AmLxpVMWt/JV2uW6IVo8npeS7qIaxMsBgfk6CSTQDE5tkiuIQBbgHsvZlz
         4tZOgrhtTU/0Jm8RBHeJEzY2PvalUpgzWMrnmPYHP25ZRbUPhOE4L55eViS2mH8zZM
         5y+VSpGECdAHtlZoYKRYivIy6lnUbq+MK0LfwnKLS/aOUa+HtTdvdtKGBHOyUWHECy
         EaetVB3n6R+iQ85QiFHmug6C08Mmta7HSxHQaNOH4iJ2eEmDeJXFzZ/B7gvwIP5mci
         H2LB9rYRqhirQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B73981540478; Tue, 11 Apr 2023 16:10:14 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:10:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        stern@rowland.harvard.edu, jonas.oberhauser@huaweicloud.com,
        joel@joelfernandes.org, rdunlap@infradead.org
Subject: [GIT PULL] LKMM changes for v6.4
Message-ID: <628d04f3-8bd3-4950-bcbe-49ff52ec408b@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the v6.4 merge window opens, please pull these LKMM updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.04.07a
  # HEAD: 57373671d5f5a92ee02d32e0b8506351ae30d33f: Documentation: litmus-tests: Correct spelling (2023-03-22 12:02:21 -0700)

----------------------------------------------------------------
LKMM updates for v6.4

This update improves LKMM diagnostic messages, unifies handling
of the ordering produced by unlock/lock pairs, adds support for the
smp_mb__after_srcu_read_unlock() macro, removes redundant members from
the to-r relation, brings SRCU read-side semantics into alignment
with Linux-kernel SRCU, makes ppo a subrelation of po, and improves
documentation.

----------------------------------------------------------------
Alan Stern (3):
      tools/memory-model: Update some warning labels
      tools/memory-model: Provide exact SRCU semantics
      tools/memory-model: Add documentation about SRCU read-side critical sections

Joel Fernandes (Google) (1):
      tools/memory-model: Restrict to-r to read-read address dependency

Jonas Oberhauser (2):
      tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-po
      tools/memory-model: Make ppo a subrelation of po

Paul E. McKenney (1):
      tools/memory-model: Add smp_mb__after_srcu_read_unlock()

Randy Dunlap (1):
      Documentation: litmus-tests: Correct spelling

 Documentation/litmus-tests/README                |   2 +-
 tools/memory-model/Documentation/explanation.txt | 178 +++++++++++++++++++++--
 tools/memory-model/linux-kernel.bell             |  30 ++--
 tools/memory-model/linux-kernel.cat              |  20 ++-
 tools/memory-model/linux-kernel.def              |   7 +-
 tools/memory-model/lock.cat                      |   6 +-
 6 files changed, 204 insertions(+), 39 deletions(-)
