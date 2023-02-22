Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89C69FC87
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjBVTyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjBVTx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:53:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6A41B5C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:53:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E05AFB81710
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB4FAC4339B;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095632;
        bh=sTsXNXhEQWUanJzyomYQCmk1zVyYImLWvIF3i+usDFU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XVzmIG7QMrHVr0o5a5QS57AMx7USICCz3KaQvqif2dozwM2U9jWsebBlDnrZcNyQ/
         ziWo744GmJZ3ug2CnPVtw10xKRkmE03UQv0/DwutF7P0bpqwbyVVrOt5kgbtsRZqbl
         NOFsfsVFJjY+A2Q5URM+K16geBVF+wvpysWjtyi23fZ/n7baJrK1iAvo4tic/2F8F0
         +EZ79MKewarhUPi9IcDPKXO8G14qc+SKn6Q4Ai4TBys/kdXaHRy5CH5bwuazWLdetY
         yqH/H2ipSaToDtcgexg8AQMmibWF0jwepSQ1BWitLCrAixt2cWAOdp0XOlEbNGM8tf
         /rKPcDqshHPsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FD40C43151;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com>
References: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023022201
X-PR-Tracked-Commit-Id: 904e28c6de083fa4834cdbd0026470ddc30676fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c71297eaf713ece684a367ce9aff06069d715b9
Message-Id: <167709563258.30115.3156422402957344436.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:52 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 11:16:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023022201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c71297eaf713ece684a367ce9aff06069d715b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
