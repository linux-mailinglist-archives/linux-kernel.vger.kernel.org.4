Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9818F69EC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBVBn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjBVBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:43:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B51449E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85CDD61236
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00ADAC4339B;
        Wed, 22 Feb 2023 01:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677030198;
        bh=uEiyLo26+Egm/YwwxBcmUfAJ+33dE9Vg7pwmB+1lVgE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mUSWlswW56DnVwdehEPRykXPpMWBufP73/6kOFNGt8x9CsFSeVPCR9CA4CIKRxlpP
         utmqpMFvfHy28dkhs1aKR7ybTCnCk2IHf7dpltOVTZxskzTn8K212fRWWX2oT0Aq5+
         Wdsex5TbBy/QjVReFmgYlO4pyQDuHKT0XVjem6opLCwOnBteDm32V+26p2wxSFDXnY
         DiGxy3clN4rBGqVbeuQrqWF+jX8K44mKrbNwH9DqwKBRJLOdRzf0JTs91reS9/dnV0
         04+4FeF8IIakWmu7h12GmaghnG0ITeCDwaW9MkNPHNTfIKAXfIvBaHYj80bG9y1LwU
         /vthiDtkQ411A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E333BC43158;
        Wed, 22 Feb 2023 01:43:17 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.3-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9f696a6a-9161-ab4c-5304-dc2db865f5d8@redhat.com>
References: <9f696a6a-9161-ab4c-5304-dc2db865f5d8@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9f696a6a-9161-ab4c-5304-dc2db865f5d8@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-1
X-PR-Tracked-Commit-Id: 0d9bdd8a550170306c2021b8d6766c5343b870c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69308402ca6f5b80a5a090ade0b13bd146891420
Message-Id: <167703019792.10177.363943860068702319.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 01:43:17 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 11:17:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69308402ca6f5b80a5a090ade0b13bd146891420

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
