Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4316ED4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjDXSuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjDXSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273EAF32;
        Mon, 24 Apr 2023 11:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D029A6284C;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F7B2C433EF;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362055;
        bh=N2cZySwmFQ9XSHlJHgIN+fvENa3SaLNzWwM96Pl7eq4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VhYsQIxI3ltxOqPzEI6ON/jn2ZyRdBg49483c/BsbCye2bFdwD1D3xuAQWprdKrb9
         7608yN+qfN/LA+n0QlskzKoYGRib8Xm8T8weSrwrVTqRJnN/LzDsDo/jyz2ytXB4+B
         GjaLmzTiuHIQGHWGXta1tQrzfm+jGT0f3iZFro1aMIuAhH00Pofr3ttrce8ys8Ar4z
         v/sVKaLfXodPcNnvSTYXdg6TP7+xKycZiEEg3zLYT4ecezClHo5j1T1+xCWI2fHbDF
         oZXh/hf3yI5cTbDqkFuAcezE75NMsjzJn56MbpjoubZeo5z4odVKZCW9VQbkxM0X/y
         m1M7XxL9UQ3RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F259C395D8;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQEXm3XG7B1wJBVsd15xFNpMjyuyxWDEcTAGrSN6zWoaA@mail.gmail.com>
References: <CAHC9VhQEXm3XG7B1wJBVsd15xFNpMjyuyxWDEcTAGrSN6zWoaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQEXm3XG7B1wJBVsd15xFNpMjyuyxWDEcTAGrSN6zWoaA@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230420
X-PR-Tracked-Commit-Id: 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72eaa0967b594cb9886c2f277a69ac1ea935b1a8
Message-Id: <168236205518.5635.17206457047162868498.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 18:47:35 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
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

The pull request you sent on Thu, 20 Apr 2023 19:52:45 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230420

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72eaa0967b594cb9886c2f277a69ac1ea935b1a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
