Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F474667A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjGDAQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGDAQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B6DC;
        Mon,  3 Jul 2023 17:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B9D610A3;
        Tue,  4 Jul 2023 00:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D8E7C433CA;
        Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429808;
        bh=ZiPRo7k/JjvcIbPU5V4ARaJ/ydfOBzfAhJawl7IM+8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=luZiGy3DkciCXNlM4vhdUPLSIvGAp2A1tmH6jMM6IxVG2MhjzM3jDhMYToASTasfg
         1A4Ga9NX8OPnCJNMPYOBb7ix583CnED1akOS9rHPz98/sBerkPAUenfg3sxcILS7Yu
         zgv2Q0yyNlZtjvGDQmH5OzJuW8vlhrcJ6j1WE7EWYBnt+mPQ4CP448aI6Mn1sI4vze
         RcpdzEhvZkKN3sXK95Mi9vSx6s+IGX7lstAq39tn1g9MWkgua2YJ23IFCTnKjz0XT3
         AXUYi8pe4D1c8FyUC+n9cEQqNvrzr37eSnfElAE2FA4SJPPmzJmCHtmlVuSSARXQ8P
         PL0acE1UasTjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62960C04E32;
        Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703200854.3081448-1-andersson@kernel.org>
References: <20230703200854.3081448-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703200854.3081448-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.5
X-PR-Tracked-Commit-Id: 1b39e7607144337d752f36c2068ed79447462f99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6afb24a0fe7294f004ee6c43b10251ff86218d56
Message-Id: <168842980839.28751.13892359473368551278.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 00:16:48 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  3 Jul 2023 13:08:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6afb24a0fe7294f004ee6c43b10251ff86218d56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
