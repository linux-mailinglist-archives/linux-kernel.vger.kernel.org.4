Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0136260CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiKKSDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiKKSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC276DCD3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69EA162086
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B6A0C433D6;
        Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189783;
        bh=VDGcxG3FwlqGPUtPt09CKPtNTd+E8SRusp16kJTFg58=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sj/hwnZ0odE2itQTX+Wey056aI0goUB3lQe9dPXNMU16yqboW5JkF7PYyKs0GAfaU
         9NrX0a+ovIxrMBwdGsDM3tGhS0HuPo1zOTw0RGE4pozPlDOfIKvXRz2cLqsmMZ9hmx
         LaKBWTCoU4uPOG8zfOKwACxQQy63tYBn12qdlrW/znhUcKhi6bYIFJ+1ZYOpTKQ3Kh
         kQ6ruMSUQWMp6V2XQLSCr7G/kAXEpw26SyxajGZAuo+fv+E50IoQ9Zi8njDhLQrcIZ
         5LJOmjp0ehzhQxcoJ/fz/ajQTLp5hrj+B/nh//JrNQagqQVbiOchTVfLQb3Y/KY3bi
         fTecqM6vzi5Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B691C395FE;
        Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2211111101080.6045@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2211111101080.6045@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2211111101080.6045@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022111101
X-PR-Tracked-Commit-Id: f77810f744139572a63e5a85ab6a8c10c2d44fb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c730fe10493d309f402cbd28ad539379b13a24d
Message-Id: <166818978317.15878.3609233346828476763.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:03 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 11:04:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022111101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c730fe10493d309f402cbd28ad539379b13a24d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
