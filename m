Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A66E82E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDSUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjDSUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D6610E0;
        Wed, 19 Apr 2023 13:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7996361645;
        Wed, 19 Apr 2023 20:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF4EAC4339C;
        Wed, 19 Apr 2023 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681937533;
        bh=ghLbHflzXj/u4XJNYfRRuJxPoDqTYJuQzfp2TQJ8o5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cktAz7jfBuYypASxTCCn5TwrpSjCCHG0czn6TVxDMGv4cqX+xUJP//57QnxrJbxVp
         yhxNzOx7vIK8H8im/pE3j8EUTgzM5+zI6iv4D0Qo6b+kkeG4jdZ3W6kPc8gAhDHaRP
         C9L/zXRAlBJFatpzkkdXOZh99a/TxSpna7eJ0Ikarv+1q1aNa1CnX/OoWGsY9LkMOV
         lgWf52Xa2R//E3WkJWRQWC5+XET+dlQzPeiGWbwFl/D5d9uby5MWeul/OMdu05Y6Py
         q1H0T0P1BWTFqurVKvBc8M48FaHxWCc+JDI+9lWU3fgFHCVQ3RP8UZdi5vvJZzSzvc
         U+syMV0h8f4gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9CF4E50D61;
        Wed, 19 Apr 2023 20:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230419202458.ECA19C433AE@smtp.kernel.org>
References: <20230419202458.ECA19C433AE@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230419202458.ECA19C433AE@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.3-rc7
X-PR-Tracked-Commit-Id: 359f5b0d4e26b7a7bcc574d6148b31a17cefe47d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23990b1affd2dc8f5e59048d4d4bef05f6e1c544
Message-Id: <168193753375.29762.12208293672165658133.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Apr 2023 20:52:13 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Apr 2023 21:24:47 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23990b1affd2dc8f5e59048d4d4bef05f6e1c544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
