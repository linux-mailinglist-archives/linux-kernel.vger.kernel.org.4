Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B87403C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjF0TE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjF0TEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683819BE;
        Tue, 27 Jun 2023 12:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35F961210;
        Tue, 27 Jun 2023 19:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56532C433C0;
        Tue, 27 Jun 2023 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892652;
        bh=W1X0dbd+njfQ5wHnZedX+ZAh+yNjC1d9hMUWDXNlAmk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QuqBbk0WMFGMiz3pYaooV/KC9tM1C/LAiq6CmeqgmRMovSN7HYldY2rGZHNSddwuM
         l0o2YLqMhgyD0ijXuy6EjWLWnQGeSS52yOfChCNGDShLoYuKJO4SVOo8A6OdFBlgSK
         rABaKKsVQrWJBcjFr4ZfWUmklGoDpU1epYXWdukEtMVKhUDZAXSpOvhPFNEZPM3BE2
         Khtu5xgSZHNnXwCRQ7pkNlh3ARdPDyK50XmGaaze6I56D4X2yMSttJ75+Gba9Ms4Kp
         2HfUsPLX54gAiyuIyhcYQhsY/T/AYTa5kiGJLUEYzsey8jamltSACXHu6PIvPtY3ft
         Z8TFHhdVRu7Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FE3BE5380A;
        Tue, 27 Jun 2023 19:04:12 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h6qsev3g.fsf@meer.lwn.net>
References: <87h6qsev3g.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h6qsev3g.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.5
X-PR-Tracked-Commit-Id: a1e72bb00a48687a1dc1c2e549eaf4ba09e802be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3540495324af9b7fa95b62da2ccbf7cdb4e3622
Message-Id: <168789265225.16132.6697509462594662134.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 19:04:12 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 10:19:31 -0600:

> git://git.lwn.net/linux.git tags/docs-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3540495324af9b7fa95b62da2ccbf7cdb4e3622

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
