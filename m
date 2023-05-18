Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45547085A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjERQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB019A;
        Thu, 18 May 2023 09:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D616509D;
        Thu, 18 May 2023 16:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09DDCC433EF;
        Thu, 18 May 2023 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684426207;
        bh=WRniWxL3vdUXkieffXLRZIpU7rD7ns+rbyi1G617eyY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WbogGFQe2J5CHqVIOi867St2e7R33eFu4ZaNAznQa5cFq08am7Eh4XUv6yub4PHD9
         vpR05xidJPpakYj641tcId1vGeR9+uqbeN5o7hyIzSkAevYsErsX8DQxUfX0vhS0Bk
         7a+uExr7Rbl3yoHyqOwTCe+Tu/fw8BmwZur/+cq3ed8S5t9HZwAml4yNZGQa3nOeei
         CK1laWb9M4yhGNnN3FFCVZObnQn6LgjtMUSBOOKDGW4myx+DI/uTFMGmSFVjf93h8q
         8DOdqApppFx3cmOXpTr9jI4fzVfCMSo6SKPRyf27yvoBJM6cJHI/Ltwz5R58tfLVZr
         RH3KDG0sDjlyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF82FE54223;
        Thu, 18 May 2023 16:10:06 +0000 (UTC)
Subject: Re: [GIT PULL for v6.4-rc3] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230518092659.4a4de8ea@sal.lan>
References: <20230518092659.4a4de8ea@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230518092659.4a4de8ea@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-3
X-PR-Tracked-Commit-Id: 280a8ab81733da8bc442253c700a52c4c0886ffd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b802651bb6c90e53b30205b2a4358433e3be57c8
Message-Id: <168442620677.7549.4912212264415676664.pr-tracker-bot@kernel.org>
Date:   Thu, 18 May 2023 16:10:06 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 May 2023 09:26:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b802651bb6c90e53b30205b2a4358433e3be57c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
