Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5EF65E203
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAEAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAEAvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:51:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE950F71;
        Wed,  4 Jan 2023 16:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50D76188F;
        Thu,  5 Jan 2023 00:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62EC433D2;
        Thu,  5 Jan 2023 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879607;
        bh=tJya2/iQZ3L5zGRm70FEzxNq6pnyLaInRqQjwPOtMGU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=C2D5grO+ISTNJDrkI45mNrBgBNBcgb99WihvLWvxoSSUy4lT8NRSfaBgI1lNXIEy8
         JvfGozMV9UoJmT0O95vmOld/UmmmPqC2q1CEAEESEezkRTuF+0kfiwovfDSUUwm/86
         xfiV9dWXpTvY6S+ySC/ebb9eCIVQyjwjx36vHNJFbPdKe9vHBhvJ8L2OQ7xYcytgzs
         TuQn4RtQBwp9Im48uccP0Y3+u3nYj28SfXj9zYTpi/psfca996GyJokYD/CkcLyY+0
         ADuLh+YyFihoEBba9acibVpgAuFCO6Xyr7pW5DEJM5QaTDARQZ1L6ANxzFIwCOYL3h
         XwZqy+m4FJ2XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B1515C05CA; Wed,  4 Jan 2023 16:46:46 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:46:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Torture-test scripting updates for v6.3
Message-ID: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
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

Hello!

This series provides torture-test scripting updates:

1.	make kvm-find-errors.sh check for compressed vmlinux files.

2.	rcutorture: Use "grep -E" instead of "egrep", courtesy of
	Tiezhu Yang.

3.	Permit double-quoted-string Kconfig options.

4.	Permit string-valued Kconfig options in kvm.sh.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/configcheck.sh     |    5 ++---
 b/tools/testing/selftests/rcutorture/bin/console-badness.sh |    2 +-
 b/tools/testing/selftests/rcutorture/bin/kvm-build.sh       |    4 ++--
 b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh |    2 +-
 b/tools/testing/selftests/rcutorture/bin/kvm.sh             |    4 ++--
 b/tools/testing/selftests/rcutorture/bin/parse-console.sh   |   10 +++++-----
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh   |    4 ++--
 tools/testing/selftests/rcutorture/bin/kvm.sh               |    2 +-
 8 files changed, 16 insertions(+), 17 deletions(-)
