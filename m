Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF30573906D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFUTxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFUTxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880FE65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F94A616AF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFF7BC433C8;
        Wed, 21 Jun 2023 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687377189;
        bh=GoCyd4FI5z5GoabBzEW+7gotpPEwTY5Cco8rev+iP/Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h256rDmJOWYG9FPxXuJQr5k4D1sWLyQSKfmR/9ElbrQfEhpzFkaFPL3yEaSNNhSJY
         sgw5nhN0IobWM5HVumSY6rxuJkIvHTfnssjv5DbKerfOVKl0TXn0LuBY3pyva3AYGK
         n517Mmbw4MaVi7uHZTAbglmFgb+1Dl/Ej6ya6XMNhOGx5LbImy3ME05tVcDtKHocVk
         Jge4scgqBZ62Vcq+/TccQJaCTGj1uOaB7cyetdCNobaoC2YGsZqQBoKejsJVmQBa7F
         NA3ypsym1gdqxAlaAWgRjR0B/imREVKB0SiaCOOMSgCiGIX9R4quOcp+gC7Ob1uENF
         5bz+OPlRThdgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1DE0C395F1;
        Wed, 21 Jun 2023 19:53:09 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168737611661.277769.2194490737572202840.tglx@xen13>
References: <168737611661.277769.2194490737572202840.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168737611661.277769.2194490737572202840.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-06-21
X-PR-Tracked-Commit-Id: 13bb06f8dd42071cb9a49f6e21099eea05d4b856
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dad9774deaf1cf8e8f7483310dfb2690310193d2
Message-Id: <168737718965.21842.7322871720736752584.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jun 2023 19:53:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Jun 2023 21:36:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-06-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dad9774deaf1cf8e8f7483310dfb2690310193d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
