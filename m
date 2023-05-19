Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB4709F18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjESScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD31A6;
        Fri, 19 May 2023 11:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DEED65A5F;
        Fri, 19 May 2023 18:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A614EC433EF;
        Fri, 19 May 2023 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684521161;
        bh=JfJ7WHxzSgF6V4re6C8ks11LFZp3bb9h+3RNn+n/5lw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ganf9fBH7xrNCOajohWB1DJadqP4czBDqxd2mwXqBsN9pyicD5pfQ+Kman/TSb5zP
         eaDkWxySN5vkwjg6u0wDC7u8RIVC//qv8ZVPMSI6s15v92VZVPFNEpSMlT9ka4UwHW
         XD1wOs31qo03lj2byeRO7TVhKLvG4OdZNaalT9A5fHSWdhnwPeGS3Z3VI9lidbnIGh
         K0Iz4SdeP8Wq7RVSgtYoGNW5P/SthpXutGZx8aeYy0IDdqYc1mmrrsZTu+5NFFxgBX
         szjtyYSXjciFatdY0bBwFsttQCve8IJWrqgf+olF7Gijo+CptUmfLdjlCr/2Mk+Roo
         pE9n/fv9eqSyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94167C3959E;
        Fri, 19 May 2023 18:32:41 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wn14o0v1.fsf@meer.lwn.net>
References: <87wn14o0v1.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wn14o0v1.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.4-fixes
X-PR-Tracked-Commit-Id: bd415b5c9552d44069d4e7c1e018b6d42f25af9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbd6ac3837cdc62f3078b53b92ad6ee59329e4dd
Message-Id: <168452116160.23824.9599555485462176599.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 18:32:41 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
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

The pull request you sent on Fri, 19 May 2023 08:24:34 -0600:

> git://git.lwn.net/linux.git tags/docs-6.4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbd6ac3837cdc62f3078b53b92ad6ee59329e4dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
