Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0F61A718
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKECyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKECye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:54:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088DBC30
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B733DB83071
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 02:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6415CC433C1;
        Sat,  5 Nov 2022 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667616871;
        bh=pquXixUsUM/NGZMobkoEX/KmUzW4YnESI8TAOdy24pA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I3UMpi1MU8pbwp6eUK9EXZ79npfTlBdAaGDDPbypabJ6LExlM6GtGC+RZZKxkSVxm
         1ni978uJjVXSWU9ASzxpY7slyop3xqj5jQe2kOgy36uWI5rfZw1fBuhMgUcUV3GWyz
         Jy9n7ogYk38LihO1Ka3nW1zpxPZOVjwFLUVI0QiXMbQqCI81LeSuWwkkX9xqJEpo6U
         22885hZqSiNENlkXdQYUeX0kEA4huRznVS+4ADvD+8tkKmONsZN6DYLFruOUGztUyx
         ng/ZLgaRaP5ZHHbLSsaBbbD3lINvrd2NBPpGl7JiUkQQRdGBfUS0sfEXJiUR8zzECE
         K77kzjARyGEfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E718E29F4C;
        Sat,  5 Nov 2022 02:54:31 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2WcbQM5P2aJrf7o@arm.com>
References: <Y2WcbQM5P2aJrf7o@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2WcbQM5P2aJrf7o@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 85f1506337f0c79a4955edfeee86a18628e3735f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b208b9fbbcba743fb269d15cb46a4036b01936b1
Message-Id: <166761687131.13409.16605586556068686168.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Nov 2022 02:54:31 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Nov 2022 23:12:45 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b208b9fbbcba743fb269d15cb46a4036b01936b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
