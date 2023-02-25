Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C66A2BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBYVKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 16:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjBYVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 16:10:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233DD516
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 13:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB1C60B83
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C61CFC4339C;
        Sat, 25 Feb 2023 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677359401;
        bh=qDg3URa9DJ1oDq2ZOoRNlPWnXjRuAEeBEuYCRZH0/qI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lYr/xQjxA0z7ZqFpC0uhBogLiyAO9m8tQw7RYxEhLpjFIpw5hlP+BQPdLKIp96My/
         u//LfNcS3E+O2MdQt8AsGGFUp8jfXcMtkC9blbSUubq+CRWV32XJNZekCCuDLMlRQ9
         NmdDKwZd+fILbjDGKevXwmvHwG9FNooUWzZoPl2/YGyuXfI+ZF5KIQVYfhf/LvXTki
         WwTUgVYHIgmLXjmeDjmAslgT/i12vVpsVtlbgbbGlQPSMlRsev4oW94EkODBbFUAAT
         SQN4LSyniB3qokygSZZrTCkOKXhcvuhER31KVkrm04tRh/C3sM9YUFvdrvINTZXHOV
         vYFIEc1vEBO/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB5B9E68D34;
        Sat, 25 Feb 2023 21:10:01 +0000 (UTC)
Subject: Re: [GIT PULL]: probes: Cleanup updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230225011631.4ab2a1f82b888845285eedf8@kernel.org>
References: <20230225011631.4ab2a1f82b888845285eedf8@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230225011631.4ab2a1f82b888845285eedf8@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.3-2
X-PR-Tracked-Commit-Id: bd78acc89d4147aa4897a4c43e2a74c7df999b12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 116b41162f8b267987ea9a73eb7e73eaa7c2cce5
Message-Id: <167735940169.13638.10585447044412717913.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 21:10:01 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Chen <chensong_2000@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Feb 2023 01:16:31 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/116b41162f8b267987ea9a73eb7e73eaa7c2cce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
