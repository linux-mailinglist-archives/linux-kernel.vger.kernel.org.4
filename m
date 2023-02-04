Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1959B68AC2E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjBDTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjBDTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:55:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C926CC0;
        Sat,  4 Feb 2023 11:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE037CE0926;
        Sat,  4 Feb 2023 19:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 254F3C433EF;
        Sat,  4 Feb 2023 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675540508;
        bh=mk01LrOBdvVxz0ygSIjri69OEBZUVCfcpw0aouOdqNY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oWoeitgGgsLicAqsJtvcw02MX3KrSM4V0KHWuh4WYvQvdzEwC0ZLfY6FfJvL1lOlI
         twMkXtGkcpz3uhsSlfTG6z8zM4RzKzdlnND5nMjf2V/BzxbxXz4ntTBIPSVK+XzHUV
         hDIPJBSPsqRj7LnIROov5qUwNgDIkvd1YYLgrra1KoSqPFQ4Awa8mHXiVUpkk7BIpu
         MqgKZ1NqTkX6+/hTdCtUX+6fcyVuJVz/6vJsv+Fv1Oc7O9lVVcSr56TGhBc4JKVSQ4
         RNI9g8qyv3c8A9xY1rrJ1lDphqCpmK64fjA3KzbQTq8oTFwfE38TAvyiX7zF0VHpQf
         yUpahlh/JGHXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15461E270C5;
        Sat,  4 Feb 2023 19:55:08 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC update for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y943GbieOKnXz1aE@antec>
References: <Y943GbieOKnXz1aE@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y943GbieOKnXz1aE@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 0a2742bf5899bf3bc46d16e4cc7dd7352ce771fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 583472ef2d176883596637a690602e6d76c5fee5
Message-Id: <167554050807.7014.9291043137027079914.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Feb 2023 19:55:08 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Feb 2023 19:44:41 +0900:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/583472ef2d176883596637a690602e6d76c5fee5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
