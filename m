Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6ED5F7DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJGTVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiJGTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B5DBC624
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF1E61D1B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D666C433D6;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170420;
        bh=Qsa/F2GN8hxPZ+3jP5MRlcYQ8uML3IYNHae2xnlhXTc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LGi7cuUVAHFgYjzQ1XXb4VuKenTvM0zNfTfTjjYKOWKWZNYJk3f7XFKK9fdCVbyhu
         vgYAunUq2RDpJruS0w3kvYxW0Tq4GNwS9t+kpHTDx8e9R6Dk4g/Xp8JI3qGuG6YhXh
         o5T2Wl6CeC/vvXL4wLWZoX+FW9a+rvbvNEoRsTEnJOKMFeEyR1RAf6BkrX6XPQ8XEM
         Pvk/eZfC1ViyHHLOM0pehBQXbjSspjLtHbwlj/Ke0sqblPv/mseMf+J+FtxOhnBqxo
         3DIYbVWJ5DL3JCfT+UgEGYHhpvm6fJTH21C91OuEpeWHQ9cUdi8dtFDj817lc7i296
         lkRxGZw9Way4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 157C3E2A05C;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d21ce246-d3cb-e067-d482-92b12861846d@redhat.com>
References: <d21ce246-d3cb-e067-d482-92b12861846d@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d21ce246-d3cb-e067-d482-92b12861846d@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022100501
X-PR-Tracked-Commit-Id: cb7c02e91c31f55d08760f04a09bf9334d809426
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79d11de9637a37035b4a72ccb528b3dfebc1bf67
Message-Id: <166517042008.8063.1756221910821072145.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:20 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 10:34:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022100501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79d11de9637a37035b4a72ccb528b3dfebc1bf67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
