Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52130747882
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGDS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjGDS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CF310D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1346D61361
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D3BAC433C8;
        Tue,  4 Jul 2023 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688497163;
        bh=xgHIn1QA/8v1QZIIsjjk86pbCDjEb9MuRcVZot82Gt4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PKH83TnCaOBH/qILR2R+GpeaX2bMIfjQq3gVrsA3E7rtMsNuaHFfzD8erf3Btrqke
         r0Kr26x6q/ymJsx3qSGrmylKEcJoP/9pe+Dk+g5SseqSigdJgfdrxixgIg8+WMxXXX
         WV0HGRpLc8Wr7/YuoAiprnD2AaAOXGr+hkLeVvMPH5HCjtS8fVjM1A3NXM0LL0jW0V
         PR6Ndfs/XZzNVx1t7t+g8v0oplJVw/GNjLTcOLouaxXAU4htJ2x1WK3wdlSk4jipOc
         86hAJPK+Sfxw9nPYYSmxCGDDakq3/W0ilRrvFIqgiQD1Z1BuFjDwa7ChP4n+WPIr7Z
         8772bUPIWmo2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A3F1E5381B;
        Tue,  4 Jul 2023 18:59:23 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230704125111.3148799-1-agruenba@redhat.com>
References: <20230704125111.3148799-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230704125111.3148799-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-rc5-fixes
X-PR-Tracked-Commit-Id: 432928c9377959684c748a9bc6553ed2d3c2ea4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94c76955e86a5a4f16a1d690b66dcc268c156e6a
Message-Id: <168849716342.3035.16455602312914770131.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 18:59:23 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Jul 2023 14:51:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94c76955e86a5a4f16a1d690b66dcc268c156e6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
