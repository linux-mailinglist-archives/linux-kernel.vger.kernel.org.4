Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE271F47B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjFAVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjFAVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CE184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39B4649D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53AA5C4339E;
        Thu,  1 Jun 2023 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685654127;
        bh=z/CmJQygH9ShVyqFw00GyW8qt9hUccl/3RIiAbbgH6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hy4/4CT9VtUhVtBcgYpXLte5QiaKRRbI0PvEsC2fEGwtckU3ZK2T6TVoSOGQCeKe5
         Pf23oCKEfE7wafPX9aCMySiVZhqFoamZ2mqAi22s9A6YJO2Z8UfztvQFxDimqplkB4
         GZ+iLrEuFI/vewLHo8pAZBtNZgwPCqOT3DLfLGU4c3xSkj5Jz4/mOrK6sNOCIsCG/H
         BAX78q8X+nOz55RZOZqlJ3Vo8lZdbteZJ5aBFmvvRNGSTFmg+Qlh/c2n/EezRY6Llz
         tUr0WVBJgvX/NTDuxQjjMl5SUxL+3SaapCY8Q5mIN0C7pOgvfO4s+w1CVca7frPhMI
         c5Cr9eY4MUOVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35C8FC395E5;
        Thu,  1 Jun 2023 21:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox fixes for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3NTc8+kq43fuQrcDSTC-EKh-ZAij0MLuTrdWodur5Fjw@mail.gmail.com>
References: <CABb+yY3NTc8+kq43fuQrcDSTC-EKh-ZAij0MLuTrdWodur5Fjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY3NTc8+kq43fuQrcDSTC-EKh-ZAij0MLuTrdWodur5Fjw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-fixes-6.4-rc5
X-PR-Tracked-Commit-Id: 8fe72b76db79d694858e872370df49676bc3be8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd69bf361e18091bff20c6f80670911682803650
Message-Id: <168565412721.3839.16144625806998240148.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jun 2023 21:15:27 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Jun 2023 08:40:57 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-fixes-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd69bf361e18091bff20c6f80670911682803650

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
