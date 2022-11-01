Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D35615252
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKATcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKATcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:32:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A112AEA;
        Tue,  1 Nov 2022 12:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 470CEB81F5E;
        Tue,  1 Nov 2022 19:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC3BC433D6;
        Tue,  1 Nov 2022 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667331128;
        bh=SqTpkEJDimDLK8JCkPSO5Of7KHU3i9/ujWgBTDi8Ym0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cOVV+0xTjfOJSF5q3foDxrY03mtFOiavKSFeXqSyNPljxLYY4wRPn1KRK0erbXzcH
         zaXOKikkeP3Tc7zaTxuaoCds4A8c1jmpbRqE8XP+EdSk0kd+/8OXlHElgc0DnpkduH
         rexFCAWWFgcuwmMiX212hZFfYGjX36cDnUWQUNFdExvUjk2V71bQxXHsvOV+QJg+Vb
         Bqx0cdzQkZRLG5lgXhwAG1gwQ+xFdeU26E2ikxd9xBK56lg907pkmIWneTAdg1OtTP
         r4pWy5YEz83fBYS4YyfTPuPFpXgiYBdBp5amcfsyt79qTaH/TMmL+mtKjwPJtCEuVu
         7hBfHzQgFIbzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBF26E270D3;
        Tue,  1 Nov 2022 19:32:07 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.1 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221101081902.GA5794@www.linux-watchdog.org>
References: <20221101081902.GA5794@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221101081902.GA5794@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc4
X-PR-Tracked-Commit-Id: 82ebbe65d781064cfb0a6a8af221a9cebcaaac9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d79dcde0bc413efd35dd7eabe2d5eed34ec6deb0
Message-Id: <166733112789.6375.9114607752098301144.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Nov 2022 19:32:07 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Manank Patel <pmanank200502@gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Nov 2022 09:19:02 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d79dcde0bc413efd35dd7eabe2d5eed34ec6deb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
