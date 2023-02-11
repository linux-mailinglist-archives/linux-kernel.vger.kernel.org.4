Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6069333B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBKTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:11:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D7199EC;
        Sat, 11 Feb 2023 11:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94CB60BBD;
        Sat, 11 Feb 2023 19:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26B5DC4339C;
        Sat, 11 Feb 2023 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676142696;
        bh=7kZWaAlskOUzi/MYBilhV8xLgVGgJFzO+FM4bE3nWuQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p8/I1IbxoPX9V4r8+p9ChEPKRORgT4eMmgXFCu1tAyW3Xx3nOW7OkfOf8UkeEIVDU
         f2NzJUPt1f0vpPcZjT55dzNYhohBasaiDlHhl3yeoqCUikSIg4doUgi+qdYxFulU/q
         6R1e5+3ySkwBnuyfkhlCC0xAnM9slT0u2126twLN9ySC46j6353xgHLEOO+qMW3IKW
         SEwkcHLtUhbXPrZk6I74kasLYjaTWStdiyMRPps94o5AdroHEht/9rEWwmAe+ZThoL
         1TM1wW5p0GjIo1zNqHWtkJnjLECpWb989AL0nIry2tcpCqn6x5ferfDUnGeWTbfXTa
         2sjiY4Kt5b/Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14D8BE21EC8;
        Sat, 11 Feb 2023 19:11:36 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) fixes for 6.2-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63e700859e02a_88e1294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <63e700859e02a_88e1294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <63e700859e02a_88e1294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.2
X-PR-Tracked-Commit-Id: 711442e29f16f0d39dd0e2460c9baacfccb9d5a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d12aca5c0cee0da197ca55241bcc5ec55dd5ae58
Message-Id: <167614269608.18613.3418622327024670718.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Feb 2023 19:11:36 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 18:42:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d12aca5c0cee0da197ca55241bcc5ec55dd5ae58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
