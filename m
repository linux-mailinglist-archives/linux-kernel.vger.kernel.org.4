Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317A6CF144
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC2Rlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjC2Rlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F535FDB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9581061DE3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09746C433D2;
        Wed, 29 Mar 2023 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680111695;
        bh=RH+VFjDQXzouKwiTsosMP8pAScxXr1KJ6mexZrlox8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ug4aJr+0WehIsI8f3J0nbbV3HkhXbqJ/u8cFVkwvz7vbhhm9eYrhgH+uh4++WfVfi
         azVuLBDHK5CTb/jqmB1ysbq6rk6jTdRw5kuNx0/52aOCjCM3aL20tm6JlAcjlylQCt
         D5SVt8QuJ6J5ThLAY4+fFpWmOdR6u0JFxcUC3GTBseWyeXCStqsXsfW6s79dcDGu6y
         oQt+3o98TQAhY4hAj5rbT2Puzf2eGF4ZuNOLVOTd6Ze//kvY8uou9dFgZxLSFAfWUr
         hWDhVw99bzgL1uV/b7O810TWKq620sV+BThskcY9xqKLKELfybJdpfp1xQpkKDXDhj
         OTwjF+yyvQUMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA22AC41612;
        Wed, 29 Mar 2023 17:41:34 +0000 (UTC)
Subject: Re: [PULL 0/2] Xtensa fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230329164527.2996022-1-jcmvbkbc@gmail.com>
References: <20230329164527.2996022-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230329164527.2996022-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230327
X-PR-Tracked-Commit-Id: e313de5b5b04176f28384b45ebebd552c0c7dae3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffe78bbd512166e0ef1cc4858010b128c510ed7d
Message-Id: <168011169495.2257.16218171145599701447.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Mar 2023 17:41:34 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Mar 2023 09:45:27 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230327

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffe78bbd512166e0ef1cc4858010b128c510ed7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
