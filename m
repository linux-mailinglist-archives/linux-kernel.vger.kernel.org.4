Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1835664DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjAJVGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAJVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:06:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03855646
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A388CB819B6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 581B4C433EF;
        Tue, 10 Jan 2023 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673384800;
        bh=/JMphHL0HYCkkIb6QtM9Q5nBcSD0HdCYl0m7ZtGlMZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HPxjIiJYGYNwVV9ZfCxB1xOxeiBu5Orw7U53ceXoJ1/QAuFF2CdbX8CDapbxaJVOf
         ylFS18/N5DR1HMrdVLa46M9CyTDxuI0+SqjgY1UxGu79o9m7tlreUx5HkVwdfnE+un
         VLi+/2UN+kNaXOfufP27QRdyCRv6mNT1OjzGnmEv0vNjl550B93wxA/vkXZIXdjhW9
         Qy7xSKt6ACEo6hrBQ2wcVAR18HTfx9lzFZL+B6MLkMJznM43q22R2U61r9UYpkNrKD
         fRL/CaeI5rgVKzwzZvHVycwXeGjEsREsGCj8xtG/sSxwXb4/omQDGAmBX8bJ7C+RPa
         E58QzYiZaiPaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 436A2E21EE8;
        Tue, 10 Jan 2023 21:06:40 +0000 (UTC)
Subject: Re: [PULL 0/2] Xtensa fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230110180940.128858-1-jcmvbkbc@gmail.com>
References: <20230110180940.128858-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230110180940.128858-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230110
X-PR-Tracked-Commit-Id: 4414c1f5c7a375eaa108676a56e12cc8234eb647
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 092f6239108d3c612f5e1c67d9cd0cc80461fc91
Message-Id: <167338480026.401.10650843584094608910.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Jan 2023 21:06:40 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Jan 2023 10:09:40 -0800:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230110

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/092f6239108d3c612f5e1c67d9cd0cc80461fc91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
