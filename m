Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F166A9F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjCCSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjCCSqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6718B2F;
        Fri,  3 Mar 2023 10:46:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B16C6199B;
        Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D185BC4339B;
        Fri,  3 Mar 2023 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869070;
        bh=i6H2KUMnAV6KsrESABYPCameOuoN9Kq0PU2+gndSSH0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tbxRd6xEiK3RNELIHT2+dLulkGzyByyMbsM3IXmjfD7NLKKxyCoJ34uu6VUynDfEA
         NFFZ0bwbs1Crscc7sYWgDGq5TpMt9IdX5HrAWNWIol9e24LC0aDa5CdEtaSZAyRfG8
         yO2s5lxxNs9ANZh+kBsUdBXssbm4Q3asN7GhlUWN5e9UnxXZnvIxspRD1ih/K/OXwE
         SGGUAgOS+SEdyhlnFEWb7yF/YPEFTOFNzHU3E15UzHCyHNHJus1qMjEpVRpwSqK3EQ
         GoAbn37o/pNsBtjJYQYltLn/5pp9bg48xYi5KllQNs0AaqaNMVbSPaqO9ThdL17Cr5
         UiKT89x3ynXJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C18C0E68D5F;
        Fri,  3 Mar 2023 18:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.3 merge window part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZAHsibl9k37pZLkv@osiris>
References: <ZAHsibl9k37pZLkv@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZAHsibl9k37pZLkv@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-2
X-PR-Tracked-Commit-Id: cd57953936f2213dfaccce10d20f396956222c7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bdf4a8bf0aab64757c23ef3acf8190af2b23797
Message-Id: <167786907078.30023.357679737275628231.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:30 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Mar 2023 13:48:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bdf4a8bf0aab64757c23ef3acf8190af2b23797

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
