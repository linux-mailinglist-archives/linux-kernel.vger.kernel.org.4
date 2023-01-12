Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2596687B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbjALXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjALXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:01:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FC5FA0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:01:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7468CB8202B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23276C433D2;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673564470;
        bh=p3O0Qw1WuwZWGpdbTdqmkb3lhIwKhiikonGz9eFym04=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lt4KJluKeI8QrOz2C+fItgezp2OF0ch6eP5IwBsuCSzn/6z2zq9AzqPIqx9NF37b+
         qIxpJlaf4pE7CSekb3/op8ojBX/QdjqW5uW8p3lXwMV0mXUvhUTlmCwtlNAhrvf32q
         Yeb6gaVmJF2kZDwSIKDarKA0GTjbYoFlSbuGS0F8eklCdGimii1SeeD5z8rpczFpPv
         LQW4Pq1zs1pDgWKT/8VtqhbM1v0SYdoL8lqTSfc2uxY8fz1ji1Qw5MClFMi6uHtbLR
         jzbYpF0+WzSKUfQQJQWvphr1DEnKMmBD9OC+nfBvJhXCi5y5jp5XyTTHXjxH1I3UTu
         84fHdlSlsUKGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EADFC395C8;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc urgent fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230112004440.GA3134351@paulmck-ThinkPad-P17-Gen-1>
References: <20230112004440.GA3134351@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230112004440.GA3134351@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-nolibc.2023.01.09a
X-PR-Tracked-Commit-Id: 00b18da4089330196906b9fe075c581c17eb726c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f129b61612af0627fb208b5daf6666f7a3ad9e07
Message-Id: <167356447005.16103.8144489367584599862.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 23:01:10 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, svens@linux.ibm.com, imp@bsdimp.com, w@1wt.eu
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Jan 2023 16:44:40 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-nolibc.2023.01.09a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f129b61612af0627fb208b5daf6666f7a3ad9e07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
