Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F369FDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjBVVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjBVVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:50:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4F39BB2;
        Wed, 22 Feb 2023 13:50:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4636159B;
        Wed, 22 Feb 2023 21:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C30E1C4339C;
        Wed, 22 Feb 2023 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677102532;
        bh=kY7XANNZ04WNvAIiht7tgIRWTGT6/TYlpHWeOAtwcUg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jv7Bc1Y6q6en3AWz74Rt9YkLTFErSjbWnvwMgEiDfXSr4U7gw6Dqvs6wef1FuvSr7
         LwN5aThdbja4OdaJtj3S5rTf30rH6JKY4aROhD9nsqJ6toXfQz7OwFm9FUG5ZBQO/N
         MM7VaNFyozXzyAUeiuZsKeLLyW5L/C/8HQv7O4sZb8TaXzbxzO5sRVsWnmYoqQqF8t
         eYLocNyN+g7+V+WcGj8T4IPR7iFbya5RiRNIKUdGVZwQ2PDorAbI2r93uC2g4Q7Vta
         LKkTMwGQs5MsQqRGAaqFXGJ3PrbVwuWFexMsGEFAXPxC6wZ1QNeRzaRcSYtEFb6Yd4
         U/YCWr36d+hKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B21D2C43151;
        Wed, 22 Feb 2023 21:48:52 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.2+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <838f8d602c321a86f829344f07c5681d371134f1.camel@HansenPartnership.com>
References: <838f8d602c321a86f829344f07c5681d371134f1.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <838f8d602c321a86f829344f07c5681d371134f1.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 833f7d4819a88f027033e0033ea44f7ae3e45a9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8762069330316392331e693befd8a5b632833618
Message-Id: <167710253272.31368.499027829627073151.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 21:48:52 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 15:31:12 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8762069330316392331e693befd8a5b632833618

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
