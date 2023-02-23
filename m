Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF36A12BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBWWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBWWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECAE5C169
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A46B81B3D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5FC6C433D2;
        Thu, 23 Feb 2023 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677190807;
        bh=QmhY+8I12dqtpRC93+tp2PlmaqKfKvQM78eEw8FNL+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OEHXW3zTrr9M7vFfPSEriiPWw8m3hNNzW+InVaOva1vTDnAbBo8uSMNL32yvwSAv1
         112EsPp8hRnocn8y5mnrUUCq+nZkArPE+NEZWEj30cS44ffSneHVYnMTqS3zKGtavK
         gQqIlrlJvxqrMrpH8UBUdCGopa+K3lv7+/CNAKmivIsG322pnQT6yHzF5pyAoZUTsd
         6v3jJ9ajpvrf+cYInGoeIaZtblVP/EdzpmOzGXIV4QlHzrIxquFfdwuVoJ+bO+1CI4
         p46ujKd8HbFfc0X7vjIDCQ1Vv+7bDqhcDJTTogu4OnSd3b1sM4J8a2hp37F5buzOsG
         lwIs/eXaZUHbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9416BC43157;
        Thu, 23 Feb 2023 22:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230221211408.6fa4bb5868cda7d506a00c61@kernel.org>
References: <20230221211408.6fa4bb5868cda7d506a00c61@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230221211408.6fa4bb5868cda7d506a00c61@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.3
X-PR-Tracked-Commit-Id: c96abaec78f34366b3ddf1c6be52ca5c1241e15b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b79eb73e2c4b362a2a261b7b2f718385fb478e4
Message-Id: <167719080756.29288.12982791618461767690.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 22:20:07 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Donglin Peng <dolinux.peng@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Quanfa Fu <quanfafu@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 21:14:08 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b79eb73e2c4b362a2a261b7b2f718385fb478e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
