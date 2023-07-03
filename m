Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8E74618D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjGCRtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGCRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE8EE6B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3607961003
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 978E2C433CA;
        Mon,  3 Jul 2023 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688406549;
        bh=yKdaK4EUWkC58c3GmfgHRWMmB4Et5tR9ZT0auaOK/Jc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jkXXvmfz/Ymt3wDx7fxgIXnkEVQ+h1wBENTbd82Eqi9luz18Se4HbYs7jmB9FVTuD
         1jvW/x4Q/wNsSOrn2fZuFl10bfPuPAUhMVsA3fKAyV7lLj0ssFrM5tUZief5SDY6RN
         Kf35etfQiV4Z+WINz9rHxe+meV48xu68UQikOxadHU1ZbYCilerbq+g3Oi06y1tdXQ
         t/wfsQ/Jz+ccEQs5M0P1qEDfo2phtvM3BRHtYikJ4uRTV00F61Iw0j7iXQIilYjlek
         ACIarUzOHVlAUf/Z+nBC+45LQS20tS+iUcHGuHkEtWkMKUceNg8PU7fyVOBn6JFIqa
         oZslN+7hcNAxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8379EC04E32;
        Mon,  3 Jul 2023 17:49:09 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3x6B+nKXENKGWq4qL0ezEq2=ZwkGJi+p2rSWxyCFG13A@mail.gmail.com>
References: <CABb+yY3x6B+nKXENKGWq4qL0ezEq2=ZwkGJi+p2rSWxyCFG13A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY3x6B+nKXENKGWq4qL0ezEq2=ZwkGJi+p2rSWxyCFG13A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.5
X-PR-Tracked-Commit-Id: 1b712f18c461bd75f018033a15cf381e712806b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99bdeae21d254056a1072cb6de19e6f9b7f52496
Message-Id: <168840654953.7534.1106078962827202305.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 17:49:09 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jul 2023 21:39:38 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99bdeae21d254056a1072cb6de19e6f9b7f52496

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
