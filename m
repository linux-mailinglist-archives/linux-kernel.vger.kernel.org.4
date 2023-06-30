Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA57431EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjF3AsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjF3AsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD152680;
        Thu, 29 Jun 2023 17:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE4F6168A;
        Fri, 30 Jun 2023 00:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0104BC433C8;
        Fri, 30 Jun 2023 00:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688086086;
        bh=DuTa9dyAMJyuwQqf1vPpylO2OOdALrAAJbDSDP70iXs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ax/F//KStXhzmNKUoceELTo2z7TurvMzm6yeyLFkK3HQ9jSiYhinsQqHJG5m3zpk4
         ibJnjxcectPfdy5B4FWeYFSMjx1YcqKDw9uEoi5NR1F5JqyCXfC5AwkFrqiCex+eoL
         vdVupyUlvhD6NEMz9374gRj18x8CjoDvVBeoZlVniuPTS+18jtwLhfGQ67dHBsREGa
         o0DIqJ6FNXFSm6Rd7cFrJk9xy0pu9V8jnew8LQzEkl37F0riuGgHMOAArE4NlxATIw
         Q9vdyKFUN28zmjfQF+V3xxuciri0RXHi8+xy+fKu9ZmDUTZ/q23JPaHuwXKZdY0ElF
         kXUA952Od34Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E09F4E5381B;
        Fri, 30 Jun 2023 00:48:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jqkN0H=mJYrhvy8Qm8OpMEqe=r8jcF08pX7QtM=BQ1LQ@mail.gmail.com>
References: <CAJZ5v0jqkN0H=mJYrhvy8Qm8OpMEqe=r8jcF08pX7QtM=BQ1LQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jqkN0H=mJYrhvy8Qm8OpMEqe=r8jcF08pX7QtM=BQ1LQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc1-2
X-PR-Tracked-Commit-Id: b5539eb5ee70257520e40bb636a295217c329a50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eb15b42482bbbaa0fd611741e687c2feee21f2c
Message-Id: <168808608591.32109.6959726677210695818.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 00:48:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 19:05:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eb15b42482bbbaa0fd611741e687c2feee21f2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
