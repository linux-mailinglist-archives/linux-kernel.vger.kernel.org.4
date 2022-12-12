Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CED64A681
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiLLSIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiLLSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01813F93
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA6560FD6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AA5CC433EF;
        Mon, 12 Dec 2022 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670868449;
        bh=vljNu28ZVmWP9pD8c7j78EbzrtZa6D2WdnZ69OLFXbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wg2vZO4i8w4mG2uTgrUGTZ8s88grNrubcspUskp9UvSqS0sOXsEBxVSysJqM6aTQE
         Mmpc7R+R8xsU0nUAMSBPj1c8mzA6hWJImDVcRYJKfZPyeeQiSNT+jcWlYdzE9/tRfS
         YDjpKR+5+3UCO5crm1ymiv05sfwHa2govP/TyyMqqSwJaNGPtalYYE1OSOJBLoj/zT
         fKi1SILlU20uBU0BV/CPJWEVeNuz+EhP+3VDps++ir+5ZiwfV0ASpaW7BotcitDmnw
         80+1YeyZbPRCLpgPDQX27B3FcMMHwl76TV01gw6l2eW3IXeqAd6r8xLKH0wM/KK1aT
         v1bE0pUy7Eeuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B303C00445;
        Mon, 12 Dec 2022 18:07:29 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
References: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.2
X-PR-Tracked-Commit-Id: 5cfe469c2654c3a4dda8504b1209abdd8b379e95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 164f59000c19fa1ee5d09327a8055ec9f9b9905a
Message-Id: <167086844917.13437.10765377331125217491.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 18:07:29 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Dec 2022 11:07:27 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/164f59000c19fa1ee5d09327a8055ec9f9b9905a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
