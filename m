Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB6C740B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjF1Ic2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:32:28 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:37908 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjF1I3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:29:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9451A6126B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 048CFC433C0;
        Wed, 28 Jun 2023 04:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687927812;
        bh=5S6yRCabcW0/yzekWqHZOlV3mBPFwmI6eomdim5efD4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PfFURiqDIhDtw//+gPbCfgg1STC0Sy37goxUCNQgWrAh8hBJkh3ztRIxbAPhNufXY
         3G3qnK+Qvg0OHeSRKA6khq/bnqxYSPzpTwKHKlGPrwwXxOYkbpQWOa/6B/9gvUfhWr
         j2iqSLpFM41xU3NM0smMSDUzOUuOKPeARhD62YqPOvYjBkC3eXQ7eBIGsDoV71wl0V
         V8nauqeb8bU8JkSyU/pOM41sep9rq5i61A1lbtD3Kz7c+mdy8j3vg2GZswQr+lltlJ
         duexITa2mSDykpoGmwhVeZdMuNDoaXM9gMj3IHpHbIq2l8JMZhRpSC+OUCDJiiiC+l
         0ANxHbMcR/KVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D74D0C43170;
        Wed, 28 Jun 2023 04:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202306271642.ED8D48AC@keescook>
References: <202306271642.ED8D48AC@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202306271642.ED8D48AC@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.5-rc1
X-PR-Tracked-Commit-Id: aa88054b70905069d1cf706aa5e9a3418d1d341d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d416a46c954ef0b753595ebfe6bb0988a24c2a57
Message-Id: <168792781187.32196.8471909196712686321.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 04:50:11 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 16:43:02 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d416a46c954ef0b753595ebfe6bb0988a24c2a57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
