Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C715B47C1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIJRjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIJRiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA73491D9;
        Sat, 10 Sep 2022 10:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDF31B80860;
        Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1E7AC433D6;
        Sat, 10 Sep 2022 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662831531;
        bh=EdW9C2ou4aTu9YYcfJvxHpJ4eUfqhRiiZEzDRgh9NX4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SGh7AbP+nugz9XL6ilMk4uBEl2tlVS808R/R/XlK2Cggv+kflwrTRk6vrh21+35xw
         AM38vxQFYnb8ITwORjjism4qSpRz/BzhDshShe61nlS1hWOvsoH/T/tgwFZxvtDRpP
         bngd0nLi1ea2chN+J5bdBVSIB50X2OK/MJH8YTuIDq7qzJHPvHHBZo5BDB+T9iBCZo
         T1fPXSDNjwQ3tu5c4/yqvI9f+peDDK9hEly3HAKxtS0jFX+Cl2PuMYC2/vpemSHUcw
         7j95km1D4Uejihw5juqmPS8o5kbf/9MTlAkn47h8LDY1vEhoTpDCOKK8upQg47HQmE
         LbUY6IOPMcypQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BE66E1CABE;
        Sat, 10 Sep 2022 17:38:51 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01662807604-ext-8310@work.hours>
References: <your-ad-here.call-01662807604-ext-8310@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01662807604-ext-8310@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-4
X-PR-Tracked-Commit-Id: 8d96bba75a43ba564bf8732e955d9f519d2bbaec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b96fbd602d35739b5cdb49baa02048f2c41fdab1
Message-Id: <166283153163.31692.16378904348411411745.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Sep 2022 17:38:51 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Sep 2022 13:00:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b96fbd602d35739b5cdb49baa02048f2c41fdab1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
