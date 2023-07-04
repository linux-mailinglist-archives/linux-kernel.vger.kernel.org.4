Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84F74785A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGDSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjGDSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6910DD;
        Tue,  4 Jul 2023 11:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 182326133A;
        Tue,  4 Jul 2023 18:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 761AAC433C7;
        Tue,  4 Jul 2023 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688495919;
        bh=kq/AZ8oNyjSoGyz9ZwlT1WrAOzgFhQgV0sbEmJcci1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HGlGoYu2WOlyYA1BJHXNzQd82gFDZppUpS5IAQJDlRpM4+hTOQbp+DIQB6gGmFDiG
         Hsyg1ByBqBy/gxqlIan8udHHdFNguGk6ywLcghcyV0Bb7pYYX+XHtiMeWJr+V8TSu6
         LzuEVdMrkzLVfb6kz6b+DaMFdlCG/a2S+G5J8SFdu9YLfqLeFLjL4dv+MRYVjShuZv
         cSQ1HkmWQsAgAr6reh8nPrvvzOJJ/jJTx/TwuI6yErCU1GGoU3hfr88vOsvoRyEmvs
         VpFawAW00JI1NVy0cSFryDebPL9Ed4FiDHkjda2GSkDlOD0ScJBbMU5UYS5Ss5xk5S
         NixLdolOB1idQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 613F9E5381B;
        Tue,  4 Jul 2023 18:38:39 +0000 (UTC)
Subject: Re: [GIT PULL] More clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230704162129.46794-1-sboyd@kernel.org>
References: <20230704162129.46794-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230704162129.46794-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: f679e89acdd3e825995a84b1b07e2ea33ea882ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b869e9f49964aace737a5a3fadd958ea94e96288
Message-Id: <168849591938.22559.17963409911037309606.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 18:38:39 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Jul 2023 09:21:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b869e9f49964aace737a5a3fadd958ea94e96288

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
