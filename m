Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714386CCB81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjC1Udg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjC1Udc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:33:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1F19B7;
        Tue, 28 Mar 2023 13:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D21B1B81CB2;
        Tue, 28 Mar 2023 20:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F2F6C433EF;
        Tue, 28 Mar 2023 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680035606;
        bh=xrXeI+98kM2nOz+Eg500jwM5daHhRTo/ti0oQ9SVNI4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QhjNt3b7hylk+jaa/JDdFBl3SftjbUVnYVJRmZ3LD6H5jR7WN+bYtKS1lCj1PN9/o
         zpUb/9XM5QnQWYmwi09RN3twk8/h/pM+NL9XSPvmbxCKknCTcHtfVLhAqHAj7KNF6V
         X0UktXWxOuVdGTRrJUCpfmVM6hEx9VgO9UMqmLQhw3kwcwQ3MOMMZpQg3E+3V4GMWJ
         SQNwwPrKmvPwmS9miRPg/CdPq9RY9AQllDk3e8tXeFsEf5ETcWtM+f+moD3YmZKHpn
         Yjg0d1VdGNzEErUf4RzREZZmh2oxh7PmN6Cqpm4FuQQpRgP+n2p9X/Aupwo1gRbqM+
         f5sKjtutidMVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5884EE21EE2;
        Tue, 28 Mar 2023 20:33:26 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01680008228-ext-8201@work.hours>
References: <your-ad-here.call-01680008228-ext-8201@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01680008228-ext-8201@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-4
X-PR-Tracked-Commit-Id: f9bbf25e7b2b74b52b2f269216a92657774f239c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05c24161f4d2adc0deb6f3f0f55d25e12fbbdcde
Message-Id: <168003560635.432.5266651089745246104.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Mar 2023 20:33:26 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Mar 2023 14:57:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05c24161f4d2adc0deb6f3f0f55d25e12fbbdcde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
