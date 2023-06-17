Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49B734322
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbjFQSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbjFQSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7201BD6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 11:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21945612C3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 18:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 853A8C433CA;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027466;
        bh=J+Vy7ZFSJz/ig0huCXrXW0M6zTM0PuIOR0XceY4cg9E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cibgO0vgBTTU/jTAhmJL0S/MJ5BCOBUesa+ryuqL8py40vZwlLPqmj4xmS4ZkO19/
         lWOjRj+IWm1EGM4xJKIsgiTe4pRrXfrHxeIUQq2AcvTsWchgP45AJbn18irG6exOLQ
         6jLgQ1hSlHq/ehoJafyPQHvEAMIJp5OqObOFPmkl7YjQkIJqslsJvV/dKa3hiO8Vw5
         HGxUZ8qglQnMN1MG2f8aAXOOUut+FGICTc92+BvfCcWu5+Pgx/3Py7poA5GVugmRsu
         8NQ+tNB32jY3zIKCfEVuwg5KZQBQvaH45pdv2io1lScIPnUSLwmooFqKIfTwT7nhmN
         a+/q4nqrmhRRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F6FBE21EE5;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZI25KRBpKGcP0wSf@kroah.com>
References: <ZI25KRBpKGcP0wSf@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZI25KRBpKGcP0wSf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.4-rc7
X-PR-Tracked-Commit-Id: b3dad076a058916c443c93074dc3ee80baaff4ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b29d271614abd97cc39782daa9d6dd70e98609f
Message-Id: <168702746645.26928.8030797368623841467.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jun 2023 18:44:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Jun 2023 15:46:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b29d271614abd97cc39782daa9d6dd70e98609f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
