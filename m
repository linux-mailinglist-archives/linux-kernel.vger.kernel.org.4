Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3BE6F0C82
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbjD0TVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245192AbjD0TU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FA15255
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BD263F63
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14B51C433EF;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623220;
        bh=SQOK8DvkzqSeqWDpqLA1G4eWF/Iu6MULfObh5SUNgy4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dNzXkwdjzIj+kTucPtju1urSou/lSx/d1zRzYcot8Kz6yyugg3nYxSNUDb4VkSoxu
         ilE0LZoDKYPoiFucKxgOJRRtGaydj1fUJjqedGuacgrBvdHbiz3dFPBs7kag69sXis
         j+1phUqTpxrQKbPqQjRb+nMUNSgEPSCNEM/VNBk9IxhMaZMurd574CoP9kSnZ1lrcA
         ydHki/oztG4aQKKVjNv2INBXcJLU6dMFOOCZu7f+ZcPWDIlqyJ3F/jWLh4GAIug4Bw
         VzZw7VEMVpfqkmUn1E8yzLDszJfsc6nvlYT+dy1+OniW86DbuOpZcbI1lWYFkVXB2R
         5dyFXxTk1Mi0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02FE0C39562;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2304262313100.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2304262313100.29760@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2304262313100.29760@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023042601
X-PR-Tracked-Commit-Id: c3a6ef330a08eba406f82b0b8cbca4e4d9b7c4ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34da76dca4673ab1819830b4924bb5b436325b26
Message-Id: <168262322000.21394.7601699310373677852.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:20 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 23:18:25 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023042601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34da76dca4673ab1819830b4924bb5b436325b26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
