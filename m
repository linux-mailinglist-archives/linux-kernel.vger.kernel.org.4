Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73174B58D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGGRLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjGGRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF84196;
        Fri,  7 Jul 2023 10:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DE1619FF;
        Fri,  7 Jul 2023 17:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45EB1C433C8;
        Fri,  7 Jul 2023 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688749858;
        bh=2XM3DgStlRihDswsxs2EfVLFjMIV0Vf2lumRbN18c2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JnCTdyN+0JiUJ9M+H/tIhNsRU8LM8n26I7wtS1LGWTsmzUxGXT1XafibIus01akGb
         L7bRUqZsFScbksIwSSgzMaUN/Q/UG9gt9dQtqyiR/vlmy9k5D+0cSGEKK68vo2OQUq
         OYSMcrIDldLpexUUXA71K8SO57qMx9lq/S1HJAlo+DDWJ9iae1o8UAR46++GGbm9hA
         o0qFXsxHtSEi0SjdAC28OUpHy9mzdp5PSLO8yeA5qXkg8/AQqAi1wu3rk1CzMe0n6b
         xz22wwDkE9ZN/DEzN/3s84AgE23zt9oVLFd2QGgnQNu2fQhwCk6c9oWYwSEhuK8Lej
         aP1O8YoSaATGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31A82E537FC;
        Fri,  7 Jul 2023 17:10:58 +0000 (UTC)
Subject: Re: [GIT PULL] apparmor bug fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
References: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-07-06
X-PR-Tracked-Commit-Id: 3f069c4c643225f2b96b4b3f8c30e4445f079d2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70806ee18a871140a73a2524a29865e1d904348c
Message-Id: <168874985818.21562.3365504880709774749.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 17:10:58 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jul 2023 11:28:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-07-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70806ee18a871140a73a2524a29865e1d904348c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
