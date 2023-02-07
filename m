Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC768E360
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBGWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBGWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6C3EFF1;
        Tue,  7 Feb 2023 14:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BAD6131A;
        Tue,  7 Feb 2023 22:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F3B1C433EF;
        Tue,  7 Feb 2023 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675808404;
        bh=j8kkrNKl9M8Jzq1sB7erz1sUw/HpmwioLkvJHp3VL+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UZx6aSuUgHKlRXIHSiE/jwW7dIGyJOgj1LFpjwV4i/N5f7HY42x/6gHUQ/LQMI9/H
         szPEP8QCobiktHPoC4jOSrbq/qWZc5h2ttKVfj04I+S9qF0QA9jJ5oOSpPRl36syC2
         Fo+zbJGjb+WytoGn02bstXi+ZY+CYwLB+MNDi8lk7GeGzfkn0Wr12CaKUKKlwr+SUj
         fNCzQivqFS9ypJX0WcM0vgNdqbP1Xk67zE4JegDKP1zpcWcWA3ZzOlLwOgrpNmOFjd
         lv8MK9uo/ZQamWI5vtDozmXqc/NxEraqs4of/uZNDoVWiXRzJRbd/l4OooAT3BFNDA
         8ss00sZtdGHvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49C57E55EFD;
        Tue,  7 Feb 2023 22:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.2, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230207221133.GA50340-robh@kernel.org>
References: <20230207221133.GA50340-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230207221133.GA50340-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-2
X-PR-Tracked-Commit-Id: 707344c8a188bb1d6704d3546229fc7a07c01a63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
Message-Id: <167580840428.25372.6229505556242608295.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Feb 2023 22:20:04 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Feb 2023 16:11:33 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0983f6bf2bfc0789b51ddf7315f644ff4da50acb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
