Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6769FD47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjBVU7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBVU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:59:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2358D43935;
        Wed, 22 Feb 2023 12:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCC8DB817F6;
        Wed, 22 Feb 2023 20:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 958A8C4339C;
        Wed, 22 Feb 2023 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099541;
        bh=DIDsGyhDZ5qRgdJkjNrCU/77PqKjjZsKtlV2iAVU79s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Be+sz/dh1zXn5TVOYF42+zUu5ItgClR/luxPg0Y/GD2FBAxFLctu2pFYzlKlezrDi
         d4swMrqDpUC7oEBwiKuyhJ3p8Yjzb0fhErvuI4QU7ZVr8XeTkTVBn1opx5KkJOjZ/k
         vCIxDTdWO8jJ2/jqR87U5m11A2guqqurCBYcRIZboi+mD26MvOmZjPKbUHvTtabK03
         xRAmHUbGxgPHJQIPpWuk9bnf7/q7mUyGagsx6/bznCLfzexU4QTmBTXjcUlzSBpAEn
         nFKk4vdA2ed7qIGcGor1o1k1OJfPAE/g8FfVUSpiufj0WJ+0Ydc6ReYsMI+bMOIYgE
         /GM+FcbzdBgxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82A16C43157;
        Wed, 22 Feb 2023 20:59:01 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT7aw1tGB2fqQMcoCFpwdvC2xfsUbgU0vaTiY_jRk+K9w@mail.gmail.com>
References: <CAHC9VhT7aw1tGB2fqQMcoCFpwdvC2xfsUbgU0vaTiY_jRk+K9w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhT7aw1tGB2fqQMcoCFpwdvC2xfsUbgU0vaTiY_jRk+K9w@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230220
X-PR-Tracked-Commit-Id: 6c6cd913accd77008f74a1a9d57b816db3651daa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23064dfe088e0926e3fc0922f118866dc1564405
Message-Id: <167709954153.1614.11181099863522437173.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 20:59:01 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        audit@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 17:38:12 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230220

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23064dfe088e0926e3fc0922f118866dc1564405

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
