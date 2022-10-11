Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562FD5FAB59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJKDnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJKDnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:43:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C280F70
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B44AB811E1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E63C433D7;
        Tue, 11 Oct 2022 03:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459802;
        bh=K+olXmzDzIXG1DsJtvMb2FoJHr2ZlDneaaIByHunLOc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LDb2S1z81gBZpf958yvNIbXmlz4oMP2g7ID26YHSFmuXr7O9m/SmxfWS+2eSzK27a
         P6K6Cb7DhXDJhuvnJmtJe7f/JxLMHFZary6hRL9nDYylpKbZlTaBAjdvugIXd+wRaX
         sR5UGm3ywgMYwoUQtxr6rNpBxKUji/UNz/QC1IIi+AJHd6FKZbVfu+ZYfY4K12+MTP
         aOMuEBN5Mn6UXYf8r3geqfETg12daIOBxPtxRJXGiu+5wU4rj7hxrQe5RMMd77tXhl
         pfGDjg6+COVE8lPnksvN8vu+rha47+LdHWzooFCR6jNH+hxltNvLcmPlLKlbtqaNOE
         nuBXkIBpg4NSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35314E270E4;
        Tue, 11 Oct 2022 03:43:22 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 debugfs improvements
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221009215553.380150-1-agruenba@redhat.com>
References: <20221009215553.380150-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221009215553.380150-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-nopid-for-v6.1
X-PR-Tracked-Commit-Id: c7d7d2d345697eb3781198e58a22504feb74af63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 288fc86067620dcbec34a335b95b75635551e8fe
Message-Id: <166545980221.4678.7707227886388276086.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:22 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  9 Oct 2022 23:55:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-nopid-for-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/288fc86067620dcbec34a335b95b75635551e8fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
