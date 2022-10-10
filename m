Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7155C5FA6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJJU5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiJJU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E15755B;
        Mon, 10 Oct 2022 13:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73E15B810EE;
        Mon, 10 Oct 2022 20:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E49C43141;
        Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435398;
        bh=NDqltLQ0Ui+t6al2QotVmad53F0fqVULXdqWCGSas5U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b1OHHm3jMDhtOfULwJPLD10sXjI4V7HBlCCbjt4xywOFytafN9xl8ZHplFGz6qTLY
         m0P2kMcAAaumWdkjl1l2XeCSIvfX2MD8rB8dzrO0aO35IR24VBLazn8Lis1P3X9akw
         YzzPEuc9XnP/u4aJKQafgqe0Fv9NnnxZ6wQeBQG398c2zmQqgMTWyXOHdPDIaUEpSs
         esCNwe/IQzjtWQb0+DgqLGZhpcZAmt4IoltF9okODCL+5OZxwpTb+jojZesyhzh7P3
         mcoU2qaMbWEIzzsvQkjTcWXB+RjF1jB0d0aS1fQnzBqV74oD8LYTA8RFbyD/98lb7F
         /mhHUMM3iqGWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1882DE2A05F;
        Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gMNxqYjxnWXweqAyc2BQgY0i0QKS60fm6CcYkRNdsh9A@mail.gmail.com>
References: <CAJZ5v0gMNxqYjxnWXweqAyc2BQgY0i0QKS60fm6CcYkRNdsh9A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gMNxqYjxnWXweqAyc2BQgY0i0QKS60fm6CcYkRNdsh9A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc1-2
X-PR-Tracked-Commit-Id: f7e6b99f22f22f3630139aeaeecb83d77e47bf9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f848b3cda39b5d41746040eb51f8e87a685bf0d9
Message-Id: <166543539809.11766.6921330006460656780.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:38 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 19:46:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f848b3cda39b5d41746040eb51f8e87a685bf0d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
