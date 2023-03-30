Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327846D0B90
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjC3Qpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjC3Qpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2840CDE7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BA0262116
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B170FC433EF;
        Thu, 30 Mar 2023 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680194748;
        bh=DAcWdXa18cROluoSPS9U08IvTpK75pvJXq9kCUM0m8w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KKfFO+lCZpCsV4aGowrN6hK5vl9bRZZumtaKh35gURZhO6xga8y0sLqeNmKXm/wAU
         40BC3JR+eNj0W4MroIwtkynLeVUPZ1AiUV6kBXNzfj+oOnmltoy8nlrz89tEq7T69j
         uCSL/AF4ArE556e07WjqNwvxQ6514rkzH7KcVSxw9HZHsz4GwCe6VBVLLLtM9vsLGA
         KZfc+sgbeWtr7oF7FjryDxLSRW/WTo6Wx0g540QQI2K7z4r0a+cBeIdAjj4rIPnJO6
         jEKizg2RerFLFvA8cvngRjF6j5qaZ0K5nF6ibU3dJVOkfGjUoAba6usUGLesGIMBnN
         V/d1fTR6r6rMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E732C43161;
        Thu, 30 Mar 2023 16:45:48 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8iil6ww.wl-tiwai@suse.de>
References: <87v8iil6ww.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v8iil6ww.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc5
X-PR-Tracked-Commit-Id: 52aad39385e1bfdb34a1b405f699a8ef302c58b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bb95a1662f8b97c443984550a7aefbe5a1a064e
Message-Id: <168019474864.8090.16481983569857857878.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Mar 2023 16:45:48 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Mar 2023 15:12:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bb95a1662f8b97c443984550a7aefbe5a1a064e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
