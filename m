Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8976AA694
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCDAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCDAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:39:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0315C93;
        Fri,  3 Mar 2023 16:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49C94B819FF;
        Sat,  4 Mar 2023 00:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15BECC433D2;
        Sat,  4 Mar 2023 00:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677890349;
        bh=gQoRGJg8eC/8vAzZBr4ucd61pBfq/yUjgFUSbnQajgY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U+gU168QWtvgc3d1kG2+iV+iUV9kD9N0484/cjq7AaYSwR9lcAwLSqNWBF/m+8Oiu
         HwpkroBFnEBRWyyDXzCI3tQ2yGlfHNP3bTsQl83Rwhuj7V6tdK9LZBG0DaYgVSlrkM
         u3nO/jCFItNXGuEy6jWlJuu6sj3uwqkLJTt9f+O/3J5lsh3CdGVhgC6BAfTktVjwaa
         s06H+K2sHSp2fmWAb7ChsGXBWbQX5JkPETMydMO13sE6VO1CTJOH480Fq/asynRLaz
         kBlAyMmBtb1IqMuzAnYVNgOX1RSChugEY64fIZT0Rj4Vn92VjfIo/dh4MazKx4te1n
         0tr35aTJHhv3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDEBCC41679;
        Sat,  4 Mar 2023 00:39:08 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.3 (part 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cfde34bf-c229-4a5d-b2c4-b76b5ba55dfb@mercury.local>
References: <cfde34bf-c229-4a5d-b2c4-b76b5ba55dfb@mercury.local>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <cfde34bf-c229-4a5d-b2c4-b76b5ba55dfb@mercury.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3-part2
X-PR-Tracked-Commit-Id: 13af134bdc6a9dacec4687e57b2ea8d3e08ff04f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0988a0ea791999ebbf95693f2676381825b05033
Message-Id: <167789034896.14111.16972376753788283240.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Mar 2023 00:39:08 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Mar 2023 01:12:08 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0988a0ea791999ebbf95693f2676381825b05033

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
