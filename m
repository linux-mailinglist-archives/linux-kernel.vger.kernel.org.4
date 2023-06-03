Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03E72103C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFCNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFCNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 09:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15151A6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C39160F5D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03879C433D2;
        Sat,  3 Jun 2023 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685800009;
        bh=uwLFmzHnfP2Te/6647K+L+Cww5d+wOP9X5PmfsYjmgA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MhEmew2hX0ggkE4xczQ0yay5qGYISjQBbfSKOwjVuw8aqttaP1kGaMxhrzzQXXnDs
         TeDULvAuocTaAu/Y3GFKNNBin6DqOeeTBnmSqTIbGWUNCdnoBd4emQTZ7A1UYuvVnm
         q9LGncs/IoHiZjJ9NOza0DxuK0qwdrhym/WSqcVGd90B6Jpd+dv15EGP0mAf4itxHv
         sudIjE6RFy2CAaMFZb+DxvR8cNbORc6cp8POkhgZ/mQw0w55gvTH0e99iS/to9GSQ7
         ImIiG59143uHgqYp7O0XN5AdML+4gf7lwophU57gdNer85sVmTyG+REds5sNhgHHp4
         iXIpAb5001LMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0CFFC395E0;
        Sat,  3 Jun 2023 13:46:48 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230603155554.9ab2f3edf0c503c312595258@kernel.org>
References: <20230603155554.9ab2f3edf0c503c312595258@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230603155554.9ab2f3edf0c503c312595258@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-6.4-rc4
X-PR-Tracked-Commit-Id: eb50d0f250e96ede9192d936d220cd97adc93b89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51f269a6ecc701f9932eff5b253a1f89746be6bd
Message-Id: <168580000889.22793.14198894210014036728.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jun 2023 13:46:48 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Jun 2023 15:55:54 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51f269a6ecc701f9932eff5b253a1f89746be6bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
