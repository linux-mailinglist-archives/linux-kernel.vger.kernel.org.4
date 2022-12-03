Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C036641306
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiLCB02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLCB00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBCE9857C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A615B6247E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC94C433D6;
        Sat,  3 Dec 2022 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670030785;
        bh=KYVXyb44JPbk5CAI3bCh8ypazbrd8rjfxTYtVAgI0KQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=maY2yO2s633Wy7tb92FYspsb1sjTTMlC83CgBzMUPZBuZ4zoD8GqIKXe4Si9aVQ5C
         5PqR2r0loi5OzTnxMEmBW1GJYS6Qzp9FIWn+CswKOTjDCYdNNHRmL51dq/VSoeDJlT
         7hCGKDdnhPV5d0H9ZlZUFHeORgjAuUH53S6atNN0pZy8QEoViRubzI5czxUSwxK2X8
         wZ+F7/m5VqXEyIRZCDhb/61uf4c+nViGDJqZu+bu01W0y1jkP2xWkI9e0iOu/qkUTP
         O6v7e++bEdBSy7qkVsgckFFS7IDUZfIWS3JN5G7TAdOsJxNdyqxkhmaPg8PoFG+t1v
         xOpjJVocp2cmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2BAB5C095D; Fri,  2 Dec 2022 17:26:24 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:26:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, w@1wt.eu
Subject: [GIT PULL] nolibc changes for v6.2
Message-ID: <20221203012624.GA1817011@paulmck-ThinkPad-P17-Gen-1>
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

Once the merge window opens, please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.12.02a
  # HEAD: 4a95be7ed7669311350d041ca6cd37bf96f92d8c: selftests/nolibc: Always rebuild the sysroot when running a test (2022-10-28 15:17:22 -0700)

----------------------------------------------------------------
nolibc updates for v6.2

This branch further improves nolibc testing.

----------------------------------------------------------------
Willy Tarreau (2):
      selftests/nolibc: Add 7 tests for memcmp()
      selftests/nolibc: Always rebuild the sysroot when running a test

 tools/testing/selftests/nolibc/Makefile      | 3 +++
 tools/testing/selftests/nolibc/nolibc-test.c | 7 +++++++
 2 files changed, 10 insertions(+)
