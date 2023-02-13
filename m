Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C6694FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBMSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBMSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:52:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF53AB4;
        Mon, 13 Feb 2023 10:52:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A12F3B816D4;
        Mon, 13 Feb 2023 18:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5903BC433D2;
        Mon, 13 Feb 2023 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676314367;
        bh=2BWWt/J89MFCn5EsUF/rEu2a1i3znp0shRx37Kzt25k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TVpXFDPAvkaoSm/7ZIxHX+JyywDDvT97HRsJrj4dpum2R4DB7y67M/hFCkXCMgCX6
         cfkdaBsjT8IUWOhptskCyyXXi469/XzuX14BhwILut11u9LDBUzjSbc6hUP2mpkiPG
         N+Isnrf9ZoMPjJ1LTd+rmKhefcJYXFtfM/1LZkRgN/iMwCcVtb8D/QT3I//+/JZ3L8
         +b0ddn4dQ+Zl2WVpq5k/g+ns8HS6CGq36exmNXl/uIf0cc6G0opl0BWAOkU1H2S8vf
         jltY8vaSV270pnfHG4mNrG8K7r/DV8ERq2QHQJ8HFUNY75z4ONHIZqZyBVgab72sBl
         /TgU/6NsYzBKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 455CBE68D2E;
        Mon, 13 Feb 2023 18:52:47 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.2-5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <06020103-8bbb-c02f-f59a-b4cad88d9184@redhat.com>
References: <06020103-8bbb-c02f-f59a-b4cad88d9184@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <06020103-8bbb-c02f-f59a-b4cad88d9184@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-5
X-PR-Tracked-Commit-Id: eb4b55f2f26fc8a7b7dc6f06f1de91480d53485b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b408817d48840847c00052ae0e02a54311913073
Message-Id: <167631436726.22765.13874147412630914796.pr-tracker-bot@kernel.org>
Date:   Mon, 13 Feb 2023 18:52:47 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Feb 2023 11:27:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b408817d48840847c00052ae0e02a54311913073

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
