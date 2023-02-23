Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDD6A12BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjBWWUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBWWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:20:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FA55C155
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 508466179B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E7B9C4339C;
        Thu, 23 Feb 2023 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677190808;
        bh=iEPL3oFNoYgPelrmi/ol3vJ9sytrXbzbbJ69QXNgnKA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zu2l9Dkfct9+PVlNIMpEKCDb9KL72+Ef3QFWPNLCe/vE/OPGWhJVfz8tsuTiiHSag
         A4Pl9LjtzqLB6Y3H3cH9XTFJsYRyr5a171ubzMEPn6Sfy0ie8xq4THV0/NZgC27Q/z
         7AmMW//YBqv8FwjLic5D+6nkl3xfcrLa57F/zqXkEdkIvn2KlutDI2G9nZzC462BR0
         ARzRgjc4QgMRhPlMi6/YBQmZrFcwhKLtC7N4FqVxk68d6Mtqsbm2es/0o2zHoMHwpD
         Vnew77AWRXYBByLMSmb8Bkdqk2We5SpQsVakgVrPMOoB+0LxZRp2865i7lE8CLRNZv
         9uXQ2CAH7NlEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B670C43157;
        Thu, 23 Feb 2023 22:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d7dde0e-ac9d-620a-cfe8-7897ed53be60@suse.cz>
References: <0d7dde0e-ac9d-620a-cfe8-7897ed53be60@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d7dde0e-ac9d-620a-cfe8-7897ed53be60@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.3
X-PR-Tracked-Commit-Id: b45bc2e09906a7c8370b7f2a6c204bcaa1b781fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd43b5068647f47d6936ffef4d15d99518fcab94
Message-Id: <167719080823.29288.15008787453761114528.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 22:20:08 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 15:33:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd43b5068647f47d6936ffef4d15d99518fcab94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
