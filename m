Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3A6EFDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjDZWrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbjDZWrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4F40FF;
        Wed, 26 Apr 2023 15:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E9D63460;
        Wed, 26 Apr 2023 22:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D38C433D2;
        Wed, 26 Apr 2023 22:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682549215;
        bh=fbKfipdEQ8bK3eYnIAg4c3idNCO+dfoD+hOVqvHJ0VU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fz/InOMRFE84y+P+uMy+8GQ62SgwhcdJlHM1VHY7KOK57E7OWboWN64fz5EdtvBq8
         3vGzizPX4djmDHKxysUtIGvM8OphFXfnrYpJKVCc8maLTzzAJDii0TLslJpmHvsbff
         HFZbIdkuMgGfkly4mN2ICVsPCexaS6lgSEzEhEj32Mv1RJBwzZJgPxkxbyw8cSDidR
         gDs2t2vZVA/WEtaUivIuZzqrMowI/puuaPvEMl7s/+7JKGdB2xqOWlgodv1avnnUEa
         xj9s49VkJUnV8j6QvPdFawhA4IJsTHpdPXAolIpKCJgP1ETwoECndpSmfC3AKtpoO9
         mHw57Uv6L3CSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C47E5FFC8;
        Wed, 26 Apr 2023 22:46:55 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.3+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8f12f4923557bccfe40aa50c01b1154946b82669.camel@HansenPartnership.com>
References: <8f12f4923557bccfe40aa50c01b1154946b82669.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <8f12f4923557bccfe40aa50c01b1154946b82669.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 3c85f087faeca3ca9ec9e7b085e1eff370e3f0db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b68ee1c6131c540a62ecd443be89c406401df091
Message-Id: <168254921508.9139.7696619340716947740.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 22:46:55 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 16:35:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b68ee1c6131c540a62ecd443be89c406401df091

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
