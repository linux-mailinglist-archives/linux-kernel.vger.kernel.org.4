Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700415FA6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJJVYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJJVYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:24:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688C779ECE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 456C3B810F6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E112CC433D7;
        Mon, 10 Oct 2022 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665437034;
        bh=7XhdSkZYfbIDwXpUYw9qfZBpq+Sb4qg0VvlP6tIbQEc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CLsqx1hxfc0HXjRDrIkGT/yl1br/ikZeE2M8ZgcWNWmPE+a87JiGxhb3VZ2zSyXPC
         BOWFf6ZCFmlKRmiDN0X5JRW8r7RhKFHcbOTlEQV4Ai5voVj3fyxPD6y8C3F/NZqlZw
         oBczfrvrNJ4QOlnc53uPBYGMza7nPyDcpHcm+/tCcMITrtVjKupyQcg5oR7hkECtLf
         ADi9cSxyOH8rDYFzM9eu8MLkVCGfNhfKu7Gco+N5fS2cgkkwHXEH9NMv1qkr9k1LLK
         WBrNp7OLXVmvIEDJoor29vZOHN+53wUo4QjdHkPQF3oLs43Szo5nvy/XzWHZ22/fLZ
         bg9w9gDX+wncQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0844E43EFE;
        Mon, 10 Oct 2022 21:23:54 +0000 (UTC)
Subject: Re: [PULL 0/2] xtensa updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221010204630.2383703-1-jcmvbkbc@gmail.com>
References: <20221010204630.2383703-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221010204630.2383703-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20221010
X-PR-Tracked-Commit-Id: e3ddb8bbe0f8cc994748c81e17acc58fda6f8abe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2302539dd4f1c62d96651c07ddb05aa2461d29c
Message-Id: <166543703485.28157.1819189052980207431.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 21:23:54 +0000
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

The pull request you sent on Mon, 10 Oct 2022 13:46:30 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20221010

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2302539dd4f1c62d96651c07ddb05aa2461d29c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
